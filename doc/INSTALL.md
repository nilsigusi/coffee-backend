# Install steps on CentOS 7



### System

```
yum update -y
yum groupinstall -y 'development tools'
yum install epel-release
```

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
bundle install
rails db:setup RAILS_ENV=production

mkdir /var/sockets
chmod 777 /var/sockets
```
