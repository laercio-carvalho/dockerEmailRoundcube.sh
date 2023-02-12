#!/bin/bash
#docker=/usr/bin/docker
echo "Operacoes Iniciais de Instalação de Roundcube Webmail com o Docker"
echo "O que voce deseja fazer?"
select Docker in  InicializarDocker DockersInstallMail DockerRunMail DockerMailBash DockerMailSaveLocal DockerStatusMail DockerStopMail Sair
do
echo "Escolheu $Docker "
#continue
case $Docker in
InicializarDocker)
  echo "Inicializando Serviço Docker"
  sudo systemctl start docker
  ./dockerEmailRoundcube.sh
  break;;
DockersInstallMail)
  echo "Baixando a imagem do webmail Roundcube"
  sudo docker pull roundcube/roundcubemail
  ./dockerEmailRoundcube.sh
  break;;
DockerRunMail)
  echo "Rodando Serviço de Webmail Roundcube Webmail na porta 3134 para não usar outras portas muito utilizadas como a 8080"
  echo "Troque de porta padrão do Docker de Webmail"
  read -r PortaDocker
  sudo docker run -d -p $PortaDocker:80 roundcube/roundcubemail
  ./dockerEmailRoundcube.sh
  break;;
DockerMailBash)
  echo "pegue o nome do Container"
  docker ps
  echo "Acessando Bast do Webmail"
  echo "Colocque o nome do Container abaixo"
  read -r nameOrId
  docker exec -it $nameOrId bash
  break;;
DockerMailSaveLocal)
  echo "Aqui você vai colocar a porta do host e a pasta que vai receber as configurações do container"
  docker ps
  read -r PortaDocker
  echo "agora coloque o diretorio desejado para o armazenamento das configurações locais do Docker"
  read -r PastaLocalDocker
  mkdir $PastaLocalDocker
  docker run -d -p $PortaDocker:80 -v $PastaLocalDocker:/var/www/html/config roundcube/roundcubemail
  echo "Pronto! Agora você já pode preservar as alterações da pasta $PastaLocalDocker"
  ./dockerEmailRoundcube.sh
  break;;
DockerStatusMail)
  echo "Verificando se o Serviço está ativo"
  docker ps
  ./dockerEmailRoundcube.sh
  break;;
DockerStopMail)
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
  ./dockerEmailRoundcube.sh
  break;;

esac
done