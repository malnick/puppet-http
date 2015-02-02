#    webhook::listener { $route:
#            port         => $listen_port,
#            bind_address => $bind_address,
#            rack_end     => $rack_env,
#            http_method  => $http_method,
#            command      => 'puppet agent -t',
#    }

define webhook::listener (

    $route              = $name, 
    $bind_address       = '0.0.0.0',
    $rack_env           = 'production',
    $http_method        = 'get', 
    $ssl_enable         = false,
    $port               = undef,
    $cert_path          = undef, 
    $key_path           = undef,
    $command            = undef,

) {

    File {
        mode  => '0755',
        group => 'root',
        user  => 'root',
    }

    file {"/usr/local/bin/webhook_${name}":
        ensure => directory,
    }

    file {"/usr/local/bin/webhook_${name}/lib/":
        ensure => directory,
    }

    file {"webhook_${name}.rb":
        path    => "/usr/local/bin/webhook_${name}/lib/webhook_${name}.rb",
        ensure  => file,
        content => template('webhook/webhook'),
    }

    file {"/usr/local/bin/webhook_${name}/logs":
        ensure => directory,
    }

    file {"/usr/local/bin/webhook_${name}/bin":
        ensure => directory,
    }

    file {"/usr/local/bin/webhook_${name}/bin/run":
        ensure  => file,
        content => template('webhook/run.erb'),
    }

    service {"webhook_${name}":
        ensure   => running,
        start    => "/opt/puppet/bin/ruby /usr/local/bin/webhook_${name}/bin/run",
        stop     => "/bin/kill -9 ${/usr/bin/lsof -i :${port} | awk '{print $2}' | tail -1)",
        provider => 'base',
        require  => File["/usr/local/bin/webhook_${name}/bin/run", "webhook_${name}.rb"],
    }
}

