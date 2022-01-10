Docker image with ejudge contest management system
==================================================

This image contains [ejudge contest management system](https://ejudge.ru).

System login and password are `ejudge`.

Data stored in `/home/ejudge`

Supported compilers:

* Free Pascal
* GNU C
* GNU C++
* Java 11
* Python 2
* Python 3
* PHP 7.4
* Perl
* FreeBASIC

Recommended to set "Language settings" - "Maximum VM size for compilers" to memory size of the machine.

Building
========

    $ docker build -t ejudge .
    
Running
=======

    $ docker run -d \
        --name ejudge \
        -p 80:80 \
        -v /opt/ejudge:/home/ejudge
        ejudge

License
=======

BSD, see `LICENSE`
