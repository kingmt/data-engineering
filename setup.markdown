# Challenge Answer Setup

A majority of convention over configuration settings were left as defaults to make it easier to evaluate the answer without hours of setup.

This setup assumes that the following are installed and working
1. Ruby 2.0 or newer
1. Rubygems
1. Bundler
1. and all the system level dependencies to compile the gems,n the Gemfile which will vary from OS to OS

To actually run the app after the repo is cloned
1. bundle install
1. rake db:reset
1. rails server
1. in a browser navigate to localhost:3000

The app requires OpenID authentication, admittedly I only tested using Google OpenID...
In case you don't have it handy the Google OpenID identity url is:
https://www.google.com/accounts/o8/id


## Miscelaneous Design Descisions

I deliberately left the database as SQLite to minimize the amount of work needed to setup the app. There are too many variables between MySql or Postgres and between Ubuntu and OS X to keep things simple.
