# spec/Dockerfile_spec.rb

require "serverspec"
require "docker"

describe "Dockerfile" do
  before(:all) do
    image = Docker::Image.build_from_dir('.')

    set :os, family: :redhat
    set :backend, :docker
    set :docker_image, image.id
  end

  it "installs the right version of CentOS" do
    expect(os_version).to include("CentOS")
  end

  # Test for packages
  it "installs required packages" do
    expect(package("epel-release")).to be_installed
    expect(package("puppetlabs-release")).to be_installed
    expect(package("puppetserver")).to be_installed
    expect(package("gcc")).to be_installed
    expect(package("hostname")).to be_installed
    expect(package("make")).to be_installed
    expect(package("ruby-devel")).to be_installed
  end

  # Ensure start_puppetserver.sh Runs
  describe command('/tmp/start_puppetserver.sh') do
    its(:exit_status) { should eq 0 }
  end


  def os_version
    command("cat /etc/redhat-release").stdout
  end
end
