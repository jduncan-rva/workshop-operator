FROM centos
RUN yum -y update
RUN yum -y install epel-release; yum -y install python-devel python-setuptools python-pip httpd make; yum -y clean all
COPY requirements.txt /tmp/
RUN pip install --upgrade pip
RUN pip install -U Sphinx
RUN pip install -r /tmp/requirements.txt
COPY docs/ /opt/docs/
WORKDIR /opt/docs
RUN sphinx-build . /var/www/html
EXPOSE 80
CMD ["/usr/sbin/httpd", "-DFOREGROUND"]
LABEL maintainer="jduncan@redhat.com"
