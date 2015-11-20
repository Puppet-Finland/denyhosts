#
# == Class: denyhosts::monit
#
# Setups monit rules for denyhosts
#
class denyhosts::monit
(
    $monitor_email

) inherits denyhosts::params
{

    monit::fragment { 'denyhosts-denyhosts.monit':
        basename   => 'denyhosts',
        modulename => 'denyhosts',
    }
}
