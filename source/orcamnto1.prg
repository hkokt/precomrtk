
#Include "Minigui.Ch"
#Include "Common.Ch"
*-------------------------*
Procedure PMeta
*-------------------------*
    
    Define Window janelamenumeta;
    At 0 , 0;
    Width 750 Height 500;
    Main;
    NoMaximize;
    NoSize

@20,500 Button Calctotal;     
Caption 'Calcular Total';
Width 200;
Action {||FjanelaMeta()}

    
    End Window 
    Center Window janelamenumeta
    Activate Window janelamenumeta
    
Return

*-------------------------*
Function FjanelaMeta()
*-------------------------*  

	Define Window janelameta;
    At 0 , 0;
    Width 750 Height 500;
    Child;
    Nomaximize;
    Nosize
        
    @50,100 Combobox cb_MesDia;
    Items {'hora', 'Preco'};
    Value 1 ;
    Width 110 Font 'Arial' Size 9 ;
    On Change {|| mudaParametro()};
    On Enter {|| mudaParametro()}
     
    @100,100 Label infometa1 Value 'Digite a Meta desejada:';
        Width 300 Height 25 Font 'Arial' Size 09 Bold
    
    @125,100 Textbox InputMeta Width 300
    
    @200,100 Label infometa2 Value 'Digite a quantidade de horas que deseja trabalhar: ';
        Width 300 Height 25 Font 'Arial' Size 09 Bold
    
    @225,100 Textbox Inputhorapreco Width 300
    
    @300,100 Label infometa3 Value 'Preço necessário para alcançar a meta:';
         Width 300 Height 25 Font 'Arial' Size 09 Bold
    
    @375,100 Textbox Showhorapreco Width 300 Readonly
    
    @125,425 Button chamaCalcmeta;
         Caption 'Calcular' Width 150;
         Action {||Fcalculameta(janelameta.InputMeta.value, janelameta.Inputhorapreco.value)}
    
    @175,425 Button gravaCalcmeta;
         Caption 'Gravar' Width 150;
         Action {||Fcalculameta(), janelameta.Release}
    
    End Window 
    Center Window janelameta
    Activate Window janelameta 
    
Return 

*-------------------------*
Function mudaParametro()
*-------------------------*

if janelameta.cb_MesDia.value == 2

Modify Control infometa1 OF janelameta Value 'Digite a Meta desejada:'
Modify Control infometa2 OF janelameta Value 'Digite o preço das horas: '
Modify Control infometa3 OF janelameta Value 'Horas necessário para alcançar a meta:'

else 

Modify Control infometa1 OF janelameta Value 'Digite a Meta desejada:'
Modify Control infometa2 OF janelameta Value 'Digite a quantidade de horas que deseja trabalhar: '
Modify Control infometa3 OF janelameta Value 'Preço necessário para alcançar a meta:'

endif

Return

*-------------------------*
Function Fcalculameta(mMeta,mHoraPreco)
*-------------------------*

Local Result 
Local ResultTempo

	Result := val(mMeta) / val(mHoraPreco)

if janelameta.cb_MesDia.value = 1

	janelameta.Showhorapreco.value := Alltrim(Str(Result))

else 
	Fconvertehora(Result) 

endif

Return 

*-------------------------*
Function Fconvertehora(convHora)
*-------------------------*
Local ConvDia
Local ConvSeg
Local convertido 

if convHora < 1
	ConvSeg := convHora * 3.6
elseif convHora > 24
ConvDia := 0
	While (convHora > 24)
		convHora := convHora - 24 
		ConvDia++
	Enddo
endif 
/* corrigir 
janelameta.Showhorapreco.value := Alltrim(str(ConvDia) + str(ConvHora) + str(ConvSeg))
*/
Return 
