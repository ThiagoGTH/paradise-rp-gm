new Text:Blind, Text:Blind2, Text:Blind3, Text:Blind4;
stock screen_OnGMInit()
{
	Blind = TextDrawCreate(641.199951, 1.500000, "anything");
	TextDrawLetterSize(Blind, 0.000000, 49.378147);
	TextDrawAlignment(Blind, 3);
	TextDrawUseBox(Blind, true);
	TextDrawBoxColor(Blind, 255);
	
	Blind2 = TextDrawCreate(641.199951, 1.500000, "anything");
	TextDrawLetterSize(Blind2, 0.000000, 49.378147);
	TextDrawAlignment(Blind2, 3);
	TextDrawUseBox(Blind2, true);
	TextDrawBoxColor(Blind2, 0x2F221AFF);

    Blind3 = TextDrawCreate(641.199951, 1.500000, "anything");
	TextDrawLetterSize(Blind3, 0.000000, 49.378147);
	TextDrawAlignment(Blind3, 3);
	TextDrawUseBox(Blind3, true);
	TextDrawBoxColor(Blind3, 0x808080FF);

    Blind4 = TextDrawCreate(641.199951, 1.500000, "anything");
	TextDrawLetterSize(Blind4, 0.000000, 49.378147);
	TextDrawAlignment(Blind4, 3);
	TextDrawUseBox(Blind4, true);
	TextDrawBoxColor(Blind4, 0xFFA500FF);
	return 1;
}

CMD:tela(playerid,params[])
{
	new option;
	if(sscanf(params, "d", option))
	{
		SendClientMessage(playerid, COLOR_GREY, "USE: /tela 1-4");
		return SendClientMessage(playerid, COLOR_GREY, "INFO: Utilize /ajuda tela para para mais informações.");
	}

	switch(option)
	{
		case 0:
		{
			TextDrawHideForPlayer(playerid, Blind);
			TextDrawHideForPlayer(playerid, Blind2);
			TextDrawHideForPlayer(playerid, Blind3);
			TextDrawHideForPlayer(playerid, Blind4);
		}
		case 1: TextDrawShowForPlayer(playerid, Blind);
		case 2: TextDrawShowForPlayer(playerid, Blind2);
        case 3: TextDrawShowForPlayer(playerid, Blind3);
        case 4: TextDrawShowForPlayer(playerid, Blind4);
		default: SendClientMessage(playerid, 0xDE3838FF, "ERRO: Opção inválida! Utilize /ajuda tela para mais informações.");
	}
	return 1;
}