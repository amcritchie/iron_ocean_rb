# ReadMe
## Deploying with Digialt Ocean, Ubuntu 14.04, Capistrano 2, Ruby 2.2.2, Nginx, and Unicorn
### Creating a server
1. Login to [Digital Ocean](https://cloud.digitalocean.com/)
2. Create a name with dashes iron-ocean-production
3. Settings
  * $5/mo
  * San Francisco
  * Ubuntu 14.04
  * IPv6
  * Check ssh key with $ cat ~/.ssh/id_rsa.pub
4. Copy you ip "111.222.333.444"

#### Preparing your Ubuntu server
ssh into your new server.
```
$ ssh root@111.222.333.444
```
Now lets update, to get all the packages on the server to the latest version.
```
root@iron-ocean-production:~# apt-get update
```
Now lets add a few things.
##### Python Software Properties To add repositories to apt.
```
root@iron-ocean-production:~# apt-get -y install curl git-core python-software-properties
```

##### Nginx
```
root@iron-ocean-production:~# add-apt-repository ppa:nginx/stable
root@iron-ocean-production:~# apt-get update
root@iron-ocean-production:~# apt-get -y install nginx
root@iron-ocean-production:~# service nginx start
start: Job is already running: nginx
```

##### Postgres
###### Install
```
root@iron-ocean-production:~# add-apt-repository ppa:pitti/postgresql
root@iron-ocean-production:~# apt-get update
root@iron-ocean-production:~# apt-get install postgresql libpq-dev
```

###### Setup postgres user
```
root@iron-ocean-production:~# sudo -u postgres psql
postgres=# \password
Enter new password:
Enter it again:
```

###### Create user and database
```
postgres=# create user iron with password 'secret';
CREATE ROLE
postgres=# create database iron_ocean_production owner iron;
CREATE DATABASE
postgres=# \q
root@iron-ocean-production:~#
```

##### Postfix for mail
```
root@iron-ocean-production:~# apt-get install postfix
[Internet Site]
[Enter]
```

##### Nodejs
```
root@iron-ocean-production:~# add-apt-repository ppa:chris-lea/node.js
root@iron-ocean-production:~# apt-get update
root@iron-ocean-production:~# apt-get -y install nodejs
```

#### Setup deployer user
```
root@iron-ocean-production:~# addgroup admin
Adding group `admin' (GID 1000) ...
Done.
root@iron-ocean-production:~# adduser deployer --ingroup admin
Adding user `deployer' ...
Adding new user `deployer' (1000) with group `admin' ...
Creating home directory `/home/deployer' ...
Copying files from `/etc/skel' ...
Enter new UNIX password:
Retype new UNIX password:
passwd: password updated successfully
Changing the user information for deployer
Enter the new value, or press ENTER for the default
        Full Name []:
        Room Number []:
        Work Phone []:
        Home Phone []:
        Other []:
Is the information correct? [Y/n] Y
```
```
root@iron-ocean-production:~# su deployer
To run a command as administrator (user "root"), use "sudo <command>".
See "man sudo_root" for details.

deployer@iron-ocean-production:/root$ cd ~
deployer@iron-ocean-production:~$
```
#### Ruby
##### Get rbenv
```
deployer@iron-ocean-production:~$ curl -L https://raw.github.com/fesplugas/rbenv-installer/master/bin/rbenv-installer | bash
```
When this command finishes, we will be told that we haven't added to 'rbenv' to
our load path.  The command will also end in the code segment we need to our bashrc so make sure you copy it.

```
Seems you still have not added 'rbenv' to the load path:

# ~/.bash_profile:

export RBENV_ROOT="${HOME}/.rbenv"


if [ -d "${RBENV_ROOT}" ]; then
  export PATH="${RBENV_ROOT}/bin:${PATH}"
  eval "$(rbenv init -)"
fi
```

To edit the file we’ll use Vim.
```
deployer@iron-ocean-production:~$ vim ~/.bashrc
```
##### Vim

1. ```i```
2. Add rbenv to our load path

 ```
 # for examples

 -------------------Add--------------------
 # ~/.bash_profile:

 export RBENV_ROOT="${HOME}/.rbenv"


 if [ -d "${RBENV_ROOT}" ]; then
   export PATH="${RBENV_ROOT}/bin:${PATH}"
   eval "$(rbenv init -)"
 fi
 -------------------Add--------------------

 # If not running interactively, don't do anything
 case $- in
 ```
3. ```esc```
4. ```:wq```

Load updated bashrc
```
deployer@iron-ocean-production:~$ . ~/.bashrc
```

##### Install
```
deployer@iron-ocean-production:~$ rbenv bootstrap-ubuntu-12-04
```
If you are told 'rbenv' isn't installed, this probably means didn't add the bashrc file.
```
deployer@iron-ocean-production:~$ rbenv install 2.2.2
deployer@iron-ocean-production:~$ rbenv global 2.2.2
deployer@iron-ocean-production:~$ ruby -v
ruby 2.2.2p95 (2015-04-13 revision 50295) [x86_64-linux]
```
If ruby 2.2.2 isn't returned,
this is a red flag that something has gone wrong in this process.


#### Bundler
```
deployer@iron-ocean-production:~$ gem install bundler --no-ri --no-rdoc
deployer@iron-ocean-production:~$ rbenv rehash
deployer@iron-ocean-production:~$ bundle -v
Bundler version 1.10.6
```

### Preparing application
1. Attempt an ssh connection to github.com on our server so that it’s known as a host.
 ```
 deployer@iron-ocean-production:~$ ssh git@github.com
 The authenticity of host 'github.com (207.97.227.239)' can't be established.
 RSA key fingerprint is 16:27:ac:a5:76:28:2d:36:63:1b:56:4d:eb:df:a6:48.
 Are you sure you want to continue connecting (yes/no)? yes
 Warning: Permanently added 'github.com,207.97.227.239' (RSA) to the list of known hosts.
 Permission denied (publickey).
 ```

2. Verify `/config/database.yml` is in the `.gitignore` file
3. Push your code to github
4. Add Capistrano and Unicorn to the gem file.  Be sure to use Capistrano 2
  ```ruby
  # Use unicorn as the app server
  gem 'unicorn'

  # Use Capistrano for deployment
  gem 'capistrano', '~> 2.x', require: false, group: :development
  ```
5. Install gems `$ bundle`

### Capistrano

There are quite a few of commands and files used to prepare Capistrano.
This read me will only focus the specifics that need to be changed from this repo.
To view the specifics view visit [Railscast](http://railscasts.com/episodes/335-deploying-to-a-vps?view=asciicast)

1. Verify the Capfile has the `load 'deploy/assets'` line uncommented
2. In your deploy.rb update the ip address, application name, and github url
3. Replace the 'iron_ocean' variables in nginx and unicorn files
  * (2) nginx.conf
  * (2) unicorn.rb
  * (1) unicorn_init.sh
4. Mark the unicorn_init as executable `$ chmod +x config/unicorn_init.sh`
5. Push your code to github

### Deploy
#### Setup
Capistrano setup will create a few files
```
$ cap deploy:setup
```
If this returns and error, check that you have a database.example.yml
#### Database
```
$ ssh deployer@178.xxx.xxx.xxx
deployer@iron-ocean-production:~$ cd apps/**name-of-app**/shared/config/
deployer@iron-ocean-production:~/apps/**name-of-app**/shared/config$ vim database.yml
```
Update the host, username, and password
```
production:
  adapter: postgresql
  encoding: unicode
  database: blog_production
  pool: 5
  host: localhost
  username: ironocean
  password: secret
```
#### Logging Into The Server Automatically
```
$ cat ~/.ssh/id_rsa.pub | ssh deployer@178.xxx.xxx.xxx 'cat >> ~/.ssh/authorized_keys'
$ ssh-add -K
$ cap deploy:cold
```
#### Configure Nginx
```
$ ssh deployer@178.xxx.xxx.xxx
deployer@iron-ocean-production:~$ sudo rm /etc/nginx/sites-enabled/default
[sudo] password for deployer:
deployer@iron-ocean-production:~$ sudo service nginx restart
Restarting nginx: nginx.
```

```
sudo update-rc.d unicorn_iron_ocean defaults
```


#### Capify
This repo already has the capify files but if you have a new repo use this command
```
$ capify .
[add] writing './Capfile'
[add] writing './config/deploy.rb'
[done] capified!
``

#### Capfile
Verify you Capfile reads as follows
```
load 'deploy'
# Uncomment if you are using Rails' asset pipeline
load 'deploy/assets'
Dir['vendor/gems/*/recipes/*.rb','vendor/plugins/*/recipes/*.rb'].each { |plugin| load(plugin) }
load 'config/deploy' # remove this line to skip loading any of the default tasks
```
####



```
root@iron-blog-production:~# apt-get -y install curl git-core python-software-properties
```

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



# Deploying with Digialt Ocean, Ubuntu 14.04, Capistrano 2, Ruby 2.2.2, Nginx, and Unicorn

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
