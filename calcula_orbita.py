import ephem		# Instalar este módulo com PIP - Ver: https://pypi.python.org/pypi/pyephem/

print()
print('---------------------------------------------')
print('  LOCALIZAÇÃO DOS PLANETAS NO SISTEMA SOLAR ' )
print('---------------------------------------------')
print('|Escolha o planeta para calcular sua órbita:|')
print('|  1 - Júpiter                              |')
print('|  2 - Marte                                |')
print('|  3 - Vênus                                |')
print('|  4 - Mercúrio                             |')
print('|  5 - Saturno                              |')
print('|  6 - Urano                                |')
print('|  7 - Netuno                               |')
print('|  8 - Plutão                               |')
print('---------------------------------------------') 
opcao=input()

if opcao=="1":
	planeta=ephem.Jupiter()
	nome="Jupiter"
elif opcao=="2":
	planeta=ephem.Mars()
	nome="Marte"
elif opcao=="3":
	planeta=ephem.Venus()
	nome="Venus"
elif opcao=="4":
	planeta=ephem.Mercury()
	nome="Mercurio"
elif opcao=="5":
	planeta=ephem.Saturn()
	nome="Saturno"
elif opcao=="6":
	planeta=ephem.Uranus()
	nome="Urano"
elif opcao=="7":
	planeta=ephem.Neptune()
	nome="Netuno"
elif opcao=="8":
	planeta=ephem.Pluto()
	nome="Plutao"
else:
	print('Opção inválida\n')
	exit()

print (nome, "escolhido!")

print ("\nA PARTIR DE QUE DATA ??? - Formato: dd/mm/aaaa *")
print ("\n*Obs.: \n Se o DIA ou o MÊS for de 1 a 9, acrescente antes o número 0. Ex.: 05/09/2017")
data=input()

dd  = data[0:2]				# Separa da data apenas o número do DIA
mm  = data[3:5]				# Separa da data apenas o número do MÊS
aaaa= data[6:]				# Separa da data apenas o número do ANO

print ("\nDURANTE QUANTOS ANOS ??? (0 - Se não chega um ano)")
anos=input()

if anos=="0":
	anos=1
	print ("\nDURANTE QUANTOS DIAS ??? (Digite 1 se a pesquisa é apenas para um dia")
	dias=input()
else:
	dias=366			# (366 em caso de ano bissexto)

dia=ephem.Date(aaaa+"/"+mm+"/"+dd)	# Data de inicio dos cálculos
arq=open(nome+".csv", "a+")		# Cria nome arquivo csv com nome de "planeta"

for rep in range(int(anos)):		# Para n (anos) repetições. Poderia ser 1000 anos!
	for i in range(int(dias)):	# Repete n (dias) vezes 
		planeta.compute(dia)	# Objeto que tem capturado todos os dados de "planeta"
	
		# ABAIXO: Variáveis com as propriedades do objeto: Data, em que constelação está, AR e DEC (localizacao)

		data=ephem.Date(dia)			
		constelacao=ephem.constellation(planeta)
		AR=planeta.ra
		DEC=planeta.dec

#		print(ephem.Date(dia), ephem.constellation(planeta), planeta.ra, planeta.dec) 
		# Descomente essa linha acima e comente as próx. 2 linhas: (isso imprime o resultado apenas na tela e não num arq.)
		arq.write(str(data) + str("; ") + str(constelacao) + str("; ") + str(AR) + str("; ") + str(DEC))
		arq.write('\n')

		dia += 1		# Aumenta um dia para chegar aos 366
arq.close()				# Nunca esquecer de fechar arquivo...

# Helio Giroto
