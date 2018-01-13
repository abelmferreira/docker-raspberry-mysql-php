# docker-raspberry-mysql-php

- Scripts para inicializar aplicações em php com Docker no Raspberry PI
- Utiliza conteiners com Linux Alpine
- Scripts PHP devem ficar em php_app e comando para inicializa-lo deve ser configurado em Docker/phpapp/start.sh
- Mysql cria banco e usuário conforme informado nas variáveis de ambiente declarado no master.sh

# Como usar

```sh
$ ./master.sh install_docker
```

Instala o docker no Raspberry e cria a network para uso pelos conteiners


```sh
$ ./master.sh build_mysql
```

Faz o Build de uma nova imagem baseado no Alpine ARM com o server do Mysql


```sh
$ ./master.sh build_phpapp
```

Faz o Build de uma nova imagem baseado no Alpine ARM com com o PHP7 instalado


```sh
$ ./master.sh start
```

Inicializa todos os conteiners, Mysql e PHP


```sh
$ ./master.sh clean
```

Remove conteiners não utilizados e imagens com nome e tag

