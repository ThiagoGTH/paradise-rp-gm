CMD:tirarcarta(playerid)
{
    ShowPlayerDialog(playerid, 2981, DIALOG_STYLE_TABLIST_HEADERS, "Comprar Licenças", "Tipo\tValor\tRequisíto\n Licença Terrestre\t$75\t16 anos\n Licença Aérea\t$325\t18 anos", "Selecionar", "Cancelar"); 
    return 1;
}

stock dmv_OnDialogResponse(playerid, dialogid, response, listitem)
{
    if(dialogid == 2981) 
    { 
        if(response) // Se clicou no botão 'Selecionar' 
        { 
            if(listitem == 0) // Licença Terrestre 
            { 
	            if(PlayerInfo[playerid][pDriveLic] == 0)
				{
		            if (GetMoney(playerid) < 75)
		                return SendErrorMessage(playerid, "Você não possui dinheiro para pagar essa multa.");

					PlayerInfo[playerid][pDriveLic] = 1;
                    GiveMoney(playerid, -75);
					SendClientMessage(playerid, COLOR_LIGHTRED, "Você comprou a sua licença terrestre, tenha cuidado."); 
				}
		       	else
		        {
		        	SendClientMessage(playerid, COLOR_WHITE, "Você já possui uma licença terrestre.");
		        }
            } 
            if(listitem == 1) // Licença Áerea
            { 
	            if(PlayerInfo[playerid][pFlyLic] == 0)
				{
                    if (GetMoney(playerid) < 325)
		                return SendErrorMessage(playerid, "Você não possui dinheiro para pagar essa multa.");

					PlayerInfo[playerid][pFlyLic] = 1;
                    GiveMoney(playerid, -325);
					SendClientMessage(playerid, COLOR_LIGHTRED, "Você comprou a sua licença aérea, tenha cuidado.");
				}
		       	else
		        {
		        	SendClientMessage(playerid, COLOR_WHITE, "Você já possui uma licença aérea.");
		        }
            } 
        } 
    } 
    return true;  
}

