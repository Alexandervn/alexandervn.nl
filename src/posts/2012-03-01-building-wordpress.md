---
template: post.html
date: 2012-03-01
title: Automated builds in Wordpress
slug: building-wordpress
---

When you are working on a project with several developers you want to have an easy way to integrate each others work.

When working with Wordpress though, there is one thing that's hard to integrate: the database. All the settings and content it contains are tightly coupled with your code&mdash;though it is not under version control. 

That's why you can also *just script* everything you need in the database. With an automated build you drop all database tables and rebuild them from code. It will give you a clean sheet when you need it. And it will be a lot easier to integrate your work with others. 

This article will give you some building blocks you need to start automating your Wordpress websites.


Getting Wordpress
------------------

Of course we need Wordpress. The latest Wordpress is always available as a Tarball. As of this writing the latest version is 3.3.1. You can download and unpack it with:

    $ curl -V0 http://wordpress.org/latest.tar.gz
    $ tar -xf latest.tar.gz
    $ rm latest.tar.gz

Installing Wordpress
---------------------------------

To install Wordpress you can use the following code. At a minimum you have to include the following&mdash;where `WP_DIR` is just a constant to your Wordpress directory:

    <?php
    define('WP_INSTALLING', true);

    require(WP_DIR . 'wp-load.php');
    require(WP_DIR . 'wp-admin/includes/upgrade.php');
    require(WP_DIR . 'wp-includes/wp-db.php');

    wp_install(
        'My Wordpress from the commandline', // Title of your blog
        'admin', // Username to make
        'info@example.com', // E-mail address of user
        true, // Whether your site is public
        null, // Deprecated
        'password' // Password of new user
    );

    // Setting the base urls
    update_option('siteurl', 'http://localhost/my-wordpress/');
    update_option('home', 'http://localhost/my-wordpress/');
    ?>

With this you don't need the browser to install Wordpress. You can just run this script in your terminal:

    $ php build.php

Uninstalling Wordpress 
------------------------------

For a proper build you also have to uninstall Wordpress if it is already installed. Therefore add the following to build.php.

    <?php
    function uninstall_wordpress() {
        global $wpdb;

        $wpdb->query('SET foreign_key_checks = 0');
        $tables = $wpdb->get_results('SHOW TABLES', ARRAY_A);

        foreach($tables as $table) {
            $table = current($table);
            $wpdb->query("DROP TABLE IF EXISTS $table");
        }

        $wpdb->query('SET foreign_key_checks = 1');
    }

    if (is_blog_installed()) {
        uninstall_wordpress();
    }
    ?>

Start with a clean install
------------------------------------------

Wordpress adds some default posts and comments as a starting point. You might also want to remove these in your build:

    <?php
    function remove_default_wp_content() {
        global $wpdb;

        $wpdb->query('TRUNCATE TABLE `wp_posts`');
        $wpdb->query('TRUNCATE TABLE `wp_comments`');
        $wpdb->query('TRUNCATE TABLE `wp_links`');
    }
    remove_default_wp_content();
    ?>

General settings
--

See for all the options the `wp_options` table.

    <?php
    update_option('blogdescription', 'My Automated Wordpress');
    update_option('posts_per_page', 6);

    update_option('permalink_structure', '/%year%/%monthnum%/%postname%/');

    // Flush the rewrite rules for the permalinks
    global $wp_rewrite;
    $wp_rewrite->flush_rules();
    ?>

Switching themes
--

Set the theme to: `my_theme`

    <?php
    update_option('template', 'my_theme');
    update_option('stylesheet', 'style.css');
    switch_theme('my_theme', 'my_theme');
    ?>

Activating plugins
--

Also make sure to check out the `wp_options` table, and possibly other tables, for the settings you might want to configure for your plugins.

    <?php
    activate_plugin(WP_DIR . '/wp-content/plugins/my-plugin/my-plugin.php');
    ?>

Adding posts and pages
--

Both posts and pages can be inserted with the same function: `wp_insert_post`. For pages you should set the `post_type` to `page`.

    <?php
    wp_insert_post(array(
        'post_type' => 'post',
        'post_title' =>  'Lorem ipsum',
        'post_status' => 'publish',
        'post_content' => 'Lorem ipsum..'
    ));
    ?>
