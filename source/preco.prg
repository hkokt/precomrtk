#Include "Minigui.ch"
#Include "Common.ch"
*-------------------------*
Procedure MenuPrincipal
*-------------------------*
 
**REQUEST DBFCDX

**RDDSETDEFAULT("DBFCDX")
**DBSETDRIVER("DBFCDX")

Fjanelas()

Return

*-------------------------*
Function FJanelas()
*-------------------------*

DEFINE WINDOW primJanela;
AT 0 , 0;
WIDTH 750 HEIGHT 500;
MAIN;
NOMAXIMIZE;
NOSIZE

@10,10 GRID mostraConta;
     WIDTH 400 Heigth 500;
     HEADERS{'Preço','Hora','ToTAL'}

@20,450 BUTTON CalcTotal;
     CAPTION 'Calcular Total';
     WIDTH 200
     **Action {||FCalculaTotal()}

End Window 
Activate Window primJanela
Center Window primJanela

Return
