FROM centos:centos7
MAINTAINER JumpServer Team <ibuler@qq.com>

WORKDIR /tmp

RUN  yum -y install wget zlib-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel readline-devel tk-devel libffi-devel gcc make  \
    && sed -i 's@GSSAPIAuthentication yes@GSSAPIAuthentication no@g' /etc/ssh/ssh_config \
    && yum clean all

RUN localedef -c -f UTF-8 -i zh_CN zh_CN.UTF-8 \
    && export LC_ALL=zh_CN.UTF-8 \
    && echo 'LANG=zh_CN.UTF-8' > /etc/sysconfig/i18n
RUN cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

# Install Python
RUN wget https://www.python.org/ftp/python/3.8.6/Python-3.8.6.tar.xz \
    && tar xvf Python-3.8.6.tar.xz && cd Python-3.8.6 \
    && ./configure && make && make install \
    && cd .. && rm -rf {Python-3.8.6.tar.xz,Python-3.8.6}

RUN  rm -f /usr/bin/python \
    && ln -s /usr/local/bin/python3 /usr/bin/python \
    && ln -s /usr/local/bin/pip3 /usr/bin/pip
RUN sed -i 's@/usr/bin/python@/usr/bin/python2@g' /usr/bin/yum

