class webhook {
    
    package { 'sinatra':
        ensure      => present,
        provider    => 'gem', 
    }

    Package <| title == 'sinatra'  |> -> Webhook::Listener <| |>
}
