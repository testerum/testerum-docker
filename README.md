# Introduction

This is the official [Testerum](https://testerum.com/) Runner docker image.
This image can be used to easily run Testerum tests in a CI/CD environment.

# Quick info

* **where to report issues related to this image**: https://github.com/testerum/testerum-docker/issues
* **where to report issues related to Testerum**: https://github.com/testerum/testerum/issues


# Supported tags and respective ``Dockerfile`` links

* [``5.3.5``, ``latest``](https://github.com/testerum/testerum-docker/blob/release-5.3.5/Dockerfile)
* [``5.3.3``](https://github.com/testerum/testerum-docker/blob/release-5.3.3/Dockerfile)
* [``5.2.3``](https://github.com/testerum/testerum-docker/blob/release-5.2.3/Dockerfile)
* [``5.0.3``](https://github.com/testerum/testerum-docker/blob/release-5.2.3/Dockerfile)
* [``3.2.1``](https://github.com/testerum/testerum-docker/blob/release-3.2.1/Dockerfile)
* [``3.1.20``](https://github.com/testerum/testerum-docker/blob/release-3.1.20/Dockerfile)

# What is Testerum?

[Testerum](https://testerum.com/) is the next-generation BDD/acceptance testing tool:
* easy to use **graphical user interface**
* **built-in step library** containing integrations with many technologies (HTTP/REST, HTTP mock servers, Selenium WebDriver, relational databases, etc.)
* readable text format for the tests, making it easy to **check-in the tests** with the source code (e.g. to a git repository)

[![Testerum logo](https://testerum.com/img/logo.png)](https://testerum.com/)


# How to use this image

This image runs Testerum tests. 

To give the Testerum Runner access to your tests, you need to mount a bind volume containing your tests, and optionally, a volume where the test reports will be placed.

To make it easy to run Selenium Webdriver tests, this image also includes Firefox and Chrome, which can run in headless mode.

## Command line examples

```shell script
docker run \
    --rm \
    --user "$(id -u "${USER}"):$(id -g "${USER}")" \
    --volume /path/to/testerum/tests-project-directory:/tests \
    testerum/testerum:latest
```

If you want to also have access to the test reports (recommended), you also need to mount a directory where the reports will be written:

```shell script
docker run \
    --rm \
    --user "$(id -u "${USER}"):$(id -g "${USER}")" \
    --volume /path/to/testerum/tests-project-directory:/tests \
    --volume /path/to/where/the-reports-will-be-written:/reports \
    testerum/testerum:latest
```

To see what command-line arguments are accepted by the Testerum Runner, use ``--help``:
```shell script
docker run \
    --rm \
    --user "$(id -u "${USER}"):$(id -g "${USER}")" \
    --volume /path/to/testerum/tests-project-directory:/tests \
    testerum/testerum:latest \
    --help
```

You should not pass the ``--repository-directory`` and ``--managed-reports-directory`` arguments, since these are already included (and point to ``/tests`` and ``/reports`` directories inside the docker container).

More information about the command-line arguments can be found on the [Testerum Runner documentation page](https://testerum.com/documentation/backend/runner/).

## Note on the user mapping in Linux

This image will create files on the host computer, inside the mapped reports directory. These files will be owned by the user and the group with id ``1000``. In the majority of cases, this is the first non-root user, so everything will have the same permissions as the user that regularly uses that computer/laptop. If you customized your user ID or have a different setup, you may have to change the owner of the reports directory, before you will be able to use the reports:

```shell script
sudo chown myuser: -R /path/to/where/the-reports-will-be-written
```

This only applies to Linux, and shouldn't cause any issues on Windows or Mac.
