# ubuntu cannot install torch
# inherit directly from pytorch/pytorch
FROM ubuntu:20.04

WORKDIR /root

###  essential command lines

Run apt update --yes && apt install --yes \
    zsh \
    wget \
    sudo \
    git \
    curl \
    tree

# install vim8.1 needed when install
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/London

RUN apt install --yes vim-nox

COPY ./src .
RUN chmod +x setup.sh
RUN chmod +x vim_install.sh
RUN chmod +x c_dev_install.sh

ENTRYPOINT ["zsh"]
