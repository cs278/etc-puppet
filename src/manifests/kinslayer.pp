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

# Atom 1.3.3
dpkgdeb::package { 'atom':
  url      => 'https://github.com/atom/atom/releases/download/v1.3.3/atom-amd64.deb',
  checksum => 'cbd54ce017500d9b82669ef706b8047756336f2b',
}->
package { 'puppet-lint':
  ensure   => 'latest',
  provider => 'gem',
}

# Fonts
package { 'fonts-inconsolata':
  ensure => latest,
}->
package { 'fonts-droid':
  ensure => latest,
}->
package { 'fonts-roboto':
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
package { 'htop':
  ensure => latest,
}->
package { 'lm-sensors':
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
}->
# Useful to have around but atom packages sometimes need it too.
package { 'make':
  ensure => latest,
}->
package { 'build-essential':
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
}->
package { 'php5-intl':
  ensure => latest,
}->
file { '/etc/php5/cli/conf.d/timezone.ini':
  ensure  => file,
  mode    => '0644',
  owner   => 'root',
  group   => 0,
  content => sprintf(
    'date.timezone=%s',
    generate('/bin/cat', '/etc/timezone')
  ),
}->
file { '/etc/php5/cli/conf.d/20-xdebug.ini':
  ensure => absent,
}->
# Wrapper to launch PHP with xdebug enabled
file { '/usr/local/bin/php-xdebug':
  ensure  => file,
  mode    => '0755',
  owner   => 'root',
  group   => 0,
  content => "#!/bin/sh\n\nexec php -dzend_extension=xdebug.so \"$@\"\n",
}

# MySQL
package { 'mysql-client':
  ensure => latest,
}

# Node
class { 'nodejs':
  repo_url_suffix => '5.x',
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
apt::key { '58118E89F3A912897C070ADBF76221572C52609D':
  server => 'hkp://p80.pool.sks-keyservers.net:80',
}->
apt::source { 'docker':
  ensure   => present,
  location => 'https://apt.dockerproject.org/repo',
  release  => 'debian-jessie',
}->
package { 'docker-engine':
  ensure => latest,
}->
# Remove old Docker
package { 'lxc-docker':
  ensure => absent,
}->
apt::key { '36A1D7869245C8950F966E92D8576A8BA88D21E9':
  ensure => absent,
}

# Dev Tools
package { 'agave':
  ensure => latest,
}
