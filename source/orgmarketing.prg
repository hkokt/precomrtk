#Include "Minigui.ch"
#Include "Common.ch"
*----------------------*
Procedure  Principal()
*----------------------*
SET DATE BRITISH 
SET CENTURY ON 

REQUEST DBFCDX
RDDSETDEFAULT("DBFCDX")
DBSETDRIVER("DBFCDX")

Public DRIVER := 'DBFCDX'

If Select('OrcDB') = 0 .and. ! FOrcDB()
     Return
Endif

If Select('MetaDB') = 0 .and. ! FMetaDB()
     Return
Endif

Define Window Jprinc;
At 0,0;
Width 300 Height 300;
Title 'Controle Marketing';
Main;
Nomaximize;
Nosize

@100,50 Button Borc;
Caption 'Orçamentos'; 
Width 100 Height 100;
Action {|| Porc() }

@100,155 Button Bmeta;
Caption 'Metas';
Width 100 Height 100;
Action {|| Pmeta() }

End Window 
Center Window Jprinc
Activate Window Jprinc 

Return Nil
*----------------------*
Function FOrcDB()
*----------------------*
Local Struct := {}
Local CdxOrc := 'indexaorc'
Local OrcDB := 'OrcDB.DBF'

If ! File (OrcDB)	
     aadd(Struct, {'b' ,'N' , 19, 4 })
     aadd(Struct, {'oHora', 'C' , 8, 0})
     aadd(Struct, {'oData', 'D' , 8, 0})
     DbCreate(OrcDB, Struct, DRIVER)
Endif

USE (OrcDB) ALIAS OrcDB New Shared Via DRIVER 

If NetErr()
     MsgSTOP("Atenção ! Arquivo [OrcDB.DBF] está bloqueado.")
     Return(.F.)
Endif

If ! File (CdxOrc + ".cdx")
     Index on Descend(Dtos(oData)) + Descend(oHora) Tag tempo to (CdxOrc)
Endif 

OrcDB->(dbSetIndex((CdxOrc)))

Return (.T.)
*----------------------*
Function FMetaDB()
*----------------------*
Local Struct := {}
Local CdxMeta := 'indexameta'
Local MetaDB := 'MetaDB.DBF'

If ! File (MetaDB)
     aadd(Struct,{'a' , 'N' , 19, 4 })
     aadd(Struct, {'mHora', 'C' , 8, 0})
     aadd(Struct, {'mData', 'D' , 8, 0})
     DbCreate(MetaDB, Struct, DRIVER)
Endif

USE (MetaDB) ALIAS MetaDB New Shared Via DRIVER 

If NetErr()
     MsgSTOP("Atenção ! Arquivo [MetaDB.DBF] está bloqueado.")
     Return(.F.)
Endif

If ! File (CdxMeta + ".cdx")
     Index on Descend(Dtos(mData)) + Descend(mHora) Tag tempo to (CdxMeta)
Endif 

MetaDB->(dbSetIndex((CdxMeta)))

Return (.T.)
*----------------------*
/*Procedure POsearch(dataIni, dataFin)
*----------------------*
Local dataIni 
Local dataFin 

dataIni := 
dataFin := 

.deleteallitems	

OrcDB->(OrdSetFocus(1))	
OrcDB->(DbSeek(DtoS(dataFin),.T.))
     
Do While ! OrcDB->oData < dataIni .and. ! OrcDB->(Eof()) 
     
	If OrcDB->dataorc > dataFin	
          OrcDB->(DbSkip())	
          Loop
     Endif
    
     Add Item{Alltrim((Str(OrcDB->,10,2))),;
     Alltrim(Str(OrcDB->,10,2)),;
     Alltrim(Str(OrcDB->,10,2))}to of 
     
     BaseMark->(DbSkip())
     
Enddo
     
Return
*----------------------*
Procedure PMsearch(dataIni, dataFin)
*----------------------*
Local dataIni 
Local dataFin 

dataIni := 
dataFin := 

.deleteallitems	

MetaDB->(OrdSetFocus(1))	
MetaDB->(DbSeek(DtoS(dataFin),.T.))
     
Do While ! MetaDB->mData < dataIni .and. ! MetaDB->(Eof()) 
     
	If MetaDB->mData > dataFin	
          MetaDB->(DbSkip())	
          Loop
     Endif
    
     Add Item{Alltrim((Str(MetaDB->,10,2))),;
     Alltrim(Str(MetaDB->,10,2)),;
     Alltrim(Str(MetaDB->,10,2))}to of 
     
     MetaDB->(DbSkip())
     
Enddo
     
Return*/
*----------------------*
Procedure Porc()
*----------------------*
Define Window Jorc;
At 0,0;
Width 600 Height 500;
Title 'Orçamentos';
Child;
Nomaximize;
Nosize

@ 10, 10 Grid Gorc;
Width 350 Height 450;
Headers {'a'};
Widths {150}

@50, 400 Button BCorc;
Caption 'Calcular Orçamento';
Width 150;
Action {|| PCorc()}

End Window 
Center Window Jorc
Activate Window Jorc 

Return Nil
*----------------------*
Procedure Pmeta()
*----------------------*
Define Window Jmeta;
At 0,0;
Width 600 Height 500;
Title 'Metas';
Child;
Nomaximize;
Nosize

@ 10, 10 Grid Gmeta;
Width 350 Height 450;
Headers {'a'};
Widths {150}

@50, 400 Button BCmeta;
Caption 'Calcular Meta';
Width 150;
Action {|| PCmeta()}

