require_relative '../spec_helper'

describe VagrantPlugins::PuppetInstall::Config do

  subject(:config) do
    instance.tap do |o|
      o.puppet_version = puppet_version if defined?(puppet_version)
      o.install_url = install_url if defined?(install_url)
      o.finalize!
    end
  end

  describe 'defaults' do
    its(:puppet_version) { should be_nil }
    its(:install_url) { should be_nil }
  end

  describe 'resolving `:latest` to a real Puppet version' do
    let(:puppet_version) { :latest }
    its(:puppet_version) { should be_a(String) }
    its(:puppet_version) { should match(/\d*\.\d*\.\d*/) }
  end

  describe "#validate" do
    let(:machine) { double('machine') }
    let(:error_hash_key) { "Puppet Install Plugin" }
    let(:result) { subject.validate(machine) }
    let(:errors) { result[error_hash_key] }
  describe 'setting a custom `install_url`' do
    let(:install_url) { 'http://some_path.com/install.sh' }
    its(:install_url) { should eq('http://some_path.com/install.sh') }
  end

    it "returns a Hash with an 'Puppet Install Plugin' key" do
      result.should be_a(Hash)
      result.should have_key(error_hash_key)
    end

    describe "puppet_version validation" do
      {
        "3.4.0" => {
          :description => "valid Puppet version string",
          :valid => true
        },
        "10.99.99" => {
          :description => "invalid Puppet version string",
          :valid => false
        },
        "FUFUFU" => {
          :description => "invalid RubyGems version string",
          :valid => false
        }
      }.each_pair do |version_string, opts|
        context "#{opts[:description]}: #{version_string}" do
          let(:puppet_version) { version_string }
          if opts[:valid]
            it "passes" do
              errors.should be_empty
            end
          else
            it "fails" do
              errors.should_not be_empty
            end
          end
        end
      end
    end # describe puppet_version
  end # describe #validate

end
