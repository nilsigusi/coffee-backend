# Install steps on CentOS 7

### System

```
yum update -y
# yum groupinstall -y 'development tools' # maybe this is not needed
yum -y install epel-release
yum -y install git net-tools
```

## First steps

### Ruby

```
curl -sSL https://rvm.io/mpapis.asc | gpg --import -
curl -L get.rvm.io | bash -s stable
source /etc/profile.d/rvm.sh
rvm reload
rvm requirements run
rvm install 2.3.0
ruby --version

gem install bundle
```

### Mysql
```
yum install mariadb-server mariadb-devel
systemctl start mariadb
systemctl enable mariadb.service
mysql_secure_installation
```

### Nginx

```
yum install -y nginx
```


## App

```
mkdir /app
cd /app
git clone https://github.com/nilsigusi/coffee-backend.git
cd coffee-backend
```

copy app config files and then fill them with real values
```
cp config/database.yml.example config/database.yml
cp config/ldap.yml.example config/ldap.yml
```

create database for the backend-app
```
mysql -u root -p
CREATE DATABASE coffeeapp;
```

now we are ready to setup the app:
```
bundle install # this takes very very long!
rails -v
# Rails 5.0.0.beta3

rails db:setup RAILS_ENV=production
# config secret key  in `/config/secrets.yml` and run again
```

adjust files for nginx: `/etc/nginx/nginx.conf` and `/etc/nginx/conf.d/default.conf` . Find related files here in `doc` directory.

create SSL certificates:
https://help.github.com/enterprise/11.10.340/admin/articles/using-self-signed-ssl-certificates/

and put them to `/etc/ssl/nginx`

start unicron
```
mkdir pids
mkdir /var/sockets
chmod 777 /var/sockets
unicorn_rails -c config/unicorn.rb -D -E "production"
```

start nginx
```
 systemctl restart nginx
```

enjoy!!

## Post steps

```
systemctl enable mariadb.service
systemctl enable nginx
```
