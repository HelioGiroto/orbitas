#!/bin/bash

# Compara as posições de Jupiter com Lua 


# cat Jupiter_em_Virgo.dat

#for linha in $(awk '{print $0}' Jupiter_em_Virgo.dat)
#do
#	awk -v linha="$linha" '{ if($1 == linha) print $0}' Lua_em_Virgo.dat >> coincide_awk.txt	

#done


for linha in $(cat Jupiter_em_Virgo.dat)
do
	grep "$linha" Lua_em_Virgo.dat >> JL_grep.dat 2>/dev/null 

done

cat JL_grep.dat | sort -nru > JL.dat


for linha in $(cat JL.dat)
do
	grep "$linha" Sol_em_Virgo.dat >> JLS_grep.dat 2>/dev/null 

done

cat JLS_grep.dat | sort -nru > JLS.dat

for linha in $(cat JLS.dat)
do
	grep "$linha" Marte_em_Leo.dat >> JLSM_grep.dat 2>/dev/null
done

cat JLSM_grep.dat | sort -nru > JLSM.dat


for linha in $(cat JLSM.dat)
do
	grep "$linha" Venus_em_Leo.dat >> JLSMV_grep.dat 2>/dev/null
done

cat JLSMV_grep.dat | sort -nru > JLSMV.dat


for linha in $(cat JLSMV.dat)
do
	grep "$linha" Mercurio_em_Leo.dat >> JLSMVMc_grep.dat 2>/dev/null
done

cat JLSMVMc_grep.dat | sort -nru > JLSMVMc.dat






