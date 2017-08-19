import ephem		# Instalar este módulo com PIP - Ver: https://pypi.python.org/pypi/pyephem/

print()
print('Localização de Júpiter nos próximos 2 anos:')
print()

jp=ephem.Jupiter()		# jp será o codinome para Jupiter.

#dia=ephem.Date('2017/9/23')	# Opção
dia=ephem.Date()		# HOJE

for rep in range(2):		# Para 2 repetições, ou seja 2 anos. Poderia ser 1000 anos!
	for i in range(366):	# Repete 366 vezes (em caso de ano bissexto)
		jp.compute(dia)	# Objeto que tem capturado todos os dados de "jp" (no caso, Jupiter - ver linha 7)
	
		# ABAIXO: Variáveis com as propriedades do objeto: Data, em que constelação está, AR e DEC (local)

		data=ephem.Date(dia)			
		constelacao=ephem.constellation(jp)
		AR=jp.ra
		DEC=jp.dec

#		print(ephem.Date(dia), ephem.constellation(jp), jp.ra, jp.dec) 
		# Descomente essa linha acima em vez das próx. 3 linhas: (abaixo gravará num arquivo, acima só imprime na tela)
		arq=open("jupiter.txt", "a+")
		arq.write(str(data) + str("; ") + str(constelacao) + str("; ") + str(AR) + str("; ") + str(DEC))
		arq.write('\n')
		dia += 1		# Aumenta um dia para chegar aos 366
	ano+=1				# como tb acrescenta um ano mais.
arq.close()			# Nunca esquecer de fechar arquivo...

# Helio Giroto
