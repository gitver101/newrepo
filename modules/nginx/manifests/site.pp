# nginx::site
define nginx::site(
    $ensure   = present,
    $content  = undef,
    $source   = undef,
) {
    include ::nginx

    $basename = regsubst($title, '[\W_]', '-', 'G')

    file { "/etc/nginx/sites-available/${basename}":
        ensure  => $ensure,
        content => $content,
        source  => $source,
        require => Package['nginx'],
    }

    file { "/etc/nginx/sites-enabled/${basename}":
        ensure => link,
        target => "/etc/nginx/sites-available/${basename}",
        notify => Service['nginx'],
    }
}
