
exec {"update":
  command => "apt-get update",
  user => root,
}

package { "pre-deps":
  name => [
    "python-software-properties",
  ],
  require => Exec["update"],
}

exec {"nodejs-repo":
  command => "apt-add-repository ppa:chris-lea/node.js && apt-get update",
  cwd => "/opt/yeoman-vagrant",
  user => root,
  creates => "/etc/apt/sources.list.d/chris-lea-node_js-precise.list",
  require => Package["pre-deps"],
}

package { "deps":
  name => ["nodejs"],
  ensure => present,
  require => Exec["nodejs-repo"],
}

exec { "npm-install-g":
  cwd => "/opt/yeoman-vagrant",
  command => "npm install -g grunt-cli",
  user => root,
  require => Package["deps"],
}

exec { "npm-install":
  command => "npm install",
  cwd => "/opt/yeoman-vagrant",
  require => Exec["npm-install-g"],
}
