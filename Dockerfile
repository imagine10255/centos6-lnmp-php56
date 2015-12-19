FROM centos:centos6
MAINTAINER Imagine Chiu<imagine10255@gmail.com>


ENV SSH_PASSWORD=P@ssw0rd


# Install base tool
RUN yum -y install vim wget tar


# Install develop tool
RUN yum -y groupinstall development


# Install rpm
RUN rpm --import http://ftp.riken.jp/Linux/fedora/epel/RPM-GPG-KEY-EPEL-6 && \
    rpm -ivh http://ftp.riken.jp/Linux/fedora/epel/6/x86_64/epel-release-6-8.noarch.rpm && \
    yum -y update epel-release && \
    cp -p /etc/yum.repos.d/epel.repo /etc/yum.repos.d/epel.repo.backup && \
    sed -i -e "s/enabled=1/enabled=0/g" /etc/yum.repos.d/epel.repo && \
    rpm --import http://rpms.famillecollet.com/RPM-GPG-KEY-remi && \
    rpm -ivh http://rpms.famillecollet.com/enterprise/remi-release-6.rpm && \
    yum -y update remi-release && \
    rpm -ivh http://nginx.org/packages/centos/6/noarch/RPMS/nginx-release-centos-6-0.el6.ngx.noarch.rpm && \
    yum -y update nginx-release-centos && \
    cp -p /etc/yum.repos.d/nginx.repo /etc/yum.repos.d/nginx.repo.backup && \
    sed -i -e "s/enabled=1/enabled=0/g" /etc/yum.repos.d/nginx.repo


# Install SSH Service
RUN yum install -y openssh-server passwd
RUN sed -ri 's/#UsePAM no/UsePAM no/g' /etc/ssh/sshd_config && \
    echo "${SSH_PASSWORD}" | passwd "root" --stdin


# Install crontab service
RUN yum -y install  vixie-cron crontabs


# Install php-fpm (https://webtatic.com/packages/php56/)
RUN yum -y --enablerepo=remi-php56,remi,epel install php-fpm php-mbstring php-xml php-mysql php-pdo php-mcrypt php-pecl-msgpack php-gd.x86_64 php56w-common php56w-opcache php-pecl-memcached


# Install nginx
RUN yum -y --enablerepo=nginx install nginx


# Setting composer
RUN curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer


# Install laravel-envoy
RUN composer global require "laravel/envoy=~1.0"


# Install supervisor
RUN yum -y install python-setuptools && \
    easy_install supervisor && \
    echo_supervisord_conf > /etc/supervisord.conf && \
    supervisord -c /etc/supervisord.conf


# Copy files for setting
ADD . /opt/


# Create Base Enter Cont Command
RUN chmod 755 /opt/docker/bash/init-bashrc.sh && echo "/opt/docker/bash/init-bashrc.sh" >> /root/.bashrc && \
    echo 'export PATH="/root/.composer/vendor/bin:$PATH"' >> /root/.bashrc


# Setting lnmp(php,lnmp)
RUN chmod 755 /opt/docker/bash/setting-lnmp.sh && bash /opt/docker/bash/setting-lnmp.sh


# Setting DateTime Zone
RUN cp -p /usr/share/zoneinfo/Asia/Taipei /etc/localtime


# Setup default path
WORKDIR /home


# Private expose
EXPOSE 22 80 81 82


# Volume for web server install
VOLUME ["/home"]


# Start run shell
CMD ["bash"]
