From ubuntu:14.04 as base
RUN apt-get update
RUN apt-get install -y gawk wget git-core diffstat unzip texinfo gcc-multilib \
     build-essential chrpath socat git

From base as GUIEclipse
RUN apt-get install -y libsdl1.2-dev xterm

From GUIEclipse as doc
RUN apt-get install -y make xsltproc docbook-utils fop dblatex xmlto

From doc as ADT
RUN apt-get install -y autoconf automake libtool libglib2.0-dev libarchive-dev
RUN apt-get install -y python-git nano
RUN touch /etc/locale
RUN locale-gen "en_US.UTF-8"
RUN dpkg-reconfigure locales
RUN update-locale LANG=en_US.UTF-8
RUN export LC_ALL=en_US.UTF-8
RUN export LANG=en_US.UTF-8
RUN export LANGUAGE=en_US.UTF-8
RUN locale-gen
