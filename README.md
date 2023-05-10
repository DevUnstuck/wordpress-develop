# WordPress Develop for ARM

This fork of [wordpress-develop](https://github.com/WordPress/wordpress-develop) is configured to work more effeciently with ARM processors, specifically Apple Silicon chips like M1 and M2.

Usage is nearly identical to the original project ([README.md](https://github.com/WordPress/wordpress-develop/blob/trunk/README.md)). 

Main differences Compared with the original project:
- the Docker services' images in this build use `arm` platform where possible. 
- WPCLI is bundled into the PHP image.
- Nginx and PHP are pre-configured for lengthy debugging sessions.

Whether you want to contribute to WordPress core or work on your own projects using the official WP image for contributors, the mods in this fork should speed up your time to code.

## Notes and config options

### Nginx

#### Certificates
To enable HTTPS, create the public and private certificate keys at the following locations( using `ssh-keygen` or other tool ):  
- Create `tools/local-env/devunstuck-key.pem` private Key.
- Create `tools/local-env/devunstuck.pub` public Key.

If you choose to rename the keys with your own custom key pair name, remember to also:
- Update the relevant `volumes:` entries in `wordpress-develop` service.
- Update`ssl_certificate_key` and `ssl_certificate` in the nginx conf file `tools/local-env/default.conf/default.template` to match.
    ```
    ...
    ssl_certificate /root/custom-key-pair-name;
    ssl_certificate_key /root/custom-key-pair-name;
    ...
    ```

#### ServerNames 
You can create multiple test servers to run simultaneosly on the nginx container.
For example, you may set the env variable `SERVER_NAME='devunstuck1.local, devunstuck2.local'`, to create 2 seperate servers that use the same configuration.


### PHP

The use of custom PHP image([devunstuck / php-xdebug-wpcli-arm](https://hub.docker.com/repository/docker/devunstuck/php-xdebug-wpcli-arm)) may be the biggest difference between this fork and the original project. 
The custom PHP image comes bundled with wpcli and xdebug.

It is based on [php - Official Image](https://hub.docker.com/_/php), and can be used in similar fashion.

Includes:
- [WP-CLI](https://wp-cli.org/) 
    - The official [wordpressdevelop/cli](https://registry.hub.docker.com/r/wordpressdevelop/cli#!) image doesn't have a ARM compatible version.
    Rather than using a seperate container, wpcli is installed to avoid setup struggles on devices like Apple Silicon powered M1, M2.
- [Xdebug](https://xdebug.org/).
- strace

## WPCLI
To run `wp` commands, first `su wp_php`, so as not to use root. Then run `wp ...` command like usual.

## Xdebug
Xdebug is enabled by default.