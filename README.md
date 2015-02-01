# puppet-webhook

## Providers

Provider will run a simple query against a webhook. For example, you'd like to run a GET request on ```http://localhost:8080/this```:
    
    webhook { 'this':
        ensure      => get,
        port        => '8080',
        fqdn        => 'localhost',
    }

This is nice if you have a webhook running somewhere to execute a certain command, and you'd like to hit that hook each time you run puppet on a specific node.

You can also ensure ```post``` and pass a ```data``` parameter to it with JSON as the attribute in string format. 

This module also provides a simple webhook erb template that sets up a listener:

```ruby
    webhook::listener { $route:
            listen_port  => $listen_port,
            bind_address => $bind_address,
            rack_end     => $rack_env,
            http_method  => $http_method,
            command      => 'puppet agent -t',
    }
```

