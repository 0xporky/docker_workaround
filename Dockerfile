# my workplace

FROM ubuntu:latest
MAINTAINER Andrew Komar <0xporky@gmail.com>

WORKDIR /root

RUN apt-get update && apt-get install -y \
	python \
	python-pip \
	git \
	byobu \
	curl \
	libncurses5-dev \
	libgnome2-dev \
	libgnomeui-dev \
	libgtk2.0-dev \
	libatk1.0-dev \
	libbonoboui2-dev \
	libcairo2-dev \
	libx11-dev \
	libxpm-dev \
	libxt-dev \
	python-dev \
	python3-dev \
	ruby-dev \
	lua5.1 \
	ua5.1-dev \
	libperl-dev \
&& git clone https://github.com/vim/vim.git \
&& cd vim \
&& ./configure --with-features=huge \
	--enable-multibyte \
	--enable-rubyinterp=yes \
	--enable-pythoninterp=yes \
	--with-python-config-dir=/usr/lib/python2.7/config-x86_64-linux-gnu \
	--enable-perlinterp=yes \
	--enable-luainterp=yes \
	--enable-gui=gtk2 \
	--enable-cscope \
	--prefix=/usr/local \
&& make VIMRUNTIMEDIR=/usr/local/share/vim/vim80 \
&& make install \
&& cd ~ \
&& rm -rf vim \
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
