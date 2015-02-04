class webhook {
    package { 'sinatra':
        ensure      => present,
        provider    => 'gem', 
    }
}