End Window 
Center Window Jmeta 
Activate Window Jmeta 

Return Nil
*----------------------*
Procedure PCorc()
*----------------------*
Define Window JCorc;
At 0,0;
Width 400 Height 400;
Title 'Registro de Orçamentos';
Child;
Nomaximize;
Nosize

@25,50 Textbox oNome Width 200

@75,50 Textbox oPreco Width 75

@125,50 Textbox oHoras Width 75

@175,50 Textbox oResultado Width 75 Readonly

@175, 250 Button oCalcula;
Caption 'Calcular';
Action {||JCorc.oResultado.value := FCorc(JCorc.oPreco.value, JCorc.oHoras.value)}

End Window 
Center Window JCorc
Activate Window JCorc 

Return Nil
*----------------------*
Procedure PCmeta()
*----------------------*
Define Window JCmeta; 
At 0,0;
Width 400 Height 400;
Title 'Registro de Metas';
Child;
Nomaximize;
Nosize;
On Init {|| Fqualmeta(JCmeta.mEscolhe.value)}

@50,270 Combobox mEscolhe;
Items{'Hora', 'Preço'};
Value 1;
Width 110 Font 'Arial' Size 9 ;
On Change {|| Fqualmeta(JCmeta.mEscolhe.value)}
@25,270 Label combom Width 200 Height 25 Font 'Arial' Size 9 Bold

@25,50 Label nomeM Width 200 Height 25 Font 'Arial' Size 9 Bold
@50,50 Textbox mNome Width 200

@80,50 Label meta Width 200 Height 25 Font 'Arial' Size 9 Bold
@105,75 Textbox mMeta Width 100 Rightalign 
@105,50 Label rq1 Width 20 Height 25 Font 'Arial' Size 9 Bold

@135,50 Label PrazoM Width 200 Height 25 Font 'Arial' Size 9 Bold
@160,75 Textbox mPrazo Width 75 Rightalign 
@160,50 Label rq2 Width 25 Height 25 Font 'Arial' Size 9 Bold
@160,155 Label dias Width 25 Height 25 Font 'Arial' Size 9 Bold

@190,50 Label PouH Width 200 Height 25 Font 'Arial' Size 9 Bold
@215,75 Textbox mPouh Width 100 Rightalign 
@215,50 Label rq3 Width 20 Height 25 Font 'Arial' Size 9 Bold

@240,50 Label resulttudo Width 200 Height 25 Font 'Arial' Size 9 Bold
@265,50 Textbox mresult Width 200 Readonly Rightalign 

@290,50 Label resultdia Width 200 Height 25 Font 'Arial' Size 9 Bold
@315,50 Textbox mresultd Width 200 Readonly Rightalign 

@175, 250 Button mCalcula;
Caption 'Calcular'

End Window
Center Window JCmeta
Activate Window JCmeta

Return Nil 
*----------------------*
Function Fqualmeta(escolheu)
*----------------------*
**Labels 
JCmeta.combom.value := 'Calcular meta por:'
JCmeta.nomeM.value := 'Digite um nome para a meta:'
JCmeta.prazoM.value := 'Prazo:'
JCmeta.meta.value := 'Meta desejada:'
JCmeta.rq1.value := 'R$'
JCmeta.rq2.value := 'Qtd'
JCmeta.dias.value := 'dias'
**limpa tb
JCmeta.mNome.value := ''
JCmeta.mMeta.value := ''
JCmeta.mPrazo.value := ''
JCmeta.mPouh.value := ''
JCmeta.mresult.value := ''
JCmeta.mresultd.value := ''

If escolheu == 1

JCmeta.PouH.value := 'Número de horas pretendidas:'
Jcmeta.rq3.value := 'Qtd'
JCmeta.resulttudo.value := 'Preço do total de horas para meta:'
JCmeta.resultdia.value := 'Arrecadação diária para meta:'

JCmeta.mCalcula.Action := {||FCmetaH(JCmeta.mMeta.value,JCmeta.mPouH.value,JCmeta.mPrazo.value)}

Else

JCmeta.PouH.value:= 'Valor pretendido por hora: '
Jcmeta.rq3.value := 'R$'
JCmeta.resulttudo.value := 'Número total de horas para meta:'
JCmeta.resultdia.value := 'Horas diárias para meta:'

JCmeta.mCalcula.Action := {||FCmetaP(JCmeta.mMeta.value,JCmeta.mPouH.value,JCmeta.mPrazo.value)}

Endif 

Return Nil 

*----------Cálculos e gravações----------*

*----------------------*
Function FCorc(nPreco, nHora)
*----------------------*
Return (str(val(nPreco)* val(nHora)))
*----------------------*
Function FCmetaH(nMeta, nHora, nPrazo)
*----------------------*
Local vPreco[2]

vPreco[1] := val(nMeta) / val(nHora) 
vPreco[2] := vPreco[1] / val(nPrazo)

JCmeta.mresult.value := Alltrim(str(vPreco[1],10,2)+' R$')
JCmeta.mresultd.value := Alltrim(str(vPreco[2],10,2)+' R$')

Return Nil
*----------------------*
Function FCmetaP(nMeta, nPreco, nPrazo)
*----------------------*
Local vHora[2]

vHora[1]:= val(nMeta) / val(nPreco) 
vHora[2]:= vHora[1] / val(nPrazo)

JCmeta.mresult.value  := Alltrim(str(vHora[1],10,0)+ ' horas')
JCmeta.mresultd.value := Alltrim(str(vHora[2],10,0)+ ' horas')

Return Nil 
