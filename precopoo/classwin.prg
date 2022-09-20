#Include "Minigui.ch"
#Include "hbclass.Ch"

Class janela

DATA sNome INIT 'NAME'
DATA nAt1 INIT 0
DATA nAt2 INIT 0
DATA nWidth INIT 400
DATA nHeight INIT 400
DATA sTitle INIT 'TITULO WIN GENERIC'

Method paraWin(sNome, nAt1, nAt2, nWidth, nHeight, sTitle)

Method montaMain()

Method montaChild()

Method addLabel()

Method addFrame()

Method addTextbox()

Method addDatepicker ()

Method addgrid()

Method addBotao()

Method addCombobox()

Method ativaWin()

End Class 



*=================================================================*
Method paraWin(nome, at1, at2, width, height, title) Class janela
*=================================================================*

::sNome := nome
::nAt1 := at1
::nAt2 := at2
::nWidth := width
::nHeight := height
::sTitle := title

Return Self 

*=================================================================*
Method montaMain() Class janela
*=================================================================*

	Define Window &(::sNome) ;
	At ::nAt1,::nAt2 ;
	Width ::nWidth Height ::nHeight ;
	Title ::sTitle ;
	Main;
	Nomaximize;
	Nosize
	
Return Self

*=================================================================*
Method montaChild() Class janela
*=================================================================*

	Define Window &(::sNome) ;
	At ::nAt1,::nAt2 ;
	Width ::nWidth Height ::nHeight ;
	Title ::sTitle ;
	Child;
	Nomaximize;
	Nosize
	
Return Self

*=================================================================*
Method addLabel(at1, at2, nome, value, width, height) Class janela 
*=================================================================*

@at1,at2 LABEL &(nome) ;
      VALUE value ;
      WIDTH width HEIGHT height 
      
Return Self 

*=================================================================*
Method addFrame(at1, at2, nome, caption, width, height) Class janela
*=================================================================*
@at1,at2 Frame &(nome) ;
Caption caption ;
Width width Height height ;
Transparent

Return Self 

*=================================================================*
Method addTextbox(at1, at2, nome, width, tooltip) Class janela 
*=================================================================*

@at1, at2 TEXTBOX &(nome) ;
      WIDTH width ;
      TOOLTIP tooltip

Return Self

*=================================================================*
Method addDatepicker (at1, at2, nome) Class janela 
*=================================================================*

@at1, at2 DATEPICKER &(nome) 

Return Self 

*=================================================================*
Method addGrid(at1, at2, nome, width, height, headers, widths, justify) Class janela 
*=================================================================*

@at1,at2 GRID &(nome);
	WIDTH width HEIGHT height;
	HEADERS headers;
	WIDTHS widths;
	JUSTIFY justify;
	FONT "Arial" SIZE 09
        
Return Self 

*=================================================================*
Method addBotao(at1,at2,nome,caption,width,height,action) Class janela 
*=================================================================*

@at1,at2 button &(nome);
caption caption;
Width width Height height;
Action {||&(action)}

Return Self

*=================================================================*
Method addCombobox(at1, at2, nome, items, value, width, onfocus) Class janela 
*=================================================================*
@at1 ,at2 Combobox &(nome) ;
Items items ;
Value value ;
Width width Font 'Arial' Size 9;
On gotfocus {|| &onfocus}

*=================================================================*
Method ativaWin() Class janela 
*=================================================================*
nome := ::sNome 

	end window 
	center window &nome
	activate window &nome
	
return self