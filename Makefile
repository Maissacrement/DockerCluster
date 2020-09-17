#!make

NAME               = nodemaster
SLAVE0             = slave_node
DOCKER             = docker
DOCKER_MACHINE    := `${DOCKER} ps -aqf "ancestor=${NAME}"`
DOCKER_MACHINE_IP := `cat ${PWD}/machines/nodemaster/hosts | head -1`
SSH_REMOTE_PATH    =./machines/nodemaster/linux/ssh_remote_host.sh

machine_id:
	${DOCKER} ps -aqf "ancestor=${NAME}"

active_ssh_on_slave_node:
	@scripts/docker-run-ssh-deamon.sh

ssh_link:
	@echo -e "ssh copy connection on ${DOCKER_MACHINE}"
	if [ -z $(DOCKER_MACHINE) ];then \
	    ${SSH_REMOTE_PATH} `docker-compose ps -q nodemaster`;\
	else \
	    ${SSH_REMOTE_PATH} ${DOCKER_MACHINE}; \
	fi

	
ssh_connect:
	@ssh root@${DOCKER_MACHINE_IP} -p 22

ssh: ssh_link active_ssh_on_slave_node ssh_connect

build:
	docker build -t ${NAME} ./machines/nodemaster --build-arg passwd=unpass

run:
	docker run -it --rm ${NAME}

kill:
	docker stop ${DOCKER_MACHINE}

build_slave:
	docker build -t ${SLAVE0} ./machines/slaves --build-arg passwd=unpass

run_slave:
	docker run -it --rm --name ${SLAVE0} ${SLAVE0} 

$(NAME): build run

$(SLAVE0): build_slave run_slave
