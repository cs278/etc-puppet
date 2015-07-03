define dpkgdeb::package(
  $url,
  $checksum,
  $package = $name,
) {
  # TODO: Should be in ~/.cache
  $deb_file = "/var/cache/dpkgdeb-package-${package}-${checksum}.deb"

  exec { "${name}-download":
    command => "/usr/bin/wget -O '${deb_file}' '${url}'",
    creates => $deb_file,
  }->
  exec { "${name}-verify":
    command => "echo '${checksum}  ${deb_file}' | sha1sum --check --quiet",
  }->
  package { $package:
    ensure   => latest,
    source   => $deb_file,
    provider => 'dpkg',
  }
}
