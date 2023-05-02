#!/bin/bash
echo "Aqui é a parte de autenticação"
echo "Nela nos conectaremos via SSH para autenticar"
echo "(BETA)As Ultimas Opções são para instalação de outros serviços. Baixe o arquivo.sh correspondente"
AutenticacaoSSH="Conecte no Servidor via SSH com DNS ou Não"
OpcaoFraseTeste="Opção Frase de Teste"
select Autentica in "$AutenticacaoSSH" "$OpcaoFraseTeste" Sair
do
echo "Escolheu $Autentica "
#continue
case $Autentica in
"$AutenticacaoSSH")
	echo "Digite abaixo o nome de Usuario: "
  	read -r usuarioServer
	echo "Coloque o nome do Servidor ou o IP: (Sugestao: 192.168.1.69)"
	read -r DNSouIP
	ssh $usuarioServer@$DNSouIP
	./autenticacaoDeUsuarioNoServer.sh
	break;;
"$OpcaoFraseTeste")
	echo "teste de frase funcionou!"
	./autenticacaoDeUsuarioNoServer.sh
	break;;
Sair)
  	echo "Saindo..."
  	break;;
*)
  	echo "Opcao invalida!"
  	echo "Tente novamente"
  	echo " "
  	./autenticacaoDeUsuarioNoServer.sh
  	break;;

esac
done