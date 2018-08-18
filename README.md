# Selenium

[![Docker Stars](https://img.shields.io/docker/stars/dpet23/selenium.svg)][hub]
[![Docker Pulls](https://img.shields.io/docker/pulls/dpet23/selenium.svg)][hub]
[![Image Layers](https://shields.beevelop.com/docker/image/layers/dpet23/selenium/latest.svg)][hub]
[![Image Size](https://shields.beevelop.com/docker/image/image-size/dpet23/selenium/latest.svg)][hub]

Web testing using [Python 3](https://www.python.org) and [Selenium](https://www.seleniumhq.org)

---

### Supported Tags

* `latest`

View on [Docker Hub][hub]

---

### Build Info

* Based on: [CentOS Linux](https://www.centos.org)

* Packages installed:
  * Git
  * Python 3.6
  * Google Chrome stable and [Chromedriver](https://sites.google.com/a/chromium.org/chromedriver/downloads)
  * Firefox and [Geckodriver](https://github.com/mozilla/geckodriver/releases)
  * [PhantomJS](http://phantomjs.org/download.html)
  * \<other necessary packages\>
* Repositories installed:
  * Extra Packages for Enterprise Linux (EPEL)
  * IUS community repository
  * Google Chrome stable

---

### Docker Pull Command

```shell
docker pull dpet23/selenium
```

---

### Example Usage

1. Clone the repository, build the Docker image, and create a container
    ```shell
    docker build -t dpet23/selenium:latest .
    docker create -it --name selenium dpet23/selenium
    ```

1. Copy the test Python scripts into the container
    ```shell
    docker cp ./tests/. selenium:/tmp/
    ```

1. Run the container
    ```shell
    docker start -ai selenium
    ```

1. Run a test script in the container
    ```shell
    python3 /tmp/Chrome-headless.py
    ```

    The expected output is:
    ```shell
    =====[ START - CHROME ]=====
    Page title: "Welcome to Python.org"
    =====[  END - CHROME  ]=====
    ```

1. Clean up
    ```shell
    exit  # from the container
    docker stop selenium
    docker rm -v selenium
    docker rmi dpet23/selenium
    ```


[hub]: https://hub.docker.com/r/dpet23/selenium
