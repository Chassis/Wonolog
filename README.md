# Wonolog
A Chassis extension to install and configure
[Wonolog](https://github.com/inpsyde/Wonolog) on your server.

**Note: This extension goes against Chassis's normal workflow as it creates files and folders**

## Usage
1. Clone this extension into your extensions directory e.g. `git clone https://github.com/Chassis/Wonolog.git extensions/wonolog`.
2. Run `vagrant provision`. This extension will create `mu-plugins/wonolog`, install it using Composer and then create `mu-plugins/wonolog.php` to load it into WordPress.
3. Make sure you have `define( 'WP_DEBUG_LOG', true );` set in `local-config.php` so that Wonolog will run.
4. Any logging from Wonolog will be added in `{WP_CONTENT_DIR}/wonolog/{Y/m/d}.log`
