import ephem		# Instalar este módulo com PIP - Ver: https://pypi.python.org/pypi/pyephem/

# Para entender melhor, vá para a última linha deste código e siga à primeira função que é chamada ali...

while True:

	def finaliza():
		print()
		print("Deseja fazer outra pesquisa ? (s/n): ")
		resp=input()
		if resp == "n" or resp == "N":
			exit()

	def imprime_arq(planeta, nome, dia, anos, dias, tipo_de_calculo):
		arq=open(nome+".csv", "a+")		# Cria nome arquivo csv com nome de "planeta"

		for rep in range(int(anos)):		# Para n (anos) repetições. Poderia ser 1000 anos!
			for i in range(int(dias)):	# Repete n (dias) vezes 		

				planeta.compute(dia)	# Objeto que tem capturado todos os dados de "planeta" naquela data
	
				# ABAIXO: Variáveis com as propriedades do objeto: Data, em que constelação está, AR e DEC (localizacao)
				data        = ephem.Date(dia)			
				constelacao = ephem.constellation(planeta)
				AR          = planeta.a_ra
				DEC         = planeta.a_dec
			
				# Agora, grava no arquivo já aberto os dados acima definidos:
				arq.write(str(data) + str(";") + str(constelacao) + str(";") + str(AR) + str(";") + str(DEC))
				arq.write('\n')
			
				# De acordo com a escolha do usuário, o prg vai avançar ou retroceder na data:
				if tipo_de_calculo=="avanza":
					dia += 1		# Aumenta um dia ATÉ chegar no núm total do laço de dias.
				else:
					dia -= 1		# Neste caso, diminui um dia ATÉ chegar no núm total do laço de dias.
	
		arq.close()
		echo "Arquivo",nome+".csv foi criado"					# Nunca esquecer de fechar arquivo...
		finaliza()

	def imprime_tela(planeta, nome, dia, anos, dias, tipo_de_calculo):
		print()
		print("Órbita de", nome)
		print("--------------------")
	
		for rep in range(int(anos)):		
			for i in range(int(dias)):	
				planeta.compute(dia)	
				data=ephem.Date(dia)			
				constelacao=ephem.constellation(planeta)
				AR=planeta.a_ra
				DEC=planeta.a_dec
				print(data, "- Constel.:", constelacao, "- AR:", AR, "- DEC:", DEC)
				if tipo_de_calculo=="avanza":
					dia += 1
				else:
					dia -= 1
		finaliza()


	def menu():
		print()
		print('---------------------------------------------')
		print('  LOCALIZAÇÃO DOS PLANETAS NO SISTEMA SOLAR ' )
		print('---------------------------------------------')
		print('Escolha o número para calcular a órbita de:')
		print('  1 - Júpiter')
		print('  2 - Marte')
		print('  3 - Vênus')
		print('  4 - Mercúrio')
		print('  5 - Saturno')
		print('  6 - Urano')
		print('  7 - Netuno')
		print('  8 - Plutão')
		print('  9 - Sol')
		print(' 10 - Lua')
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
		elif opcao=="9":
			planeta=ephem.Sun()
			nome="Sol"
		elif opcao=="10":
			planeta=ephem.Moon()
			nome="Lua"
		else:
			print('Opção inválida\n')
			finaliza()
			menu()

		print (nome, "escolhido!\n")

		print ("A partir de que DATA ??? - Formato: dd/mm/aaaa *")
		print ("  ...... (*Obs.: Se o DIA ou o MÊS for de 1 a 9, acrescente antes o número 0. Ex.: 05/09/2017)")
		print ("  .............. Se for a data de HOJE, simplesmente pressione ENTER.")
		data=input()

		# Caso o usuário apenas press. ENTER, teremos manipular para data atual do local:
		if data=="":
			hoje  = ephem.Date(ephem.now())		# Determina dia de hoje (mas em Greenwich)
			hoje1 = ephem.localtime(hoje)		# Corrije para localizacao atual.
			hoje1 = str(hoje1)			# Converte para string pq não é str!
			hoje2 = hoje1.replace("-","/")		# Troca o formato da data de - para /
			data  = hoje2[8:10]+"/"+hoje2[5:7]+"/"+hoje2[0:4] # abaixo:
			# Acima: Troca de aaaa/mm/dd hh:mm:ss para dd/mm/aaaa - Fazendo o SLICE e atribuindo à variável inicial! .... uff.....
	
		print ()
		print ("Durante quantos ANOS ???")
		print (" .......Digite 0 ou ENTER - Se NÃO chega a um ano.") 
		print (" .......Se quer a pesquisa RETRÓGRADA, colocar sinal de menos (-) antes do núm. Ex.: -100 (para 100 anos antes)")
		anos=input()
	
		# Verifica se tem o sinal negativo antes do número.
		anos_neg=anos[0:1]
		if anos_neg =="-":
			anos=anos[1:]
			tipo_de_calculo="retrocede"
		else:
			tipo_de_calculo="avanza"


		# Verifica se o usuário apenas press. ENTER ou digitou 0 em ANOS:
		if anos=="0" or anos=="":
			anos=1
			print ("\nDurante quantos DIAS ???")		# Só pergunta quantos DIAS se o ano = 0 ou ano = 1.
			print (" ........Digite 1 ou ENTER se a pesquisa é apenas para UM DIA // Se quer a pesquisa retrógrada, digitar sinal (-) antes do núm.")
			dias=input()

			# Valida a entrada que o usuário escolheu:
			dias_neg=dias[0:1]				
			# Tb é necess. essa condicao caso o usuário quer a pesquisa retrógrada que não chega a 1 ano, ou seja, de alguns dias anteriores somente!
			if dias_neg =="-":
				dias=dias[1:]
				tipo_de_calculo="retrocede"
			else:
				tipo_de_calculo="avanza"

			if dias=="":
				dias=1
		else:
			dias=366			# (366 em caso de ano bissexto)


		# Organiza a data precisa em que o sistema iniciará os cálculos:
		dd  = data[0:2]				# Separa da data apenas o número do DIA
		mm  = data[3:5]				# Separa da data apenas o número do MÊS
		aaaa= data[6:]				# Separa da data apenas o número do ANO
		dia = ephem.Date(aaaa+"/"+mm+"/"+dd)	# Data de inicio dos cálculos


		print("\nQuer o resultado na TELA ou gravado em ARQUIVO ?? (T ou A?)??")
		resp=input()

		if resp == "T" or resp == "t":
			imprime_tela(planeta, nome, dia, anos, dias, tipo_de_calculo)
		else:
			imprime_arq(planeta, nome, dia, anos, dias, tipo_de_calculo)

	menu()

										# Autor: Helio Giroto - www.heliogiroto.com
