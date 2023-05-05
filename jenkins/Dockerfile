FROM jenkins/jenkins:latest

USER root
RUN echo "deb http://ftp.de.debian.org/debian sid main" >> /etc/apt/sources.list
RUN apt-get update && apt-get install build-essential -y

RUN apt-get -y install cmake         \
        curl                         \
        g++                      \
        gcc                          \
        gdb                          \
        git                                 \
        python3                      \
        rlwrap                       \
        ruby                         \
        strace                       \
        sudo                         \
        systemd                       \
        tar                          \
        tcsh                         \
        tmux                         \
        tree                         \
        unzip                        \
        diffutils                           \
        valgrind                     \
        wget                         \
        zip                          \
        zsh                          \
        vim apt-utils pip

# Large layer was splitted because build timeout on push to github package
RUN     apt-get -y install            \
        ghc                                 \
        nodejs                              \
        php                          \
        php-bcmath                   \
        php-cli                      \
        php-gd                       \
        php-mbstring                 \
        php-xml                      \
        bc

RUN cd /tmp \
    && curl -sSL "https://github.com/Snaipe/Criterion/releases/download/v2.4.1/criterion-2.4.1-linux-x86_64.tar.xz" -o /tmp/criterion-2.4.1.tar.xz \
    && tar xf criterion-2.4.1.tar.xz \
    && cp -r /tmp/criterion-2.4.1/* /usr/local/ \
    && echo "/usr/local/lib" > /etc/ld.so.conf.d/usr-local.conf \
    && ldconfig

RUN cd /tmp \ 
   && curl -sSL https://get.haskellstack.org/ | sh

RUN apt-get update

RUN cd /tmp \
    && rm -rf /tmp/* \
    && chmod 1777 /tmp


USER jenkins

ENV JAVA_OPTS="-Djenkins.install.runSetupWizard=false"
# ENV CASC_JENKINS_CONFIG=/var/jenkins_home/my_marvin.yml

COPY plugin.txt /usr/share/jenkins/ref/plugin.txt

RUN jenkins-plugin-cli --plugin-file /usr/share/jenkins/ref/plugin.txt
