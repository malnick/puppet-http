class webhook {
    
    package { ['sinatra','rack']:
        ensure      => present,
        provider    => 'pe_gem', 
    }

}
