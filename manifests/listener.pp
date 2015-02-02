#    webhook::listener { $route:
#            port         => $listen_port,
#            bind_address => $bind_address,
#            rack_end     => $rack_env,
#            http_method  => $http_method,
#            command      => 'puppet agent -t',
#    }

define webhook::listener (

    $port               = $webhook::params::listen_port,
    $bind_address       = $webhook::params::bind_address,
    $rack_env           = $webhook::params::rack_env,
    $route              = $name, 
    $http_method        = $webhook::params::http_method,
    $ssl_enable         = $webhook::params::ssl_enable,
    $cert_path          = $webhook::params::cert_path,
    $key_path           = $webhook::params::key_path,
    $command            = $webhook::params::command

) inherits webhook::params {

    file {"/usr/local/bin/webhook_${name}":
        ensure => directory,
        mode   => '0755',
        owner  => 'root',
        group  => 'root',
    }

    file {"/usr/local/bin/webhook_${name}/webhook_${name}.rb":
        ensure  => file,
        content => template('webhook/webhook'),
        mode    => '0755',
        owner   => 'root',
        group   => 'root',
    }

}

