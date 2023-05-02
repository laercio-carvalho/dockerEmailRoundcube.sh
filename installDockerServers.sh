#!/bin/bash
#!/bin/bash
#docker=/usr/bin/docker
echo "Operacoes Iniciais de Instalação de Roundcube Webmail com o Docker"
echo "O que voce deseja fazer?"
select Docker in  InicializarDocker DockersInstallServer DockerRunServer DockerServerBash DockerServerSaveLocal DockerServerStatus DockerServerStop Sair
do
echo "Escolheu $Docker "
#continue
case $Docker in
InicializarDocker)
	echo "Inicializando Serviço Docker"
  	sudo systemctl start docker
  	./installDockerServers.sh
  	break;;
DockersInstallServer)
  	echo "Escolha o nome do Servidor que voce quer baixar"
  	read -r ServerChoice
  	sudo docker pull $ServerChoice
  	./installDockerServers.sh
  	break;;
DockerRunServer)
  	echo "Digite o nome do serviço e depois Troque de porta padrão do Docker de seu Servidor(ou repita ela) "
  	mysql=3306 ; http=80 ; postfix=25 ; IMAP=143 ; Pop3=110
  	read -r PortaServicoDockerPadrao
  	read -r PortaDockerLocal
  	echo "Agora o nome do Serviço"
  	read -r ServerChoice
  	sudo docker run -d -p $[PortaDockerLocal]:$[PortaServicoDockerPadrao] $ServerChoice
  	./installDockerServers.sh
  	break;;
DockerServerBash)
  	echo "pegue o nome do Container"
  	docker ps -a
  	echo "Acessando Bast do Webmail"
  	echo "Colocque o nome do Container abaixo"
  	read -r nameOrId
  	docker run -it $nameOrId bash
  	break;;
DockerServerSaveLocal)
  	echo "Aqui você vai colocar a porta do host e a pasta que vai receber as configurações do container"
  	docker ps
  	read -r PortaDockerLocal
  	echo "agora coloque o diretorio desejado para o armazenamento das configurações locais do Docker"
  	echo "Sugestao ( /home/popos/Servidores/NOME"
  	read -r PastaParcialDocker
  	PastaAtualDocker=$HOME/Servidores/$PastaParcialDocker
  	mkdir $PastaAtualDocker
  	echo "Diga o nome do Servidor Docker: "
  	read -r ServerChoice
  	echo "Diga o nome do local padrão dos arquivos de Configuração do Docker Desejado: "
  	read -r OriginalConfigServer
  	docker run -d -p $PortaDockerLocal:80 -v $PastaAtualDocker:$OriginalConfigServer $ServerChoice
  	echo "Pronto! Agora você já pode preservar as alterações da pasta $PastaAtualDocker"
  	./installDockerServers.sh
  	break;;
DockerServerStatus)
  	echo "Verificando se o Serviço está ativo"
  	docker ps -a
  	./installDockerServers.sh
  	break;;
DockerServerStop)
  	echo "Parando Serviço de Webmail Roundcube..."
  	docker ps
  	echo "Pegue o nome ou id do container que você que parar e digite abaixo: "
  	read -r nameOrId
  	sudo docker stop $nameOrId
  	break;;
Sair)
  	echo "Saindo..."
  	break;;
*)
  	echo "Opcao invalida!"
  	echo "Tente novamente"
  	echo " "
  	./installDockerServers.sh
  	break;;

esac
done