GITCOMMIT := $(shell git rev-parse --short=7 HEAD 2>/dev/null)
NAME=tomato

all: build

build:
	docker build -t davidcelis/${NAME}:${GITCOMMIT} .

push:
	@echo "==> Publishing davidcelis/${NAME}:$(GITCOMMIT)"
	@docker tag davidcelis/${NAME}:$(GITCOMMIT) davidcelis/${NAME}:latest
	@docker push davidcelis/${NAME}:$(GITCOMMIT)
	@docker push davidcelis/${NAME}:latest
	@echo "==> Your image is now available at davidcelis/${NAME}:$(GITCOMMIT)"

run: kill
	docker run -it -h tomato -d --net=host --rm -v /var/run/docker.sock:/var/run/docker.sock -v /Users/davidcelis/Developer:/home/davidcelis/Developer -v /Users/davidcelis/.ssh:/home/davidcelis/.ssh -v /Users/davidcelis/.config/fish/local.fish:/home/davidcelis/.config/fish/local.fish --cap-add=SYS_PTRACE --security-opt seccomp=unconfined --privileged --name tomato davidcelis/tomato

ssh:
	mosh --no-init --ssh="ssh -o StrictHostKeyChecking=no -i ~/.ssh/id_ed25519 -p 3222" davidcelis@localhost -- tmux new-session -AD -s main

kill:
	docker kill tomato | true


.PHONY: all build run kill
