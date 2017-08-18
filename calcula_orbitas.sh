#!/bin/bash

# Para entender o código: VÁ PARA A ÚLTIMA LINHA DESTE SCRIPT PARA SABER QUAL É A PRIMEIRA FUNCAO QUE É CHAMADA...


function cria_datas { 
	# Esta funcão faz que cada item (linha) do arquivo de órbitas seja transformado em DATAS (dd/mm/aaa):

	# Caso esse arquivo planeta_datas.txt já exista, irá "resetá-lo":
	if test -a $planeta"_datas.txt"; then rm $planeta"_datas.txt";fi

	for cada_item in $(cat $planeta"_orbitas.txt")
	do
		date -d "2017/09/23 +$cada_item"''"days" +"%d/%m/%Y" >> $planeta"_datas.txt"	# Começa contar a partir de 23/Set/2017
		# Se vc usa MacOs - Substitua a linha acima por esta abaixo:
	#	date... 	

	# Se ainda assim não funcione corretamente, baixe os arquivos prontos em: 
	done

	echo "Terminado! Arquivo" $planeta"_datas.txt criado!"
	echo

	echo "Gostaria de comparar as órbitas para encontrar todas as coincidências de localizacao? (s/n)" 
	read resp

	if test "$resp" == "s" || "$resp" == "S" 2> /dev/null		# Suprime mensagens de erro (caso digite n, x, q, etc)
	then
		# busca_coincidencias
		bash compara_orbitas.sh
	else 
		echo "Fechando programa..."
		echo
		exit
	fi
}

function arredonda {

#	echo "0" > $planeta"_arredondado.txt"		# inclui 0 na primeira linha como ponto inicial

	# Essa função fará que cada item (linha) do arquivo dos dias da órbita seja arredondado (para evitar números decimais):

	for linha in $(cat $planeta"_orbitas.txt")
	do
		tem_ponto=$(echo $linha | grep -Fo ".")
		if test "$tem_ponto" == "."; then			# Tem uma parte decimal nesse item ? Se não, vai p/ 293
			inteiro=$(echo $linha | cut -d'.' -f1)
			decimal=$(echo $linha | cut -d'.' -f2 | grep -E ^[0-9]+)
			if [[ $decimal -gt 50 ]] 2> /dev/null	# Se o decimal é maior que 50, então... // (2> ...): Suprime msg de erro 
			then					
				inteiro=$((inteiro+1))		# Acrescenta 1 ao inteiro (arredonda para mais).
								# podia ser tb inteiro=$(echo $(expr $inteiro + 1))
			fi
		else
			echo $linha >> $planeta"_arredondado.txt"	# Caso a linha (item) não tenha uma parte decimal...
		fi

		echo $inteiro >> $planeta"_arredondado.txt"
	done			# Aqui termina a função, e abaixo, faz ajustes:

	# Ajustes nos nomes arquivos criados:
	rm $planeta"_orbitas.txt"				# Limpa os arquivos com nros. decimais e...
	mv $planeta"_arredondado.txt" $planeta"_orbitas.txt"	# renomeia os demais para nome-do-planeta_orbitas.txt
	sed -i '/^$/d' $planeta"_orbitas.txt"			# CORREÇÃO: Para apagar algumas linhas em branco do arquivo! (????)

	echo
	echo -e "Um arquivo chamado: ---" $planeta"_orbitas.txt --- foi gerado! 
Ao abrir este arquivo, você terá uma lista em NÚMERO DE DIAS 
sobre quando $planeta voltará a passar NUM MESMO PONTO do céu 
nos próximos $anos ANOS!"
	echo
	echo "Agora falta converter o arquivo" $planeta"_orbitas.txt para datas no formato - Dia/Mês/Ano" 
	echo "Presione ENTER para continuar..."
	read 
	echo
	echo "Criando arquivo de datas..."
	cria_datas
}


