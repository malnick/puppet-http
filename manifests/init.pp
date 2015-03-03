class webhook {
    
    package { ['sinatra','rack']:
        ensure      => present,
        provider    => 'gem', 
    }

}
