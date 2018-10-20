# A class to setup and install Wonolog
class wonolog (
	$config,
	$content  = $config[mapped_paths][content]
) {
	file { "${content}/mu-plugins":
		ensure => 'directory',
		force  => true,
	}

	file { "${content}/mu-plugins/wonolog":
		ensure => 'directory',
		force  => true,
	    require => File["${content}/mu-plugins"],
	}

	exec { 'install wonolog':
		path        => [ '/bin/', '/sbin/', '/usr/bin/', '/usr/sbin/' ],
		cwd         => "${content}/mu-plugins/wonolog",
		command     => 'composer require inpsyde/wonolog',
		require     => File["${content}/mu-plugins/wonolog"],
		environment => ['HOME=/home/vagrant'],
	}

	file { "${content}/mu-plugins/wonolog.php":
		ensure  => file,
		content => template('wonolog/wonolog.php.erb'),
	}
}
