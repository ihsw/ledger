Installation
============

Packages
--------

#) Required packages for compilation:

    # apt-get install build-essential libxml2-dev libz-dev

#) Download from `http://php.net/downloads.php`

#) Untar the source archive somewhere and start `configure` as such:

    # ./configure --prefix=/usr/local/etc/php-5.5.3 --exec-prefix=/usr/local/etc/php-5.5.3 --without-pear --enable-bcmath --enable-mbstring --with-zlib --with-gettext --enable-fpm --enable-opcache

#) Assuming `configure` went well, finish compiling php:

    # make && make install

#) Create a `php.ini` file for php:

    # cd /usr/local

    # cp src/php-5.5.3/php.ini-development etc/php-5.5.3/lib/php.ini

#) Edit it to have some variant of the following values:

	date.timezone = America/Montreal
	cgi.fix_pathinfo=0

#) Create a sensible php-fpm pool configuration from the default one:

    # cd /usr/local/etc/php-5.5.3/etc

    # cp ./php-fpm.conf.default ./php-fpm.conf

#) Edit it to have some variant of the following values:

    include=etc/fpm.d/*.conf
    pid = run/php-fpm.pid
    error_log = log/php-fpm.log
    syslog.facility = daemon
    syslog.ident = php-fpm
    log_level = notice
    emergency_restart_threshold = 0
    emergency_restart_interval = 0
    process_control_timeout = 0
    process.max = 128
    daemonize = no
    events.mechanism = epoll
    user = www-data
    group = www-data
    listen = var/run/php-fpm.sock
    listen.owner = root
    listen.group = root
    listen.mode = 0666
    pm.max_requests = 500
    slowlog = var/log/$pool.log.slow
    request_slowlog_timeout = 10s
    request_terminate_timeout = 30s
    security.limit_extensions = .php
    env[HOSTNAME] = $HOSTNAME
    env[PATH] = /usr/local/bin:/usr/bin:/bin
    env[TMP] = /tmp
    env[TMPDIR] = /tmp
    env[TEMP] = /tmp

#) Make the pool directory:

    # mkdir /usr/local/etc/php-5.5.3/etc/fpm.d/

#) Create an init script for php-fpm:

    # cp /usr/local/src/php-5.5.3/sapi/fpm/init.d.php-fpm.in /etc/init.d/php-fpm

#) Edit it to have some variant of the following values:

    prefix=/usr/local/etc/php-5.5.3/
    exec_prefix=/usr/local/etc/php-5.5.3/

    php_fpm_BIN=/usr/local/etc/php-5.5.3/sbin/php-fpm
    php_fpm_CONF=/usr/local/etc/php-5.5.3/etc/php-fpm.conf
    php_fpm_PID=/usr/local/etc/php-5.5.3/var/run/php-fpm.pid

Notes
-----

* `--prefix=/usr/local/etc/php-5.5.3 --exec-prefix=/usr/local/etc/php-5.5.3` for install isolation

* `--without-pear` because fuck pear

* `--enable-bcmath --enable-mbstring --with-zlib` because bcmath, mbstring, and zlib support rocks

* `--with-gettext` because internationalization is cool

* `--enable-fpm` because fpm beats the pants off `mod_php`

* `--enable-mysqlnd` because mysqlnd is fast

* `--enable-opcache` because it's native opcode caching

* having supervisord manage the main php-fpm process requires `daemonize = no`

Testing
=======

Functionality Testing
---------------------

#) Run the following commands:

    # /usr/local/etc/php-5.5.3/bin/php --version

    PHP 5.5.3 (cli) (built: Aug 31 2013 21:12:56) 
    Copyright (c) 1997-2013 The PHP Group
    Zend Engine v2.5.0, Copyright (c) 1998-2013 Zend Technologies

    # /usr/local/etc/php-5.5.3/sbin/php-fpm --version

    PHP 5.5.3 (fpm-fcgi) (built: Aug 31 2013 21:13:10)
    Copyright (c) 1997-2013 The PHP Group
    Zend Engine v2.5.0, Copyright (c) 1998-2013 Zend Technologies

#) Start up the php-fpm root process manually:

    # /usr/local/etc/php-5.5.3/sbin/php-fpm -F

    [31-Aug-2013 22:41:34] WARNING: Nothing matches the include pattern '/usr/local/etc/php-5.5.3/etc/fpm.d/*.conf' from /usr/local/etc/php-5.5.3/etc/php-fpm.conf at line 15.
    [31-Aug-2013 22:41:34] NOTICE: fpm is running, pid 20900
    [31-Aug-2013 22:41:34] NOTICE: ready to handle connections