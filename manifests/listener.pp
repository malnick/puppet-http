define webhook::listener (

    $routes, 
    $ssl_enable         = false,
    $port               = undef,
    $cert_path          = undef, 
    $key_path           = undef,
    $rack_env           = 'production',
    $bind_address       = '0.0.0.0',

) {

    #$    validate_hash($routes, "${routes}") 

    File {
        mode  => '0755',
        group => 'root',
        owner => 'root',
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
        content => template('webhook/simple_webhook.rb.erb'),
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
        stop     => "/bin/kill -9 $(/usr/bin/lsof -i :${port} | awk '{print \$2}' | tail -1)",
        provider => 'base',
        require  => File["/usr/local/bin/webhook_${name}/bin/run", "webhook_${name}.rb"],
    }
}

