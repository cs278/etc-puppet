Exec {
  path => '/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin',
}

class { 'apt':
}

apt::source { 'google-chrome':
  location => 'http://dl.google.com/linux/chrome/deb/',
  release  => 'stable',
  repos    => 'main',
  key      => {
    id     => '4CCA1EAF950CEE4AB83976DCA040830F7FAC5991',
    source => 'https://dl-ssl.google.com/linux/linux_signing_key.pub',
  },
}->
package { 'google-chrome-stable':
  ensure => latest,
}

# Atom 1.0.2
dpkgdeb::package { 'atom':
  url      => 'https://atom.io/download/deb',
  checksum => '245f8a29611b2c99e119e7fbefa577aaac4c6df8',
}

# Fonts
package { 'fonts-inconsolata':
  ensure => latest,
}->
package { 'fonts-droid':
  ensure => latest,
}

# Theming
package { 'dmz-cursor-theme':
  ensure => latest,
}->
package { 'gtk2-engines-murrine':
  ensure => latest,
}

# Utilities
package { 'redshift':
  ensure => latest,
}->
package { 'jq':
  ensure => latest,
}->
package { 'realpath':
  ensure => latest,
}->
package { 'pwgen':
  ensure => latest,
}->
package { 'sshfs':
  ensure => latest,
}

# PHP
package { 'php5-cli':
  ensure => latest,
}->
package { 'php5-curl':
  ensure => latest,
}->
package { 'php5-gd':
  ensure => latest,
}->
package { 'php5-mysql':
  ensure => latest,
}->
package { 'php5-mysqlnd':
  ensure => latest,
}->
package { 'php5-readline':
  ensure => latest,
}->
package { 'php5-xdebug':
  ensure => latest,
}

# Node
class { 'nodejs':
}->
package { 'bower':
  ensure   => 'present',
  provider => 'npm',
}

# Docker
apt::key { '36A1D7869245C8950F966E92D8576A8BA88D21E9':
  ensure => present,
  source => 'https://get.docker.io/gpg',
}->
apt::source { 'docker':
  ensure   => present,
  location => 'http://get.docker.com/ubuntu',
  release  => 'docker',
}->
package { 'lxc-docker':
  ensure => latest,
}
