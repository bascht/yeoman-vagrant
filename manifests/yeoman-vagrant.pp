class yeoman_base {
  exec {"update":
    command => "/usr/bin/apt-get update"
  }

  package { "pre-deps":
    name => [
      "python-software-properties",
    ],
    require => Exec["update"],
  }

  exec {"nodejs-repo":
    command => "/usr/bin/apt-add-repository ppa:chris-lea/node.js && apt-get update",
    cwd => "/opt/yeoman-vagrant",
    user => root,
    creates => "/etc/apt/sources.list.d/chris-lea-node_js-precise.list",
    require => Package["pre-deps"]
  }

  package { "deps":
    name => ["nodejs"],
    ensure => present,
    require => Exec["nodejs-repo"]
  }
}

class yeoman_packages {
  exec { "npm-install-g":
    cwd => "/opt/yeoman-vagrant",
    command => "/usr/bin/npm install -g grunt-cli",
    user => root,
    require => Class['yeoman_base']
  }

  exec { "npm-install":
    command => "/usr/bin/npm install",
    cwd => "/opt/yeoman-vagrant",
    require => Exec["npm-install-g"]
  }
}

include yeoman_base
include yeoman_packages
