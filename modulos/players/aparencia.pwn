new confirm_dialog_extra[MAX_PLAYERS];

CMD:meupersonagem(playerid, params[])
{
	if(PlayerInfo[playerid][pPsgDados] == 0)
	{
		Dialog_Show(playerid, DateBirth2, DIALOG_STYLE_INPUT, "Data de Nascimento", "Digite a nova data de nascimento na caixa abaixo. (DD/MM/AAAA):", "Confirmar", "Cancelar");
	}
	else
	{
		SendClientMessage(playerid, COLOR_LIGHTRED, "Você já preencheu as informações de seu personagem.");
	}
	return 1;
}

CMD:aparencia(playerid, params[]) 
{
	Dialog_Show(playerid, MAINAPARENCIA, DIALOG_STYLE_LIST, "Editar Aparência", "Altura\nPeso\nEtnia\nOlhos\nCabelos", "Selecionar", "Cancelar");
	return 1;
}

CMD:minhaaparencia(playerid, params[])
{
	SendClientMessage(playerid, COLOR_YELLOW, "Sua aparência:");
	ShowAparencia(playerid, playerid);
	return 1;
}

CMD:veraparencia(playerid, params[])
{
	static userid;
	new string[128];
	
	if (sscanf(params, "u", userid))
	    return SendClientMessage(playerid, COLOR_GRAD1, "/veraparencia [playerid/nome]");

	if (userid == INVALID_PLAYER_ID || !IsPlayerNearPlayer(playerid, userid, 5.0))
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "O jogador está desconectado ou longe de você.");

	format(string, sizeof(string), "* %s observa a aparência de %s.", pNome(playerid), pNome(userid));
    SendClientMessageInRange(10.0, playerid, string,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
	format(string, sizeof(string), "Aparência de %s", pNome(userid));
	SendClientMessage(playerid, COLOR_YELLOW, string);
	ShowAparencia(playerid, userid);
	return 1;
}

Dialog:MAINAPARENCIA(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    switch (listitem)
	    {
	        case 0:
	        {
	            if(PlayerInfo[playerid][pAltura] == 0)
				{
				    Dialog_Show(playerid, ALTURA, DIALOG_STYLE_LIST, "Altura", "1,10m\n1,20m\n1,25m\n1,30m\n1,35m\n1,40m\n1,45m\n1,50m\n1,55m\n1,60m\n1,65m\n1,70m\n1,75m\n1,80m\n1,85m\n1,90m\n1,95m\n2,00m\n2,10m", "Selecionar", "Cancelar");
				}
				else
				{
				    SendClientMessage(playerid, COLOR_LIGHTRED, "Este campo já foi preenchido.");
				    return 1;
				}
    		}
    		case 1:
    		{
    		  	if(PlayerInfo[playerid][pPeso] == 0)
				{
				    Dialog_Show(playerid, PESO, DIALOG_STYLE_LIST, "Peso", "50kg\n60kg\n70kg\n80kg\n90kg\n100kg\n110kg\n120kg\n130kg\n140kg\n150kg", "Selecionar", "Cancelar");
				}
				else
				{
				    SendClientMessage(playerid, COLOR_LIGHTRED, "Este campo já foi preenchido.");
				    return 1;
				}
			}
			case 2:
    		{
    		  	if(PlayerInfo[playerid][pEtnia] == 0)
				{
				    Dialog_Show(playerid, ETNIA, DIALOG_STYLE_LIST, "Etnia", "Caucasiano\nNegro\nAsiático\nHispânico\nMediterrâneo\nDescohecida", "Selecionar", "Cancelar");
				}
				else
				{
				    SendClientMessage(playerid, COLOR_LIGHTRED, "Este campo já foi preenchido.");
				    return 1;
				}
			}
			case 3:
    		{
    		  	if(PlayerInfo[playerid][pOlhos] == 0)
				{
				    Dialog_Show(playerid, OLHOS, DIALOG_STYLE_LIST, "Olhos", "Castanhos-claro\nCastanhos-escuro\nAzuis\nVerdes", "Selecionar", "Cancelar");
				}
				else
				{
				    SendClientMessage(playerid, COLOR_LIGHTRED, "Este campo já foi preenchido.");
				    return 1;
				}
			}
			case 4:
    		{
    		  	if(PlayerInfo[playerid][pCabelo] == 0)
				{
				    Dialog_Show(playerid, CABELOS, DIALOG_STYLE_LIST, "Cabelo", "Preto\nBranco\nGrisalhos\nLoiro\nAfro\nCareca", "Selecionar", "Cancelar");
				}
                else
				{
				    SendClientMessage(playerid, COLOR_LIGHTRED, "Este campo já foi preenchido.");
				    return 1;
				}
			}
	    }
	}
	return 1;
}

