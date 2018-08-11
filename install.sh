#!/bin/bash -e

export MAGENTO_VERSION=2.2.5
export INSTALL_DIR=/var/www/html
export COMPOSER_HOME=/var/www/.composer/

curl -sS https://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer
cp /u16/docker/auth.json $COMPOSER_HOME

requirements="libpng12-dev libmcrypt-dev libmcrypt4 libcurl3-dev libfreetype6 libjpeg-turbo8 libjpeg-turbo8-dev libpng12-dev libfreetype6-dev libicu-dev libxslt1-dev" \
    && apt-get update \
    && apt-get install -y $requirements \
    && rm -rf /var/lib/apt/lists/* \
    && docker-php-ext-install pdo_mysql \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install gd \
    && docker-php-ext-install mcrypt \
    && docker-php-ext-install mbstring \
    && docker-php-ext-install zip \
    && docker-php-ext-install intl \
    && docker-php-ext-install xsl \
    && docker-php-ext-install soap \
    && docker-php-ext-install bcmath \
    && requirementsToRemove="libpng12-dev libmcrypt-dev libcurl3-dev libpng12-dev libfreetype6-dev libjpeg-turbo8-dev" \
    && apt-get purge --auto-remove -y $requirementsToRemove

chsh -s /bin/bash www-data


# RUN cd /tmp && \ 
  # curl https://codeload.github.com/magento/magento2/tar.gz/$MAGENTO_VERSION -o $MAGENTO_VERSION.tar.gz && \
  # tar xvf $MAGENTO_VERSION.tar.gz && \
  # mv magento2-$MAGENTO_VERSION/* magento2-$MAGENTO_VERSION/.htaccess $INSTALL_DIR

# RUN chown -R www-data:www-data /var/www
# RUN su www-data -c "cd $INSTALL_DIR && composer install"
# RUN su www-data -c "cd $INSTALL_DIR && composer config repositories.magento composer https://repo.magento.com/"  

# RUN cd $INSTALL_DIR \
    # && find . -type d -exec chmod 770 {} \; \
    # && find . -type f -exec chmod 660 {} \; \
    # && chmod u+x bin/magento

# COPY ./install-magento /usr/local/bin/install-magento
# RUN chmod +x /usr/local/bin/install-magento

# COPY ./install-sampledata /usr/local/bin/install-sampledata
# RUN chmod +x /usr/local/bin/install-sampledata

# RUN a2enmod rewrite
# RUN echo "memory_limit=2048M" > /usr/local/etc/php/conf.d/memory-limit.ini

# RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# WORKDIR $INSTALL_DIR

## Add cron job
# ADD crontab /etc/cron.d/magento2-cron
# RUN chmod 0644 /etc/cron.d/magento2-cron \
    # && crontab -u www-data /etc/cron.d/magento2-cron
	
	
	
	
	
# echo "================ Installing locales ======================="
# apt-get clean && apt-get update
# apt-get install -q locales=2.23*

# dpkg-divert --local --rename --add /sbin/initctl
# locale-gen en_US en_US.UTF-8
# dpkg-reconfigure locales

# echo "HOME=$HOME"
# cd /u16

# echo "================= Updating package lists ==================="
# apt-get update

# echo "================= Adding some global settings ==================="
# mv gbl_env.sh /etc/profile.d/
# mkdir -p "$HOME/.ssh/"
# mv config "$HOME/.ssh/"
# mv 90forceyes /etc/apt/apt.conf.d/
# touch "$HOME/.ssh/known_hosts"
# mkdir -p /etc/drydock

# echo "================= Installing basic packages ==================="
# apt-get install -q -y \
  # build-essential=12.1* \
  # curl=7.47.0* \
  # gcc=4:5.3.1* \
  # gettext=0.19.7* \
  # libxml2-dev=2.9.3* \
  # libxslt1-dev=1.1.28* \
  # make=4.1* \
  # nano=2.5.3* \
  # openssh-client=1:7.2p2* \
  # openssl=1.0.2g* \
  # software-properties-common=0.96.20.7 \
  # sudo=1.8.16*  \
  # texinfo=6.1.0* \
  # zip=3.0* \
  # unzip=6.0-20ubuntu1 \
  # wget=1.17.1* \
  # rsync=3.1.1* \
  # psmisc=22.21* \
  # netcat-openbsd=1.105* \
  # vim=2:7.4.1689* \
  # python-lxml

# echo "================= Installing Python packages ==================="
# apt-get install -q -y \
  # python-pip=8.1.1* \
  # python-software-properties=0.96.20* \
  # python-dev=2.7.12*

# echo "================= Installing Git ==================="
add-apt-repository ppa:git-core/ppa -y
apt-get update
apt-get install -q -y git


# echo "================= Adding JQ 1.5.1 ==================="
# apt-get install -q jq=1.5*

# echo "================= Installing Java 1.8.0 ==================="
# . /u16/java/install.sh

# echo "================ Installing apache-maven-3.5.3 ================="
# wget -nv http://www-us.apache.org/dist/maven/maven-3/3.5.3/binaries/apache-maven-3.5.3-bin.tar.gz
# tar xzf apache-maven-3.5.3-bin.tar.gz -C /usr/local && rm -f apache-maven-3.5.3-bin.tar.gz
# ln -fs /usr/local/apache-maven-3.5.3/bin/mvn /usr/bin
# echo 'export PATH=$PATH:/usr/local/apache-maven-3.5.3/bin' >> /etc/drydock/.env

# echo "================ Adding ansible 2.4.3.0 ===================="
# sudo pip install -q 'ansible==2.4.3.0'

# echo "================ Adding boto 2.48.0 ======================="
# sudo pip install -q 'boto==2.48.0'

# echo "================ Adding boto3 ======================="
# sudo pip install -q 'boto3==1.6.16'

# export PK_VERSION=1.2.2
# echo "================ Adding packer $PK_VERSION  ===================="
# export PK_FILE=packer_"$PK_VERSION"_linux_amd64.zip

# echo "Fetching packer"
# echo "-----------------------------------"
# rm -rf /tmp/packer
# mkdir -p /tmp/packer
# wget -nv https://releases.hashicorp.com/packer/$PK_VERSION/$PK_FILE
# unzip -o $PK_FILE -d /tmp/packer
# sudo chmod +x /tmp/packer/packer
# mv /tmp/packer/packer /usr/bin/packer

# echo "Added packer successfully"
# echo "-----------------------------------"

# echo "================= Adding awscli 1.14.64 ============"
# sudo pip install -q 'awscli==1.14.64'

# echo "================= Intalling Shippable CLIs ================="

# git clone https://github.com/Shippable/node.git nodeRepo
# ./nodeRepo/shipctl/x86_64/Ubuntu_16.04/install.sh
# rm -rf nodeRepo

# echo "Installed Shippable CLIs successfully"
# echo "-------------------------------------"

# echo "================= Cleaning package lists ==================="
# apt-get clean
# apt-get autoclean
# apt-get autoremove
