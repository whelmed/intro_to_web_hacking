# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/xenial64"

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  config.vm.network "forwarded_port", guest: 80, host: 8080

  # View the documentation for the provider you are using for more
  # information on available options.

  # Define a Vagrant Push strategy for pushing to Atlas. Other push strategies
  # such as FTP and Heroku are also available. See the documentation at
  # https://docs.vagrantup.com/v2/push/atlas.html for more information.
  # config.push.define "atlas" do |push|
  #   push.app = "YOUR_ATLAS_USERNAME/YOUR_APPLICATION_NAME"
  # end

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  config.vm.provision "shell", inline: <<-SHELL
    apt-get update -y
    apt-get install -y php libapache2-mod-php php-mcrypt php-mysql php-gd mysql-client apache2 vim unzip git php-xml php-bcmath
    
    sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password h3k0nf_4nfJs'
    sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password h3k0nf_4nfJs'
    sudo apt-get -y install mysql-server    

    rm /var/www/html/index.html

    cd /home/ubuntu
    git clone https://github.com/ethicalhack3r/DVWA.git dvwa

    cd dvwa
    rsync -av -R ** /var/www/html
    cd /var/www/html

    a2enmod rewrite

    chown -R www-data:www-data /var/www/html

    mysql -h 127.0.0.1 -u root -ph3k0nf_4nfJs  -e "CREATE DATABASE dvwa;"
    mysql -h 127.0.0.1 -u root -ph3k0nf_4nfJs  -e "grant all privileges on dvwa.* to 'root'@'localhost' identified by 'h3k0nf_4nfJs'; flush privileges;"
    #mysql -h 127.0.0.1 -u root -ph3k0nf_4nfJs  -e "flush privileges;"

    cp /vagrant/config.php /var/www/html/config/config.inc.php
    cp /vagrant/.htaccess /var/www/html/config/.htaccess
    
    sudo chmod g+w /var/www/html/hackable/uploads/
    sudo chmod g+w /var/www/html/external/phpids/0.6/lib/IDS/tmp/phpids_log.txt
    
    service apache2 restart
    
  SHELL
end