Dialog:ALTURA(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    new altura[32];
	    new string[128];
		PlayerInfo[playerid][pAltura] = listitem+1;
		switch (PlayerInfo[playerid][pAltura])
 		{
 	    	case 0: { altura = "N/A";}
			case 1: { altura = "1,10m";}
			case 2: { altura = "1,20m";}
			case 3: { altura = "1,25m";}
			case 4: { altura = "1,30m";}
			case 5: { altura = "1,35m";}
			case 6: { altura = "1,40m";}
			case 7: { altura = "1,45m";}
			case 8: { altura = "1,50m";}
			case 9: { altura = "1,55m";}
			case 10: { altura = "1,60m";}
			case 11: { altura = "1,65m";}
			case 12: { altura = "1,70m";}
			case 13: { altura = "1,75m";}
			case 14: { altura = "1,80m";}
			case 15: { altura = "1,85m";}
			case 16: { altura = "1,90m";}
			case 17: { altura = "1,95m";}
			case 18: { altura = "2,00m";}
			case 19: { altura = "2,10m";}
 		}
 		format(string, sizeof(string), "Certo, sua altura é %s.", altura);
		SendClientMessage(playerid, COLOR_YELLOW, string);
        SaveAccount(playerid);
	}
	return 1;
}

forward SendConfirmationMsg(playerid,msg2[],type,extra);
public SendConfirmationMsg(playerid,msg2[],type,extra)
{
	confirm_dialog_extra[playerid] = extra;
	ShowPlayerDialog(playerid,type,DIALOG_STYLE_MSGBOX,"Confirmar ação",msg2,"Confirmar","Cancelar");
}

