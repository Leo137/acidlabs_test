ENV['VAGRANT_DEFAULT_PROVIDER'] = 'virtualbox'
Vagrant.require_version '>= 1.5'

Vagrant.configure('2') do |config|
  name = File.basename(Dir.getwd).delete('_') + '-dev'

  config.vm.box = 'joshfng/railsbox'
  # config.ssh.private_key_path = "~/.ssh/id_rsa"
  config.ssh.forward_agent = true
  config.vm.hostname = name

  config.vm.synced_folder '.', '/vagrant'

  config.vm.provider :virtualbox do |v|
    v.name = name
    v.memory = 1024
    v.cpus = 1
    v.customize [
      'modifyvm', :id,
      '--nictype1', 'virtio',
      '--name', name,
      '--natdnshostresolver1', 'on'
    ]
  end

  # rails
  config.vm.network 'forwarded_port', guest: 3000, host: 3500
  config.vm.network 'forwarded_port', guest: 8806, host: 8806
  config.vm.network :private_network, ip: "10.0.0.15"
end
