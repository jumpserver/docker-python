FROM centos:centos7
MAINTAINER JumpServer Team <ibuler@qq.com>

WORKDIR /tmp
ARG PYTHON_VERSION=3.8.6
ENV PYTHON_VERSION=$PYTHON_VERSION

RUN curl https://mirrors.aliyun.com/repo/Centos-7.repo > /etc/yum.repos.d/CentOS-Base.repo \
    && sed -i -e '/mirrors.cloud.aliyuncs.com/d' -e '/mirrors.aliyuncs.com/d' /etc/yum.repos.d/CentOS-Base.repo \
    && curl http://mirrors.aliyun.com/repo/epel-7.repo > /etc/yum.repos.d/epel.repo \
    && yum -y install wget zlib-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel readline-devel tk-devel libffi-devel gcc make \
    && yum clean all

RUN localedef -c -f UTF-8 -i zh_CN zh_CN.UTF-8 \
    && export LC_ALL=zh_CN.UTF-8 \
    && echo 'LANG=zh_CN.UTF-8' > /etc/sysconfig/i18n \
    && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

# Install Python
RUN wget https://www.python.org/ftp/python/${PYTHON_VERSION}/Python-${PYTHON_VERSION}.tar.xz \
    && tar xvf Python-${PYTHON_VERSION}.tar.xz && cd Python-${PYTHON_VERSION} \
    && ./configure && make && make install \
    && cd .. && rm -rf {Python-${PYTHON_VERSION}.tar.xz,Python-${PYTHON_VERSION}}

RUN  rm -f /usr/bin/python \
    && ln -s /usr/local/bin/python3 /usr/bin/python \
    && ln -s /usr/local/bin/pip3 /usr/bin/pip \
    && sed -i 's@/usr/bin/python@/usr/bin/python2@g' /usr/bin/yum

