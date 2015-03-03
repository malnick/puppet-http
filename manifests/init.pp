class webhook {
    
    package { 'sinatra':
        ensure      => present,
        provider    => 'pe_gem', 
    }

    Package <| title == 'sinatra'  |> -> Webhook::Listener <| |>
}