Dialog:ETNIA(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    new etnia[32];
	    new string[128];
		PlayerInfo[playerid][pEtnia] = listitem+1;
 		switch (PlayerInfo[playerid][pEtnia])
 		{
 	    	case 0: { etnia = "N/A";}
			case 1: { etnia = "Caucasiano";}
			case 2: { etnia = "Negro";}
			case 3: { etnia = "Asiático";}
			case 4: { etnia = "Hispânico";}
			case 5: { etnia = "Mediterrâneo";}
			case 6: { etnia = "Desconhecida";}
			
 		}
 		format(string, sizeof(string), "Certo, sua etnia é %s.", etnia);
		SendClientMessage(playerid, COLOR_YELLOW, string);
        SaveAccount(playerid);
	}
	return 1;
}
Dialog:OLHOS(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    new olhos[32];
	    new string[128];
		PlayerInfo[playerid][pOlhos] = listitem+1;
 		switch (PlayerInfo[playerid][pOlhos])
 		{
 	    	case 0: { olhos = "N/A";}
			case 1: { olhos = "Castanhos-claro";}
			case 2: { olhos = "Castanhos-escuro";}
			case 3: { olhos = "Azuis";}
			case 4: { olhos = "Verdes";}
 		}
 		format(string, sizeof(string), "Certo, seus olhos são %s.", olhos);
		SendClientMessage(playerid, COLOR_YELLOW, string);
        SaveAccount(playerid);
	}
	return 1;
}
Dialog:PESO(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    new peso[32];
	    new string[128];
		PlayerInfo[playerid][pPeso] = listitem+1;
		switch (PlayerInfo[playerid][pPeso])
 		{
 	    	case 0: { peso = "N/A";}
			case 1: { peso = "50kg";}
			case 2: { peso = "60kg";}
			case 3: { peso = "70kg";}
			case 4: { peso = "80kg";}
			case 5: { peso = "90kg";}
			case 6: { peso = "100kg";}
			case 7: { peso = "110kg";}
			case 8: { peso = "120kg";}
			case 9: { peso = "130kg";}
			case 10: { peso = "140kg";}
			case 11: { peso = "150kg";}
 		}
 		format(string, sizeof(string), "Certo, seu peso é %s.", peso);
		SendClientMessage(playerid, COLOR_YELLOW, string);
        SaveAccount(playerid);
	}
	return 1;
}
Dialog:CABELOS(playerid, response, listitem, inputtext[])
{
	if (response)
	{
		new cabelo[32];
		new string[128];
		PlayerInfo[playerid][pCabelo] = listitem+1;
		switch (PlayerInfo[playerid][pCabelo])
 		{
 	    	case 0: { cabelo = "N/A";}
			case 1: { cabelo = "Preto";}
			case 2: { cabelo = "Branco";}
			case 3: { cabelo = "Grisalho";}
			case 4: { cabelo = "Loiro";}
			case 5: { cabelo = "Afro";}
			case 6: { cabelo = "Careca";}
 		}
 		format(string, sizeof(string), "Certo, seu cabelo é %s.", cabelo);
		SendClientMessage(playerid, COLOR_YELLOW, string);
        SaveAccount(playerid);
	}
	return 1;
}

ShowAparencia(playerid, targetid)
{
    new
	    peso[24],
	    altura[32],
	    etnia[128],
		olhos[32],
		cabelo[32],
  		string[64];
		
	switch (PlayerInfo[targetid][pAltura])
 	{
 	    case 0: { altura = "N/A";}
		case 1: { altura = "1,10m";}
		case 2: { altura = "1,20m";}
		case 3: { altura = "1,25m";}
		case 4: { altura = "1,30m";}
		case 5: { altura = "1,35m";}
		case 6: { altura = "1,40m";}
		case 7: { altura = "1,45m";}
		case 8: { altura = "1,50m";}
		case 9: { altura = "1,55m";}
		case 10: { altura = "1,60m";}
		case 11: { altura = "1,65m";}
		case 12: { altura = "1,70m";}
		case 13: { altura = "1,75m";}
		case 14: { altura = "1,80m";}
		case 15: { altura = "1,85m";}
		case 16: { altura = "1,90m";}
		case 17: { altura = "1,95m";}
		case 18: { altura = "2,00m";}
		case 19: { altura = "2,10m";}
 	}
 	switch (PlayerInfo[targetid][pPeso])
 	{
		case 0: { peso = "N/A";}
		case 1: { peso = "50kg";}
		case 2: { peso = "60kg";}
		case 3: { peso = "70kg";}
		case 4: { peso = "80kg";}
		case 5: { peso = "90kg";}
		case 6: { peso = "100kg";}
		case 7: { peso = "110kg";}
		case 8: { peso = "120kg";}
		case 9: { peso = "130kg";}
		case 10: { peso = "140kg";}
		case 11: { peso = "145kg";}
 	}
 	switch (PlayerInfo[targetid][pEtnia])
 	{
 	    case 0: { etnia = "N/A";}
		case 1: { etnia = "Caucasiano";}
		case 2: { etnia = "Negro";}
		case 3: { etnia = "Asiático";}
		case 4: { etnia = "Hispânico";}
		case 5: { etnia = "Mediterrâneo";}
		case 6: { etnia = "Desconhecida";}
 	}
 	switch (PlayerInfo[targetid][pOlhos])
 	{
 	    case 0: { olhos = "N/A";}
		case 1: { olhos = "Castanhos-claro";}
		case 2: { olhos = "Castanhos-escuro";}
		case 3: { olhos = "Azuis";}
		case 4: { olhos = "Verdes";}
 	}
	switch (PlayerInfo[targetid][pCabelo])
 	{
 	    case 0: { cabelo = "N/A";}
		case 1: { cabelo = "Preto";}
		case 2: { cabelo = "Branco";}
		case 3: { cabelo = "Grisalho";}
		case 4: { cabelo = "Loiro";}
		case 5: { cabelo = "Afro";}
		case 6: { cabelo = "Careca";}
 	}
	format(string, sizeof(string), "Altura: %s.", altura);
	SendClientMessage(playerid, COLOR_WHITE, string);
	format(string, sizeof(string), "Peso: %s.", peso);
	SendClientMessage(playerid, COLOR_WHITE, string);
	format(string, sizeof(string), "Etnia: %s", etnia);
	SendClientMessage(playerid, COLOR_WHITE, string);
	format(string, sizeof(string), "Olhos: %s.", olhos);
	SendClientMessage(playerid, COLOR_WHITE, string);
	format(string, sizeof(string), "Cabelo: %s.", cabelo);
	SendClientMessage(playerid, COLOR_WHITE, string);
	return 1;
}

