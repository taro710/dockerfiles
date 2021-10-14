FROM ubuntu:latest

EXPOSE 19132/udp

RUN apt update

RUN apt install -y zsh
RUN apt install -y vim
RUN apt install -y git
RUN apt install -y tmux

# メインシェル変更
RUN chsh -s `which zsh`

WORKDIR /root

# prezto導入
RUN git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"

# dotfile導入
RUN git clone https://github.com/taro710/dotfiles.git

RUN cp $HOME/dotfiles/.zpreztorc $HOME
RUN cp $HOME/dotfiles/.zshrc $HOME
RUN cp $HOME/dotfiles/.vimrc $HOME

# vimプラグイン導入
RUN chmod 775 $HOME/dotfiles/.vim/myplugins.sh
RUN cd $HOME/dotfiles/.vim/ && ./myplugins.sh

CMD ["zsh"]