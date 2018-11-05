FROM node:latest
RUN npm i -g nuclide relay-compiler graphql

RUN apt-get update && apt-get install -y openssh-server
RUN mkdir /var/run/sshd
RUN mkdir -p /root/.ssh
RUN ADD public_key /root/.ssh/authorized_keys
# RUN echo 'root:password' | chpasswd

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

EXPOSE 22
EXPOSE 9090/tcp
EXPOSE 9090/udp
EXPOSE 9091/tcp
EXPOSE 9091/udp
EXPOSE 9092/tcp
EXPOSE 9092/udp
EXPOSE 9093/tcp
EXPOSE 9093/udp
CMD ["/usr/sbin/sshd", "-D"]

# Add Watchman support
ADD watchman /watchman
RUN apt-get install -y libssl-dev autoconf automake libtool libtool-bin python-dev
RUN cd /watchman && ./autogen.sh && ./configure && make -j8 && make install

# Other miscellaneous stuff
RUN apt-get install -y clang-format
