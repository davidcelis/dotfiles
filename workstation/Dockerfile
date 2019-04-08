# Install 1password
FROM ubuntu:18.10 as onepassword_builder
RUN apt-get update && apt-get install -y curl ca-certificates unzip
RUN curl -sS -o 1password.zip https://cache.agilebits.com/dist/1P/op/pkg/v0.5.5/op_linux_amd64_v0.5.5.zip && unzip 1password.zip op -d /usr/local/bin && rm 1password.zip

# Install doctl
FROM ubuntu:18.10 as doctl_builder
RUN apt-get update && apt-get install -y wget ca-certificates
RUN wget https://github.com/digitalocean/doctl/releases/download/v1.14.0/doctl-1.14.0-linux-amd64.tar.gz && tar xf doctl-1.14.0-linux-amd64.tar.gz && chmod +x doctl && mv doctl /usr/local/bin && rm doctl-1.14.0-linux-amd64.tar.gz

# Install terraform
FROM ubuntu:18.10 as terraform_builder
RUN apt-get update && apt-get install -y wget ca-certificates unzip
RUN wget https://releases.hashicorp.com/terraform/0.11.13/terraform_0.11.13_linux_amd64.zip && unzip terraform_0.11.13_linux_amd64.zip && chmod +x terraform && mv terraform /usr/local/bin && rm terraform_0.11.13_linux_amd64.zip

# base OS
FROM ubuntu:18.10
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update -qq && apt-get upgrade -y && apt-get install -qq -y \
	build-essential \
	ca-certificates \
	curl \
	docker.io \
	git \
	jq \
	less \
	man \
	mosh \
	openssh-server \
	postgresql-contrib \
	ripgrep \
	silversearcher-ag \
	software-properties-common \
	sudo \
	tig \
	tmate \
	tmux \
	tree \
	unzip \
	wget \
	zip \
	zlib1g-dev \
	--no-install-recommends \
	&& rm -rf /var/lib/apt/lists/*

# Install Fish
RUN apt-add-repository ppa:fish-shell/release-3 && apt-get update && apt-get install fish -y

# Set up SSH for port 3222
RUN mkdir /run/sshd
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
RUN sed 's/#Port 22/Port 3222/' -i /etc/ssh/sshd_config

# Install vim
RUN add-apt-repository ppa:jonathonf/vim -y && apt-get update && apt-get install vim-gtk3 -y

# Install rbenv
RUN git clone https://github.com/rbenv/rbenv.git ~/.rbenv && eval "$(~/.rbenv/bin/rbenv init -)"

# Install ruby-install
RUN wget -O ruby-install-0.7.0.tar.gz https://github.com/postmodern/ruby-install/archive/v0.7.0.tar.gz && \
	tar -xzvf ruby-install-0.7.0.tar.gz && \
	cd ruby-install-0.7.0/ && \
	make install && \
	cd && rm -rf ruby-install-0.7.0*

# Install the latest version of Ruby
RUN wget https://raw.githubusercontent.com/davidcelis/dotfiles/master/ruby-version && \
  ruby-install ruby $(cat ruby-version) -c -i ~/.rbenv/versions/$(cat ruby-version) && \
	rm ruby-version

ENV LANG="en_US.UTF-8"
ENV LC_ALL="en_US.UTF-8"
ENV LANGUAGE="en_US.UTF-8"

RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
	locale-gen --purge $LANG && \
	dpkg-reconfigure --frontend=noninteractive locales && \
	update-locale LANG=$LANG LC_ALL=$LC_ALL LANGUAGE=$LANGUAGE

# For correct colors in tmux
ENV TERM screen-256color

# 1p
COPY --from=onepassword_builder /usr/local/bin/op /usr/local/bin/

# doctl tools
COPY --from=doctl_builder /usr/local/bin/doctl /usr/local/bin/

# Terraform tools
COPY --from=terraform_builder /usr/local/bin/terraform /usr/local/bin/

# Authorize my SSH keys
RUN mkdir ~/.ssh && curl -fsL https://github.com/davidcelis.keys > ~/.ssh/authorized_keys && chmod 700 ~/.ssh && chmod 600 ~/.ssh/authorized_keys

# tmux plugins
RUN git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
RUN git clone https://github.com/tmux-plugins/tmux-open.git ~/.tmux/plugins/tmux-open
RUN git clone https://github.com/tmux-plugins/tmux-yank.git ~/.tmux/plugins/tmux-yank
RUN git clone https://github.com/tmux-plugins/tmux-prefix-highlight.git ~/.tmux/plugins/tmux-prefix-highlight

RUN chsh -s /usr/bin/fish

EXPOSE 3222 60000-60010/udp

WORKDIR /root
COPY scripts/entrypoint /bin/entrypoint
CMD ["/bin/entrypoint"]
