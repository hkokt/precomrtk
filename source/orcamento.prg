#Include "Minigui.Ch"
#Include "Common.Ch"
*-------------------------*
Procedure Principal
*-------------------------*
 
REQUEST DBFCDX

RDDSETDEFAULT("DBFCDX")
DBSETDRIVER("DBFCDX")

If Select('BaseMark') = 0 .and. ! MarkDBopen()
     Return
Endif

Pjanelatotalmostra()

Return

*-------------------------*
Function MarkDBopen()
*-------------------------*

Local DRIVER := 'DBFCDX'
Local Struct := {}
Local CdxBase := 'indexabase'
Local BaseMark := 'BaseMark.DBF'

If .NOT. File (BaseMark)	
     aadd(Struct,{'hora' ,'N' , 19, 4 })	
     aadd(Struct,{'preco' , 'N' , 19, 4 })	
     aadd(Struct,{'precohora' ,'N' , 19, 4 })
     aadd(Struct, {'cliente', 'C', 150, 0 })
     aadd(Struct, {'horaorc', 'C', 8, 0})
     aadd(Struct, {'dataorc', 'D', 8, 0})
     DbCreate(BaseMark, Struct, DRIVER)	
Endif

USE (BaseMark) ALIAS BaseMark New Shared Via DRIVER 

If NetErr()
     MsgSTOP("Atenção ! Arquivo de [  ] está bloqueado.")
     Return(.F.)
Endif

If ! File (Cdxbase+".cdx")
     Index on Descend(Dtos(dataorc)) + Descend(horaorc) Tag tempo to (Cdxbase)
Endif 	

BaseMark->(dbSetIndex((CdxBase)))

Return(.T.)

*-------------------------*
Procedure Pjanelatotalmostra()
*-------------------------*

Define Window janelaMenuTotal;
At 0 , 0;
Width 750 Height 500;
Main;
Nomaximize;
Nosize

@10,10 Grid Mostraconta;
     Width 500 Height 450;
     Headers{'Qtd de Horas','Valor da Hora','Total de serviço','Nome do Cliente'};
     Widths {100,100,100,200}

@20,550 Button Calctotal;     
     Caption 'Calcular Total';
     Width 150;
     Action {||PjanelaTotal()}

@100,550 DatePicker data1 ON ENTER {||Fmostranogrid(janelaMenuTotal.data1.value,janelaMenuTotal.data2.value)}
@145,550 DatePicker data2 ON ENTER {||Fmostranogrid(janelaMenuTotal.data1.value,janelaMenuTotal.data2.value)}

End Window 
Center Window janelaMenuTotal
Activate Window janelaMenuTotal

Return

*-------------------------*
Function Fmostranogrid(DataIni, DataFin)
*-------------------------*

janelaMenuTotal.Mostraconta.deleteallitems	

BaseMark->(OrdSetFocus(1))	
BaseMark->(DbSeek(DtoS(DataFin),.T.))
	     
	Do While ! BaseMark->dataorc < DataIni .and. ! BaseMark->(Eof()) 
	     
		If BaseMark->dataorc > DataFin	
	        
		  BaseMark->(DbSkip())	
	          Loop
	        
		Endif
	    
	     Add Item{Alltrim((Str(BaseMark->hora,10,2))),;
	     Alltrim('R$'+ (Str(BaseMark->preco,10,2))),;
	     Alltrim('R$'+ (Str(BaseMark->precohora,10,2))),;
	     Alltrim(BaseMark->cliente,150,0)}to Mostraconta of janelaMenuTotal
	     
	     BaseMark->(DbSkip())
	     
	Enddo
     
Return

*-------------------------*
Procedure PjanelaTotal()
*-------------------------*

Define Window janelaTotal;
At 0 , 0;
Width 750 Height 500;
Child;
Nomaximize;
Nosize

@25,100 Label info1 Value 'Nome do cliente : ';
	Width 300 Height 25 Font 'Arial' Size 09 Bold

@50,100 Textbox nomeCliente Width 300

@100,100 Label info2 Value 'Quantidade de horas trabalhadas :';
	Width 300 Height 25 Font 'Arial' Size 09 Bold

@125,100 Textbox InputHoras Width 300

@200,100 Label info3 Value 'Valor da hora :';
	Width 300 Height 25 Font 'Arial' Size 09 Bold

@225,100 Textbox InputPreco Width 300

@300,100 Label info4 Value 'Valor pelo serviço :';
     Width 300 Height 25 Font 'Arial' Size 09 Bold

@375,100 Textbox ShowTotal Width 300 Readonly

@125,425 Button chamaCalc;
     Caption 'Calcular' Width 150;
     Action {||janelaTotal.ShowTotal.Value := Alltrim(str(Fcalculatotal(janelaTotal.InputHoras.Value,janelaTotal.InputPreco.Value)))}

@175,425 Button gravaCalc;
     Caption 'Gravar' Width 150;
     Action {||janelaTotal.ShowTotal.Value := Alltrim(str(Fcalculatotal(janelaTotal.InputHoras.Value,janelaTotal.InputPreco.Value))),;
     PgravaTotalDB(janelaTotal.InputHoras.Value,;
     janelaTotal.InputPreco.Value,;
     janelaTotal.ShowTotal.Value,;
     janelaTotal.nomeCliente.Value), janelaTotal.Release}

End Window 
Center Window janelaTotal
Activate Window janelaTotal 

Return 

*-------------------------*
Procedure PgravaTotalDB(nHora,nValor,nPrecoHora,cNomecliente)
*-------------------------*

     BaseMark->(DbAppend())
     BaseMark->hora := val(nHora)
     BaseMark->preco := val(nValor)
     BaseMark->precohora := val(nPrecoHora)
     BaseMark->cliente := cNomeCliente
     BaseMark->horaorc := Time()
     BaseMark->dataorc := Date()
 
Return

*-------------------------*
Function Fcalculatotal(nHora,nValor)
*-------------------------*

Local Result 

Result := val(nHora) * val(nValor)

Return (Result)
