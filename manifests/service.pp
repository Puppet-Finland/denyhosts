#
# == Class: denyhosts::service
#
# Configures denyhosts to start on boot
#
class denyhosts::service inherits denyhosts::params {

    service { 'denyhosts':
        enable    => true,
        name      => 'denyhosts',
        hasstatus => $::denyhosts::params::service_hasstatus,
        require   => Class['denyhosts::config'],
    }
}
