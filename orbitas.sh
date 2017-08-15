#!/bin/bash

# VÁ PARA A ÚLTIMA LINHA DESTE SCRIPT PARA SABER QUAL É A PRIMEIRA FUNCAO QUE É CHAMADA...

function cria_arq_datas { 

	for linha in $(cat $planeta.txt)
	do

		date -d "2017/09/23 +$linha"''"days" +"%d/%m/%Y" >> $planeta"_datas.txt"

	done
	echo "Terminado! Arquivo" $planeta"_datas.txt criado!"
	echo

}


function ultima_msg {
	echo
	echo -e "Um arquivo chamado: --- $planeta.txt --- foi gerado! 
Ao abrir este arquivo, você terá uma lista em NÚMERO DE DIAS 
sobre quando $planeta voltará a passar NUM MESMO PONTO do céu 
nos próximos $anos ANOS!."
	echo

	sed -i '/^$/d' $planeta.txt	# Tive que por essa linha pq señ aparecia umas linhas em branco no arquivo! (????)

	echo "Gostaria de converter o arquivo" $planeta".txt para datas no formato DD/MM/AAAA? (s/n)" 
	read resp
	if test "$resp" == "s" || "$resp" == "S"
	then
		echo "Criando arquivo de datas..."
		cria_arq_datas
	else
		echo "Fechando programa..."
		echo
		exit
	fi

}

function arredonda {
	echo "" > $planeta.txt				# Isso é para [re-]escrever um [novo] arquivo vazio.
	for linha in $(cat $planeta"_1.txt")
	do
		tem_ponto=$(echo $linha | grep -Fo ".")
		if test "$tem_ponto" == "."; then
			inteiro=$(echo $linha | cut -d'.' -f1)
			decimal=$(echo $linha | cut -d'.' -f2 | grep -E ^[0-9]{2})
			if [[ $decimal -gt 50 ]]
			then 
				inteiro=$((inteiro+1))
			fi
		else
			echo $linha >> $planeta.txt
		fi

		echo $inteiro >> $planeta.txt

	done

#	rm $planeta"_1.txt"		# ************ ao fim dos testes DESCOMENTAR !!!! ***************
	ultima_msg
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
	echo "Quer que calcule sua órbita num período de quantos ANOS? "
	read anos

	if test $anos -lt 8;then echo; echo "	O período de órbitas será arredondado para 8 anos"; fi

	dia=0
	echo $dia > $planeta"_1.txt"	# Cria novo arq chamado Venus.txt com valor 0 na 1a.linha

	sequencia=(293 407 409 292 410 317 84 299 411)
	tot_ciclos=$((anos/8+1))	# Acrescenta 1 ciclo a mais para efeito de garantia

	for cada_ciclo in $(seq 1 $tot_ciclos)
	do
		for cada_intervalo in ${sequencia[*]}
		do
			dia=$(echo "$dia+$cada_intervalo" | bc)
			echo $dia >> $planeta"_1.txt"

		done
		dia=$(echo "$dia-0.39" | bc )	# Aqui subtrai 9hs:30min de cada 8 anos para ajustar posicao exata!
	done
	arredonda		# Vai até a funcao arredonda
}


function calcula_orbitas {
	echo
	echo "Quer que calcule sua órbita num período de quantos ANOS? "
	read anos

	# Corrige caso o número requerido seja menor que uma órbita completa do respectivo planeta:
	if test "$planeta" == "Jupiter" && test $anos -lt 12;then
		echo "		ERRO: O período tem que ser maior que 11 anos"
		exit
	elif test "$planeta" == "Marte" && test $anos -lt 2;then
		echo "		ERRO: O período tem que ser pelo menos 2 anos"
		exit
	fi


	# Calcula o número total de órbitas (giros completos) dentro desse periodo de anos digitado pelo usuário (em dias): 
	n_orbitas=$(echo "$anos*365/$dias_orbita" | bc)


	echo "0" > $planeta"_1.txt"		# Imprime primeira linha do arquivo com o valor 0 (0 = Ponto inicial, de origem)
	for multiplo in $(seq 1 $n_orbitas)
	do
		echo "$dias_orbita * $multiplo" | bc >> $planeta"_1.txt"
	done
	arredonda		# CHAMA A FUNCAO arredonda...
}

function escolhe {
	echo
	echo "--- ÓRBITA DOS PLANETAS ---"
	echo
	echo "Escolha o planeta:"
	echo "	1 - Júpiter"
	echo "	2 - Marte"
	echo "	3 - Vênus"
	read n_planeta
	echo

	# Analisa a opcao requerida para atribuir o valor de dias correspondente à sua orbita:
	# - Jupiter leva 4331.97 dias para completar sua translacao!
	# - Marte leva 686.97 dias para completar sua translacao!
								  # Fonte: http:// e Stellarium app


	case $n_planeta in
		1) planeta=Jupiter; dias_orbita=4331.87; echo "	"$planeta "selecionado"; calcula_orbitas;;
		2) planeta=Marte; dias_orbita=686.97; echo "	"$planeta "selecionado"; calcula_orbitas;;
		3) planeta=Venus; echo "	"$planeta "selecionado"; calcula_Venus;;
		*) echo "Opcao inválida..."; echo; exit;;
	esac
}

# CHAMA A PRIMEIRA FUNCAO DO PROGRAMA:
escolhe

