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

### Signing up for third-party services

Refer to `application.yml.example` for details and links to sign up for your accounts.

You will at the most need assigned API keys to enable your third-party services with Launcher.

### Configuring Launcher

There are few essential files that you must edit to get Launcher up and running.

* rename file `config/application.yml.example` to `config/application.yml` and edit the file
* rename file `config/database.yml.example` renamed to `config/database.yml` and edit the file
* edit `db/seed.rb` with offered rewards to your backers

### Get Launcher running

1. run `rake db:migrate`
2. run `rake db:seed`
3. start the server

### Using Heroku

If you're using Heroku, you can copy the application.yml configurations over with one line of command in terminal:

    rake figaro:heroku


Launcher Wish List
------------------

* Amazon Payment as an alternate form of collecting funds



Rails Installation
------------------

- Figaro gem used to define application configurations (see config/application.yml.example)

- seed.rb to feed data into tables

- edit route.rb to define routings especially for facebook, twitter, blog, etc..


BENEFITS OF LAUNCHER
- Supports t-shirt (Kickstarter requires you to contact your backers individually to get their t-shirt sizes -- cumberstone!)
- Kickstarter keeps 5% of your earnings... with Launcher, you don't waste anything.
- Save yourself from countless hours of integrating third-party services.


GETTING STARTED

- download Launcher
- copy application.yml.example and rename to application.yml
- edit application.yml
- copy database.yml.example and rename to database.yml
- edit database.yml
- run rake db:migrate
- run rake db:seed

If using heroku... rake figaro:heroku (this will copy configs from application.yml to heroku)

assetize the pipeline (to convert facebook.js.erb to facebook.js using application configs)

