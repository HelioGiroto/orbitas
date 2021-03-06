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
		sed -i 's/^instalador/#instalador/' AnoNovoJudeuMuculmano.sh		# Nome desse script.
		echo
	else
		echo
		echo "Saindo do programa... Não se pode instalar!"
		exit
	fi
}


function compara {
	echo "Deseja que faça as comparações entre os dois arquivos ? (s/n)"
	read resp

	if [[ "$resp" == "S" || "$resp" == "s" ]]
	then
		sort muculmano.txt > sort_m.txt
		sort judeu.txt > sort_j.txt
		comm -12 sort_m.txt sort_j.txt > comum.txt		
		sort -n -k3 comum.txt > ano_novo_comum.txt

		rm sort* comum*
	else
		exit
	fi

	nro_ocorrencias=$(cat ano_novo_comum.txt | wc -l)

	echo 
	echo "Foram encontradas $nro_ocorrencias ocorrências em comúm num periodo de quase 2400 anos!"
	echo "O arquivo chamado -- ano_novo_comum.txt -- traz essas datas em comúm até 3000 dC"
	echo 
}

function calculo {

	# Formato para Ano Novo Judeu:
	# hdate -h 2017 | grep -E " [1-2] Tishrei" | cut -d"," -f2
	# -h significa imprime os feriados (Holidays)
	# Esses parâmetros imprime esse formato de saída:
	# Jueves, 21 Septiembre 2017, 1 Tishrei 5778
	# Viernes, 22 Septiembre 2017, 2 Tishrei 5778

	
	# Formato para Ano Novo Muçulmano:
	# ical -hi 14390101 -d
	# -hi - Imprime no formato de data Hijri, ou seja, no estilo muçulmano. 
	# aaaammdd - formato de data, sendo 0101 - o primeiro dia do primeiro mes.
	# -d - Dual: Ambos calendarios (muçulmano e ocidental.
	# 1439 = 2017, 
	echo "Gerando arquivos..."
	echo

	echo "ANO NOVO MUÇULMANO - Muharram (de 622 até 3000):" > muculmano.txt
	for ano in $(seq 1 2452)		# 1439 = 2017
	do 
		resto=$((ano%32))				# Detalhe gráfico para os pontinhos...
		if [[ $resto -eq 0 ]];then echo -n ">";fi	# 

		if [[ $ano -lt 10 ]]
		then
			ano="000"$ano
		elif [[ $ano -lt 100 ]]
		then
			ano="00"$ano
		elif [[ $ano -lt 1000 ]]	
		then	
			ano="0"$ano
		fi

		ano=$ano"0101"			# para que a variável ano seja aaaa0101 (justamente o formato que exige ical).

		# Abaixo: Tente apagar o último comando depois do último pipe para ver o efeito.... Em vez de $ano, digite 14390101


		dia_m=$(ical -hi $ano -d | grep -Eo "01\/.." | cut -d'/' -f2)
		mes_m=$(ical -hi $ano -d | grep -E "From" | cut -d"/" -f3| cut -d" " -f2)
		ano_m=$(ical -hi $ano -d | grep -E "From" | grep -Eo "[0-9]+)" | cut -d")" -f1)

		echo $dia_m $mes_m $ano_m >> muculmano.txt
	done 

	echo
	echo "Foi criado um arquivo de nome: -- muculmano.txt --"
	echo "com a data de cada ano novo muçulmano até o ano 3000"
	echo 
		

	#	CÁLCULO DO ANO NOVO JUDEU: 
	
	echo "FESTAS DAS TROMBETAS - Rosh Hashana (do ano 1 ao 3000):" > judeu.txt

	for ano in $(seq 1 3000)
	do

		resto=$((ano%40))				# Detalhe gráfico para os pontinhos...
		if [[ $resto -eq 0 ]];then echo -n ">";fi	# 
	
		hdate -hq $ano | grep " [1-2] Tishrei" | cut -d"," -f2 | sed 's/ //' >> judeu.txt #2>/dev/null
		# Acima: -q é para suprimir as mensagens do hdate no terminal - q=Quiet.

	done

	sed -i 's/Septiembre/September/g; s/Setembro/September/g; s/Agosto/August/g; s/Octubre/October/g; s/Outubro/October/g' judeu.txt	
	# Acima: É preciso traduzir de português (ou espanhol) para inglês os nomes dos meses.

	echo
	echo "Foi criado um arquivo de nome: -- judeu.txt --"
	echo "com a data de cada ano novo judeus de 1 até o ano 3000"
	echo

	compara		# chama a última função

}



clear
echo "=========================="
echo "ANO NOVO JUDEU E MUÇULMANO"
echo "=========================="
echo

instalador	# A partir da 2a.vez que abra esse script, essa linha estará comentada!!! Para executá-lo como da primeira vez, basta apagar o símbolo # do INICIO dessa linha (caso tenha).

calculo
