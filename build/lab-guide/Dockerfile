FROM centos
RUN yum -y update
RUN yum -y install epel-release; yum -y install python-devel python-setuptools python-pip make; yum -y clean all
COPY requirements.txt /tmp/
RUN pip install --upgrade pip
RUN pip install -U Sphinx
RUN pip install -r /tmp/requirements.txt
COPY docs/ /opt/docs/
WORKDIR /opt/docs
RUN make html
EXPOSE 8080
WORKDIR /opt/docs/_build/html/
CMD ["python", "-m", "SimpleHTTPServer", "8080"]
LABEL maintainer="jduncan@redhat.com"
