# WordPress

This fork of [wordpress-develop](https://github.com/WordPress/wordpress-develop) is configured to work more effeciently with ARM processors, specifically Apple Silicon chips like M1 and M2.
Whether you want to contribute to WordPress core or just develop your own projects, this fork should help reduce configuration problems on ARM-based machines.

All services in Docker compose have been updated to use ARM version of images where possible. 
Otherwise usage is nearly identical to the original project, see Official ([README.md](https://github.com/WordPress/wordpress-develop/blob/trunk/README.md)).

## Notes and config options

### Nginx

#### Certificates
Update the contents of the public and private certificate keys stored in `/tools/local-env/`, but keep the file names:  
- update `tools/local-env/devunstuck-key.pem` with a new private Key.
- update `tools/local-env/devunstuck.pub` with the paired public Key.

If you choose to change the name of the filenames as well, then also update `ssl_certificate_key` and `ssl_certificate` in the nginx conf file `tools/local-env/default.conf/default.template` to match.

#### ServerNames
This fork is allows you to create multiple test servers that can run simultaneosly on the nginx container.
For example, you may set the env variable `SERVER_NAME='devunstuck1.local, devunstuck2.local'`, to create 2 seperate servers that use the same configuration.


### PHP

The use of custom PHP image([devunstuck / php-xdebug-wpcli-arm](https://hub.docker.com/repository/docker/devunstuck/php-xdebug-wpcli-arm)) may be the biggest difference between this fork and the original project. 
The custom PHP image comes bundled with wpcli and xdebug.


### WPCLI

The [wordpressdevelop/cli](https://registry.hub.docker.com/r/wordpressdevelop/cli#!) image doesn't have an ARM compatible version and can behave in unpredictable ways.
So, instead of being a seperate image, wpcli is installed inside the PHP container. 

#### Usage
The "wp_php" user is setup to use instead of root for WPCLI commands.
Before running `wp` command within container, you will need to`su wp_php`.
An added benefit is the assurance of always knowing `wpcli` and `php-fpm` are using the same version of PHP.


### Xdebug

Xdebug is enabled by default in the php container. 
Have fun finding and fixing issues. :)