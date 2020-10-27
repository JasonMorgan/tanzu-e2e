FROM ubuntu
COPY kp /usr/local/bin/
RUN apt-get update && apt-get upgrade -yq && \
    apt-get install -yq jq curl apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common && \
    curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl && \
    chmod u+x kubectl && \
    mv kubectl /usr/local/bin