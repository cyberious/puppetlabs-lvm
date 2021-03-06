# == Define: lvm::volume_group
#
define lvm::volume_group (
  $physical_volumes,
  $ensure           = present,
  $logical_volumes  = {},
) {

  validate_hash($logical_volumes)

  physical_volume { $physical_volumes:
    ensure => $ensure,
  }

  volume_group { $name:
    ensure           => $ensure,
    physical_volumes => $physical_volumes,
  }

  create_resources(
    'lvm::logical_volume',
    $logical_volumes,
    {
      ensure       => $ensure,
      volume_group => $name,
    }
  )
}
