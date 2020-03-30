FROM centos:latest
LABEL maintainer="dpet23"

# Versions
ARG CHROME_DRIVER_VERSION="81.0.4044.69"
ARG GECKODRIVER_VERSION="0.26.0"
ARG PHANTOMJS_VERSION="2.1.1"

# Install packages and set up
RUN rpm --import /etc/pki/rpm-gpg/* \
    && yum install -y -q https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm \
    && yum install -y -q https://centos7.iuscommunity.org/ius-release.rpm \
    && yum update -y -q \
    && yum install -y -q git \
    && yum install -y -q python36u python36u-libs python36u-devel python36u-pip \
    && ln -s /usr/bin/python3.6 /usr/bin/python3 \
    && ln -s /usr/bin/pip3.6 /usr/bin/pip3 \
    && yum install -y -q curl bzip2 \
    && mkdir -p /opt

# Install Chrome and Chromedriver
RUN yum install -y -q unzip openjdk-8-jre-headless xvfb libxi6 libgconf-2-4 \
    && echo "=====[ Installing Chrome ]=====" \
    && echo "[google-chrome]" > /etc/yum.repos.d/google-chrome.repo \
    && echo "name=google-chrome" >> /etc/yum.repos.d/google-chrome.repo \
    && echo "baseurl=http://dl.google.com/linux/chrome/rpm/stable/x86_64" >> /etc/yum.repos.d/google-chrome.repo \
    && echo "enabled=1" >> /etc/yum.repos.d/google-chrome.repo \
    && echo "gpgcheck=1" >> /etc/yum.repos.d/google-chrome.repo \
    && echo "gpgkey=https://dl-ssl.google.com/linux/linux_signing_key.pub" >> /etc/yum.repos.d/google-chrome.repo \
    && yum install -y -q google-chrome-stable \
    && echo "=====[ Installing Chromedriver ]=====" \
    && curl -L -o /tmp/chromedriver_linux64.zip "https://chromedriver.storage.googleapis.com/${CHROME_DRIVER_VERSION}/chromedriver_linux64.zip" \
    && unzip /tmp/chromedriver_linux64.zip -d /tmp/ \
    && mv -f /tmp/chromedriver /usr/local/bin/chromedriver \
    && chown root:root /usr/local/bin/chromedriver \
    && chmod 0755 /usr/local/bin/chromedriver

# Install Firefox and Geckodriver
RUN yum install -y -q libXt-devel \
    && echo "=====[ Installing Firefox ]=====" \
    && curl -L -o /tmp/firefox.tar.bz2 "https://download.mozilla.org/?product=firefox-latest&os=linux64&lang=en-US" \
    && rm -rf /opt/firefox \
    && tar -C /opt -xjf /tmp/firefox.tar.bz2 \
    && chmod 755 /opt/firefox/firefox \
    && ln -fs /opt/firefox/firefox /usr/bin/firefox \
    && echo "=====[ Installing Geckodriver ]=====" \
    && curl -L -o /tmp/geckodriver.tar.gz "https://github.com/mozilla/geckodriver/releases/download/v${GECKODRIVER_VERSION}/geckodriver-v${GECKODRIVER_VERSION}-linux64.tar.gz" \
    && rm -rf /opt/geckodriver \
    && tar -C /opt -zxf /tmp/geckodriver.tar.gz \
    && mv /opt/geckodriver /opt/geckodriver-$GECKODRIVER_VERSION \
    && chmod 755 /opt/geckodriver-$GECKODRIVER_VERSION \
    && ln -fs /opt/geckodriver-$GECKODRIVER_VERSION /usr/bin/geckodriver

# Install PhantomJS
RUN yum install -y -q fontconfig freetype freetype-devel fontconfig-devel libstdc++ \
    && echo "=====[ Installing PhantomJS ]=====" \
    && curl -L -o /tmp/phantomjs.tar.bz2 "https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-${PHANTOMJS_VERSION}-linux-x86_64.tar.bz2" \
    && tar -C /opt -xjf /tmp/phantomjs.tar.bz2 \
    && chmod 755 /opt/phantomjs-${PHANTOMJS_VERSION}-linux-x86_64/bin/phantomjs \
    && ln -s /opt/phantomjs-${PHANTOMJS_VERSION}-linux-x86_64/bin/phantomjs /usr/bin/phantomjs

# Install Python packages
COPY ./requirements.txt /tmp/
RUN pip3 install -r /tmp/requirements.txt

# Clean up
RUN rm -v /tmp/*
