# H1
## H2
### H3
#### H4
##### H5
###### H6

== README


# Deploying with Digialt Ocean, Ubuntu 14.04, Capistrono 2, Ruby 2.2.2, Nginx, and Unicorn

## Setting up a droplet
* Login to [Digital Ocean](https://cloud.digitalocean.com/)
* Create a name


### Setting up a droplet

#### Setting up a droplet

##### Setting up a droplet

###### Setting up a droplet



```javascript
function fancyAlert(arg) {
  if(arg) {
    $.facebox({div:'#foo'})
  }
}
```

gem 'capistrano', '~> 2.x', require: false, group: :development




This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...


Setting up Git
-Create Git Repo
-In terminal
    -$ git init
    -$ git add .
    -$ git commit -m 'inital commit'
    -$ git remote add origin git@github.com:username/repo.git
    -$ git git push -u origin master

Pushing to Heroku
-$ heroku create iron-ocean
-$ heroku git:remote -a iron-ocean
-$ git push heroku master

Data Base
-in config/database.yml change names of databases
-$ rake db:create
-$ rake db:migrate


New Table
- $ rails g model Message user_id:integer body:string


Restarting DB
-Close all instnaces of db runnging, e.g., 'rails c' and 'rails s'
-$ rake db:drop db:create db:migrate db:seed

Set up Figaro
- $ bundle exec figaro install
- In the config/application file add ENV values

-After pushing to heroku run (below) to populate all the env variables
-$ figaro heroku:set -e production


Pushing to heroku with a change to the assets
-$ RAILS_ENV=production bundle exec rake assets:precompile
-$ git add .
-$ git commit -m 'message'
-$ git push
-$ git push heroku master

Carrierwave - after bundle this generator to create the Carrierwave class
-$ rails g uploader image


Pushing to Digital Ocean
-Create a droplet
--Droplet Host name: iron-ocean-production
--$5
--San Fransicso
--Ubuntu
-Use ubuntu 14.01
-get ssh key $ cat ~/.ssh/id_rsa.pub

Preparing Ubuntu server.
-SSH into the server
--$ ssh root@107.170.223.75
--yes
-Udpate to get the latest packages
--# apt-get -y update
-Used for adding Repos to apt
--# apt-get -y install curl git-core pythone-software-properties
-Get nginx
--# add-apt-repository ppa:nginx/stable
--[Enter]
-Update again
--# apt-get -y update
-Install nginx
--# apt-get -y install nginx
-Start nginx
--# service nginx start
-Add latest postgres
--# add-apt-repository ppa:pitti/postgresql
--[Enter]
-Update again
--# apt-get -y update
-Install postgres
--# apt-get -y install postgresql libpq-dev

-Login as postgres user
--# sudo -u postgres psql
--# \password
--: hmr
--: hmr
--# create user ironocean with password 'secret';
--# create database iron_ocean_production owner ironocean;
--# \q

-Intall application for mailing
--# apt-get -y install telnet postfix
--[Enter]
--[Enter]

-Add nodejs
--# add-apt-repository ppa:chris-lea/node.js
--# apt-get -y update
--# apt-get -y install nodejs

-Create deployer
--# adduser deployer
--: hmr
--: hmr
--] [Enter][Enter][Enter][Enter][Enter] Y
--# su deployer
--# cd

-Adding ruby
--# curl https://raw.githubusercontent.com/fesplugas/rbenv-installer/master/bin/rbenv-installer | bash
-Add to Bash rc
if [ -d "${RBENV_ROOT}" ]; then
  export PATH="${RBENV_ROOT}/bin:${PATH}"
  eval "$(rbenv init -)"
fi
--# vim ~/.bashrc
--i
-Load if stament before first function
--esc
--:wq


-Load Bash RC
--$ . ~/.bashrc

-Install so rmagic will work
--# apt-get install libmagickwand-dev




Please feel free to use a different markup language if you do not plan to run
<tt>rake doc:app</tt>.



# Deploying with Digialt Ocean, Ubuntu 14.04, Capistrono 2, Ruby 2.2.2, Nginx, and Unicorn

## Setting up a droplet
* Login to [Digital Ocean](https://cloud.digitalocean.com/)
* Create a name


### Setting up a droplet

#### Setting up a droplet

##### Setting up a droplet

###### Setting up a droplet



```javascript
function fancyAlert(arg) {
  if(arg) {
    $.facebox({div:'#foo'})
  }
}
```

gem 'capistrano', '~> 2.x', require: false, group: :development
