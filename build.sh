#!/bin/bash
#

version=$1

if [ -z "$version"  ];then
    echo "Usage: sh build.sh version"
    exit
fi

docker build -t registry.fit2cloud.com/jumpserver/python:$version .
echo "registry.fit2cloud.com/jumpserver/python:$version"
