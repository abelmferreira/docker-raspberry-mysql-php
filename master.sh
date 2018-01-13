#!/bin/bash

IMAGE_NAME_MYSQL=arm/alpine-mysql
IMAGE_NAME_PHP=arm/alpine-phpapp
DOCKERFILE_MYSQL=Docker/Dockerfile-mysql
DOCKERFILE_PHP=Docker/Dockerfile-phpapp
USAGEMSG="Usage : $0 {start|start_mysql|start_phpapp|build_mysql|build_phpapp|clean|install_docker}"


if [ $# -lt 1 ]
then
        echo $USAGEMSG
        exit
fi


case "$1" in
	start)
		$0 start_mysql
		$0 start_phpapp
		;;

	start_mysql)
		echo "Iniciando Mysql Docker conteiner"
		docker run -d --rm --name mysql -p 3306:3306 -v $(pwd)/data_mysql:/app --network=myBridge \
			-e MYSQL_ROOT_PASSWORD=automacao \
			-e MYSQL_DATABASE=automacao \
			-e MYSQL_USER=autom \
			-e MYSQL_PASSWORD=autom \
			$IMAGE_NAME_MYSQL
		;;

	start_phpapp)
		echo "Iniciando PHP Docker conteiner"
		docker run -d --rm --name phpappUdp -p 85:85/udp -v $(pwd)/php_app:/app/daemon --network=myBridge \
			-e MYSQL_DATABASE=automacao \
			-e MYSQL_USER=autom \
			-e MYSQL_PASSWORD=autom \
			-e MYSQL_HOST=mysql \
			-e ARDUINOS_SUBNET="192.168.25." \
			$IMAGE_NAME_PHP /app/start.sh udp
		;;

	build_mysql)
		docker build -t ${IMAGE_NAME_MYSQL}:latest -f ${DOCKERFILE_MYSQL} .
		;;
	
	build_phpapp)
		docker build -t ${IMAGE_NAME_PHP}:latest -f ${DOCKERFILE_PHP} .
		;;

	logs)
		docker logs -f --tail 50 $2
		;;

	clean)
		docker rm $(docker ps -a -q)
		docker rmi $(docker images | grep "^<none>" | tr -s " " | grep " <none> " | cut -d' ' -f3 | tr '\n' ' ')
		;;

	install_docker)
		curl -sSL https://get.docker.com |sh
		docker network create --driver bridge myBridge
		;;

	*)
		echo $USAGEMSG
		exit 1
		;;
esac