Dialog:DateBirth2(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    new
			iDay,
			iMonth,
			iYear;
	    static const
	        arrMonthDays[] = {31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};

	    if (sscanf(inputtext, "p</>ddd", iDay, iMonth, iYear)) {
         	Dialog_Show(playerid, DateBirth2, DIALOG_STYLE_INPUT, "Data de Nascimento", "Erro: Formato inválido.\n\nDigite a nova data de nascimento na caixa a abaixo. (DD/MM/AAAA):", "Confirmar", "Cancelar");
		}
		else if (iYear < 1900 || iYear > 2014) {
      		Dialog_Show(playerid, DateBirth2, DIALOG_STYLE_INPUT, "Data de Nascimento", "Erro: Formato inválido.\n\nDigite a nova data de nascimento na caixa a abaixo.: (DD/MM/AAAA):", "Confirmar", "Cancelar");
		}
		else if (iMonth < 1 || iMonth > 12) {
		    Dialog_Show(playerid, DateBirth2, DIALOG_STYLE_INPUT, "Data de Nascimento", "Erro: Formato inválido.\n\nDigite a nova data de nascimento na caixa a abaixo. (DD/MM/AAAA):", "Confirmar", "Cancelar");
		}
		else if (iDay < 1 || iDay > arrMonthDays[iMonth - 1]) {
		   	Dialog_Show(playerid, DateBirth2, DIALOG_STYLE_INPUT, "Data de Nascimento", "Erro: Formato inválido.\n\nDigite a nova nova de nascimento na caixa a abaixo. (DD/MM/AAAA):", "Confirmar", "Cancelar");
		}
		else {
		    format(PlayerInfo[playerid][pBirthdate], 24, inputtext);
		    Dialog_Show(playerid, Origin2, DIALOG_STYLE_INPUT, "Origem", "Digite a baixo o local de origem do personagem:", "Confirmar", "Cancel");

		}
	}
	return 1;
}

