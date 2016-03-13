# Class: beegfs::repo::debian

class beegfs::repo::debian (
  $manage_repo    = true,
  $package_source = $beegfs::package_source,
  $package_ensure = $beegfs::package_ensure,
  $major_version  = $beegfs::major_version,
  $release,
) {

  anchor { 'beegfs::apt_repo' : }

  include '::apt'

  if $manage_repo {
    case $package_source {
      'beegfs': {
        apt::source { 'beegfs':
          location     => "http://www.beegfs.com/release/beegfs_${major_version}",
          repos        => 'non-free',
          architecture => 'amd64',
          release      => $release,
          key          => {
            'id' => '055D000F1A9A092763B1F0DD14E8E08064497785',
            'source' => 'http://www.beegfs.com/release/latest-stable/gpg/DEB-GPG-KEY-beegfs',
          },
          include  => {
            'src' => false,
            'deb' => true,
          },
          notify       => Exec['apt_update'],
        }
      }
      default: {}
    }
  }
}