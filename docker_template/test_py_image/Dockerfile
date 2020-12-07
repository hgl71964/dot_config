FROM python:3.8

WORKDIR /usr/src/app

COPY requirements.txt .

RUN pip install -r requirements.txt

# to get zsh 
RUN ["apt-get", "update"]
RUN ["apt-get", "install", "-y", "zsh"]
RUN wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true
# end of zsh setting

# TODO: add vim as the default editor and pull from github to apply settings

COPY ./src .
CMD ["zsh"]
#ENTRYPOINT ["bash"]
