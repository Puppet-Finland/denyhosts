#
# Class: denyhosts::config
#
# Configures denyhosts daemon
#
class denyhosts::config
(
    $deny_threshold_valid,
    $deny_threshold_invalid,
    $deny_threshold_restricted,
    $deny_threshold_root,
    $allowed_hosts,
    $email

) inherits denyhosts::params
{

    file { 'denyhosts-denyhosts.conf':
        ensure  => present,
        name    => '/etc/denyhosts.conf',
        content => template('denyhosts/denyhosts.conf.erb'),
        owner   => $::os::params::adminuser,
        group   => $::os::params::admingroup,
        mode    => '0755',
        notify  => Class['denyhosts::service'],
    }

    file { 'denyhosts-hosts.allow':
        ensure  => present,
        name    => '/etc/hosts.allow',
        content => template('denyhosts/hosts.allow.erb'),
        owner   => $::os::params::adminuser,
        group   => $::os::params::admingroup,
        mode    => '0755',
        notify  => Class['denyhosts::service'],
    }
}
