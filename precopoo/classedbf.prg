#Include "Minigui.ch"
#Include "hbclass.ch"

#Define DRIVER "DBFCDX"
Class criadbf

DATA aDados 	INIT {}
DATA aStruct 	INIT {}
DATA sNomeBD

Method pegaVars(aDados) 

Method criaDB(sNomeBD)

End Class 

Method pegaVars(dados) Class criadbf

Local i 
Local j := 1

	for i:= 1 to Len(dados)

		Aadd (::aDados,  dados[i]) 

	next
	
	do while j < Len(dados)
	
		Aadd(::aStruct, {::aDados[j],::aDados[j+1],::aDados[j+2],::aDados[j+3]})

		j+=4
	enddo
	
Return ::aStruct

Method criaDB(nome) Class criadbf

	nome := nome + '.DBF'
	DbCreate(nome, (::aStruct), DRIVER)
	
Return Self 