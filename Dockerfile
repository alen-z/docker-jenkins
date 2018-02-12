FROM jenkins/jenkins:lts

USER root

# Prepare for Docker CLI
RUN apt-get update && apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg2 \
    software-properties-common

RUN curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg | apt-key add -

RUN add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") \
    $(lsb_release -cs) \
    stable"

# Install Docker CLI and Maven
RUN apt-get update && apt-get install -y maven docker-ce

# Allow Jenkins user to use Docker
RUN usermod -aG docker jenkins

USER jenkins
