FROM centos:6
MAINTAINER Imagine Chiu<imagine10255@gmail.com>


ENV APP_DIR=/home/wwwroot \
    LOG_DIR=/home/wwwlogs \
    CONF_DIR=/home/wwwconfig


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


# Install php-fpm
RUN yum -y --enablerepo=remi-php56,remi,epel install php-fpm php-mbstring php-xml php-mysql php-pdo php-mcrypt php-pecl-memcached php-pecl-msgpack


# Install nginx
RUN yum -y --enablerepo=nginx install nginx


# Setup dir
ADD . /home/
WORKDIR /home


# Create Base Enter Cont Command
RUN chmod 755 ./docker_bash/init.sh && echo "./docker_bash/init.sh" >> /root/.bashrc


# Setting lnmp(php,lnmp)
RUN bash ./docker_bash/setting_lnmp.sh


# Private expose
EXPOSE 3306
EXPOSE 80 81 82


# Volume for web server install
VOLUME ["${APP_DIR}","${LOG_DIR}","${CONF_DIR}"]


# Start run shell
CMD ["bash"]