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

# Atom 1.0.7
dpkgdeb::package { 'atom':
  url      => 'https://github.com/atom/atom/releases/download/v1.0.7/atom-amd64.deb',
  checksum => '8f3232b8c95a68b9bcbee498699d4c60ef5ed409',
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
pacakge { 'htop':
  ensure => latest,
}->
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
package { 'php5-mysqlnd':
  ensure => latest,
}->
package { 'php5-readline':
  ensure => latest,
}->
package { 'php5-xdebug':
  ensure => latest,
}

# MySQL
package { 'mysql-client':
  ensure => latest,
}

# Node
class { 'nodejs':
}->
package { 'bower':
  ensure   => 'present',
  provider => 'npm',
}

# HHVM
apt::key { '36AEF64D0207E7EEE352D4875A16E7281BE7A449':
  ensure => present,
  source => 'http://dl.hhvm.com/conf/hhvm.gpg.key',
}->
apt::source { 'hhvm':
  ensure   => present,
  location => join(['http://dl.hhvm.com/', downcase($::lsbdistid)], ''),
  release  => $::lsbdistcodename,
}->
package { 'hhvm':
  ensure => latest,
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
