FROM centos:centos6
MAINTAINER Jumpserver Team <ibuler@qq.com>

WORKDIR /tmp

RUN yum -y install wget sqlite-devel xz gcc automake zlib-devel openssl-devel openssh-clients && sed -i 's@GSSAPIAuthentication yes@GSSAPIAuthentication no@g' /etc/ssh/ssh_config && yum clean all

RUN localedef -c -f UTF-8 -i zh_CN zh_CN.UTF-8 && export LC_ALL=zh_CN.UTF-8 && echo 'LANG=zh_CN.UTF-8' > /etc/sysconfig/i18n

# Install Python
RUN wget https://www.python.org/ftp/python/3.6.1/Python-3.6.1.tar.xz && \
    tar xvf Python-3.6.1.tar.xz  && cd Python-3.6.1 && ./configure && make && make install &&  \
    rm -rf /tmp/{Python-3.6.1.tar.xz,Python-3.6.1}

RUN mv /usr/bin/python /usr/bin/python2
RUN ln -s /usr/local/bin/python3 /usr/bin/python && ln -s /usr/local/bin/pip3 /usr/bin/pip
RUN sed -i 's@/usr/bin/python@/usr/bin/python2@g' /usr/bin/yum

