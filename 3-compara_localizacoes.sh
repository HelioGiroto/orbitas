#!/bin/bash

				# Faz o cruzamento das informações processadas até aqui...

# Compara as posições de Jupiter com Lua :

for linha in $(cat Jupiter_em_Virgo.dat)
do
	grep "$linha" Lua_em_Virgo.dat >> JL_grep.dat 2>/dev/null 
done

cat JL_grep.dat | sort -nru > JL.dat				# Cada CAT/SORT ordena os dados (Por data crescente) do arq gerado.


# Compara Jupiter e Lua com Sol:

for linha in $(cat JL.dat)
do
	grep "$linha" Sol_em_Virgo.dat >> JLS_grep.dat 2>/dev/null 
done

cat JLS_grep.dat | sort -nru > JLS.dat				# CAT/SORT


# Compara Jupiter+Lua+Sol com Marte:

for linha in $(cat JLS.dat)
do
	grep "$linha" Marte_em_Leo.dat >> JLSM_grep.dat 2>/dev/null
done

cat JLSM_grep.dat | sort -nru > JLSM.dat			# CAT/SORT


# Compara Jupiter+Lua+Sol+Marte com Venus:

for linha in $(cat JLSM.dat)
do
	grep "$linha" Venus_em_Leo.dat >> JLSMV_grep.dat 2>/dev/null
done

cat JLSMV_grep.dat | sort -nru > JLSMV.dat			# CAT/SORT


# Compara Jupiter+Lua+Sol+Marte+Venus com Mercurio:

for linha in $(cat JLSMV.dat)
do
	grep "$linha" Mercurio_em_Leo.dat >> JLSMVMc_grep.dat 2>/dev/null
done

cat JLSMVMc_grep.dat | sort -nru > JLSMVMc.dat			# CAT/SORT


rm *_grep.dat			# "Limpa" (deleta) arquivos des-ordeados....

echo "Finalizado!"
												# Autor: Helio Giroto
												
