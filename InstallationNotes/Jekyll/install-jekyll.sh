
# ! - Make sure resolv.conf is good
# VALIDATE resolv.conf

# Make sure you setup you _/etc/resolv.conf_ file properly. Example:
#domain           enigma
#nameserver       1.1.1.1
#nameserver       1.0.0.1
#nameserver       8.8.8.8


# Update APT Get PACKAGES
sudo apt-get update -y && sudo apt-get upgrade -y

sudo apt-add-repository ppa:brightbox/ruby-ng
sudo apt-get update
sudo apt-get -y install ruby2.5 ruby2.5-dev build-essential  dh-autoreconf ;


# GNU PG
sudo apt install gnupg2
curl -sL "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x2EE0EA64E40A89B84B2DF73499E82A75642AC823" | sudo apt-key add


# INSTALL RVM - BEGIN
curl -sSL https://get.rvm.io -o rvm.sh
cat ./rvm.sh | bash -s stable --rails


# source /home/sammy/.rvm/scripts/rvm
cd /home
cd  $USER
source .rvm/scripts/rvm
# END (rvm)


rvm rubygems 2.7.6  


# Issue with 3.0.0 so go with 2.7
rvm reinstall 2.7.0

gem install bundler

### Create a file named Gemfile with

----------------------------------------
source "https://rubygems.org"

gem "jekyll"

group :jekyll_plugins do
  gem "jekyll-feed"
  gem "jekyll-seo-tag"
end

----------------------------------------


then run -> 'bundle install'

then -> 'bundle exec jekyll serve'



## Lastly

sudo gem update
sudo gem install jekyll bundler
