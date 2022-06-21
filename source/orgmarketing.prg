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
Procedure POsearch()
*----------------------*

Return
*----------------------*
Procedure PMsearch()
*----------------------*

Return
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
On Init {|| Fqual(JCmeta.mEscolhe.value)}

@25,270 Combobox mEscolhe;
Items{'Hora', 'Preço'};
Value 1;
Width 110 Font 'Arial' Size 9 ;
On Change {|| Fqual(JCmeta.mEscolhe.value)}

@25,50 Label nomeM Width 200 Height 25 Font 'Arial' Size 9 Bold
@50,50 Textbox mNome Width 200

@75,50 Label meta Width 75 Height 25 Font 'Arial' Size 9 Bold
@100,50 Textbox mMeta Width 75 Rightalign 

@75, 140 Label prazoM Width 75 Height 25 Font 'Arial' Size 9 Bold
@100, 140 Textbox mPrazo Width 75 Rightalign 

@125,50 Label precoM Width 75 Height 25 Font 'Arial' Size 9 Bold
@150,50 Textbox mPreco Width 75 Rightalign 

@175,50 Label resultadopM Width 75 Height 25 Font 'Arial' Size 9 Bold
@200,50 Textbox mResultadoP Width 75 Readonly Rightalign 

@225,50 Label resultadopdM Width 75 Height 25 Font 'Arial' Size 9 Bold
@250,50 Textbox mResultadoPD Width 75 Readonly Rightalign 

@125,140 Label horasM Width 75 Height 25 Font 'Arial' Size 9 Bold
@150,140 Textbox mHoras Width 75 Rightalign 

@225,140 Label resultadohDM Width 75 Height 25 Font 'Arial' Size 9 Bold
@250,140 Textbox mResultadoHD Width 75 Readonly

@175,140 Label resultadohM Width 75 Height 25 Font 'Arial' Size 9 Bold
@200,140 Textbox mResultadoH Width 75 Readonly

@175, 250 Button mCalcula;
Caption 'Calcular'

End Window
Center Window JCmeta
Activate Window JCmeta

Return Nil 
*----------------------*
Function Fqual(escolheu)
*----------------------*
JCmeta.mMeta.value:=""
JCmeta.mHoras.value:=""
JCmeta.mPreco.value:=""
JCmeta.mPrazo.value:=""
JCmeta.mResultadoP.value:=""
JCmeta.mResultadoPD.value:=""
JCmeta.mResultadoH.value:=""
JCmeta.mResultadoHD.value:=""

If escolheu == 1

	JCmeta.mPreco.Readonly := .T.
	JCmeta.mHoras.Readonly := .F.
	JCmeta.mCalcula.Action := {||FCmetaH(JCmeta.mMeta.value,JCmeta.mHoras.value,JCmeta.mPrazo.value)}

Else

	JCmeta.mPreco.Readonly := .F.
	JCmeta.mHoras.Readonly := .T.
	JCmeta.mCalcula.Action := {||FCmetaP(JCmeta.mMeta.value,JCmeta.mPreco.value,JCmeta.mPrazo.value)}

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

JCmeta.mResultadoH.value := Alltrim(str(vPreco[1]))
JCmeta.mResultadoHD.value := Alltrim(str(vPreco[2]))

Return Nil
*----------------------*
Function FCmetaP(nMeta, nPreco, nPrazo)
*----------------------*
Local vHora[2]

vHora[1]:=val(nMeta) / val(nPreco) 
vHora[2]:=vHora[1] / val(nPrazo)

JCmeta.mResultadoP.value := Alltrim(str(vHora[1]))
JCmeta.mResultadoPD.value := Alltrim(str(vHora[2]))

Return Nil 
