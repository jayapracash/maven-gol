FROM alpine:latest
ENV LANG C.UTF-8 
ENV JAVA_HOME /usr/lib/jvm/java-1.8-openjdk/jre	
RUN echo $JAVA_HOME
RUN apk --update add sudo git wget
#RUN sed -i s/#PermitRootLogin.*/PermitRootLogin\ yes/ /etc/ssh/sshd_config 
#RUN sed -i s/#PasswordAuthentication.*/PasswordAuthentication\ yes/ /etc/ssh/sshd_config 
#RUN sed -i s/#Port.*/Port\ 22/ /etc/ssh/sshd_config 
#RUN sed -i 's/#HostKey \/etc\/ssh\/ssh_host_rsa_key.*/HostKey \/etc\/ssh\/ssh_host_rsa_key/' /etc/ssh/sshd_config 
#RUN sed -i 's/#HostKey \/etc\/ssh\/ssh_host_ecdsa_key.*/HostKey \/etc\/ssh\/ssh_host_ecdsa_key/' /etc/ssh/sshd_config 
#RUN sed -i 's/#ListenAddress 0.0.0.0.*/ListenAddress\ 0.0.0.0/' /etc/ssh/sshd_config 
#RUN sed -i 's/#HostKey \/etc\/ssh\/ssh_host_ed25519_key.*/HostKey \/etc\/ssh\/ssh_host_ed25519_key/' /etc/ssh/sshd_config
#RUN cat /etc/ssh/sshd_config
RUN apk fetch openjdk8
RUN apk add openjdk8
RUN echo "export JAVA_HOME=/usr/lib/jvm/java-1.8-openjdk/jre" >> /etc/bash.bashrc \
	&& source /etc/bash.bashrc
RUN java -version
#RUN addgroup -S jp && adduser --shell /bin/bash --home /home/jp -S -G jp jp 
#RUN echo "jp ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
#RUN adduser jp root
#RUN id jp \
#	&& rm -rf /var/cache/apk/* /tmp/* \
#	&& ls /home
#RUN echo -e "prakash28\nprakash28\n" | passwd jp 
#EXPOSE 22
EXPOSE 80
EXPOSE 8080
EXPOSE 9090
RUN addgroup -S tomcat && sudo adduser --home /opt/tomcat --shell /bin/false -S -G tomcat tomcat
RUN wget http://www-eu.apache.org/dist/tomcat/tomcat-9/v9.0.19/bin/apache-tomcat-9.0.19.tar.gz -P /tmp
RUN sudo tar xf /tmp/apache-tomcat-9*.tar.gz -C /opt/tomcat
RUN sudo chown -RH tomcat: /opt/tomcat/apache-tomcat-9.0.19
RUN sudo sh -c 'chmod +x /opt/tomcat/apache-tomcat-9.0.19/bin/*.sh'
RUN apk add openrc openrc-doc man bash
#To give public access to tomcat comment the value class in context.xml in manager and hostmanager in webapps
COPY ./context.xml /opt/tomcat/apache-tomcat-9.0.19/webapps/manager/META-INF/context.xml
COPY ./context.xml.host-manager /opt/tomcat/apache-tomcat-9.0.19/webapps/host-manager/META-INF/context.xml

COPY ./tomcat-users.xml /opt/tomcat/apache-tomcat-9.0.19/conf/tomcat-users.xml
COPY ./tomcat-alpine-service /etc/init.d/tomcat
COPY ./gameoflife-web/target/gameoflife.war /opt/tomcat/apache-tomcat-9.0.19/webapps/gameoflife.war
RUN chmod 755 /etc/init.d/tomcat
RUN mkdir /run/openrc/
RUN cat dev/null > /run/openrc/softlevel
RUN rc-update \
#    && rc-service tomcat start\   #use this before the cmd or cmd to start tomcat 
    && rc-service --list \
    && rc-update add tomcat \
    && rc-status
RUN sed -i s/8080/9090/ /opt/tomcat/apache-tomcat-9.0.19/conf/server.xml 

WORKDIR /opt/tomcat/apache-tomcat-9.0.19/bin
CMD ["sh","catalina.sh", "run"]

#RUN apk add bash
#RUN ssh-keygen -A
#USER jp
#CMD ["sudo","/usr/sbin/sshd","-D"]
#ENTRYPOINT ["/bin/bash"]
#-------------------to install java from tar----------------------
#USER root
#RUN wget http://download.java.net/java/jdk9-alpine/archive/181/binaries/jdk-9-ea+181_linux-x64-musl_bin.tar.gz
#RUN tar -xzvf *.tar.gz
#RUN chmod +x jdk-9
#RUN mv jdk-9 /usr/local/share
#ENV JAVA_HOME=/usr/local/share/jdk-9
#ENV PATH="$JAVA_HOME/bin:${PATH}"
#RUN rm -rf *.tar.gz
