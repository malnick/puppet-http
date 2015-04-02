class http {
    
    package { ['sinatra','rack']:
        ensure      => present,
        provider    => 'gem', 
    }

}
