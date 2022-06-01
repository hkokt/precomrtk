#Include "Minigui.Ch"
#Include "Common.Ch"
#Define Cor {255,215,227}
#Define Cor2 {255,234,241}

Procedure Menuprincipal 

public tHora, nPreco, nTotal

Define Window Menuprinc;
    At 0,0;
    Width 800 Height 600;
    Title 'PreçO Marketing';
    Main;
    Nomaximize;
    Backcolor Cor

    @10,10 Grid Mostraregi;
            Width 600 Height 500;
            Headers {'Hora', 'PreçO', 'Total'};
            Widths {200,200,200};
            Backcolor Cor2
                    
    End Window 
    Center Window Menuprinc
    Activate Window Menuprinc
Return

Function Precototal()



Return
