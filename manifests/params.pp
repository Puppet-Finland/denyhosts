#
# == Class denyhosts::params
#
# Defines some variables based on the operating system
#
# The operating system support for denyhosts is getting spotty, because it used 
# to based on tcpwrappers which is losing support in many daemons including 
# sshd. Development versions of denyhosts are moving towards iptables-based 
# blocking:
#
# <https://github.com/denyhosts/denyhosts>
#
# The iptables migration will probably bring denyhosts back to operating system 
# repositories sooner or later.
#
class denyhosts::params {

    include ::os::params

    # On some platforms the init script does not have a "status" target, which 
    # means config change does not trigger a service restart without "hastatus 
    # => false". This block is also used to cause failure on distributions where 
    # this module will not work.
    case $::lsbdistcodename {
        'trusty':   { fail("Unsupported distribution ${::lsbdistcodename}") }
        'jessie':   { fail("Unsupported distribution ${::lsbdistcodename}") }
        'squeeze':  { $service_hasstatus = false }
        'lucid':    { $service_hasstatus = false }
        default:    { $service_hasstatus = true }
    }

    case $::osfamily {
        'RedHat': {
            $pidfile = '/var/lock/subsys/denyhosts'
            $secure_log = '/var/log/secure'
            $service_name = 'denyhosts'
        }
        'Debian': {
            $pidfile = '/var/run/denyhosts.pid'
            $secure_log = '/var/log/auth.log'
            $service_name = 'denyhosts'
        }
        default: {
            fail("Unsupported operating system ${::osfamily}")
        }
    }

    $service_start = "${::os::params::service_cmd} ${service_name} start"
    $service_stop = "${::os::params::service_cmd} ${service_name} stop"
}
