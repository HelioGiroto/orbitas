#!/bin/bash
clear

# IMPORTANTE: Uso neste script o comando COMM, que faz comparações entre dois arquivos e mostra a intercessão (similitudes, coisas em COMMúm!) entre eles. É justam. o contrário de DIFF!
# Mas para que ele funcione, é preciso antes ordenar os arquivos com SORT, mas SEM nenhum parâmetro. ver linha 15:

# MANIPULA TODOS OS ARQUIVOS (gerados no script anterior) ANTES DE COMPARAR:
for arquivo in *.dat
do
	echo "Preparando e analisando o arquivo: " $arquivo
	cat $arquivo | sort > _$arquivo	# Se não coloca isso o COMM não funcionará!
	rm $arquivo			
	mv _$arquivo $arquivo
	# Nas 2 linhas acima: (Tb 52) Se repete a rotina de gerar arq.novo, deletar o velho, e renomear o novo com o nome do velho.
done
echo 			# Linha em branco

# INICIA AS COMPARACOES - JUPITER COM LUA (Um a um seria assim):
	# comm -12 Jupiter_em_Virgo.dat Lua_em_Virgo.dat > JL.dat	# Compara os dois arquivos (localizacao dos 2 planetas)
	# cat JL.dat | sort -nr -k1 -k2 -k3 > _JL.dat	# Ordena (SORT) Numerica e Reversam. (Descendente) começa do 1o campo, 2o e 3o.
	# rm JL.dat
	# mv _JL.dat > JL.dat

	# Em seguida COMM-pararíamos o JL.dat (resultado da COMM anterior) com o próximo planeta... e assim sucessiv..

# PORÉM COLOCAREMOS TODA ESSA ROTINA ACIMA NUM LAÇO MUUUITO COMPLEXO MAS EFICAZ:
# 	(Faça o teste no papel e caneta simulando o laço com os nros. de índice de array [0-5], etc.)
# 	Coloco 2>/dev/null por causa do último laco que nao será encontrado

planeta=(Jupiter Lua Sol Marte Venus Mercurio todos)	# Array com mensagens que receberá o usuário

arq=(Jupiter_em_Virgo.dat Sol_em_Virgo.dat Marte_em_Leo.dat Venus_em_Leo.dat Mercurio_em_Leo.dat nulo.dat)	# Array com os arqs. gerados no script anterior

novo_arq=(Lua_em_Virgo.dat em_comum_JL.dat em_comum_JLS.dat em_comum_JLSM.dat em_comum_JLSMV.dat em_comum_TODOS.dat nulos.dat)	# Array dos nomes de arquivos que serão comparados 

echo -n "Buscando as localizações em comúm entre os astros: Júpiter" 	# para efeito de impressao na tela (estética do pgm)

# Inicia o laço para simplesmente usar o comando COMM para cada par de arquivos:
for n in $(seq 0 5)
do
	echo -n " e" ${planeta[$n+1]}	# Estética do pgm (na tela)
	comm -12 ${arq[$n]} ${novo_arq[$n]} > ${novo_arq[$n+1]} 2>/dev/null	# Compara itens das duas listas e direciona resultado para o próximo item da 2a.lista
	sleep 1				# Os sleep's são apenas para efeito visual...
done

echo

# Agora ORDENA de forma mais inteligível os arquivos gerados (os arqs --- em_comum*.dat ---)
for arq in em_comum*
do
	cat $arq | sort -nr -k1 -k2 -k3 > _$arq
	rm $arq
	mv _$arq $arq
done


# Finaliza...
echo
echo "Todos os arquivos com as localizações em comúm foram gerados!"
echo "Seus nomes são:"
sleep 1
echo
ls em_comum*
echo

rm nulo*	# ajuste

							# Autor: Helio Giroto
