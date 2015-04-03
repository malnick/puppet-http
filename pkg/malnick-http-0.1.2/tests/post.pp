http { 'status':
  ensure  => post,
  port    => '1015',
  fqdn    => 'localhost',
  data    => {
    'hostname'          => $::fqdn,
    'analytics_version' => '1.2.3',
  }
}
