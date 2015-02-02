#    webhook::listener { $route:
#            listen_port  => $listen_port,
#            bind_address => $bind_address,
#            rack_end     => $rack_env,
#            http_method  => $http_method,
#            command      => 'puppet agent -t',
#    }

define webhook::listener (


    $listen_port        = $webhook::params::listen_port,
    $bind_address       = $webhook::params::bind_address,
    $rack_env           = $webhook::params::rack_env,
    $route              = $webhook::params::route,
    $http_method        = $webhook::params::http_method,
    $install            = $webhook::params::install,

) inherits webhook::params {

}

