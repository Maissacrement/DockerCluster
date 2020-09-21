FROM ubuntu:20.04

ENV USER root
ENV EDITOR nano
ENV HOSTNAME slave
USER ${USER}
ARG passwd

RUN echo 'root:'${passwd} | chpasswd

ENV TZ=Europe/Paris
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt update &&\
    apt install -y apt-utils ansible ssh man-db cron net-tools nano \
    inetutils-ping lsof

RUN mkdir -p /tmp/socket &&\
    touch /tmp/socket/listener

COPY ./cron.tab /var/spool/cron/crontabs/${USER}
COPY ./playbookrc ~/.playbookrc

RUN sed -i 's/#*PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config

#RUN (sleep 5 &&  \
#        (echo yes >> /tmp/socket/listener) \
#   ) &

RUN echo "export PS1='${USER}@${HOSTNAME}:~# '" >> /root/.bashrc
#RUN echo "source ~/.playbookrc" >> /root/.bashrc
#RUN touch ~/.sparkrc && echo "source ~/.sparkrc" >> /root/.bashrc

EXPOSE 22
ENTRYPOINT ["tail", "-f", "/dev/null"]
#ENTRYPOINT ["/bin/bash"]