Dialog:DateBirth(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    new
			iDay,
			iMonth,
			iYear,
			string[64];

	    static const
	        arrMonthDays[] = {31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};

	    if (sscanf(inputtext, "p</>ddd", iDay, iMonth, iYear)) {
         		Dialog_Show(playerid, DateBirth, DIALOG_STYLE_INPUT, "Data de Nascimento", "Erro: Formato inválido.\n\n Digite a data de nascimento do personagem na caixa a abaixo: (DD/MM/AAAA):", "Confirmar", "Cancelar");
		}
		else if (iYear < 1900 || iYear > 2015) {
      			Dialog_Show(playerid, DateBirth, DIALOG_STYLE_INPUT, "Data de Nascimento", "Erro: Formato inválido.\n\n Digite a data de nascimento do personagem na caixa a abaixo: (DD/MM/AAAA):", "Confirmar", "Cancelar");
		}
		else if (iMonth < 1 || iMonth > 12) {
		    	Dialog_Show(playerid, DateBirth, DIALOG_STYLE_INPUT, "Data de Nascimento", "Erro: Formato inválido.\n\n Digite a data de nascimento do personagem na caixa a abaixo: (DD/MM/AAAA):", "Confirmar", "Cancelar");
		}
		else if (iDay < 1 || iDay > arrMonthDays[iMonth - 1]) {
		   		Dialog_Show(playerid, DateBirth, DIALOG_STYLE_INPUT, "Data de Nascimento", "Erro: Formato inválido.\n\n Digite a data de nascimento do personagem na caixa a abaixo: (DD/MM/AAAA):", "Confirmar", "Cancelar");
		}
		else {
		    format(PlayerInfo[playerid][pBirthdate], 24, inputtext);

		    format(string, sizeof(string), "Certo, você nasceu em %s.", inputtext);
			SendClientMessage(playerid, COLOR_YELLOW, string);
		}
	}
	return 1;
}

Dialog:Origin(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    new string[64];

	    if (isnull(inputtext) || strlen(inputtext) > 32) {
	        Dialog_Show(playerid, Origin, DIALOG_STYLE_INPUT, "Origem", "Digite a baixo o local de origem do personagem:", "Confirmar", "Cancel");
		}
		else for (new i = 0, len = strlen(inputtext); i != len; i ++) {
		    if ((inputtext[i] >= 'A' && inputtext[i] <= 'Z') || (inputtext[i] >= 'a' && inputtext[i] <= 'z') || (inputtext[i] >= '0' && inputtext[i] <= '9') || (inputtext[i] == ' ') || (inputtext[i] == ',') || (inputtext[i] == '.'))
				continue;

			else return Dialog_Show(playerid, Origin, DIALOG_STYLE_INPUT, "Origem", "Erro: Use somente letras e números.\n\nDigite abaixo o local de origem do personagem:", "Confirmar", "Cancel");
		}
		format(PlayerInfo[playerid][pOrigin], 32, inputtext);

		format(string, sizeof(string), "Certo, você é de %s.", inputtext);
		SendClientMessage(playerid, COLOR_YELLOW, string);
	}
	return 1;
}

Dialog:Origin2(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    if (isnull(inputtext) || strlen(inputtext) > 32) {
	        Dialog_Show(playerid, Origin2, DIALOG_STYLE_INPUT, "Origem", "Digite abaixo o local de origem do personagem:", "Confirmar", "Cancel");
		}
		else for (new i = 0, len = strlen(inputtext); i != len; i ++) {
		    if ((inputtext[i] >= 'A' && inputtext[i] <= 'Z') || (inputtext[i] >= 'a' && inputtext[i] <= 'z') || (inputtext[i] >= '0' && inputtext[i] <= '9') || (inputtext[i] == ' ') || (inputtext[i] == ',') || (inputtext[i] == '.'))
				continue;

			else return Dialog_Show(playerid, Origin2, DIALOG_STYLE_INPUT, "Origem", "Erro: Use somente letras e números.\n\nDigite abaixo o local de origem do personagem:", "Confirmar", "Cancel");
		}
		format(PlayerInfo[playerid][pOrigin], 32, inputtext);
		PlayerInfo[playerid][pPsgDados] = 1;
		SendClientMessage(playerid, COLOR_LIGHTRED, "Você completou os dados do seu personagem. Preencha a aparência utilizando \"/aparencia\".");
        SaveAccount(playerid);
	}
	return 1;
}