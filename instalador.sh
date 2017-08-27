#!/bin/bash

# INSTALADOR

function ja_instalado {
	echo "Os programas, módulos e pacotes necessários para-"
	echo "executar o programa Orbitas.py e 23-Set.sh já-"
	echo "foram instalados!"
	echo
	echo -n "Deseja reinstalá-los ?? (s/n): " 
	read resp
	
	resp=$(echo $resp | tr 'a-z' 'A-Z')

	if test "$resp" == "S"
	then
		sed -i 's/^#menu/menu/' instalador.sh
		echo
		echo "Opção de instalação ativada!"
		echo "----------------------------------------------"
		echo "Favor abrir novamente esse programa novamente!"
		echo "Basta digitar na linha do Terminal (prompt):"
		echo
		echo "bash instalador.sh"
		echo "----------------------------------------------"
	else
		exit
	fi
}

function roda_py {
	python3 orbitas.py
	exit			# Ao omitir esse exit, o prg lerá a últ linha desse script (abrindo a funcao ja_instalado). Mas nesse caso, já mata (kill) o processo.
}


function windows {
	sed -i 's/^menu/#menu/' instalador.sh
	echo
	echo "Instalação Windows..."
	sleep 2
	echo
	sudo apt-get install -y hdate itools python3 python3-pip idle-python3.5 ...? 
	pip ephem...?
	
	roda_py
}



function linux {
	sed -i 's/^menu/#menu/' instalador.sh
	echo
	echo "Instalação Linux..."
	echo
	sleep 2
	sudo apt-get update
	sudo apt-get install -y hdate itools python3 python3-pip idle-python3.5
	# sudo apt-get upgrade
	pip3 install --upgrade pip
	pip3 install ephem
	sudo apt-get update
	echo
	echo "Programas instalados!"
	sleep 3
	roda_py
}



function mac {
	sed -i 's/^menu/#menu/' instalador.sh
	echo
	echo "Instalação Mac..."
	echo
	sleep 2
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	brew install hdate itools ical 2>/dev/null
	sudo easy_install pip
	pip install ephem
	echo
	echo "Programas instalados!"
	sleep 3
	roda_py
}


function menu {
	clear
	echo "-----------------------------------"
	echo "Qual é o seu Sistema Operacional ??"
	echo "-----------------------------------"
	echo "W - Windows"
	echo "L - Linux (Debian/Ubuntu)"
	echo "M - Machintosh"
	echo
	read sistema

	sistema=$(echo $sistema | tr 'a-z' 'A-Z')

	echo "Para instalar será necessário:"
	echo " 	1- Estar conectado à internet"
	echo "	2- Talvez pedirá sua senha"
	echo

	if test $sistema == "W";then windows; elif test $sistema == "L";then linux; elif test $sistema == "M";then mac; else echo "Opção inválida... Tente outra vez!"; echo; exit; fi

}


menu

ja_instalado
# Autor: Helio Giroto
