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

dpkgdeb::package { 'atom':
  url      => 'https://atom.io/download/deb',
  checksum => '9caa44d635f506ab7c9ffb44e0cc65444736d9e3',
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

# PHP
package { 'php5-cli':
  ensure => latest,
}
