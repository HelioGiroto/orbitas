#!/bin/bash

# SOMENTE PARA AS ÓRBITAS DE ANOS ANTES DE CRISTO

# GERANDO OS ARQUIVOS FILTRADOS:

echo
echo "Este programa vai filtrar (peneirar) as órbitas para saber quando cada planeta estará aproximadamente na mesma posição como a do dia 23/09/2017"
echo
echo "Digite ENTER para continuar!"
read


# Jupiter em Virgo:
cat Jupiter.csv | awk -F';' '/Virgo/{print $1}' | awk -F' ' '{print $1}' >> Jupiter_em_Virgo.dat

# Sol em Virgo:
cat Sol.csv | awk -F';' '/Virgo/{print $1}' | awk -F' ' '{print $1}' >> Sol_em_Virgo.dat

# Lua em Virgo
cat Lua.csv | awk -F';' '/Virgo/{print $1}' | awk -F' ' '{print $1}' >> Lua_em_Virgo.dat 

# Marte em Leo:
cat Marte.csv | awk -F';' '/Leo/{print $1}' | awk -F' ' '{print $1}' >> Marte_em_Leo.dat

# Venus em Leo:
cat Venus.csv | awk -F';' '/Leo/{print $1}' | awk -F' ' '{print $1}' >> Venus_em_Leo.dat

# Mercurio em Leo:
cat Mercurio.csv | awk -F';' '/Leo/{print $1}' | awk -F' ' '{print $1}' >> Mercurio_em_Leo.dat

#

sed -i 's/\//_/g' Jupiter_em_Virgo.dat	# Altera as barras das datas por Underline
sed -i 's/\//_/g' Sol_em_Virgo.dat	# Altera as barras das datas por Underline
sed -i 's/\//_/g' Lua_em_Virgo.dat	# Altera as barras das datas por Underline
sed -i 's/\//_/g' Marte_em_Leo.dat	# Altera as barras das datas por Underline
sed -i 's/\//_/g' Venus_em_Leo.dat	# Altera as barras das datas por Underline
sed -i 's/\//_/g' Mercurio_em_Leo.dat	# Altera as barras das datas por Underline


echo "Arquivos gerados!"


