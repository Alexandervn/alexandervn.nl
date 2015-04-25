---
template: post.html
date: 2012-05-03
title: How to install ZeroMQ with PHP binding on Ubuntu 11.10
slug: install-zeromq-php-ubuntu
---

Some version numbers:

* Ubuntu 11.10 server (64-bit)
* PHP 5.3.6
* ZeroMQ 2.1.11
* VirtualBox 4.1.8

Make sure you have all the packages:

    sudo apt-get install build-essential libtool autoconf 
    \ uuid-dev php5 php5-dev pkg-config git

Installing ZeroMQ:

    wget http://download.zeromq.org/zeromq-2.1.11.tar.gz 
    tar -xvzf zeromq-2.1.11.tar.gz
    cd zeromq-2.1.11.tar.gz
    ./configure
    make
    sudo make install
    sudo ldconfig

Installing the PHP binding:

    git clone git://github.com/mkoppanen/php-zmq.git
    cd php-zmq
    phpize && ./configure
    make
    sudo make install

And finally add the following line to your /etc/php5/(apache2|cli)/php.ini:

    extension=zmq.so

Testing if it works, add this to zmq.php:

    <?php var_dump(class_exists('ZMQContext')); ?>

And run:

    php zmq.php
