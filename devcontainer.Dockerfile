FROM ubuntu:22.04

RUN apt update && \
    apt install -y wget curl zsh git build-essential unzip vim ca-certificates curl gnupg lsb-release

# Install Docker cli
RUN mkdir -m 0755 -p /etc/apt/keyrings
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
RUN echo \
  "deb [arch=amd64 signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu jammy stable" \
    | tee /etc/apt/sources.list.d/docker.list > /dev/null
RUN apt update && \
    apt install -y docker-ce-cli docker-buildx-plugin docker-compose-plugin

# Install kubernetes in docker
RUN curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.17.0/kind-linux-amd64
RUN chmod +x ./kind
RUN mv ./kind /usr/local/bin/kind

# Install kubectl
RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
RUN install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# Install go
RUN wget https://go.dev/dl/go1.20.linux-amd64.tar.gz
RUN rm -rf /usr/local/go && tar -C /usr/local -xzf go1.20.linux-amd64.tar.gz

# Install can
run wget https://github.com/SasSwart/can/releases/latest/download/linux_amd64.zip \
    && unzip linux_amd64.zip \
    && mv build/linux_amd64 /usr/local/can \
    && ln -s /usr/local/can/can /usr/local/bin/can

RUN mkdir "/workspace"
WORKDIR /workspace

ARG DOCKER_GROUP_GID
RUN adduser user
RUN groupadd -g $DOCKER_GROUP_GID docker
RUN usermod -aG docker user

RUN chsh -s /usr/bin/zsh user

USER user

RUN cd \
    && wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh \
    && chmod +x ./install.sh \
    && ./install.sh \
    && rm ./install.sh

RUN echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.zshrc
RUN echo 'export PS1="(devcontainer) $PS1"' >> ~/.zshrc

ENTRYPOINT /usr/bin/zsh