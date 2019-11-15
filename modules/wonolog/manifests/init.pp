# A class to setup and install Wonolog
class wonolog (
	$config,
	$content = $config[mapped_paths][content],
	$version = $config[php]
) {
	file { "${content}/mu-plugins":
		ensure => 'directory',
		force  => true,
	}

	file { "${content}/mu-plugins/wonolog":
		ensure  => 'directory',
		force   => true,
		require => File["${content}/mu-plugins"],
	}

	exec { 'install wonolog':
		path        => [ '/bin/', '/sbin/', '/usr/bin/', '/usr/sbin/' ],
		cwd         => "${content}/mu-plugins/wonolog",
		command     => 'composer require inpsyde/wonolog',
		require     => [
			File["${content}/mu-plugins/wonolog"],
			File["/etc/php/${version}/cli/conf.d/wonolog.ini"],
			File["/etc/php/${version}/fpm/conf.d/wonolog.ini"],
			Exec['install composer']
		],
		environment => ['HOME=/home/vagrant'],
	}

	file { "${content}/mu-plugins/wonolog.php":
		ensure  => file,
		content => template('wonolog/wonolog.php.erb'),
		require => Exec['install wonolog']
	}

	file { "/etc/php/${version}/cli/conf.d/wonolog.ini":
		ensure  => file,
		content => template('wonolog/wonolog.ini.erb'),
		owner   => 'root',
		group   => 'root',
		mode    => '0644',
		notify  => Service["php${version}-fpm"]
	}

	file { "/etc/php/${version}/fpm/conf.d/wonolog.ini":
		ensure  => file,
		content => template('wonolog/wonolog.ini.erb'),
		owner   => 'root',
		group   => 'root',
		mode    => '0644',
		notify  => Service["php${version}-fpm"]
	}
}
