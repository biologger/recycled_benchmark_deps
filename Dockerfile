FROM mambaorg/micromamba:latest

LABEL maintainer="biologger@protonmail.com"

COPY --chown=$MAMBA_USER:$MAMBA_USER dockerenv.yaml /tmp/dockerenv.yaml

USER root

RUN apt update && apt install ca-certificates git -y && update-ca-certificates

RUN micromamba install -y -n base -f /tmp/dockerenv.yaml && \
    micromamba clean --all --yes
    
RUN mkdir /scripts 
RUN cd /scripts && git clone https://github.com/Freevini/ReCycled.git && chmod +x /scripts/ReCycled/ReCycled.sh

RUN mkdir /benchmark

WORKDIR /benchmark

USER $MAMBA_USER

