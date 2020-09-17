FROM ubuntu:20.04

USER root
ARG passwd
ENV HOSTNAME nodemaster

RUN export PS1='${USER}@${HOSTNAME}:~# '

ENV TZ=Europe/Paris
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt update &&\
    apt install -y mysql-server ansible \
    net-tools iproute2 iproute2-doc gawk \
    openssh-server --fix-missing

RUN mkdir /var/run/sshd
RUN echo 'root:'${passwd} | chpasswd
RUN sed -i 's/#*PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed -i 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profileS

RUN mkdir -p /APP
COPY . /APP

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
