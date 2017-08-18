#!/bin/bash

# Este script faz uma comparação entre os calendarios judeu e muçulmano para depois cruzar as informações e encontrar em quais ocasiões as duas culturas comemoram seu Ano Novo num mesmo dia.

# O QUE SERÁ INSTALADO PARA RODAR ESTE PROGRAMA:
# 
# No Terminal (Linux):
# sudo apt-get install hdate
# sudo apt-get install itools
#

# Fiz essa função abaixo apenas como um auto-instalador e auto-reparador dele mesmo no caso de usá-lo pela primeira vez:

function instalador {
	echo
	echo "É A 1a. VEZ QUE VC ABRE ESSE PROGRAMA!"
	echo
	echo "Por isso, precisam ser baixados dois programas necessários para que esse este funcione..."
	echo "...E talvez o computador peça a sua senha."
	echo
	echo "Você já está conectado na internet? (s/n)?"
	read resp

	if test "$resp" == "s" || test "$resp" == "S"
	then
		echo "Começando a instalação..."
		sleep 3
		sudo apt-get install -y hdate
		sudo apt-get install -y itools
		sed -i 's/^instalador/#instalador/' AnoNovoJudeuMuculmano.sh
		echo
	else
		echo
		echo "Saindo do programa... Não se pode instalar!"
		exit
	fi
}

clear
echo "=========================="
echo "ANO NOVO JUDEU E MUÇULMANO"
echo "=========================="

instalador	# A partir da 2a.vez que abra esse script, essa linha estará comentada!!! Para executá-lo como da primeira vez, basta apagar o símbolo # do INICIO dessa linha (caso tenha).

function inicio {

	# Formato para Ano Novo Judeu:
	hdate -h 2017 | grep -E " [12] Tishrei" | cut -d"," -f2

	echo

	# Formato para Ano Novo Muçulmano:
	ical -hi 14390101 -d

}

inicio