CMD:mostrarlicencas(playerid, params[])
{
	if(!PlayerInfo[playerid][user_logged]) return SendClientMessage(playerid, COLOR_LIGHTRED, "ERRO: Você precisa estar logado.");
    new other, string[256];
	if (sscanf(params, "i", other)) return SendClientMessage(playerid, COLOR_GREY,"USE: /mostrarlicencas [ID]");
	else
	{
	    if(!IsPlayerConnected(other)) return SendClientMessage(playerid, COLOR_LIGHTRED, "ERRO: Este player não está logado.");
	    if(ProxDetectorS(7.0, playerid, other))
		{
		    if(playerid != other)
		    {
		    	format(string,sizeof(string),"* %s mostra suas licenças para %s", pNome(playerid), pNome(other));
			   	SendClientMessageInRange(10.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
			}
		    SendClientMessage(other, COLOR_LIGHTGREEN,"________PARADISE ID_________");
			format(string, sizeof(string), "Nome: %s        Nascimento: %s", pNome(playerid), PlayerInfo[playerid][pBirthdate]);
			SendClientMessage(other, COLOR_WHITE, string);
		    if(PlayerInfo[playerid][pDriveLic] > 0)
			{
				format(string, sizeof(string), "Licença de Motorista: Possui.");
				SendClientMessage(other, COLOR_WHITE, string);
			}
			else
			{
			    format(string, sizeof(string), "Licença de Motorista: Não possui.");
				SendClientMessage(other, COLOR_LIGHTRED, string);
			}
			if(PlayerInfo[playerid][pFlyLic] > 0)
			{
				format(string, sizeof(string), "Licença de Voo: Possui.");
				SendClientMessage(other, COLOR_WHITE, string);
			}
			else
			{
			    format(string, sizeof(string), "Licença de Voo: Não possui");
				SendClientMessage(other, COLOR_LIGHTRED, string);
			}
			SendClientMessage(other, COLOR_LIGHTGREEN, "________________________________");
		}
		else
		{
			SendClientMessage(playerid, COLOR_GRAD1, "   Jogador está muito longe.");
		}
	}
	return 1;
}

CMD:mostrardistintivo(playerid, params[])
{
	static
	    userid;

	if (sscanf(params, "u", userid))
	    return SendSyntaxMessage(playerid, "/mostrardistintivo [playerid/nome]");

	if (userid == INVALID_PLAYER_ID || !IsPlayerNearPlayer(playerid, userid, 5.0))
	    return SendErrorMessage(playerid, "O jogador está desconectado ou longe de você.");

    if (GetFactionType(playerid) != FACTION_POLICE)
	    return SendErrorMessage(playerid, "Você não possui um distintivo.");

	if(userid == playerid)
	{
 		SendClientMessageEx(playerid, COLOR_GREEN, "_______________[PARADISE CITY GOVERNMENT]_______________");
       	SendClientMessageEx(playerid, COLOR_WHITE, "Nome: %s", pNome(playerid));
       	SendClientMessageEx(playerid, COLOR_WHITE, "Organização: %s", FactionData[PlayerInfo[playerid][pFaction]][factionName]);
 		SendClientMessageEx(playerid, COLOR_WHITE, "Função: %s", Faction_GetRank(playerid));
 		//SendClientMessageEx(playerid, COLOR_WHITE, "Distintivo: #%d", PlayerInfo[playerid][pDistintivo]);
	}
	else
	{

	   	SendClientMessageEx(userid, COLOR_GREEN, "_______________[PARADISE CITY GOVERNMENT]_______________");
       	SendClientMessageEx(userid, COLOR_WHITE, "Nome: %s", pNome(playerid));
		SendClientMessageEx(userid, COLOR_WHITE, "Organização: %s",FactionData[PlayerInfo[playerid][pFaction]][factionName]);
 		SendClientMessageEx(userid, COLOR_WHITE, "Função: %s", Faction_GetRank(playerid));
 		//SendClientMessageEx(userid, COLOR_WHITE, "Distintivo: #%d", PlayerInfo[playerid][pDistintivo]);
 		SendNearbyMessage(playerid, 10.0, COLOR_PURPLE, "* %s pega do bolso um documento e mostra-o para %s.", pNome(playerid), pNome(userid));

	}
	return 1;
}

CMD:licencamotorista(playerid, params[])
{
	static
	    userid;

	new string[256];

	if (sscanf(params, "u", userid))
	    return SendClientMessage(playerid, COLOR_GRAD1, "/licencamotorista [playerid/nome]");

	if (userid == INVALID_PLAYER_ID || !IsPlayerNearPlayer(playerid, userid, 5.0))
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "O jogador está desconectado ou longe de você.");

	if (PlayerInfo[playerid][pDriveLic] == 0)
		return SendClientMessage(playerid, COLOR_LIGHTRED, "Você não tem uma licença de motorista.");

	new peso[24],altura[32],etnia[128],olhos[32],cabelo[32];

	new atext[20];
	if(PlayerInfo[userid][pGender] == 1)
	{
	 	atext = "Masculino";
	}
	else
	{
		atext = "Feminino";
	}
	switch (PlayerInfo[userid][pAltura])
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
 	switch (PlayerInfo[userid][pPeso])
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
 	switch (PlayerInfo[userid][pEtnia])
 	{
 	    case 0: { etnia = "N/A";}
		case 1: { etnia = "Caucasiano";}
		case 2: { etnia = "Negro";}
		case 3: { etnia = "Asiático";}
		case 4: { etnia = "Hispânico";}
		case 5: { etnia = "Mediterrâneo";}
		case 6: { etnia = "Desconhecida";}
 	}
 	switch (PlayerInfo[userid][pOlhos])
 	{
 	    case 0: { olhos = "N/A";}
		case 1: { olhos = "Castanhos-claro";}
		case 2: { olhos = "Castanhos-escuro";}
		case 3: { olhos = "Azuis";}
		case 4: { olhos = "Verdes";}
 	}
	switch (PlayerInfo[userid][pCabelo])
 	{
 	    case 0: { cabelo = "N/A";}
		case 1: { cabelo = "Preto";}
		case 2: { cabelo = "Branco";}
		case 3: { cabelo = "Grisalho";}
		case 4: { cabelo = "Loiro";}
		case 5: { cabelo = "Afro";}
		case 6: { cabelo = "Careca";}
 	}

	if(userid == playerid)
	{
 		SendClientMessage(playerid, COLOR_RADIO, "_________________[PARADISE CITY DRIVER LICENSE]_________________");
       	format(string, sizeof(string), "Nome: %s 	Nascimento: %s", pNome(playerid), PlayerInfo[playerid][pBirthdate]);
		SendClientMessage(playerid, COLOR_WHITE, string);
		format(string, sizeof(string), "Altura: %s 	Sexo: %s", altura, atext);
		SendClientMessage(playerid, COLOR_WHITE, string);
		format(string, sizeof(string), "Etnia: %s 	Cabelo: %s", etnia, cabelo);
		SendClientMessage(playerid, COLOR_WHITE, string);
		format(string, sizeof(string), "Peso: %s 	Olhos: %s", peso, olhos);
		SendClientMessage(playerid, COLOR_WHITE, string);
 		SendClientMessage(playerid, COLOR_WHITE, "Validade: 03/12/2025");
 		//SendClientMessage(playerid, COLOR_RADIO, "_________________[GOVERNMENT OF PARADISE CITY]__________________");

	}
	else
	{
	    SendClientMessage(userid, COLOR_RADIO, "_________________[PARADISE CITY DRIVER LICENSE]_________________");
       	format(string, sizeof(string), "Nome: %s | Nascimento: %s", pNome(userid), PlayerInfo[userid][pBirthdate]);
		SendClientMessage(userid, COLOR_WHITE, string);
		format(string, sizeof(string), "Altura: %s | Sexo: %s", altura, atext);
		SendClientMessage(userid, COLOR_WHITE, string);
		format(string, sizeof(string), "Etnia: %s | Cabelo: %s", etnia, cabelo);
    	SendClientMessage(userid, COLOR_WHITE, string);
		format(string, sizeof(string), "Peso: %s | Olhos: %s", peso, olhos);
		SendClientMessage(userid, COLOR_WHITE, string);
 		SendClientMessage(userid, COLOR_WHITE, "Validade: 03/12/2025");
 		//SendClientMessage(userid, COLOR_RADIO, "_________________[GOVERNMENT OF PARADISE CITY]__________________");

 		format(string, sizeof(string), "* %s pega do bolso um documento e mostra-o para %s.", pNome(playerid), pNome(userid));
		ProxDetector(10.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
	}
	return 1;
}
