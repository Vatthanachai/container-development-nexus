FROM jenkins/jenkins:2.580.1-lts-jdk21

# Root is needed to install the toolchains, switched back to jenkins at the end
USER root

ENV DOTNET_ROOT=/usr/share/dotnet \
    DOTNET_NOLOGO=1 \
    DOTNET_CLI_TELEMETRY_OPTOUT=1 \
    PATH=$PATH:/usr/share/dotnet

RUN apt-get update && \
    apt-get install -y --no-install-recommends ca-certificates curl gettext libicu-dev && \
    rm -rf /var/lib/apt/lists/*

# .NET SDK, LTS channels
RUN curl -fsSL https://dot.net/v1/dotnet-install.sh -o /tmp/dotnet-install.sh && \
    chmod +x /tmp/dotnet-install.sh && \
    /tmp/dotnet-install.sh --channel 8.0 --install-dir "$DOTNET_ROOT" && \
    /tmp/dotnet-install.sh --channel 10.0 --install-dir "$DOTNET_ROOT" && \
    rm /tmp/dotnet-install.sh && \
    dotnet --list-sdks

# Node.js LTS
RUN curl -fsSL https://deb.nodesource.com/setup_24.x | bash - && \
    apt-get install -y --no-install-recommends nodejs && \
    rm -rf /var/lib/apt/lists/* && \
    node --version

USER jenkins
