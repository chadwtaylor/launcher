Launcher
========

Launch your own crowdfunding platform.

Disclaimers
-----------

This is self-promotion for NeverFold in exchange for open-sourcing our own crowdfunding platform after being rejected by Kickstarter on the basis of 'home improvement'.

Examples are the best teachers so we're using NeverFold's real-world experiences in this project. Feel free to re-use contents and alter them however you see fit.

We strongly encourage you to come up with your own Privacy Policy and Terms -- we have left those intact as a guidance for your next big thing!

Stripe is used for payment processing.

Lastly but not least, this project assumes you are comfortable with Rails. NeverFold is not responsible for anything that goes wrong with your project.

Good luck!

Supported Third-Party Services
------------------------------
* Stripe
* Facebook
* Twitter
* Zendesk
* Airbrake
* MailChimp
* Google Analytics
* Woopra
* GoSquared

Getting Started
---------------

### Setting up your database

In this project, we used Postgres and it is free to install from http://postgresapp.com.

### Configuring Launcher

There are few essential files that you must edit to get Launcher up and running.

* rename file `config/application.yml.example` to `config/application.yml` and edit the file.
* rename file `config/database.yml.example` renamed to `config/database.yml` and edit the file.
* edit `db/seed.rb` to build your own rewards.
* edit `config/routes.rb` to route your social media requests.

### Signing up for third-party services

Refer to `application.yml` for details and links to sign up for your accounts.

You will at the most need assigned API keys to enable your third-party services with Launcher. Once you have those API keys in hand, update `config/application.yml`

### Get Launcher running

1. run `rake db:migrate` (make sure your database is set up first)
2. run `rake db:seed`
3. start the server

### Using Heroku

If you're using Heroku, you can copy the `application.yml` configurations over with one line of command in terminal:

    rake figaro:heroku

Launcher Wish List
------------------

* Amazon Payment as an alternate form of collecting funds

Contact
-------

Please contact me at `launcher (at) neverfold (dot) com` if you're using this project for your next big thing. I'll add your website to the list here.

Again, good luck!