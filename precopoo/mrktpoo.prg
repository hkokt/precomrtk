#Include "minigui.ch"
#Include "common.ch"
#Include "classwin.prg"

procedure main
/*instancia Janela*/
Local wMenu:= janela():new()

wMenu:paraWin('menu1', 0, 0, 310, 300, 'controle marketing')
wMenu:montaMain()
wMenu:addBotao(100,50,'btorc','Orçamentos',100,100, 'winOrcamento()')
wMenu:addBotao(100,155,'btmeta','Metas',100,100, 'winMeta()')
wMenu:ativaWin()

return nil 

function winOrcamento()
/*instancia Janela*/
Local wOrc := janela():new()

wOrc:paraWin('orcamento', 0, 0, 900, 500, 'Orçamentos')
	wOrc:montaChild()
		wOrc:addGrid(10, 10, 'grid1', 700, 450,;
			{	'Cliente', ;
				'Horas/Dia ',;
				'Preço/Hora', ;
				'Prazo', ;
				'Total Horas', ;
				'Adicionais', ;
				'Valor final'}, ;
			{100, 100, 100, 100, 100, 100, 100},;
			{	BROWSE_JTFY_LEFT, ;
				BROWSE_JTFY_CENTER, ;
				BROWSE_JTFY_CENTER, ;
				BROWSE_JTFY_CENTER, ;
				BROWSE_JTFY_CENTER,	;
				BROWSE_JTFY_CENTER,	;
				BROWSE_JTFY_CENTER})
		wOrc:addBotao(50, 740, 'bt1', 'Novo Orçamento', 130, 30, 'teste()')					
		wOrc:addFrame(200, 720, 'pesquisa', "Filtros de pesquisa", 160, 235)
			WOrc:addLabel(220, 740, 'sort', "Organizar por:", 150, 30)
			wOrc:addCombobox(240, 740, 'qualsort', {"Último registro", "Ordem Alfabética"}, 1, 120)
		wOrc:addFrame(275, 730, 'pesquisa1', "Período de", 140, 100)
			wOrc:addDatepicker(300, 740, 'data1')
			wOrc:addLabel(325,745, 'a', "à", 200, 25)
			wOrc:addDatepicker(345, 740, 'data2')
			wOrc:addBotao(390, 750, 'busca', "Buscar", 90, 30, 'teste()')
wOrc:ativaWin()

return nil 

function winMeta()
/*instancia Janela*/
Local wMeta := janela():new()
Local qual := 1
wMeta:paraWin('meta', 0, 0, 1050, 500, 'Metas')
	wMeta:montaChild()
		switch qual 
				case 1
					wMeta:addGrid(10, 10, 'grid1', 832, 450, ;
						{	'Nome', ;
							'Meta', ;
							'Data', ;
							'Prazo', ;
							'Horas pretendidas', ;
							'Preço/Hora', ;
							'Meta diária'}, ;
						{150, 100, 100, 100, 130, 150, 100}, ;
						{	BROWSE_JTFY_LEFT, ;
							BROWSE_JTFY_CENTER, ;
							BROWSE_JTFY_CENTER, ;
							BROWSE_JTFY_CENTER, ;
							BROWSE_JTFY_CENTER, ;
							BROWSE_JTFY_CENTER, ;
							BROWSE_JTFY_CENTER}) 
				exit
		 		otherwise
					wMeta:addGrid(10, 10, 'grid1', 832, 450, ;
						{	'Nome', ;
							'Meta', ;
							'Data', ;
							'Prazo', ;
							'Valor pretendido', ;
							'Meta de horas', ;
							'Meta diária'}, ;
						{150, 100, 100, 100, 130, 150, 100},;
						{	BROWSE_JTFY_LEFT, ;
							BROWSE_JTFY_CENTER, ;
							BROWSE_JTFY_CENTER, ;
							BROWSE_JTFY_CENTER, ;
							BROWSE_JTFY_CENTER, ;
							BROWSE_JTFY_CENTER, ;
							BROWSE_JTFY_CENTER}) 
				exit 
			end
		wMeta:addbotao(50, 880, 'bt1', "Nova Meta", 130, 30)
		wMeta:addFrame(140, 860, 'pesquisa', "Filtros de Pesquisa", 160, 300)
			wMeta:addLabel(165, 880, 'tipo', "Calcular por:", 150, 30)	
			wMeta:addCombobox(185, 880, 'qualgrid', {"Hora", "Preço"}, 1, 100, 'GetProperty ( meta, qualgrid, Value ) -> qual')
			wMeta:addLabel(220, 880, 'sort', "Orfanizar por:", 150, 30)
			wMeta:addCombobox(240, 880, 'qualsort', {"Último registro", "Ordem alfabética"}, 1, 120)
		wMeta:addFrame(275, 870, 'pesquisa1', "Período de: ", 140, 100)
			wMeta:addDatepicker(300, 880, 'dataIni')
		wMeta:addLabel(325, 885, 'a', "à", 200, 25)
			wMeta:addDatepicker(345 , 880, 'dataFin')
			wMeta:addBotao(390, 890, 'busca', "buscar", 90, 30, 'teste()')
wMeta:ativaWin()

return nil 

Function teste()
return msginfo('foi')