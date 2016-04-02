require_relative '../spec_helper'

describe VagrantPlugins::PuppetInstall::Config do
  let(:machine) { double('machine') }
  let(:instance) { described_class.new }

  subject(:config) do
    instance.tap do |o|
      o.puppet_version = puppet_version if defined?(puppet_version)
      o.install_url = install_url if defined?(install_url)
      o.validate_version = validate_version if defined?(validate_version)
      o.finalize!
    end
  end

  describe 'defaults' do
    its(:puppet_version) { should be_nil }
    its(:install_url) { should be_nil }
    its(:validate_version) { should be_nil}
  end

  describe 'resolving `:latest` to a real Puppet version' do
    let(:puppet_version) { :latest }
    its(:puppet_version) { should be_a(String) }
    its(:puppet_version) { should match(/\d*\.\d*\.\d*/) }
  end

  describe 'validate' do
    it 'should be no-op' do
      expect(subject.validate(machine)).to eq('VagrantPlugins::PuppetInstall::Config' => [])
    end
  end

  describe '#validate!' do
    describe 'puppet_version validation' do
      {
        '3.4.0' => {
          description: 'valid puppet version string',
          valid: true
        },
        '~> 2.7' => {
          description: 'valid puppet version string',
          valid: true
        },
        '9.9.9' => {
          description: 'invalid puppet version string',
          valid: false
        },
        'FUFUFU' => {
          description: 'invalid RubyGems version string',
          valid: false
        }
      }.each_pair do |version_string, opts|
        context "#{opts[:description]}: #{version_string}" do
          let(:puppet_version) { version_string }
          if opts[:valid]
            it 'passes' do
              expect { subject.validate!(machine) }.to_not raise_error
            end
          else
            it 'fails' do
              expect { subject.validate!(machine) }.to raise_error(Vagrant::Errors::ConfigInvalid)
            end
          end
        end
      end
    end # describe puppet_version

    describe 'not specified puppet_version validation' do
      it 'passes' do
        Gem::DependencyInstaller.any_instance.stub(:find_gems_with_sources).and_return([])
        expect { subject.validate!(machine) }.to_not raise_error
      end
    end # describe not specified puppet_version validation

    describe 'validate_version set to false should not raise error' do
      {
        false => {
          description: 'Boolean false'
        },
        'false' => {
          description: 'String false'
        },
        :false => {
          description: ':false'
        },
      }.each_pair do |falsey, opts|
        context "#{opts[:description]}" do
          let(:validate_version) { falsey }
          let(:puppet_version) { '9.9.9' }

          it 'passes' do
            expect { subject.validate!(machine) }.to_not raise_error
          end
        end
      end
    end # describe validate_version set to false should not raise error

    describe 'validate_version set to true with an invalid version should not raise error' do
      let(:validate_version) { true }
      let(:puppet_version) { '9.9.9' }

      it 'fails' do
        expect { subject.validate!(machine) }.to raise_error
      end
    end # validate_version set to true with an invalid version should not raise error
  end
end
