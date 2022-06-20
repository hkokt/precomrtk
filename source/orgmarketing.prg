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
     aadd(Struct, {'' ,'N' , 19, 4 })
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
     aadd(Struct,{'' , 'N' , 19, 4 })
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
Headers {};
Widths {}

@400, 50 Button BCorc;
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
Headers {};
Widths {}

@400, 50 Button BCmeta;
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
Action {|| }


End Window 
Center Window JCorc
Activate Window JCorc 

Return Nil
*----------------------*
Procedure PCmeta()
*----------------------*
Define Window JCmeta 
At 0,0;
Width 400 Height 400;
Title 'Registro de Metas';
Child;
Nomaximize;
Nosize

@25,270 Combobox mEscolhe;
Items{'Hora', 'Preço'}
Value 1;
Width 110 Font 'Arial' Size 9 ;
On Change {|| Fqual(JCmeta.mEscolhe.value)}

@25,50 Textbox mNome Width 200

@75,50 Textbox mMeta Width 75

@125,50 Textbox mPreco Width 75

@125,140 Textbox mHoras Width 75

@175,50 Textbox oResultadoP Width 75 Readonly

@175,140 Textbox oResultadoH Width 75 Readonly

@225,50 Textbox oResultadoPD Width 75 Readonly

@225,140 Textbox oResultadoPH Width 75 Readonly

@175, 250 Button mCalcula;
Caption 'Calcular'

End Window
Center Window JCmeta 
Activate Window JCmeta

Return Nil 
*----------------------*
Function Fqual(escolheu)
*----------------------*
If escolheu == 1

	JCmeta.mPreco.Readonly 
	JCmeta.mCalcula.Action := FCmetaH()

Elseif escolheu == 2

	JCmeta.mHoras.Readonly 
	JCmeta.mCalcula.Action := FCmetaP()

Endif 

Return 
*----------Cálculos e gravações----------*

*----------------------*
Function FCorc()
*----------------------*

Return 
*----------------------*
Function FCmetaH(cNome, cMeta, nHora, nPrazo)
*----------------------*



Return 
*----------------------*
Function FCmetaP(cNome, cMeta, nPreco, nPrazo)
*----------------------*

Return 
