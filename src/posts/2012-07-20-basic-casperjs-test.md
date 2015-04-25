---
template: post.html
date: 2012-07-20
title: Basic Casper.js test
slug: basic-casperjs-test
---

[Casper.js](http://casperjs.org) is an add-on for [Phantom.js](http://phantomjs.org/), which is a headless Webkit which you can inspect with Javascript. Casper.js adds functionality for particularly navigating and testing web pages.

This is a simple example test for a web page. It checks if the correct URL was loaded (without redirects), if the status code is '`200 OK`' and it echoes all errors or `console.log()`'s.

    var casper = require('casper').create({
        verbose: true,
    });

    var url = 'http://duckduckgo.com/';

    casper.on('page.error', function(msg, trace) {
        this.echo("Error: " + msg, "ERROR");
    });

    casper.on('remote.message', function(msg) {
        console.log(msg);
    });

    casper.start(url, function() {
        this.test.assert(this.getCurrentUrl() === url, 'Url is: ' + this.getCurrentUrl());
        this.test.assertHttpStatus(200, 'HTTP status code 200 OK');
    });

    casper.run();

The output of running this might look like this:

    PASS Url is: http://duckduckgo.com/
    PASS HTTP status code 200 OK
