# puppet-http

## HTTP Provider
Provider will run a simple query against a webhook. For example, you'd like to run a GET request on ```http://localhost:8080/this```:

### GET    

```ruby
http { 'this':
  ensure      => get,
  port        => '8080',
  fqdn        => 'localhost', # Do not place the http://, this currently done by the provider. Will update for https support soon.
}
```

This is nice if you have a webhook running somewhere to execute a certain command, and you'd like to hit that hook each time you run puppet on a specific node.

### Or POST - All data is mutated to JSON

```ruby
http { 'status':
  ensure  => post,
  port    => '1015',
  fqdn    => 'localhost',
  data    => {
    'hostname'          => $::fqdn,
    'some_data_key'     => '1.2.3',
    'some_other_data'   => 'ImImportant'
  }
}
```

## Listener Defined Type

This module also provides a simple webhook erb template that sets up a listener:

```ruby
include http
http::listener {'puppet':
  port => '6969',
  routes            => { 
    'run_puppet'  => {
      'method'  => 'get',
      'command' => "su - peadmin -c 'mco puppet runonce'"
    },
    'test'        => {
      'method'  => 'get',
      'command' => 'echo fuckitshipit',
    },
  }
}
```

## Listener Defined Type Parameters

```ssl_enable```

```cert_path```

```key_path```

```port```

```bind_address```

```rack_env```

```command```

```http_method```

## Big fucking todo list

1. https support for webhook provider
1. more listener options:
    1. more than one route per webhook
    1. stricter security; github token verification
1. put method for provider
1. other shit I didn't do this sunday

    
