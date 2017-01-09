Vagrant.configure(2) do |config|

  config.vm.box = "bento/centos-7.2"

  config.vm.provider "parallels" do |prl|
    prl.memory = "4096"
    prl.linked_clone = true
    prl.update_guest_tools = false
    prl.check_guest_tools = false
    prl.customize ["set", :id, "--sh-app-guest-to-host", "off"]
    prl.customize ["set", :id, "--shared-cloud", "off"]
    prl.customize ["set", :id, "--shared-profile", "off"]
    prl.customize ["set", :id, "--time-sync", "on"]
  end

  config.vm.hostname = "oracle"
  config.vm.network :forwarded_port, guest: 1521, host: 1521

  config.vm.provision "shell", inline: <<-SHELL
    test -f /etc/yum.repos.d/epel.repo || yum install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm -y
    ansible --version || yum install ansible -y
  SHELL

  config.vm.provision "ansible" do |ansible|
    ansible.config_file = "tests/ansible.cfg"
    ansible.verbose = "v"
    ansible.playbook = "tests/test_oracle_install.yml"
  end
end
