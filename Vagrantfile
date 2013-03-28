Vagrant::Config.run do |config|
    config.vm.box = "precise64"
    config.vm.box_url = "http://files.vagrantup.com/precise64.box"

    config.ssh.forward_agent = true

    config.vm.define :showmaster do |showmaster_config|
        showmaster_config.vm.customize ["modifyvm", :id, "--memory", 384]
        showmaster_config.vm.customize ["modifyvm", :id, "--cpus", 1]
        showmaster_config.vm.share_folder "yeoman-vagrant", "/opt/yeoman-vagrant", "."
        showmaster_config.vm.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/yeoman-vagrant", "1"]
        showmaster_config.vm.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/v-root", "1"]
        showmaster_config.vm.provision :puppet do |puppet|
            puppet.manifests_path = "manifests"
            puppet.manifest_file  = "yeoman-vagrant.pp"
            puppet.options = [
                #'--verbose',
                #'--debug',
            ]
        end
    end
end

