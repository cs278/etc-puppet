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
