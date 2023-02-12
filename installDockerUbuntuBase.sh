#!/bin/bash
#docker=/usr/bin/docker
echo "Começaremos a Instalar e Configurar o Docker"
echo "Aqui será dividido em varios passos, escolha o numero correspondente: "
echo "(BETA)As Ultimas Opções são para instalação de outros serviços. Baixe o arquivo.sh correspondente"
select Docker in DockersEssencials DockersGPGKey DockerSetupRepository DockerInstall DockerTesting DockerEmailServer
do
echo "Escolheu $Docker "
#continue
case $Docker in
DockersEssencials)
  echo "Atualizando pacotes: "
  sudo apt update
  echo "Instalando Pacotes essenciais..."
  sudo apt install ca-certificates curl gnupg lsb-release
  ./installDockerUbuntuBase.sh
  break;;
DockersGPGKey)
  echo "Adicionando a chave GPG do Docker"
  sudo mkdir -m 0755 -p /etc/apt/keyrings
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
  ./installDockerUbuntuBase.sh
  break;;
DockerSetupRepository)
  echo "Setando o Repositorio"
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  ./installDockerUbuntuBase.sh
  break;;
DockerInstall)
  echo "Atualizando Repositorios"
  sudo apt update
  echo "Corrigindo possiveis problemas com permissoes"
  sudo chmod a+r /etc/apt/keyrings/docker.gpg
  sudo apt update
  echo "Instalando ultima versao do Dockor Engine: "
  sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
  ./installDockerUbuntuBase.sh
  break;;
DockerTesting)
  echo "Testando Docker..."
  sudo docker run hello-world
  echo "Docker Instalado e configurado com sucesso!"
  break;;
DockerEmailServer)
  echo "Começar a Instalar Servidor de Email"
  ./dockerEmailRoundcube.sh
  break;;
*)
  echo "Opcao invalida!"
  echo "Tente novamente"
  echo " "
  ./installDockerUbuntuBase.sh
  break;;

esac
done