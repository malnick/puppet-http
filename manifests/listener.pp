define http::listener (

    $routes             = {},
    $ssl_enable         = false,
    $port               = undef,
    $cert_path          = undef, 
    $key_path           = undef,
    $rack_env           = 'production',
    $bind_address       = '0.0.0.0',

) {

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
        content => template('http/simple_webhook.rb.erb'),
        notify  => Service["webhook_${name}"],
    }

    file {"/usr/local/bin/webhook_${name}/logs":
        ensure => directory,
    }

    file {"/usr/local/bin/webhook_${name}/bin":
        ensure => directory,
    }

    file {"/usr/local/bin/webhook_${name}/bin/run":
        ensure  => file,
        content => template('http/run.erb'),
    }

    file { "/etc/init.d/webhook_${name}":
      ensure  => file,
      content => template('http/init.erb'),
      mode    => '0755',
      notify  => Service["webhook_${name}"],
    }

    service {"webhook_${name}":
        ensure     => running,
        enable     => true,
        require    => [Package['sinatra'],File["/usr/local/bin/webhook_${name}/bin/run", "webhook_${name}.rb"]],
    }
}

