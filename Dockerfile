FROM ubuntu:20.04

ENV TZ=America/Sao_Paulo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update -y
RUN apt-get install python python3-pip python3.8 firefox wget -y

# Volumes to store results and tests
VOLUME /opt/robotframework/results
VOLUME /opt/robotframework/resources
VOLUME /opt/robotframework/tests

# Installing firefox driver

RUN wget https://github.com/mozilla/geckodriver/releases/download/v0.31.0/geckodriver-v0.31.0-linux64.tar.gz
RUN tar -xvzf geckodriver-v0.31.0-linux64.tar.gz
RUN chmod +x geckodriver
RUN mv -f geckodriver /usr/local/bin/geckodriver

# Install requirements
COPY ./requirements.txt ./
RUN pip3 install --no-cache-dir -r requirements.txt



