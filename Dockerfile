# my workplace

FROM ubuntu:latest
MAINTAINER Andrew Komar <0xporky@gmail.com>

RUN apt update && apt-get install -y \
	vim \
	python \
	python-pip \
	git \
	byobu \
	curl \
&& pip install --upgrade pip \
&& pip install pyflakes pep8 pylint ipython \
&& git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim \
&& mkdir ~/vimconfig \
&& git clone https://github.com/0xporky/Vim-config.git ~/vimconfig \
&& cp ~/vimconfig/.vimrc ~/.vimrc \
&& rm -rf ~/vimconfig \
&& mkdir ~/vimcolors \
&& git clone https://github.com/Relrin/dotfiles.git ~/vimcolors \
&& cp -r ~/vimcolors/vim/colors ~/.vim/colors \
&& rm -rf ~/vimcolors \
&& mkdir ~/closetag \
&& git clone https://github.com/vim-scripts/closetag.vim.git ~/closetag \
&& mkdir ~/.vim/scripts \
&& cp ~/closetag/plugin/closetag.vim ~/.vim/scripts/closetag.vim \
&& rm -rf ~/closetag \
&& vim -c PluginInstall -c quitall \
&& curl -sL https://deb.nodesource.com/setup_7.x | bash - \
&& apt-get install -y nodejs

ADD .ssh /root/.ssh
ADD gpgkeys /root/gpgkeys

RUN gpg --import /root/gpgkeys/public.key \
&& gpg --import /root/gpgkeys/secret.key \
&& rm -rf /root/gpgkeys
