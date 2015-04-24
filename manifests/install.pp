#
# == Class: denyhosts::install
#
# Installs denyhosts package
#
class denyhosts::install inherits denyhosts::params {

    package { 'denyhosts-denyhosts':
        ensure => installed,
        name   => 'denyhosts',
    }
}
