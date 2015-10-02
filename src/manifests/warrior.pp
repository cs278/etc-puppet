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
  url      => 'https://github.com/atom/atom/releases/download/v1.0.2/atom-amd64.deb',
  checksum => '245f8a29611b2c99e119e7fbefa577aaac4c6df8',
}

# Fonts
package { 'fonts-inconsolata':
  ensure => latest,
}->
package { 'fonts-droid':
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
package { 'php5-mysqlnd':
  ensure => latest,
}->
package { 'php5-readline':
  ensure => latest,
}->
package { 'php5-xdebug':
  ensure => latest,
}