function calcula_Venus {
#
# 	O trânsito de Vênus é diferente porque passa-
# 	pelo mesmo ponto no céu numa sequencia- 
# 	de a cada 293 407 409 292 410 317 84 299 411 dias a partir de 23 de Setembro de 2017! *
#	Por isso, o cálculo é mais complexo que o de Marte e de Júpiter.
#
#	Ou seja: Para saber qual será sua posicao futura (uma outra data) há que respeitar -
#	a ordem dos intervalos dentro dessa sequencia de dias acima!
#
#	A ordem dos intervalos é: 293 407 409 292 410 317 84 299 411 dias.
#
#	Além disso, a cada 80 anos se deve diminuir 4 dias para estar-
#	mais exata a sua localizacao no céu.
#	
#     *	Para se saber a localizacao exata do astro numa data diferente de 23 de Setembro,-
#	seria necessário consultar no Stellarium qual seria sua posicao futura naquele mesmo ponto para- 	
#	ajustar na sequencia, conforme a ordem dos intervalos dessa sequencia.
#
#	O único que se pode garantir com exatidão é:- 
#	Vênus sempre estará num mesmo ponto do céu a cada 8 anos exatos (2922 dias) a partir da data que seja.
# 	Faca o teste: No Stellarium, vá a quelquer data, localize Venus e depois mude para 8 anos. Ele estará justo no mesmo lugar!
#	Pois é o valor total da sequencia de intervalos 293+407+409+292+410+317+84+299+411 = 2922, porém-
#	dentro desses 8 anos, ele terá passado 9 vezes muito perto daquele mesmo lugar no céu (conforme a sequência).
#

	echo
	echo "Quer saber sua órbita num período de quantos ANOS? "
	read anos

	if test $anos -lt 8;then echo; echo "	O período de órbitas será arredondado para 8 anos"; fi

	dia_orbita=0
	echo $dia_orbita > $planeta"_orbitas.txt"	# Cria novo arq chamado Venus.txt com valor 0 na 1a.linha

	sequencia=(293 407 409 292 410 317 84 299 411)	# Sequencia dos vários intervalos (em dias) em que Venus faz sua órbita.

	# Um ciclo é um período de 8 anos em que Vênus realiza a sequencia acima.
	# É necessário para que saibamos quantas vezes a sequencia será calculada... 
	# P.ex: 4 ciclos = 4 vezes que a sequencia será calculada.
	
	tot_ciclos=$((anos/8+1))	# Acrescenta 1 ciclo a mais para efeito de melhor funcionamento dos cálculos 

	for cada_ciclo in $(seq 1 $tot_ciclos)	# $tot_ciclos = O numero de vezes que se calculará a sequencia abaixo:
	do
		for cada_intervalo in ${sequencia[*]}
		do
			dia_orbita=$(echo "$dia_orbita+$cada_intervalo" | bc)
			echo $dia_orbita >> $planeta"_orbitas.txt"
		done

	# Ajuste de cálculo ( ao fim de cada $sequencia completa (de cada ciclo de 8 anos) - por isso está fora do laço acima):
	dia_orbita=$(echo "$dia_orbita-0.39" | bc )	# Aqui subtrai 9hs:30min de cada 8 anos para ajustar sua posicao exata!
	done

	arredonda		# Vai até a funcao arredonda
}


function calcula_orbitas {
	echo
	echo "Quer saber sua órbita num período de quantos ANOS? "
	read anos

	# Corrige caso o número digitado seja menor que uma órbita completa do respectivo planeta:
	if test "$planeta" == "Jupiter" && test $anos -lt 12;then
		echo "		ERRO: O período tem que ser maior que 11 anos"
		exit
	elif test "$planeta" == "Marte" && test $anos -lt 2;then
		echo "		ERRO: O período tem que ser pelo menos 2 anos ou mais"
		exit
	fi

	# Por exemplo, no caso de Jupiter, se o usuário digita 24 anos, será equivalente a 2 órbitas completas. E esse programa terá que criar um arquivo chamado Jupiter_orbitas.txt com uma lista de número de dias em que ele passará pelo mesmo ponto inicial.

	# Calcula o número total de órbitas (giros completos ao redor do Sol) dentro desse periodo de anos digitado pelo usuário (em dias): 
	n_orbitas=$(echo "$anos*365/$dias_orbita" | bc)

	# Imprime primeira linha do arquivo com o valor 0 (0 = Ponto inicial, de origem, ponto inicial das oŕbitas.):
	echo "0" > $planeta"_orbitas.txt"	

	# Conforme o número de órbitas dentro dos anos solicitados, calcula e imprimirá EM NÚMERO DE DIAS as suas órbitas... 
	# (A cada $dias_orbita estará passando pelo mesmo ponto inicial (0)) ...
	
	for orbita_num in $(seq 1 $n_orbitas)
	do
		echo "$dias_orbita * $orbita_num" | bc >> $planeta"_orbitas.txt"
	done
	arredonda		# CHAMA A FUNCAO arredonda...
}

function menu {
	echo
	echo "--- ÓRBITA DOS PLANETAS ---"
	echo
	echo "Escolha o planeta:"
	echo "	1 - Júpiter"
	echo "	2 - Marte"
	echo "	3 - Vênus"
	read n_planeta
	echo

	# Analisa a opcao requerida para calcular o valor de dias correspondente à sua orbita:

	# - Jupiter leva 4331.97 dias para completar sua translacao!
	# - Marte leva 686.97 dias para completar sua translacao!
	# Fonte: https://nssdc.gsfc.nasa.gov/planetary/factsheet/index.html e Stellarium app

	case $n_planeta in
		1) planeta=Jupiter; dias_orbita=4331.87; echo "	"$planeta "selecionado"; calcula_orbitas;;
		2) planeta=Marte; dias_orbita=686.97; echo "	"$planeta "selecionado"; calcula_orbitas;;
		3) planeta=Venus; echo "	"$planeta "selecionado"; calcula_Venus;;
		*) echo "Opcao inválida..."; echo; exit;;
	esac
}

# CHAMA A PRIMEIRA FUNCAO DO PROGRAMA:
menu

