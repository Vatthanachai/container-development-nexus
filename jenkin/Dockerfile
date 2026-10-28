FROM jenkins/agent:latest
 # Switch to root to install .NET Core SDK
USER root

# Just for my sanity... Show me this distro information!
RUN uname -a && cat /etc/*release

RUN apt-get update && apt-get full-upgrade -y && \
    apt-get install -y wget curl libunwind8 gettext apt-transport-https

RUN wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb && \    
    dpkg -i packages-microsoft-prod.deb

RUN curl -s https://deb.nodesource.com/setup_16.x | bash

RUN apt-get update && apt autoremove -y

# Install the .Net Core framework, set the path, and show the version of core installed.
RUN apt-get install -y \ 
    dotnet-sdk-3.1 \
    dotnet-sdk-6.0 \ 
    dotnet-sdk-7.0 && \    
    dotnet --info

RUN apt install -y nodejs && \
    node --version

# Good idea to switch back to the jenkins user.
USER jenkins
