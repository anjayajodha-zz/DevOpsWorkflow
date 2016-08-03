group { 'web':
  ensure => 'present',
  gid    => '1002',
}

node default {
  class { 'nodejs':
    repo_url_suffix => '5.x',
  }
  class {'::mongodb::server':
    verbose => 'true',
  }
  include wget
}

package { 'express':
  ensure   => 'present',
  provider => 'npm',
}

package { 'forever':
  ensure   => 'present',
  provider => 'npm',
}

package { 'git':
  ensure   => 'latest',
}

package {'nodemon':
  ensure   => 'present',
  provider => 'npm'
}

file { '/todolistmean/':
  ensure => 'directory',
}

wget::fetch { 'http://192.168.133.30/meanapp.tar.gz':
  destination => '/todolistmean/',
  cache_dir   => '/var/cache/wget',
} ~>
exec { 'extracttar' :
  command => 'tar xzvf meanapp.tar.gz',
  cwd     => '/todolistmean',
  user    => 'root',
  path    => '/bin',
} ->
exec { 'installdeps' :
  command => 'npm install',
  cwd     => '/todolistmean/ToDoListMean',
  user    => 'root',
  path    => '/usr/bin',
} ->
exec { 'restartnode' :
  command => 'killall nodejs;forever start server.js;',
  cwd     => '/todolistmean/ToDoListMean',
  user    => 'root',
  path    => '/usr/bin',
}