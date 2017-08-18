#!/bin/bash


function busca_coincidencias {
	
	clear
	echo "  Coincidências EXATAS entre Júpiter e Marte:"
	echo "(Datas que estão no mesmo lugar que em 23/09/17"
	echo "==============================================="	

	for linha in $(cat Jupiter_datas.txt)
	do
		mes=$(echo $linha | cut -d'/' -f2)
		ano=$(echo $linha | cut -d'/' -f3)
		mes_ano=$(echo $mes/$ano)
		grep -E $mes_ano Marte_datas.txt
		grep -E $mes_ano Marte_datas.txt >> coincidencias.txt

	done
	echo

	# 

	echo "Coincidências com uma diferenca de UM MÊS A MAIS entre os dois planetas:"
	echo "========================================================================"


	for linha in $(cat Jupiter_datas.txt)
	do
		ano=$(echo $linha | cut -d'/' -f3)	# Se inverte para que nas 4 linhas seguintes nao dê falho...
		mes=$(echo $linha | cut -d'/' -f2)
		mes=$(echo $mes+1 | bc)
		if test "$mes" == "13";then
			mes=1
			ano=$(echo $ano+1 | bc) 
		fi	

		mes_ano=$(echo $mes/$ano)
		grep -E $mes_ano Marte_datas.txt
		grep -E $mes_ano Marte_datas.txt >> coincidencias.txt

	done
	echo

	#

	echo "Coincidências com uma diferenca de UM MÊS A MENOS entre os dois planetas:"
	echo "========================================================================"

	for linha in $(cat Jupiter_datas.txt)
	do

		ano=$(echo $linha | cut -d'/' -f3)
		mes=$(echo $linha | cut -d'/' -f2)
		mes=$(echo $mes-1 | bc)
		if test "$mes" == "0"; then
			mes=12
			ano=$(echo $ano-1 | bc)
		fi

		mes_ano=$(echo $mes/$ano)
		grep -E $mes_ano Marte_datas.txt
		grep -E $mes_ano Marte_datas.txt >> coincidencias.txt

	done
	echo

	cat coincidencias.txt | sort -t/ -k3 -o Jupiter-Marte.txt
	rm coincidencias.txt

	n_vezes=$(cat Jupiter-Marte.txt | wc -l)
	echo "Foram encontradas entre Jupiter e Marte," $n_vezes "ocorrências!"
	echo "As informacoes acima foram gravadas no arquivo: Jupiter-Marte.txt"
	echo




	echo "**********************  *  *****************************"
	echo


	echo "  Coincidências EXATAS entre Júpiter e Vênus:"
	echo "(Datas que estão no mesmo lugar que em 23/09/17"
	echo "==============================================="		

	for linha in $(cat Jupiter_datas.txt)
	do
		mes=$(echo $linha | cut -d'/' -f2)
		ano=$(echo $linha | cut -d'/' -f3)
		mes_ano=$(echo $mes/$ano)
		grep -E $mes_ano Venus_datas.txt
		grep -E $mes_ano Venus_datas.txt >> coincidencias.txt

	done
	echo

	# 

	echo "Coincidências com uma diferenca de UM MÊS A MAIS entre os dois planetas:"
	echo "========================================================================"


	for linha in $(cat Jupiter_datas.txt)
	do
		ano=$(echo $linha | cut -d'/' -f3)	# Se inverte para que nas 4 linhas seguintes nao dê falho...
		mes=$(echo $linha | cut -d'/' -f2)
		mes=$(echo $mes+1 | bc)
		if test "$mes" == "13";then
			mes=1
			ano=$(echo $ano+1 | bc) 
		fi	

		mes_ano=$(echo $mes/$ano)
		grep -E $mes_ano Venus_datas.txt
		grep -E $mes_ano Venus_datas.txt >> coincidencias.txt

	done
	echo

	#

	echo "Coincidências com uma diferenca de UM MÊS A MENOS entre os dois planetas:"
	echo "========================================================================"

	for linha in $(cat Jupiter_datas.txt)
	do

		ano=$(echo $linha | cut -d'/' -f3)
		mes=$(echo $linha | cut -d'/' -f2)
		mes=$(echo $mes-1 | bc)
		if test "$mes" == "0"; then
			mes=12
			ano=$(echo $ano-1 | bc)
		fi

		mes_ano=$(echo $mes/$ano)
		grep -E $mes_ano Venus_datas.txt
		grep -E $mes_ano Venus_datas.txt >> coincidencias.txt

	done
	echo

	cat coincidencias.txt | sort -t/ -k3 -o Jupiter-Venus.txt
	rm coincidencias.txt

	n_vezes=$(cat Jupiter-Venus.txt | wc -l)
	echo "Foram encontradas entre Jupiter e Venus," $n_vezes "ocorrências!"
	echo "As informacoes acima foram gravadas no arquivo: Jupiter-Venus.txt"
	echo


	echo "**********************  *  *****************************"
	echo


	echo "Coincidências EXATAS entre Júpiter, Vênus e Marte:"
	echo " (Datas que estão no mesmo lugar que em 23/09/17"
	echo "=================================================="		

	for linha in $(cat Jupiter-Marte.txt)
	do
		mes=$(echo $linha | cut -d'/' -f2)
		ano=$(echo $linha | cut -d'/' -f3)
		mes_ano=$(echo $mes/$ano)
		grep -E $mes_ano Jupiter-Venus.txt
		grep -E $mes_ano Jupiter-Venus.txt >> coincidencias.txt

	done
	echo

	# 

	echo "Coincidências com uma diferenca de UM MÊS A MAIS entre os 3 planetas:"
	echo "====================================================================="


	for linha in $(cat Jupiter-Marte.txt)
	do
		ano=$(echo $linha | cut -d'/' -f3)	# Se inverte para que nas 4 linhas seguintes nao dê falho...
		mes=$(echo $linha | cut -d'/' -f2)
		mes=$(echo $mes+1 | bc)
		if test "$mes" == "13";then
			mes=1
			ano=$(echo $ano+1 | bc) 
		fi	

		mes_ano=$(echo $mes/$ano)
		grep -E $mes_ano Jupiter-Venus.txt
		grep -E $mes_ano Jupiter-Venus.txt >> coincidencias.txt

	done
	echo

	#

	echo "Coincidências com uma diferenca de UM MÊS A MENOS entre os 3 planetas:"
	echo "======================================================================"

	for linha in $(cat Jupiter-Marte.txt)
	do
		ano=$(echo $linha | cut -d'/' -f3)
		mes=$(echo $linha | cut -d'/' -f2)
		mes=$(echo $mes-1 | bc)
		if test "$mes" == "0"; then
			mes=12
			ano=$(echo $ano-1 | bc)
		fi

		mes_ano=$(echo $mes/$ano)
		grep -E $mes_ano Jupiter-Venus.txt
		grep -E $mes_ano Jupiter-Venus.txt >> coincidencias.txt

	done
	echo

	cat coincidencias.txt | sort -t/ -k3 -o 3planetas.txt
	rm coincidencias.txt

	n_vezes=$(cat 3planetas.txt | wc -l)
	echo "Foram encontradas entre Jupiter, Venus e Marte" $n_vezes "ocorrências!"
	echo "As informacoes acima foram gravadas no arquivo: 3planetas.txt"
	echo
}


busca_coincidencias
