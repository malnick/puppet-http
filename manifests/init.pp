class webhook {
    package { 'sinatra':
        ensure      => present,
        provider    => 'gem', 
    }
    package { 'rack':
        ensure   => present,
        provider => 'gem',
    }

    Package <| |> -> Service <| |>
}
