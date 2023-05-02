#!/usr/bin/env bash
echo "Informe Qual eh o servico e depois a porta alternativa"
mysql=3306 ; ftp=21 ; http=80
read -r Servico
echo "O "$Servico
echo "A porta $[Servico]"