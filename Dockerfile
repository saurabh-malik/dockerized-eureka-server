FROM openjdk:8-jdk
MAINTAINER Saurabh Malik <saurabh.malik1@globallogic.com>

# Gradle
ENV GRADLE_VERSION 2.13
ENV GRADLE_SHA 0f665ec6a5a67865faf7ba0d825afb19c26705ea0597cec80dd191b0f2cbb664

RUN cd /usr/lib \
 && curl -fl https://downloads.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip -o gradle-bin.zip \
 && echo "$GRADLE_SHA gradle-bin.zip" | sha256sum -c - \
 && unzip "gradle-bin.zip" \
 && ln -s "/usr/lib/gradle-${GRADLE_VERSION}/bin/gradle" /usr/bin/gradle \
 && rm "gradle-bin.zip"

# Set Appropriate Environmental Variables
ENV GRADLE_HOME /usr/lib/gradle
ENV PATH $PATH:$GRADLE_HOME/bin

VOLUME ["/root/.gradle/caches"]
# Set working dir
WORKDIR /usr/bin/app
ADD /. /usr/bin/app
RUN ["gradle", "clean", "build"]

RUN cd build/libs \ && ls

#Change working directory to keep the jar
WORKDIR /tmp

# Move the build jar to tmp folder
RUN mv /usr/bin/app/build/libs/eureka-server.jar /tmp/app.jar

RUN /bin/bash -c 'touch /tmp/app.jar'
EXPOSE 8761
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/tmp/app.jar"]
