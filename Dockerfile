# my workplace

FROM ubuntu:latest
MAINTAINER Andrew Komar <0xporky@gmail.com>

RUN apt-get update && apt-get install -y \
	vim \
	python \
	python-pip \
	git \
	byobu \
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
&& vim -c PluginInstall -c quitall

ADD .ssh/ ~/
ADD .gnupg/ ~/
