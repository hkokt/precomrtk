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

Return Nil
*----------------------*
Function FOrcDB()
*----------------------*
Local Struct := {}
Local CdxOrc := 'indexaorc'
Local OrcDB := 'OrcDB.DBF'

If ! File (OrcDB)	
     aadd(Struct,{'' ,'N' , 19, 4 })
     aadd(Struct, {'', 'C', 8, 0})
     aadd(Struct, {'', 'D', 8, 0})
     DbCreate(OrcDB, Struct, DRIVER)
Endif

USE (OrcDB) ALIAS OrcDB New Shared Via DRIVER 

If NetErr()
     MsgSTOP("Atenção ! Arquivo está bloqueado.")
     Return(.F.)
Endif

If ! File (CdxOrc + ".cdx")
     Index on Descend(Dtos()) + Descend() Tag tempo to (CdxOrc)
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
     aadd(Struct,{'' ,'N' , 19, 4 })
     aadd(Struct, {'', 'C', 8, 0})
     aadd(Struct, {'', 'D', 8, 0})
     DbCreate(MetaDB, Struct, DRIVER)
Endif

USE (MetaDB) ALIAS MetaDB New Shared Via DRIVER 

If NetErr()
     MsgSTOP("Atenção ! Arquivo está bloqueado.")
     Return(.F.)
Endif

If ! File (CdxMeta + ".cdx")
     Index on Descend(Dtos()) + Descend() Tag tempo to (CdxMeta)
Endif 

MetaDB->(dbSetIndex((CdxMeta)))

Return (.T.)

*----------------------*
Procedure Porc()
*----------------------*

Define Window 

Return Nil
*----------------------*
Procedure Pmeta()
*----------------------*

Return Nil
*----------------------*
Procedure PCorc()
*----------------------*

Return Nil
*----------------------*
Procedure PCmeta()
*----------------------*

Return Nil 
*----------------------*
Function FCorc()
*----------------------*

Return ()
*----------------------*
Function FCmeta()
*----------------------*

Return ()
