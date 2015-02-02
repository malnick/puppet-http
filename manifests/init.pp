class webhook {
    package { 'sinatra':
        ensure      => present,
        provider    => 'pe_gem',
    }
}
