<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the
 * installation. You don't have to use the web site, you can
 * copy this file to "wp-config.php" and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * MySQL settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://codex.wordpress.org/Editing_wp-config.php
 *
 * @package WordPress
 */

// ** MySQL settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', 'wordpress' );

/** MySQL database username */
define( 'DB_USER', 'admin' );

/** MySQL database password */
define( 'DB_PASSWORD', 'admin' );

/** MySQL hostname */
define( 'DB_HOST', 'mysql-service' );

/** Database Charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8' );

/** The Database Collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

define('WP_SITEURL', 'http://' . $_SERVER['HTTP_HOST']);
define('WP_HOME', 'http://' . $_SERVER['HTTP_HOST']);

/**#@+
 * Authentication Unique Keys and Salts.
 *
 * Change these to different unique phrases!
 * You can generate these using the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}
 * You can change these at any point in time to invalidate all existing cookies. This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define('AUTH_KEY',         '>Ij{iy5DO+4+aix|.|&cf^|uo`|5G768@xlYQTGR~}PXV;l~Zg1+E th=%#6keEG');
define('SECURE_AUTH_KEY',  'NU^h={y}DJ24aN2{^y}G<R}Lj>.vMX%d]2~A~9N|->jN_i_&<8(x+Sz+FN<5o&a5');
define('LOGGED_IN_KEY',    'l:pITbSPxQ/(L|peI<,k-`r`dQ^Uf,0BW|-M!-_WiF*&c{=B__/RuEm(^=!NHFRq');
define('NONCE_KEY',        '6C4|_7ERIR9QO#1[W:v<G>J-J4?&b&u-u$7mzT!#i{oc4)H:-{S|+<OS4)Zifry7');
define('AUTH_SALT',        'd>><*~yF4w*KX/W /,G (ukVMEQ-ohDc.5g;J{4uuN3voib[|`xwDhlV*N%8m)J/');
define('SECURE_AUTH_SALT', '7.!]I<c^a^a=%ECwz0;t=*b#[1y)wP|%dAeQh.|W<v.xRR]Qusi&}mj=RR>Qii7A');
define('LOGGED_IN_SALT',   'vO(nKe;(B=]`pIVV,ZUSbHK()3J|`|r1q+Wz7S~?xQYy6*6!!<>}BiAhDyk-G3)d');
define('NONCE_SALT',       '_<-JLHUj]6|uaVNhW#2R^X4-HE@T^^G|uFvZP7mK6.>6y{z.<Iv7Yo!W-aIYAcHw');
/**#@-*/

/**
 * WordPress Database Table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix = 'wp_';

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the Codex.
 *
 * @link https://codex.wordpress.org/Debugging_in_WordPress
 */
define( 'WP_DEBUG', false );

/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', dirname( __FILE__ ) . '/' );
}

/** Sets up WordPress vars and included files. */
require_once( ABSPATH . 'wp-settings.php' );