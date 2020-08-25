#include <YSI\y_hooks>

enum e_InteriorData {
	e_InteriorName[32],
	e_InteriorID,
	Float:e_InteriorX,
	Float:e_InteriorY,
	Float:e_InteriorZ
};

new const g_arrInteriorData[][e_InteriorData] = {
	{"24/7 1", 17, -25.884498, -185.868988, 1003.546875},
    {"24/7 2", 10, 6.091179, -29.271898, 1003.549438},
    {"24/7 3", 18, -30.946699, -89.609596, 1003.546875},
    {"24/7 4", 16, -25.132598, -139.066986, 1003.546875},
    {"24/7 5", 4, -27.312299, -29.277599, 1003.557250},
    {"24/7 6", 6, -26.691598, -55.714897, 1003.546875},
    {"Airport Ticket", 14, -1827.147338, 7.207417, 1061.143554},
    {"Airport Baggage", 14, -1861.936889, 54.908092, 1061.143554},
    {"Shamal", 1, 1.808619, 32.384357, 1199.593750},
    {"Andromada", 9, 315.745086, 984.969299, 1958.919067},
    {"Ammunation 1", 1, 286.148986, -40.644397, 1001.515625},
    {"Ammunation 2", 4, 286.800994, -82.547599, 1001.515625},
    {"Ammunation 3", 6, 296.919982, -108.071998, 1001.515625},
    {"Ammunation 4", 7, 314.820983, -141.431991, 999.601562},
    {"Ammunation 5", 6, 316.524993, -167.706985, 999.593750},
    {"Ammunation Booths", 7, 302.292877, -143.139099, 1004.062500},
    {"Ammunation Range", 7, 298.507934, -141.647048, 1004.054748},
    {"Blastin Fools Hallway", 3, 1038.531372, 0.111030, 1001.284484},
    {"Budget Inn Motel Room", 12, 444.646911, 508.239044, 1001.419494},
    {"Jefferson Motel", 15, 2215.454833, -1147.475585, 1025.796875},
    {"Off Track Betting Shop", 3, 833.269775, 10.588416, 1004.179687},
    {"Sex Shop", 3, -103.559165, -24.225606, 1000.718750},
    {"Meat Factory", 1, 963.418762, 2108.292480, 1011.030273},
    {"Zero's RC shop", 6, -2240.468505, 137.060440, 1035.414062},
    {"Dillimore Gas", 0, 663.836242, -575.605407, 16.343263},
    {"Catigula's Basement", 1, 2169.461181, 1618.798339, 999.976562},
    {"FC Janitor Room", 10, 1889.953369, 1017.438293, 31.882812},
    {"Woozie's Office", 1, -2159.122802, 641.517517, 1052.381713},
    {"Binco", 15, 207.737991, -109.019996, 1005.132812},
    {"Didier Sachs", 14, 204.332992, -166.694992, 1000.523437},
    {"Prolaps", 3, 207.054992, -138.804992, 1003.507812},
    {"Suburban", 1, 203.777999, -48.492397, 1001.804687},
    {"Victim", 5, 226.293991, -7.431529, 1002.210937},
    {"Zip", 18, 161.391006, -93.159156, 1001.804687},
    {"Club", 17, 493.390991, -22.722799, 1000.679687},
    {"Bar", 11, 501.980987, -69.150199, 998.757812},
    {"Lil' Probe Inn", 18, -227.027999, 1401.229980, 27.765625},
    {"Jay's Diner", 4, 457.304748, -88.428497, 999.554687},
    {"Gant Bridge Diner", 5, 454.973937, -110.104995, 1000.077209},
    {"Secret Valley Diner", 6, 435.271331, -80.958938, 999.554687},
    {"World of Coq", 1, 452.489990, -18.179698, 1001.132812},
    {"Welcome Pump", 1, 681.557861, -455.680053, -25.609874},
    {"Burger Shot", 10, 375.962463, -65.816848, 1001.507812},
    {"Cluckin' Bell", 9, 369.579528, -4.487294, 1001.858886},
    {"Well Stacked Pizza", 5, 373.825653, -117.270904, 1001.499511},
    {"Rusty Browns Donuts", 17, 381.169189, -188.803024, 1000.632812},
    {"Denise's Room", 1, 244.411987, 305.032989, 999.148437},
    {"Katie's Room", 2, 271.884979, 306.631988, 999.148437},
    {"Helena's Room", 3, 291.282989, 310.031982, 999.148437},
    {"Michelle's Room", 4, 302.180999, 300.722991, 999.148437},
    {"Barbara's Room", 5, 322.197998, 302.497985, 999.148437},
    {"Millie's Room", 6, 346.870025, 309.259033, 999.155700},
    {"Sherman Dam", 17, -959.564392, 1848.576782, 9.000000},
    {"Planning Dept", 3, 384.808624, 173.804992, 1008.382812},
    {"Area 51", 0, 223.431976, 1872.400268, 13.734375},
    {"LS Gym", 5, 772.111999, -3.898649, 1000.728820},
    {"SF Gym", 6, 774.213989, -48.924297, 1000.585937},
    {"LV Gym", 7, 773.579956, -77.096694, 1000.655029},
    {"B-Dup's House", 3, 1527.229980, -11.574499, 1002.097106},
    {"B-Dup's Crack Pad", 2, 1523.509887, -47.821197, 1002.130981},
    {"CJ's House", 3, 2496.049804, -1695.238159, 1014.742187},
    {"Madd Doggs Mansion", 5, 1267.663208, -781.323242, 1091.906250},
    {"OG Loc's House", 3, 513.882507, -11.269994, 1001.565307},
    {"Ryders House", 2, 2454.717041, -1700.871582, 1013.515197},
    {"Sweet's House", 1, 2527.654052, -1679.388305, 1015.498596},
    {"Crack Factory", 2, 2543.462646, -1308.379882, 1026.728393},
    {"Big Spread Ranch", 3, 1212.019897, -28.663099, 1000.953125},
    {"Fanny batters", 6, 761.412963, 1440.191650, 1102.703125},
    {"Strip Club", 2, 1204.809936, -11.586799, 1000.921875},
    {"Strip Club (Private Room)", 2, 1204.809936, 13.897239, 1000.921875},
    {"Unnamed Brothel", 3, 942.171997, -16.542755, 1000.929687},
    {"Tiger Skin Brothel", 3, 964.106994, -53.205497, 1001.124572},
    {"Pleasure Domes", 3, -2640.762939, 1406.682006, 906.460937},
    {"Liberty City Outside", 1, -729.276000, 503.086944, 1371.971801},
    {"Liberty City Inside", 1, -794.806396, 497.738037, 1376.195312},
    {"Gang House", 5, 2350.339843, -1181.649902, 1027.976562},
    {"Colonel Furhberger's", 8, 2807.619873, -1171.899902, 1025.570312},
    {"Crack Den", 5, 318.564971, 1118.209960, 1083.882812},
    {"Warehouse 1", 1, 1412.639892, -1.787510, 1000.924377},
    {"Warehouse 2", 18, 1302.519897, -1.787510, 1001.028259},
    {"Sweet's Garage", 0, 2522.000000, -1673.383911, 14.866223},
    {"Lil' Probe Inn Toilet", 18, -221.059051, 1408.984008, 27.773437},
    {"Unused Safe House", 12, 2324.419921, -1145.568359, 1050.710083},
    {"RC Battlefield", 10, -975.975708, 1060.983032, 1345.671875},
    {"Barber 1", 2, 411.625976, -21.433298, 1001.804687},
    {"Barber 2", 3, 418.652984, -82.639793, 1001.804687},
    {"Barber 3", 12, 412.021972, -52.649898, 1001.898437},
    {"Tatoo Parlor 1", 16, -204.439987, -26.453998, 1002.273437},
    {"Tatoo Parlor 2", 17, -204.439987, -8.469599, 1002.273437},
    {"Tatoo Parlor 3", 3, -204.439987, -43.652496, 1002.273437},
    {"LS Police HQ", 6, 246.783996, 63.900199, 1003.640625},
    {"SF Police HQ", 10, 246.375991, 109.245994, 1003.218750},
    {"LV Police HQ", 3, 288.745971, 169.350997, 1007.171875},
    {"Driving School", 3, -2029.798339, -106.675910, 1035.171875},
    {"8-Track", 7, -1398.065307, -217.028900, 1051.115844},
    {"Bloodbowl", 15, -1398.103515, 937.631164, 1036.479125},
    {"Dirt Track", 4, -1444.645507, -664.526000, 1053.572998},
    {"Kickstart", 14, -1465.268676, 1557.868286, 1052.531250},
    {"Vice Stadium", 1, -1401.829956, 107.051300, 1032.273437},
    {"SF Garage", 0, -1790.378295, 1436.949829, 7.187500},
    {"LS Garage", 0, 1643.839843, -1514.819580, 13.566620},
    {"SF Bomb Shop", 0, -1685.636474, 1035.476196, 45.210937},
    {"Blueberry Warehouse", 0, 76.632553, -301.156829, 1.578125},
    {"LV Warehouse 1", 0, 1059.895996, 2081.685791, 10.820312},
    {"LV Warehouse 2 (hidden part)", 0, 1059.180175, 2148.938720, 10.820312},
    {"Caligula's Hidden Room", 1, 2131.507812, 1600.818481, 1008.359375},
    {"Bank", 0, 2315.952880, -1.618174, 26.742187},
    {"Bank (Behind Desk)", 0, 2319.714843, -14.838361, 26.749565},
    {"LS Atrium", 18, 1710.433715, -1669.379272, 20.225049}
};

CMD:atrabalho(playerid, params[])
{
    if(PlayerInfo[playerid][user_logged] == 0)
	{
		SendClientMessage(playerid, COLOR_GRAD1, "Você não está logado.");
		return true;
	}
    if(PlayerInfo[playerid][user_admin] > 0)
    {
		switch(AdminTrabalhando[playerid])
		{
		    case 0:
			{
   				SendClientMessage(playerid, COLOR_YELLOW, "Você entrou em modo de trabalho administrativo.");
      			AdminTrabalhando[playerid] = 1;
                SetPlayerColor(playerid,0x587B95FF);
                SetPlayerAttachedObject(playerid, 8, 2992, 2, 0.306000, -0.012000, 0.009000, 0.000000, -95.299942, -1.399999, 1.000000, 1.000000, 1.000000);
                SetPlayerAttachedObject(playerid, 7, 2992, 2, 0.313000, -0.007000, 0.032999, -0.299999, 83.700019, 0.000000, 1.000000, 1.000000, 1.000000);
			}
		    case 1:
		    {
		        SendClientMessage(playerid, COLOR_YELLOW, "Você saiu do modo de trabalho administrativo.");
      			AdminTrabalhando[playerid] = 0;
                SetPlayerColor(playerid,COLOR_WHITE);
                RemovePlayerAttachedObject(playerid, 8);
                RemovePlayerAttachedObject(playerid, 7);
		    }
		}
	}
	return true;
}

CMD:gmx(playerid,params[])
{
	if(PlayerInfo[playerid][user_logged] == 0) return SendClientMessage(playerid, COLOR_GRAD1, "Você não está logado.");
	if(PlayerInfo[playerid][user_admin] < 5) return SendClientMessage(playerid, COLOR_GREY, "Você não possui autorização para utilizar esse comando.");
	if (PlayerInfo[playerid][user_admin] < 4 && !AdminTrabalhando[playerid])
        return SendClientMessage(playerid, COLOR_LIGHTRED, "ERRO: Você deve usar o comando /atrabalho antes.");
	GiveGMX();
	return 1;
}

CMD:tog(playerid, params[])
{
	if(PlayerInfo[playerid][user_logged] == 0)
	{
		SendClientMessage(playerid, COLOR_GRAD1, "Você não está logado.");
		return true;
	}

	new option[32];
	if(sscanf(params,"s[32]",option))
	{
	    SendClientMessage(playerid, COLOR_GREY, "USE: /tog [syntax]");
		SendClientMessage(playerid, COLOR_GREY, "SYNTAXES: pm, facção");
	    if(PlayerInfo[playerid][user_admin] >= 4)
		{
			SendClientMessage(playerid, COLOR_LIGHTRED, "Administração 4+: {FFFFFF}admin");
		}
		return 1;
	}

    if(strcmp(option, "pm", true) == 0)
    {
		switch(GetPVarInt(playerid, "TogPM"))
		{
	  		case 0:
			{
	   			if (PlayerInfo[playerid][user_admin] > 3)
	    		{
			    	SetPVarInt(playerid, "TogPM", 1);
				    SendClientMessage(playerid, COLOR_GREY, "Você desativou suas PM's.");
				}
				else return SendClientMessage(playerid, COLOR_LIGHTRED, "ERRO: Você deve ser um doador para ter acesso a este comando.");
			}
			case 1:
			{
				SetPVarInt(playerid, "TogPM", 0);
	    		SendClientMessage(playerid, COLOR_GREY, "Você ativou suas PM's.");
			}
		}
	}
	else if (!strcmp(option, "facção", true))
	{
	    if (PlayerInfo[playerid][pFaction] == -1)
	        return SendErrorMessage(playerid, "Você não faz parte de nenhuma facção.");

	    if (!PlayerInfo[playerid][pDisableFaction])
	    {
	        PlayerInfo[playerid][pDisableFaction] = 1;
			SendServerMessage(playerid, "Você desativou o chat da facção (/tog para ativar).");
		}
		else
		{
  			PlayerInfo[playerid][pDisableFaction] = 0;
     		SendServerMessage(playerid, "Você ativou o chat da facção.");
		}
	}
	else if(strcmp(option, "admin", true) == 0)
	{
	    if(PlayerInfo[playerid][user_admin] < 4) return SendClientMessage(playerid, COLOR_GREY, "Você não possui autorização para utilizar esse comando.");
		switch(GetPVarInt(playerid, "TogAdmin"))
		{
			case 0:
			{
				SetPVarInt(playerid, "TogAdmin", 1);
				SendClientMessage(playerid, COLOR_WHITE, "Você sumiu do /admins.");
			}
			case 1:
			{
	   			SetPVarInt(playerid, "TogAdmin", 0);
	   			SendClientMessage(playerid, COLOR_WHITE, "Você apareceu no /admins.");
			}
		}
	}
	return 1;
}

CMD:admins(playerid, params[])
{
	new count = 0;
	SendClientMessage(playerid, COLOR_WHITE, "Administradores online:");
    foreach (new i : Player) if (PlayerInfo[i][user_admin] > 0)
	{
		if(GetPVarInt(i, "TogAdmin") == 0)
		{
       	if(AdminTrabalhando[playerid] == 1)
			SendClientMessageEx(playerid, COLOR_WHITE, "* %s %s (%s) [%d]: {33CC33}Em trabalho", AdminRankName(playerid), pNome(i), PlayerInfo[i][pForumName], i);
		else
		    SendClientMessageEx(playerid, COLOR_WHITE, "* %s %s (%s) [%d]: {FF6347}Em roleplay", AdminRankName(playerid), pNome(i), PlayerInfo[i][pForumName], i);

        count++;
		}
	}
	if (!count) {
	    SendClientMessage(playerid, COLOR_WHITE, "Não há nenhum administrador online no momento.");
	}
	return 1;
}

CMD:aa(playerid)
{
    MEGAString[0]=EOS;
	if(PlayerInfo[playerid][user_logged] == 0) 
    { 
        SendClientMessage(playerid, COLOR_GRAD1, "Você não está logado.");
		return true;
	}
    if(PlayerInfo[playerid][user_admin] < 1) return SendClientMessage(playerid, COLOR_GREY, "Você não possui autorização para utilizar esse comando.");

	if(PlayerInfo[playerid][user_admin] >= 1)
	{
	    strcat(MEGAString, "{33AA33}_______________________________ COMANDOS ADMINISTRATIVOS _______________________________{FFFFFF}\n\n");
	}
	if(PlayerInfo[playerid][user_admin] >= 1)
	{
     	strcat(MEGAString, "[Tester] /atrabalho /trocarvw /trocarinterior /infoplayer /ir /ban /baninfo /spec /specoff /ajail /unajail /presos\n");
		strcat(MEGAString, "[Tester] /tapa /userforum /ultimoatirador /checkrt /chatkill /aremovercallsign /reviver\n\n");
	}
	if(PlayerInfo[playerid][user_admin] >= 2)
	{
		strcat(MEGAString, "[Game Admin] /ooc /reclife /limparchat /congelar /descongelar /oban /ajailoff /listaarmas /trazercarro\n");
		strcat(MEGAString, "[Game Admin] /respawncarcarro /respawnarcarros /respawnarperto\n\n");
	}
	if(PlayerInfo[playerid][user_admin] >= 3)
	{
		strcat(MEGAString, "[Senior Admin] /setskin /clima /desbanir /setcustomskin /entrarcarro /areparo /curartodos /pegarip\n");
		strcat(MEGAString, "[Senior Admin] /darvida /darcolete /resetararmas /perte\n\n");
	}
	if(PlayerInfo[playerid][user_admin] >= 4)
	{
		strcat(MEGAString, "[Lead Admin] /criarcarro /destruircarro /fly /ovni /ovnisair /dararma /setscore /setarequipe\n\n");
	}
	if(PlayerInfo[playerid][user_admin] >= 5)
	{
	    strcat(MEGAString, "[Head Admin] /setadmin /gmx /trancarserver /salvartodos /dargrana\n\n");
	}
	
	if(PlayerInfo[playerid][pFactionMod] >= 1)
	{
		strcat(MEGAString, "{33AA33}FACTION TEAM:{FFFFFF} /ajuda ft\n\n");
	}
	if(PlayerInfo[playerid][pPropertyMod] >= 1)
	{
		strcat(MEGAString, "{33AA33}PROPERTY TEAM:{FFFFFF} /ajuda pt\n\n");
	}
	ShowPlayerDialog(playerid, 8724, DIALOG_STYLE_MSGBOX, "COMANDOS ADMINISTRATIVOS", MEGAString, "OK","");
	return true;
}

CMD:darvida(playerid, params[])
{
	static
		userid,
	    Float:amount;

	if(PlayerInfo[playerid][user_logged] == 0) return SendClientMessage(playerid, COLOR_GRAD1, "Você não está logado.");
	if(PlayerInfo[playerid][user_admin] < 3) return SendClientMessage(playerid, COLOR_GREY, "Você não possui autorização para utilizar esse comando.");

	if (sscanf(params, "uf", userid, amount))
		return SendSyntaxMessage(playerid, "/darvida [playerid/nome] [quantidade]");

	if (userid == INVALID_PLAYER_ID)
	    return SendErrorMessage(playerid, "Você específicou um jogador inválido.");

	SetPlayerHealth(userid, amount);
	SendServerMessage(playerid, "Você setou %s com %.2f de vida.", pNome(userid), amount);
	return 1;
}

CMD:darcolete(playerid, params[])
{
	static
		userid,
	    Float:amount;

	if(PlayerInfo[playerid][user_logged] == 0) return SendClientMessage(playerid, COLOR_GRAD1, "Você não está logado.");
	if(PlayerInfo[playerid][user_admin] < 3) return SendClientMessage(playerid, COLOR_GREY, "Você não possui autorização para utilizar esse comando.");

	if (sscanf(params, "uf", userid, amount))
		return SendSyntaxMessage(playerid, "/darcolete [playerid/nome] [quantidade]");

	if (userid == INVALID_PLAYER_ID)
	    return SendErrorMessage(playerid, "Você específicou um jogador inválido.");

    SetPlayerArmour(userid, amount);
	SendServerMessage(playerid, "Você setou %s com %.2f de colete.", pNome(userid), amount);
	return 1;
}

CMD:resetararmas(playerid, params[])
{
	static
	    userid;

    if(PlayerInfo[playerid][user_logged] == 0) return SendClientMessage(playerid, COLOR_GRAD1, "Você não está logado.");
	if(PlayerInfo[playerid][user_admin] < 3) return SendClientMessage(playerid, COLOR_GREY, "Você não possui autorização para utilizar esse comando.");

	if (sscanf(params, "u", userid))
	    return SendSyntaxMessage(playerid, "/resetararmas [playerid/nome]");

    if (userid == INVALID_PLAYER_ID)
	    return SendErrorMessage(playerid, "Você específicou um jogador inválido.");

	ResetWeapons(userid);
	SendAdminAction(playerid, "Você resetou as armas de %s.", pNome(userid));
	return 1;
}

CMD:pegarip(playerid, params[])
{
	static
	    userid;

    if(PlayerInfo[playerid][user_logged] == 0) return SendClientMessage(playerid, COLOR_GRAD1, "Você não está logado.");
	if(PlayerInfo[playerid][user_admin] < 3) return SendClientMessage(playerid, COLOR_GREY, "Você não possui autorização para utilizar esse comando.");
	if (PlayerInfo[playerid][user_admin] < 4 && !AdminTrabalhando[playerid])
        return SendClientMessage(playerid, COLOR_LIGHTRED, "ERRO: Você deve usar o comando /atrabalho antes.");

	if (sscanf(params, "u", userid))
	    return SendSyntaxMessage(playerid, "/pegarip [playerid/nome]");

	if (userid == INVALID_PLAYER_ID)
	    return SendErrorMessage(playerid, "Você específicou um jogador inválido.");

	SendServerMessage(playerid, "O IP de %s é: %s.", pNome(userid), ReturnIP(userid));
	return 1;
}

CMD:curartodos(playerid, params[])
{
	if(PlayerInfo[playerid][user_logged] == 0) return SendClientMessage(playerid, COLOR_GRAD1, "Você não está logado.");
	if(PlayerInfo[playerid][user_admin] < 3) return SendClientMessage(playerid, COLOR_GREY, "Você não possui autorização para utilizar esse comando.");
	new string[256];
	foreach (new i : Player) {
	    SetPlayerHealth(i, 100.0);
	}
	format(string, 128, "AdmCmd: O administrador %s curou todos os jogadores online.", pNome(playerid));
	ABroadCast(COLOR_LIGHTGREEN,string,1);
	return 1;
}

CMD:setarequipe(playerid, params[])
{
	static
		userid,
		type[24];

	if(PlayerInfo[playerid][user_logged] == 0) return SendClientMessage(playerid, COLOR_GRAD1, "Você não está logado.");
	if(PlayerInfo[playerid][user_admin] < 5) return SendClientMessage(playerid, COLOR_GREY, "Você não possui autorização para utilizar esse comando.");

	if (sscanf(params, "us[32]", userid, type))
	{
	    SendSyntaxMessage(playerid, "/setarequipe [playerid/nome] [equipe]");
		SendClientMessage(playerid, -1, "EQUIPES: faction team, property team");
		return 1;
	}

	if (userid == INVALID_PLAYER_ID)
	    return SendErrorMessage(playerid, "Você específicou um jogador inválido.");

    if (!strcmp(type, "faction team", true))
	{
		if (PlayerInfo[userid][pFactionMod])
		{
			PlayerInfo[userid][pFactionMod] = false;

			SendAdminAction(playerid, "Você retirou %s da faction team.", pNome(userid));
			SendAdminAction(userid, "%s removeu você da faction team.", pNome(playerid));
		}
		else
		{
			PlayerInfo[userid][pFactionMod] = true;

			SendAdminAction(playerid, "Você colocou %s na faction team.", pNome(userid));
			SendAdminAction(userid, "%s colocou você na faction team.", pNome(playerid));
		}
	}

	if (!strcmp(type, "property team", true))
	{
		if (PlayerInfo[userid][pPropertyMod])
		{
			PlayerInfo[userid][pPropertyMod] = false;

			SendAdminAction(playerid, "Você retirou %s da faction team.", pNome(userid));
			SendAdminAction(userid, "%s removeu você da faction team.", pNome(playerid));
		}
		else
		{
			PlayerInfo[userid][pPropertyMod] = true;

			SendAdminAction(playerid, "Você colocou %s na faction team.", pNome(userid));
			SendAdminAction(userid, "%s colocou você na faction team.", pNome(playerid));
		}
	}


	return 1;
}
/*CMD:factionteam(playerid, params[])
{
	static
	    userid;

    if(PlayerInfo[playerid][user_logged] == 0) return SendClientMessage(playerid, COLOR_GRAD1, "Você não está logado.");
	if(PlayerInfo[playerid][user_admin] < 4) return SendClientMessage(playerid, COLOR_GREY, "Você não possui autorização para utilizar esse comando.");

	if (sscanf(params, "u", userid))
	    return SendSyntaxMessage(playerid, "/factionteam [playerid/nome]");

	if (userid == INVALID_PLAYER_ID)
	    return SendErrorMessage(playerid, "Você específicou um jogador inválido.");

	if (PlayerInfo[userid][pFactionMod])
	{
	    PlayerInfo[userid][pFactionMod] = false;

	    SendAdminAction(playerid, "Você retirou %s da faction team.", pNome(userid));
		SendAdminAction(userid, "%s removeu você da faction team.", pNome(playerid));
	}
	else
	{
	    PlayerInfo[userid][pFactionMod] = true;

        SendAdminAction(playerid, "Você colocou %s na faction team.", pNome(userid));
		SendAdminAction(userid, "%s colocou você na faction team.", pNome(playerid));
	}
	return 1;
}*/

CMD:areparo(playerid, params[])
{
    new vehicleid = GetPlayerVehicleID(playerid);

	if(PlayerInfo[playerid][user_logged] == 0) return SendClientMessage(playerid, COLOR_GRAD1, "Você não está logado.");
	if(PlayerInfo[playerid][user_admin] < 3) return SendClientMessage(playerid, COLOR_GREY, "Você não possui autorização para utilizar esse comando.");

	if (vehicleid > 0 && isnull(params))
	{
		RepairVehicle(vehicleid);
		SendServerMessage(playerid, "Você reparou seu veículo atual.");
	}
	else
	{
		if (sscanf(params, "d", vehicleid))
	    	return SendSyntaxMessage(playerid, "/areparo [ID]");

		else if (!IsValidVehicle(vehicleid))
	    	return SendErrorMessage(playerid, "Você especificou o ID de um veículo inexistente.");

		RepairVehicle(vehicleid);
		SendServerMessage(playerid, "Você reparou o veículo de ID: %d.", vehicleid);
	}
	return 1;
}

CMD:respawnarcarros(playerid, params[])
{
    if(PlayerInfo[playerid][user_logged] == 0) return SendClientMessage(playerid, COLOR_GRAD1, "Você não está logado.");
	if(PlayerInfo[playerid][user_admin] < 2) return SendClientMessage(playerid, COLOR_GREY, "Você não possui autorização para utilizar esse comando.");

	new count;
	new string [128];
	for (new i = 1; i != MAX_VEHICLES; i ++)
	{
	    if (IsValidVehicle(i) && GetVehicleDriver(i) == INVALID_PLAYER_ID)
	    {
	        RespawnVehicle(i);
			count++;
		}
	}
	if (!count)
	    return SendErrorMessage(playerid, "Não existem carros para serem respawnados.");

	format(string, sizeof(string), "AdmCmd: %s respawnou %d veículos desocupados.", pNome(playerid), count);
	ABroadCast(COLOR_LIGHTRED, string, 1);
	return 1;
}

CMD:respawnarperto(playerid, params[])
{
    if(PlayerInfo[playerid][user_logged] == 0) return SendClientMessage(playerid, COLOR_GRAD1, "Você não está logado.");
	if(PlayerInfo[playerid][user_admin] < 2) return SendClientMessage(playerid, COLOR_GREY, "Você não possui autorização para utilizar esse comando.");

	new count;

	for (new i = 1; i != MAX_VEHICLES; i ++)
	{
	    static
	        Float:fX,
	        Float:fY,
	        Float:fZ;

	    if (IsValidVehicle(i) && GetVehicleDriver(i) == INVALID_PLAYER_ID)
		{
			GetVehiclePos(i, fX, fY, fZ);

			if (IsPlayerInRangeOfPoint(playerid, 50.0, fX, fY, fZ))
			{
		        RespawnVehicle(i);
				count++;
			}
		}
	}
	if (!count)
	    return SendErrorMessage(playerid, "Não há veículos por perto para serem respawnados.");

	SendServerMessage(playerid, "Você respawnou %d veículos por perto.", count);
	return 1;
}
CMD:entrarcarro(playerid, params[])
{
	new vehicleid, seatid;

    if(PlayerInfo[playerid][user_logged] == 0) return SendClientMessage(playerid, COLOR_GRAD1, "Você não está logado.");
	if(PlayerInfo[playerid][user_admin] < 3) return SendClientMessage(playerid, COLOR_GREY, "Você não possui autorização para utilizar esse comando.");

	if (sscanf(params, "d", vehicleid))
	    return SendSyntaxMessage(playerid, "/entrrcarro [id]");

	if (vehicleid < 1 || vehicleid > MAX_VEHICLES || !IsValidVehicle(vehicleid))
		return SendErrorMessage(playerid, "Você especificou o ID de um veículo inexistente.");

	seatid = GetAvailableSeat(vehicleid, 0);

	if (seatid == -1)
	    return SendErrorMessage(playerid, "Não há assentos disponíveis nesse veículo.");

	PutPlayerInVehicle(playerid, vehicleid, seatid);
	return 1;
}

CMD:respawnarcarro(playerid, params[])
{
	new vehicleid;
	new string[128];
    if(PlayerInfo[playerid][user_logged] == 0) return SendClientMessage(playerid, COLOR_GRAD1, "Você não está logado.");
	if(PlayerInfo[playerid][user_admin] < 2) return SendClientMessage(playerid, COLOR_GREY, "Você não possui autorização para utilizar esse comando.");

	if (sscanf(params, "d", vehicleid))
	    return SendSyntaxMessage(playerid, "/respawnarcarro [ID]");

	if (vehicleid < 1 || vehicleid > MAX_VEHICLES || !IsValidVehicle(vehicleid))
		return SendErrorMessage(playerid, "Você especificou o ID de um veículo inexistente.");

	RespawnVehicle(vehicleid);
	format(string, sizeof(string), "AdmCmd: %s respawnou veículo ID: %s'.", pNome(playerid), vehicleid);
	ABroadCast(COLOR_LIGHTRED, string, 1);

	return 1;
}

CMD:trazercarro(playerid, params[])
{
	new vehicleid;

    if(PlayerInfo[playerid][user_logged] == 0) return SendClientMessage(playerid, COLOR_GRAD1, "Você não está logado.");
	if(PlayerInfo[playerid][user_admin] < 2) return SendClientMessage(playerid, COLOR_GREY, "Você não possui autorização para utilizar esse comando.");

	if (sscanf(params, "d", vehicleid))
	    return SendSyntaxMessage(playerid, "/trazercarro [id]");

	if (vehicleid < 1 || vehicleid > MAX_VEHICLES || !IsValidVehicle(vehicleid))
		return SendErrorMessage(playerid, "Você especificou o ID de um veículo inexistente.");

	static
	    Float:x,
	    Float:y,
	    Float:z;

	GetPlayerPos(playerid, x, y, z);
	SetVehiclePos(vehicleid, x + 2, y - 2, z);

 	SetVehicleVirtualWorld(vehicleid, GetPlayerVirtualWorld(playerid));
	LinkVehicleToInterior(vehicleid, GetPlayerInterior(playerid));

	return 1;
}

CMD:ultimoatirador(playerid, params[])
{
	if(PlayerInfo[playerid][user_logged] == 0) return SendClientMessage(playerid, COLOR_GRAD1, "Você não está logado.");
	if(PlayerInfo[playerid][user_admin] < 1) return SendClientMessage(playerid, COLOR_GREY, "Você não possui autorização para utilizar esse comando.");

	static
	    userid;

	new string [256];

	if (sscanf(params, "u", userid))
	    return SendClientMessage(playerid, COLOR_GREY, "USE: /ultimoatirador [playerid]");

    if (userid == INVALID_PLAYER_ID)
	    return SendClientMessage(playerid, COLOR_GREY, "ERRO: Você específicou um jogador inválido.");

	if (PlayerInfo[userid][pLastShot] == INVALID_PLAYER_ID)
	    return SendClientMessage(playerid, COLOR_GREY, "ERRO: Este jogador não foi atingido desde que logou.");

	format(string, sizeof(string), "SERVER: %s foi atingido por último por: %s (%s).", pNome(userid), pNome(PlayerInfo[userid][pLastShot]), GetDuration(gettime() - PlayerInfo[userid][pShotTime]));
	SendClientMessage(playerid, COLOR_YELLOW, string);
    return 1;
}

CMD:dargrana(playerid, params[])
{
	static
		userid,
	    amount;
	new string[256];
	if(PlayerInfo[playerid][user_logged] == 0) return SendClientMessage(playerid, COLOR_GRAD1, "Você não está logado.");
	if(PlayerInfo[playerid][user_admin] < 5) return SendClientMessage(playerid, COLOR_GREY, "Você não possui autorização para utilizar esse comando.");

	if (sscanf(params, "ud", userid, amount))
		return SendSyntaxMessage(playerid, "/dargrana [playerid/nome] [quantidade]");

	if (userid == INVALID_PLAYER_ID)
	    return SendErrorMessage(playerid, "Você específicou um jogador inválido.");

	GiveMoney(userid, amount);

	format(string, sizeof(string), "AdmCmd: %s deu $%s para %s.", pNome(playerid), FormatNumber(amount), pNome(userid));
	ABroadCast(COLOR_LIGHTRED, string, 1);
 	format(string, sizeof(string), " `LOG-CASH:` [%s] **%s** deu **$%s** para **%s** *(%s)*", ReturnDate(), pNome(playerid), FormatNumber(amount), pNome(userid), ReturnIP(userid));
    DCC_SendChannelMessage(DC_LogAdmin, string);
	return 1;
}

CMD:userforum(playerid, params[])
{
	if(PlayerInfo[playerid][user_logged] == 0) return SendClientMessage(playerid, COLOR_GRAD1, "Você não está logado.");
	if(PlayerInfo[playerid][user_admin] < 1) return SendClientMessage(playerid, COLOR_GREY, "Você não possui autorização para utilizar esse comando.");

	new name[30];
	if(sscanf(params, "s[30]", name))
		return SendClientMessage(playerid, COLOR_GREY, "/userforum [nome no fórum]");

	if(strlen(name) > 30)
		return SendClientMessage(playerid, COLOR_GREY, "ERRO: Você deve escolher um nome no fórum que não passe de 30 caracteres.");
	
	new string[258];
	format(PlayerInfo[playerid][pForumName], 30, "%s", name);
	if(PlayerInfo[playerid][user_admin] > 0)
	{
		format(string, sizeof(string), "AdmCmd: %s %s atualizou o nome do fórum para '%s'.", AdminRankName(playerid), pNome(playerid), PlayerInfo[playerid][pForumName]);
		ABroadCast(COLOR_LIGHTRED, string, 1);

		format(string, sizeof(string), " `LOG-UF:` [%s] **%s %s** atualizou o nome do forum para **%s**", ReturnDate(), AdminRankName(playerid), pNome(playerid), PlayerInfo[playerid][pForumName]);
    	DCC_SendChannelMessage(DC_LogAdmin, string);
		
	}
	return 1;
}

CMD:listaarmas(playerid, params[])
{
	new userid;

	if(PlayerInfo[playerid][user_logged] == 0) return SendClientMessage(playerid, COLOR_GRAD1, "Você não está logado.");
	if(PlayerInfo[playerid][user_admin] < 2) return SendClientMessage(playerid, COLOR_GREY, "Você não possui autorização para utilizar esse comando.");
	if (PlayerInfo[playerid][user_admin] < 4 && !AdminTrabalhando[playerid])
        return SendClientMessage(playerid, COLOR_LIGHTRED, "ERRO: Você deve usar o comando /atrabalho antes.");

	if (sscanf(params, "u", userid))
	    return SendSyntaxMessage(playerid, "/listaarmas [playerid/nome]");

	if (userid == INVALID_PLAYER_ID)
	    return SendErrorMessage(playerid, "Esse jogador está desconectado.");

	new
	    weaponid,
	    ammo;

    SendClientMessage(playerid, COLOR_GREY, "-----------------------------------------------------------");
    SendClientMessageEx(playerid, COLOR_LIGHTRED, "Armas de %s:", pNome(userid));

	for (new i = 0; i < 13; i ++)
	{
		GetPlayerWeaponData(userid, i, weaponid, ammo);

		if (weaponid > 0)
		    SendClientMessageEx(playerid, COLOR_WHITE, "* %s (%d munições)", ReturnWeaponName(weaponid), ammo);
	}
	SendClientMessage(playerid, COLOR_GREY, "-----------------------------------------------------------");
	return 1;
}

CMD:tapa(playerid, params[])
{
	static
	    userid;
	new string[128];
    if(PlayerInfo[playerid][user_logged] == 0) return SendClientMessage(playerid, COLOR_GRAD1, "Você não está logado.");
	if(PlayerInfo[playerid][user_admin] < 1) return SendClientMessage(playerid, COLOR_GREY, "Você não possui autorização para utilizar esse comando.");
	if (PlayerInfo[playerid][user_admin] < 4 && !AdminTrabalhando[playerid])
        return SendClientMessage(playerid, COLOR_LIGHTRED, "ERRO: Você deve usar o comando /atrabalho antes.");

	if (sscanf(params, "u", userid))
	    return SendClientMessage(playerid, COLOR_GREY, "USE: /tapa [playerid/name]");

    if (userid == INVALID_PLAYER_ID)
	    return SendClientMessage(playerid, COLOR_GREY, "ERRO: Jogador desconectado.");

	static
	    Float:x,
	    Float:y,
	    Float:z;

	GetPlayerPos(userid, x, y, z);
	SetPlayerPos(userid, x, y, z + 5);

	PlayerPlaySound(userid, 1130, 0.0, 0.0, 0.0);
	format(string, sizeof(string), "AdmCmd: %s deu um tapa em %s.", pNome(playerid), pNome(userid));
	ABroadCast(COLOR_LIGHTRED, string, 1);
	format(string, sizeof(string), " `LOG-TAPA:` [%s] **%s** deu um tapa em **%s**", ReturnDate(), pNome(playerid), pNome(userid));
    DCC_SendChannelMessage(DC_LogAdmin, string);
	return 1;
}

CMD:ajailoff(playerid, params[])
{
	if(PlayerInfo[playerid][user_logged] == 0) return SendClientMessage(playerid, COLOR_GRAD1, "Você não está logado.");
	if(PlayerInfo[playerid][user_admin] < 2) return SendClientMessage(playerid, COLOR_GREY, "Você não possui autorização para utilizar esse comando.");
	if (PlayerInfo[playerid][user_admin] < 4 && !AdminTrabalhando[playerid])
        return SendClientMessage(playerid, COLOR_LIGHTRED, "ERRO: Você deve usar o comando /atrabalho antes.");

	new name[MAX_PLAYER_NAME], reason[128], query[300], time, string[100], rows;
	if(sscanf(params, "sds[100]", name, time, reason)) return SendClientMessage(playerid, COLOR_GREY, "USE: /ajailoff [nome] [tempo] [motivo]");
	mysql_format(Database, query, sizeof(query), "SELECT `Username` FROM `players` WHERE `Username` = '%e' LIMIT 0,1", name);
	new Cache:result = mysql_query(Database, query);
	cache_get_row_count(rows);

	if(!rows)
	{
	    SendClientMessage(playerid, COLOR_GREY, "ERRO: Esse usuário não existe.");
	}
	
	if(time < 1) return SendClientMessage(playerid, COLOR_GREY, "ERRO: Você não pode prender um jogador por menos de um minuto.");

	for (new i = 0; i < rows; i ++)
	{
		mysql_format(Database, query, sizeof(query), "UPDATE `players` SET `Jailed` = '%i', `JailedTime` = '%i' WHERE `Username` = '%e'", 1, time, name);
		mysql_tquery(Database, query);
		format(string, sizeof(string), "AdmCmd: %s foi preso off-line por %s por %d minutos, motivo: %s.", name, pNome(playerid), time, reason);
		SendClientMessageToAll(COLOR_LIGHTRED, string);
		format(string, sizeof(string), " `LOG-AJAIL:` [%s] **%s** prendeu **%s** na prisão administrativa enquanto off-line por **%d minutos**, motivo: **%s**. ", ReturnDate(), pNome(playerid), name, time, reason);
        DCC_SendChannelMessage(DC_LogAdmin, string);
	}
	cache_delete(result);
	return 1;
}

CMD:presos(playerid, params[])
{
	if(PlayerInfo[playerid][user_logged] == 0) return SendClientMessage(playerid, COLOR_GRAD1, "Você não está logado.");
	if(PlayerInfo[playerid][user_admin] < 1) return SendClientMessage(playerid, COLOR_GREY, "Você não possui autorização para utilizar esse comando.");
	if (PlayerInfo[playerid][user_admin] < 4 && !AdminTrabalhando[playerid])
        return SendClientMessage(playerid, COLOR_LIGHTRED, "ERRO: Você deve usar o comando /atrabalho antes.");

	new string[128], count = 0;

	foreach(new i : Player)
	{
 		if(PlayerInfo[i][pJailed] == 1)
 		{
   			format(string, sizeof(string), "%s %s [%d] - Tempo restante: %i minutos\n", string, pNome(i), i, PlayerInfo[i][pJailedTime] / 60);
      		Dialog_Show(playerid, DIALOG_JAILED, DIALOG_STYLE_MSGBOX, "Jogadores Presos", string, "OK", "");
        	count++;
 		}
	}
	if(count == 0) return SendClientMessage(playerid, COLOR_GREY, "SERVER: Não há jogadores presos administrativamente no momento.");
	return 1;
}
CMD:tempo(playerid, params[])
{
	new string[258];
	if(PlayerInfo[playerid][user_logged] == 0) return SendClientMessage(playerid, COLOR_GRAD1, "Você não está logado.");
	if(PlayerInfo[playerid][pJailed] == 0) return SendClientMessage(playerid, COLOR_GRAD1, "ERRO: Você não está em nenhuma prisão.");
	if(PlayerInfo[playerid][pJailed] > 0)
	{
		format(string, sizeof(string), "SERVER: Você saíra da prisão administrativa daqui a %i minutos.", PlayerInfo[playerid][pJailedTime] / 60);
		SendClientMessage(playerid, COLOR_YELLOW, string);
	}
	return 1;
}

CMD:ajail(playerid, params[])
{
	if(PlayerInfo[playerid][user_logged] == 0) return SendClientMessage(playerid, COLOR_GRAD1, "Você não está logado.");
	if(PlayerInfo[playerid][user_admin] < 1) return SendClientMessage(playerid, COLOR_GREY, "Você não possui autorização para utilizar esse comando.");
	if (PlayerInfo[playerid][user_admin] < 4 && !AdminTrabalhando[playerid])
        return SendClientMessage(playerid, COLOR_LIGHTRED, "ERRO: Você deve usar o comando /atrabalho antes."); 

	new targetid, time, reason[100];
	new string[256];
	if(sscanf(params, "uds[100]", targetid, time, reason)) return SendClientMessage(playerid, COLOR_GREY, "USE: /ajail [playername/playerid] [tempo] [motivo]");
	if(!IsPlayerConnected(targetid)) return SendClientMessage(playerid, COLOR_GREY, "ERRO: Jogador desconectado.");

	if(time < 1) return SendClientMessage(playerid, COLOR_GREY, "ERRO: Você não pode prender um jogador por menos de um minuto.");

	format(string, sizeof(string), "AdmCmd: %s colocou %s na prisão administrativa por %d minutos, motivo: %s.", pNome(playerid), pNome(targetid), time, reason);
	SendClientMessageToAll(COLOR_LIGHTRED, string);
	SaveAccount(targetid);
	format(string, sizeof(string), " `LOG-AJAIL:` [%s] **%s** colocou **%s** na cadeia por **%d minutos**, motivo: %s.", ReturnDate(), pNome(playerid), pNome(targetid), time, reason);
    DCC_SendChannelMessage(DC_LogAdmin, string);

	ClearAnimations(targetid);
	SetPlayerPos(targetid, 2307.6868,576.3664,106.5366);
	SetPlayerFacingAngle(targetid, 269.2296);
	SetPlayerInterior(targetid, 0); 
	SetPlayerVirtualWorld(targetid, 1338);
	ResetWeapons(targetid);
	SetPlayerHealth(targetid, 99999);

	PlayerInfo[targetid][pJailed] = true;
	PlayerInfo[targetid][pJailedTime] = time * 60;
	return 1;
}

CMD:unajail(playerid, params[])
{
	if(PlayerInfo[playerid][user_logged] == 0) return SendClientMessage(playerid, COLOR_GRAD1, "Você não está logado.");
	if(PlayerInfo[playerid][user_admin] < 2) return SendClientMessage(playerid, COLOR_GREY, "Você não possui autorização para utilizar esse comando.");
	if (PlayerInfo[playerid][user_admin] < 4 && !AdminTrabalhando[playerid])
        return SendClientMessage(playerid, COLOR_LIGHTRED, "ERRO: Você deve usar o comando /atrabalho antes."); 
	new targetid;
	new string[256];
	if(sscanf(params, "u", targetid)) return SendClientMessage(playerid, COLOR_GREY, "USE: /unajail [playerid]");
	if(!IsPlayerConnected(targetid)) return SendClientMessage(playerid, COLOR_GREY, "ERRO: Jogador desconectado.");
	if(!PlayerInfo[targetid][pJailed]) return SendClientMessage(playerid, COLOR_GREY, "ERRO: Este jogador não está preso.");

	SetPlayerVirtualWorld(targetid, 0); 
	SetPlayerInterior(targetid, 0);
	SetPlayerHealth(targetid, 100);
	SetPlayerPos(targetid, 1642.2025,-2335.0376,-2.6797);

	PlayerInfo[targetid][pJailed] = false;
	PlayerInfo[targetid][pJailedTime] = 0;

	format(string, sizeof(string), "AdmCmd: %s retirou %s da prisão administrativa.", pNome(playerid), pNome(targetid));
	SendClientMessageToAll(COLOR_LIGHTRED, string);
	format(string, sizeof(string), " `LOG-UNAJAIL:` [%s] **%s** retirou **%s** da prisão administrativa.", ReturnDate(), pNome(playerid), pNome(targetid));
    DCC_SendChannelMessage(DC_LogAdmin, string);
	return 1;
}

CMD:kick(playerid, params[])
{
	if(PlayerInfo[playerid][user_logged] == 0) return SendClientMessage(playerid, COLOR_GRAD1, "Você não está logado.");
	if(PlayerInfo[playerid][user_admin] < 1) return SendClientMessage(playerid, COLOR_GREY, "Você não possui autorização para utilizar esse comando.");
	if (PlayerInfo[playerid][user_admin] < 4 && !AdminTrabalhando[playerid])
        return SendClientMessage(playerid, COLOR_LIGHTRED, "ERRO: Você deve usar o comando /atrabalho antes."); 
	new targetid, reason[128], string[200];
	if(sscanf(params, "us[128]", targetid, reason)) return SendClientMessage(playerid, COLOR_GREY, "USE: /kick [playername/playerid] [motivo]");
	if(!IsPlayerConnected(targetid)) return SendClientMessage(playerid, COLOR_GREY, "ERRO: Jogador desconectado.");
	
	format(string, sizeof(string), "AdmCmd: %s kickou %s, motivo: %s.", pNome(playerid), pNome(targetid), reason);
	SendClientMessageToAll(COLOR_LIGHTRED, string);
	SaveAccount(targetid);
	format(string, sizeof(string), " `LOG-KICK:` [%s] **%s** kickou **%s**, motivo: %s.", ReturnDate(), pNome(playerid), pNome(targetid), reason);
    DCC_SendChannelMessage(DC_LogAdmin, string);
	SetTimerEx("Kick_Ex", 400, false, "i", targetid);
	return 1;
}

CMD:trancarserver(playerid, params[])
{
    if(PlayerInfo[playerid][user_logged] == 0) return SendClientMessage(playerid, COLOR_GRAD1, "Você não está logado.");
	if(PlayerInfo[playerid][user_admin] < 5) return SendClientMessage(playerid, COLOR_GREY, "Você não possui autorização para utilizar esse comando.");
	
	new password[30], string[128];
    if(sscanf(params, "s[128]", password)) return SendClientMessage(playerid, COLOR_GREY, "USE: /trancarserver [senha]");
	format(string, sizeof(string), "Você definiu a senha do servidor como: %s.", password);
	SendClientMessage(playerid, COLOR_YELLOW, string);
	format(string, sizeof(string), "password %s", password);
	SendRconCommand(string);
	return 1;
}

CMD:setscore(playerid, params[])
{
    if(PlayerInfo[playerid][user_logged] == 0) return SendClientMessage(playerid, COLOR_GRAD1, "Você não está logado.");
	if(PlayerInfo[playerid][user_admin] < 4) return SendClientMessage(playerid, COLOR_GREY, "Você não possui autorização para utilizar esse comando.");
	if (PlayerInfo[playerid][user_admin] < 4 && !AdminTrabalhando[playerid])
        return SendClientMessage(playerid, COLOR_LIGHTRED, "ERRO: Você deve usar o comando /atrabalho antes."); 

	new targetid, score;
	new string[128];
	if(sscanf(params, "ud", targetid, score)) return SendClientMessage(playerid, COLOR_GREY, "USE: /setscore [playername/playerid] [quantidade]");
	if(!IsPlayerConnected(targetid)) return SendClientMessage(playerid, COLOR_GREY, "ERRO: Jogador desconectado.");
	SetPlayerScore(targetid, score);
	format(string,sizeof(string),"AdmCmd: %s (%d) setou o seu score para %d.", pNome(playerid), playerid, score);
	SendClientMessage(targetid, COLOR_YELLOW,string);
	format(string,sizeof(string),"AdmCmd: Você setou o score de %s (%d) para %d", pNome(targetid), targetid, score);
	SendClientMessage(playerid, COLOR_YELLOW,string);
	return 1;
}
CMD:ir(playerid, params[])
{
	static
	    id,
	    type[24],
		string[64];

	if(PlayerInfo[playerid][user_admin] < 1) return SendClientMessage(playerid, COLOR_GREY, "Você não possui autorização para utilizar esse comando.");
	if (PlayerInfo[playerid][user_admin] < 4 && !AdminTrabalhando[playerid])
        return SendClientMessage(playerid, COLOR_LIGHTRED, "ERRO: Você deve usar o comando /atrabalho antes."); 

	if (sscanf(params, "u", id))
 	{
	 	SendSyntaxMessage(playerid, "/ir [player ou nome]");
		SendClientMessage(playerid, COLOR_YELLOW, "NOMES:{FFFFFF} pos, carro, pichação, prisão, interior, entrada");
		return 1;
	}
    if (id == INVALID_PLAYER_ID)
	{
	    if (sscanf(params, "s[24]S()[64]", type, string))
		{
		    SendSyntaxMessage(playerid, "/ir [player ou nome]");
			SendClientMessage(playerid, COLOR_YELLOW, "NOMES:{FFFFFF} pos, carro, pichação, prisão, interior, entrada");
			return 1;
	    }

	    if (!strcmp(type, "pos", true)) {

			if (PlayerInfo[playerid][user_admin] < 3)
				return SendErrorMessage(playerid, "Você não possui autorização para utilizar esse comando.");
			
			new Float:X2,Float:Y2,Float:Z2;
			if (sscanf(string, "fff", X2, Y2, Z2))
				return SendSyntaxMessage(playerid, "/ir pos [x] [y] [z]");
			SetPlayerPos(playerid, X2, Y2, Z2);

	        return SendServerMessage(playerid, "Você foi até as coordenadas.");
		}

		else if (!strcmp(type, "carro", true))
		{
			new vehicleid;
			if (sscanf(params, "d", vehicleid)) return SendSyntaxMessage(playerid, "/ir carro [id]");

			if (vehicleid < 1 || vehicleid > MAX_VEHICLES || !IsValidVehicle(vehicleid))
				return SendErrorMessage(playerid, "Você especificou o ID de um veículo inexistente.");

			static
				Float:x,
				Float:y,
				Float:z;

			GetVehiclePos(vehicleid, x, y, z);
			SetPlayerPos(playerid, x, y - 2, z + 2);
	        SetPlayerPos(playerid, 283.5930, 1413.3511, 10.4078);
	        SetPlayerFacingAngle(playerid, 180.0000);

	        SetPlayerInterior(playerid, 0);
	        SetPlayerVirtualWorld(playerid, 0);

	        return SendServerMessage(playerid, "Você se teleportou até o carro.");
		}
		else if (!strcmp(type, "entrdada", true))
		{
		    if (sscanf(string, "d", id))
		        return SendSyntaxMessage(playerid, "/ir entrada [ID]");

			if ((id < 0 || id >= MAX_ENTRANCES) || !EntranceData[id][entranceExists])
			    return SendErrorMessage(playerid, "Você especificou o ID de uma entrada inexistente.");

		    SetPlayerPos(playerid, EntranceData[id][entrancePos][0], EntranceData[id][entrancePos][1], EntranceData[id][entrancePos][2]);
		    SetPlayerInterior(playerid, EntranceData[id][entranceExterior]);

			SetPlayerVirtualWorld(playerid, EntranceData[id][entranceExteriorVW]);
		    SendServerMessage(playerid, "Você se teleportou para a entrada ID: %d.", id);
		    return 1;
		}

		if (!strcmp(type, "pichação", true)) 
		{
	        if (PlayerInfo[playerid][pFactionMod] < 1)
				return SendErrorMessage(playerid, "Você não possui autorização para utilizar esse comando.");
			
			if (PlayerInfo[playerid][user_admin] < 3)
				return SendErrorMessage(playerid, "Você não possui autorização para utilizar esse comando.");

			if (sscanf(string, "d", id))
				return SendSyntaxMessage(playerid, "/ir pichação [pichação id]");

			if ((id < 0 || id >= MAX_GRAFFITI_POINTS) || !GraffitiData[id][graffitiExists])
				return SendErrorMessage(playerid, "Você especificou uma pichação inválida.");

			SetPlayerPos(playerid, GraffitiData[id][graffitiPos][0], GraffitiData[id][graffitiPos][1], GraffitiData[id][graffitiPos][2]);
			SetPlayerInterior(playerid, 0);
			SetPlayerVirtualWorld(playerid, 0);

	       	return SendServerMessage(playerid, "Você se teleportou para a pichação.");
		}

		if (!strcmp(type, "prisão", true)) 
		{
	        if (PlayerInfo[playerid][pFactionMod] < 1)
				return SendErrorMessage(playerid, "Você não possui autorização para utilizar esse comando.");
			
			if (PlayerInfo[playerid][user_admin] < 3)
				return SendErrorMessage(playerid, "Você não possui autorização para utilizar esse comando.");

			if (sscanf(string, "d", id))
				return SendSyntaxMessage(playerid, "/ir prisão [prisão id]");

			if ((id < 0 || id >= MAX_ARREST_POINTS) || !ArrestData[id][arrestExists])
				return SendErrorMessage(playerid, "Você específicou um ponto de prisão inválido.");

			SetPlayerPos(playerid, ArrestData[id][arrestPos][0], ArrestData[id][arrestPos][1], ArrestData[id][arrestPos][2]);
			SetPlayerInterior(playerid, ArrestData[id][arrestInterior]);
			SetPlayerVirtualWorld(playerid, ArrestData[id][arrestWorld]);

	       	return SendServerMessage(playerid, "Você se teleportou para a prisão.");
		}
		else if (!strcmp(type, "interior", true))
		{
		    static
		        str[1536];

			str[0] = '\0';

			for (new i = 0; i < sizeof(g_arrInteriorData); i ++) {
			    strcat(str, g_arrInteriorData[i][e_InteriorName]);
			    strcat(str, "\n");
		    }
		    Dialog_Show(playerid, TeleportInterior, DIALOG_STYLE_LIST, "Teleporte: Lista de Interiores", str, "Selecionar", "Cancelar");
		    return 1;
		}
	    else return SendErrorMessage(playerid, "Você específicou um jogador inválido.");
	}
	if (!IsPlayerSpawned(id))
		return SendErrorMessage(playerid, "Você não pode ir até um jogador que não spawnou.");

	if(GetPlayerState(playerid) == PLAYER_STATE_SPECTATING)
		return SendClientMessage(playerid, COLOR_LIGHTRED, "Esse administrador está em modo espectador em alguém, por isso não pode ir até o mesmo.");

	SendPlayerToPlayer(playerid, id);
	return 1;
}
CMD:trazer(playerid, params[])
{
    if(PlayerInfo[playerid][user_logged] == 0) return SendClientMessage(playerid, COLOR_GRAD1, "Você não está logado.");
	if(PlayerInfo[playerid][user_admin] < 1) return SendClientMessage(playerid, COLOR_GREY, "Você não possui autorização para utilizar esse comando.");
	if (PlayerInfo[playerid][user_admin] < 4 && !AdminTrabalhando[playerid])
        return SendClientMessage(playerid, COLOR_LIGHTRED, "ERRO: Você deve usar o comando /atrabalho antes.");

	if(GetPlayerState(playerid) == PLAYER_STATE_SPECTATING)
		return SendClientMessage(playerid, COLOR_LIGHTRED, "Esse administrador está em modo espectador em alguém, por isso não pode puxa-lo.");

	new targetid, Float: PlayerPos[3];
	GetPlayerPos(playerid, PlayerPos[0], PlayerPos[1], PlayerPos[2]);
	if(sscanf(params, "u", targetid)) return SendClientMessage(playerid, COLOR_GREY, "USE: /trazer [id/nick]");
	if(!IsPlayerConnected(targetid)) return SendClientMessage(playerid, COLOR_GREY, "Usuário inválido ou offline.");

	SetPlayerPos(targetid, PlayerPos[0], PlayerPos[1] + 2.0, PlayerPos[2]);
	return 1;
}

static const TempoNomes[][] = {
	/*0 -*/ 	"Tempo limpo",
	/*1 -*/ 	"Tempo firme, sem chances de chuva",
	/*2 -*/ 	"Poucas nuvens, sem chuva",
	/*3 -*/ 	"Tempo seco",
	/*4 -*/ 	"Algumas nuvens com vento",
	/*5 -*/ 	"Tempo firme",
	/*6 -*/ 	"Tempo seco",
	/*7 -*/ 	"Vento forte, mas sem chuva",
	/*8 -*/ 	"Temporal forte",
	/*9 -*/ 	"Neblina intensa",
	/*10 -*/ 	"Sem muitas nuvens",
	/*11 -*/ 	"Sem nuvens",
	/*12 -*/ 	"Nublado",
	/*13 -*/ 	"Ceu com poucas nuvens",
	/*14 -*/ 	"Ceu com poucas nuvens",
	/*15 -*/ 	"Nublado, com muito vento",
	/*16 -*/ 	"Temporal com vento forte",
	/*17 -*/ 	"Nublado e tempo firme",
	/*18 -*/ 	"Nublado e tempo firme",
	/*19 -*/ 	"Tempestade de areia",
	/*20 -*/ 	"Tempo fechado, com chances de chuva",
	/*21 -*/ 	"Tempo escuro",
	/*22 -*/ 	"Tempo escuro",
	/*23 -*/ 	"Sol e tempo firme",
	/*24 -*/ 	"Poucas nuvens",
	/*25 -*/ 	"Tempo fechado",
	/*26 -*/ 	"Nuvens no ceu, mas sem chuva",
	/*27 -*/ 	"Pouca neblina",
	/*28 -*/ 	"Ceu incoberto",
	/*29 -*/ 	"Ceu incoberto",
	/*30 -*/ 	"nublado, com chances de chuva",
	/*31 -*/ 	"Nublado, com risco de chuva",
	/*32 -*/ 	"Neblina forte",
	/*33 -*/ 	"Poucas nuvens",
	/*34 -*/ 	"Sem nuvens",
	/*35 -*/ 	"Ceu incoberto",
	/*36 -*/ 	"Tempo firme",
	/*37 -*/ 	"Tempo firme",
	/*38 -*/ 	"Tempo nublado",
	/*39 -*/ 	"Com muita chance de chuva",
	/*40 -*/ 	"Tempo claro",
	/*41 -*/	"Tempo claro",
	/*42 -*/ 	"Neblina forte e intensa",
	/*43 -*/ 	"Risco de tempestades",
	/*44 -*/ 	"Tempo fechado"
};

CMD:clima(playerid, params[])
{
	if(PlayerInfo[playerid][user_logged] == 0) return SendClientMessage(playerid, COLOR_GRAD1, "Você não está logado.");
	if(PlayerInfo[playerid][user_admin] < 3) return SendClientMessage(playerid, COLOR_GREY, "Você não possui autorização para utilizar esse comando.");
	if (PlayerInfo[playerid][user_admin] < 4 && !AdminTrabalhando[playerid])
        return SendClientMessage(playerid, COLOR_LIGHTRED, "ERRO: Você deve usar o comando /atrabalho antes.");

	new weather, hora;
	if(sscanf(params, "dd", hora, weather))
	{
		SendClientMessage(playerid, COLOR_WHITE, "USE: /clima [hora (0 - 24)] [tempo (0 - 44]");
		return true;
	}
	if(hora < 0 || hora > 24)
	{
		SendClientMessage(playerid, COLOR_GRAD2, "Hora mínima, de 0 ~ 24!");
		return true;
	}
	if(weather < 0||weather > 44) { SendClientMessage(playerid, COLOR_GREY, "Tempo mínimo, de 0 ~ 44 !"); return 1; }
	new string[128];
	SetWeather(weather);
	SetWorldTime(hora);
	format(string, sizeof(string), "Hora configurada para %d horas e clima para %s.", hora, TempoNomes[weather]);
	SendClientMessageToAll(COLOR_GRAD1, string);
	return true;
}

CMD:salvartodos(playerid, params[])
{
	if(PlayerInfo[playerid][user_logged] == 0) return SendClientMessage(playerid, COLOR_GRAD1, "Você não está logado.");
	if(PlayerInfo[playerid][user_admin] < 5) return SendClientMessage(playerid, COLOR_GREY, "Você não possui autorização para utilizar esse comando.");
	new string[256];
	foreach (new i : Player) {
		SaveAccount(i);
	}
	
	format(string, 128, "AdmCmd: O administrador %s salvou a conta de todos os jogadores na database.", pNome(playerid));
	ABroadCast(COLOR_LIGHTGREEN,string,1);
	return 1;
}

CMD:infoplayer(playerid, params[])
{
	if(PlayerInfo[playerid][user_logged] == 0) return SendClientMessage(playerid, COLOR_GRAD1, "Você não está logado.");
	if(PlayerInfo[playerid][user_admin] < 1) return SendClientMessage(playerid, COLOR_GREY, "Você não possui autorização para utilizar esse comando.");
	if (PlayerInfo[playerid][user_admin] < 4 && !AdminTrabalhando[playerid])
        return SendClientMessage(playerid, COLOR_LIGHTRED, "ERRO: Você deve usar o comando /atrabalho antes.");
	new giveplayerid;
	new armatext[30];
	new municao;
	new arma;
	new Float:plrtempheal;
	new Float:plrarmour;
	new plrping;
	new iplayer[MAX_PLAYER_NAME];
	new smunicao;
	new string[128];
	new ip[32];
	if(sscanf(params, "u", giveplayerid))
	{
		SendClientMessage(playerid, COLOR_WHITE, "USE: /infoplayer [id do player]");
		return true;
	}
	if(IsPlayerConnected(giveplayerid))
	{
		if(giveplayerid != INVALID_PLAYER_ID)
		{
   			GetPlayerName(giveplayerid, iplayer, sizeof(iplayer));
   			GetPlayerIp(giveplayerid,ip,128);
   			new intid = GetPlayerInterior(giveplayerid);
			new world = GetPlayerVirtualWorld(giveplayerid);
			plrping = GetPlayerPing(giveplayerid);
			GetPlayerArmour(giveplayerid, plrarmour);
			GetPlayerHealth(giveplayerid,plrtempheal);
			arma = GetPlayerWeapon(giveplayerid);
			municao = GetPlayerAmmo(giveplayerid);
			SendClientMessage(playerid, COLOR_GREEN, "|________[ EXIBINDO INFORMAÇÕES ]________|");
			format(string, sizeof(string), "{FF6347}Nome: {FFFFFF} %s", iplayer);
			SendClientMessage(playerid, COLOR_LIGHTRED, string);
			format(string, sizeof(string), "{FF6347}IP: {FFFFFF}%s", ip);
			SendClientMessage(playerid, COLOR_LIGHTRED, string);
			format(string, sizeof(string), "{FF6347}Interior: {FFFFFF}%d", intid);
			SendClientMessage(playerid, COLOR_LIGHTRED, string);
			format(string, sizeof(string), "{FF6347}Mundo: {FFFFFF}%d", world);
			SendClientMessage(playerid, COLOR_LIGHTRED, string);
			format(string, sizeof(string), "{FF6347}Ping: {FFFFFF}%d", plrping);
			SendClientMessage(playerid, COLOR_LIGHTRED, string);
			format(string, sizeof(string), "{FF6347}Colete: {FFFFFF}%1f", plrarmour);
			SendClientMessage(playerid, COLOR_LIGHTRED, string);
			format(string, sizeof(string), "{FF6347}Saúde: {FFFFFF}%1f", plrtempheal);
			SendClientMessage(playerid, COLOR_LIGHTRED, string);
			if(arma == 38) { armatext = "Minigun";}
			else if(arma == 40) { armatext = "Detonador"; }
			else if(arma == 36) { armatext = "Lança missil RPG"; }
			else if(arma == 35) { armatext = "Lança missil"; }
			else if(arma == 16) { armatext = "Granada"; }
			else if(arma == 18) { armatext = "Coktel Molotov"; }
			else if(arma == 22) { armatext = "Pistola de Duas mãos 9mm"; }
			else if(arma == 26) { armatext = "Escopeta de Cano Serrado"; }
			else if(arma == 27) { armatext = "Escopeta de Combate"; }
			else if(arma == 28) { armatext = "Micro Uzi"; }
			else if(arma == 32) { armatext = "Tec9"; }
			else if(arma == 37) { armatext = "Lança Chamas"; }
			else if(arma == 0) { armatext = "Desarmado"; }
            else if(arma == 4) { armatext = "Faca"; }
            else if(arma == 5) { armatext = "Bastão de Base Ball"; }
            else if(arma == 9) { armatext = "Motoserra"; }
            else if(arma == 14) { armatext = "Flores"; }
            else if(arma == 17) { armatext = "Granada de Gas"; }
            else if(arma == 23) { armatext = "Pistola com silênciador"; }
            else if(arma == 16) { armatext = "Granada"; }
            else if(arma == 24) { armatext = "Desert Eagle"; }
            else if(arma == 25) { armatext = "ShotGun"; }
            else if(arma == 29) { armatext = "MP5"; }
            else if(arma == 30) { armatext = "AK-47"; }
            else if(arma == 31) { armatext = "M4"; }
            else if(arma == 33) { armatext = "Rifle"; }
            else if(arma ==  34) { armatext = "Rifle Sniper"; }
            else if(arma == 41) { armatext = "Spray"; }
            else if(arma == 42) { armatext = "Extintor"; }
            else if(arma == 46) { armatext = "Paraquedas"; }
            else { armatext = "Desconhecido"; }
            format(string, sizeof(string), "{FF6347}Arma: {FFFFFF}%s", armatext);
			SendClientMessage(playerid, COLOR_LIGHTRED, string);
			if(arma == 40 || arma == 36 || arma == 18 || arma == 28 || arma == 37)
			{
				SendClientMessage(playerid, COLOR_LIGHTRED, "/tv nele, pois ele pode estar usando xiter de armas");
			}
			if(municao == 65535) { smunicao = 0; } else { smunicao = municao; }
			format(string, sizeof(string), "{FF6347}Munição: {FFFFFF}%d", smunicao);
			SendClientMessage(playerid, COLOR_LIGHTRED, string);
		}
	}
	else
	{
	    SendClientMessage(playerid, COLOR_GREY, "Este jogador está off-line !");
	    return true;
	}
	return true;
}

CMD:trocarinterior(playerid, params[])
{
	if(PlayerInfo[playerid][user_logged] == 0) return SendClientMessage(playerid, COLOR_GRAD1, "Você não está logado.");
	if(PlayerInfo[playerid][user_admin] < 1) return SendClientMessage(playerid, COLOR_GREY, "Você não possui autorização para utilizar esse comando.");
	if (PlayerInfo[playerid][user_admin] < 4 && !AdminTrabalhando[playerid])
        return SendClientMessage(playerid, COLOR_LIGHTRED, "ERRO: Você deve usar o comando /atrabalho antes.");

	new targetid, interior;
	new string[128];
	if(sscanf(params, "ud", targetid, interior)) return SendClientMessage(playerid, COLOR_GREY, "USE: /trocarinterior [playername/playerid] [interior]");
	if(!IsPlayerConnected(targetid)) return SendClientMessage(playerid, COLOR_GREY, "ERRO: Jogador desconectado.");
	SetPlayerInterior(targetid, interior);
	format(string,sizeof(string), "AdmCmd: Você alterou o interior de %s (%d) para %d", pNome(targetid), targetid, interior);
	SendClientMessage(playerid, COLOR_GREY,string);
	format(string,sizeof(string), "%s (%d) alterou o seu interior para %d", pNome(playerid), playerid, interior);
	SendClientMessage(targetid, COLOR_GREY,string);
	return 1;
}
CMD:trocarvw(playerid, params[])
{
	if(PlayerInfo[playerid][user_logged] == 0) return SendClientMessage(playerid, COLOR_GRAD1, "Você não está logado.");
	if(PlayerInfo[playerid][user_admin] < 1) return SendClientMessage(playerid, COLOR_GREY, "Você não possui autorização para utilizar esse comando.");
	if (PlayerInfo[playerid][user_admin] < 4 && !AdminTrabalhando[playerid])
        return SendClientMessage(playerid, COLOR_LIGHTRED, "ERRO: Você deve usar o comando /atrabalho antes.");

	new targetid, world;
	new string[128];
	if(sscanf(params, "ud", targetid, world)) return SendClientMessage(playerid, COLOR_GREY, "USE: /trocarvw [playername/playerid] [world]");
	if(!IsPlayerConnected(targetid)) return SendClientMessage(playerid, COLOR_GREY, "ERRO: Jogador desconectado.");
	SetPlayerVirtualWorld(targetid, world);
	format(string,sizeof(string), "AdmCmd: Você alterou o virtual world de %s (%d) para %d", pNome(targetid), targetid, world);
	SendClientMessage(playerid, COLOR_GREY,string);
	format(string,sizeof(string), "%s (%d) alterou o seu virtual world para %d", pNome(playerid), playerid, world);
	SendClientMessage(targetid, COLOR_GREY,string);
	return 1;
}

CMD:dararma(playerid, params[])
{
	static
	    userid,
	    weaponid,
	    ammo;
	new string[256];
    if(PlayerInfo[playerid][user_logged] == 0) return SendClientMessage(playerid, COLOR_GRAD1, "Você não está logado.");
	if(PlayerInfo[playerid][user_admin] < 4) return SendClientMessage(playerid, COLOR_GREY, "Você não possui autorização para utilizar esse comando.");
	
	if (sscanf(params, "udI(500)", userid, weaponid, ammo))
	    return SendSyntaxMessage(playerid, "/dararma [playerid/nome] [arma id] [munição]");

	if (userid == INVALID_PLAYER_ID)
	    return SendErrorMessage(playerid, "Você não pode dar arma para jogadores desconectados.");

	if (!IsPlayerSpawned(userid))
	    return SendErrorMessage(playerid, "Você não pode dar arma para jogadores que ainda não entraram no servidor.");

	if (weaponid <= 0 || weaponid > 46 || (weaponid >= 19 && weaponid <= 21))
		return SendErrorMessage(playerid, "Você específicou uma arma inválida.");

	GiveWeaponToPlayer(userid, weaponid, ammo);
	SendServerMessage(playerid, "Você deu para %s uma %s com %d munições.", pNome(userid), ReturnWeaponName(weaponid), ammo);

	format(string, sizeof(string), "O administrador %s deu arma (%s com %d balas) para %s.", pNome(playerid), ReturnWeaponName(weaponid), ammo, pNome(userid));
	DCC_SendChannelMessage(DC_Logs1, string);
	return 1;
}

CMD:reclife(playerid, params[])
{
	if(PlayerInfo[playerid][user_logged] == 0) return SendClientMessage(playerid, COLOR_GRAD1, "Você não está logado.");
	if(PlayerInfo[playerid][user_admin] < 2) return SendClientMessage(playerid, COLOR_GREY, "Você não possui autorização para utilizar esse comando.");
	if (PlayerInfo[playerid][user_admin] < 4 && !AdminTrabalhando[playerid])
        return SendClientMessage(playerid, COLOR_LIGHTRED, "ERRO: Você deve usar o comando /atrabalho antes.");
	new para1;
	if(sscanf(params, "uf", para1))
	{
		SendClientMessage(playerid, COLOR_GRAD2, "USE: /reclife [playerid/nome]");
		return 1;
	}
	if(!IsPlayerConnected(para1))return SendClientMessage(playerid, COLOR_GRAD1, "Jogador não conectado.");

	GetPlayerName(para1, giveplayer, sizeof(giveplayer));
	GetPlayerName(playerid, sendername, sizeof(sendername));
	if(IsPlayerConnected(para1))
	{
		if(para1 != INVALID_PLAYER_ID)
		{
			new string[256];
			SetPlayerHealth(para1, 100);
			format(string, 128, "AdmCmd: O admin %s recuperou a vida de %s [ID: %d].",sendername, giveplayer,para1);
			ABroadCast(COLOR_LIGHTGREEN,string,1);
			format(string, sizeof(string), " `LOG-RECLIFE:` [%s] **%s** recuperou a vida de **%s**", ReturnDate(), sendername, giveplayer);
    		DCC_SendChannelMessage(DC_LogAdmin, string);
		}
	}
	return 1;
}

CMD:limparchat(playerid, result[])
{
	if(PlayerInfo[playerid][user_logged] == 0) return SendClientMessage(playerid, COLOR_GRAD1, "Você não está logado.");
	if(PlayerInfo[playerid][user_admin] < 2) return SendClientMessage(playerid, COLOR_GREY, "Você não possui autorização para utilizar esse comando.");
	if (PlayerInfo[playerid][user_admin] < 4 && !AdminTrabalhando[playerid])
        return SendClientMessage(playerid, COLOR_LIGHTRED, "ERRO: Você deve usar o comando /atrabalho antes.");

	for(new i; i < 100; i++)
	{
		SendClientMessageToAll(-1, " ");
	}
	new string[128];
	format(string, sizeof(string), "SERVER: O administrador %s limpou o chat.", pNome(playerid));
	SendClientMessageToAll(COLOR_WHITE, string);
	return true;
}

CMD:a(playerid, result[])
{
	if(PlayerInfo[playerid][user_admin] < 1) return SendClientMessage(playerid, COLOR_GREY, "Você não possui autorização para utilizar esse comando.");
	if(isnull(result))return SendClientMessage(playerid, COLOR_GRAD2, "USE: (/a)dminchat [admin chat]");
	new string[128];
	if (PlayerInfo[playerid][user_admin] > 0)
	{
		format(string, sizeof(string), "(( %s %s: %s ))", AdminRankName(playerid), pNome(playerid), result);
		ABroadCast(COLOR_ADMINCHAT , string, 1);
		
		format(string, sizeof(string), " **AdminChat:** %s %s: %s", AdminRankName(playerid), pNome(playerid), result);
		DCC_SendChannelMessage(DC_Logs3, string);
	}
	return true;
}

CMD:chatkill(playerid)
{
	if(PlayerInfo[playerid][user_logged] == 0) 
    { 
        SendClientMessage(playerid, COLOR_GRAD1, "Você não está logado.");
		return true;
	}
	if(PlayerInfo[playerid][user_admin] < 1) return SendClientMessage(playerid, COLOR_GREY, "Você não possui autorização para utilizar esse comando.");
	if (PlayerInfo[playerid][user_admin] < 4 && !AdminTrabalhando[playerid])
        return SendClientMessage(playerid, COLOR_LIGHTRED, "ERRO: Você deve usar o comando /atrabalho antes.");

	if(ChatKill[playerid])
	{
		ChatKill[playerid] = false;
		SendClientMessage(playerid, COLOR_GREY, "Você desligou o chat kill!");
	}
	else
	{
		ChatKill[playerid] = true;
		SendClientMessage(playerid, COLOR_GREY, "Você ligou o chat kill!");
	}
	return 1;
}


CMD:checkrt(playerid, params[])
{
	if(PlayerInfo[playerid][user_logged] == 0) 
    { 
        SendClientMessage(playerid, COLOR_GRAD1, "Você não está logado.");
		return true;
	}
    if(PlayerInfo[playerid][user_logged] < 1) return SendClientMessage(playerid, COLOR_GREY, "Você não possui autorização para utilizar esse comando.");
    if(PlayerInfo[playerid][user_admin] < 4 && !AdminTrabalhando[playerid])
        return SendClientMessage(playerid, COLOR_LIGHTRED, "ERRO: Você deve usar o comando /atrabalho antes.");
	if(PlayerInfo[playerid][user_logged] >= 1)
	{
		new playername[MAX_PLAYER_NAME];
		new temrt = 0;
		new string[128];
		foreach(new i : Player)
		{
			if(NetStats_PacketLossPercent(i) > 0.5){
				format(string, sizeof(string), "[ATENÇÃO] %s [ID: %d] tem uma perda de pacotes de %0.2f {FF0000}(Possivelmente está de RT)", playername, i, NetStats_PacketLossPercent(i));
				SendClientMessage(playerid, COLOR_LIGHTRED, string);
				temrt = 1;
			}
		}
		if(temrt == 0)
		{
			SendClientMessage(playerid, COLOR_GREY, "Nenhum player está com o relógio travado no momento!");
		}
	}
	return true;
}

CMD:ooc(playerid, result[])
{
	if(PlayerInfo[playerid][user_logged] == 0) 
    { 
        SendClientMessage(playerid, COLOR_GRAD1, "Você não está logado.");
		return true;
	}
    if(PlayerInfo[playerid][user_admin] < 2) return SendClientMessage(playerid, COLOR_GREY, "Você não possui autorização para utilizar esse comando.");
    if (PlayerInfo[playerid][user_admin] < 4 && !AdminTrabalhando[playerid])
        return SendClientMessage(playerid, COLOR_LIGHTRED, "ERRO: Você deve usar o comando /atrabalho antes.");
	if(isnull(result))
	{
		SendClientMessage(playerid, COLOR_GREY, "USE: /ooc [texto]");
		return true;
	}
	new string[200];
	format(string, sizeof(string), "(( [OOC] %s: %s ))", pNome(playerid), result);
	SendClientMessageToAll(0xB1C8FBAA, string);
	format(string, sizeof(string), " `LOG-OOC:` [%s] [OOC] **%s**: %s.", ReturnDate(), pNome(playerid), result);
    DCC_SendChannelMessage(DC_LogAdmin, string);
	return true;
}

CMD:setadmin(playerid, params[])
{
 	static
		userid,
	    level;

  	if(PlayerInfo[playerid][user_logged] == 0) return SendClientMessage(playerid, COLOR_GRAD1, "Você não está logado.");
	if(PlayerInfo[playerid][user_admin] < 5) return SendClientMessage(playerid, COLOR_GREY, "Você não possui autorização para utilizar esse comando.");
	if (sscanf(params, "ud", userid, level))
		return SendClientMessage(playerid, COLOR_GREY, "/setadmin [playerid/nome] [level]");

	if (userid == INVALID_PLAYER_ID)
		return SendClientMessage(playerid, COLOR_GREY, "Você digitou um player inválido.");

	if (level < 0 || level > 5)
		return SendClientMessage(playerid, COLOR_GREY, "Level inválido. Os niveis devem variar entre 0 a 5.");

	new string[128];

	if (level > PlayerInfo[userid][user_admin])
	{
		format(string, sizeof string, "Você promoveu %s para administrador nível %d.", pNome(userid), level);
		SendClientMessage(playerid, COLOR_YELLOW, string);
		format(string, sizeof string, "%s promoveu você para administrador nível %d.", pNome(playerid), level);
		SendClientMessage(userid, COLOR_YELLOW, string);
	}
	else
	{
		format(string, sizeof string, "Você rebaixou %s para administrador nível %d.", pNome(userid), level);
		SendClientMessage(playerid, COLOR_YELLOW, string);
		format(string, sizeof string, "%s rebaixou você para administrador nível (%d).", pNome(playerid), level);
		SendClientMessage(userid, COLOR_YELLOW, string);
	}
	PlayerInfo[userid][user_admin] = level;
	return 1;
}

CMD:congelar(playerid, params[])
{
	if(PlayerInfo[playerid][user_logged] == 0) return SendClientMessage(playerid, COLOR_GRAD1, "Você não está logado.");
	if(PlayerInfo[playerid][user_admin] < 2) return SendClientMessage(playerid, COLOR_GREY, "Você não possui autorização para utilizar esse comando.");
	if (PlayerInfo[playerid][user_admin] < 4 && !AdminTrabalhando[playerid])
        return SendClientMessage(playerid, COLOR_LIGHTRED, "ERRO: Você deve usar o comando /atrabalho antes.");
	new playa;
	if(sscanf(params, "u", playa))
	{
		SendClientMessage(playerid, COLOR_GRAD1, "USE: /congelar [playerid/nome]");
	}
	if(IsPlayerConnected(playa))
	{
		if(PlayerInfo[playa][user_admin] >= 4 && PlayerInfo[playerid][user_admin] < 4)
		{
			SendClientMessage(playerid, COLOR_GRAD1, "Você não pode congelar um management!");
			return true;
		}
		new string[128];
		GetPlayerName(playa, giveplayer, sizeof(giveplayer));
		GetPlayerName(playerid, sendername, sizeof(sendername));
		TogglePlayerControllable(playa, 0);
		format(string, sizeof(string), "AdmCmd: %s congelou %s.", sendername, giveplayer);
		ABroadCast(COLOR_LIGHTRED,string,1);
		format(string, sizeof(string), " `LOG-CONGELAR:` [%s] **%s** congelou **%s**.", ReturnDate(), sendername, giveplayer);
   	 	DCC_SendChannelMessage(DC_LogAdmin, string);
	}
	return 1;
}

CMD:descongelar(playerid, params[])
{
	if(PlayerInfo[playerid][user_logged] == 0) return SendClientMessage(playerid, COLOR_GRAD1, "Você não está logado.");
	if(PlayerInfo[playerid][user_admin] < 2) return SendClientMessage(playerid, COLOR_GREY, "Você não possui autorização para utilizar esse comando.");
	if (PlayerInfo[playerid][user_admin] < 4 && !AdminTrabalhando[playerid])
        return SendClientMessage(playerid, COLOR_LIGHTRED, "ERRO: Você deve usar o comando /atrabalho antes.");
	new playa;
	if(sscanf(params, "u", playa))
	{
		SendClientMessage(playerid, COLOR_GRAD1, "USE: /descongelar [playerid/nome]");
	}
	if(IsPlayerConnected(playa))
	{
		if(PlayerInfo[playa][user_admin] >= 4 && PlayerInfo[playerid][user_admin] < 4)
		{
			SendClientMessage(playerid, COLOR_GRAD1, "Você não pode descongelar um management!");
			return true;
		}
		new string[128];
		GetPlayerName(playa, giveplayer, sizeof(giveplayer));
		GetPlayerName(playerid, sendername, sizeof(sendername));
		TogglePlayerControllable(playa, 1);
		format(string, sizeof(string), "AdmCmd: %s descongelou %s.",sendername, giveplayer);
		ABroadCast(COLOR_LIGHTRED,string,1);
		format(string, sizeof(string), " `LOG-CONGELAR:` [%s] **%s** descongelou **%s**.", ReturnDate(), sendername, giveplayer);
   	 	DCC_SendChannelMessage(DC_LogAdmin, string);
	}
	return 1;
}

CMD:setcustomskin(playerid, params[])
{
	if(PlayerInfo[playerid][user_logged] == 0) return SendClientMessage(playerid, COLOR_GRAD1, "Você não está logado.");
	if(PlayerInfo[playerid][user_admin] < 3) return SendClientMessage(playerid, COLOR_GREY, "Você não possui autorização para utilizar esse comando.");
	if (PlayerInfo[playerid][user_admin] < 4 && !AdminTrabalhando[playerid])
        return SendClientMessage(playerid, COLOR_LIGHTRED, "ERRO: Você deve usar o comando /atrabalho antes.");

	new para1, level;
	if(sscanf(params, "ud", para1, level))
	{
		SendClientMessage(playerid, COLOR_GREY, "USE: /setcustomskin [playerid] [skin id]");
		return true;
	}
	if(level < 20000 || level > 25000)
	{
		SendClientMessage(playerid, COLOR_GREY, "ERRO: ID inválido. USE: ID 20001 a 25000.");
		return true;
	}
	new string[128];
	if(IsPlayerConnected(para1))
	{
		if(para1 != INVALID_PLAYER_ID)
		{
			GetPlayerName(para1, giveplayer, sizeof(giveplayer));
			GetPlayerName(playerid, sendername, sizeof(sendername));
			PlayerInfo[para1][user_skin] = level;
			format(string, sizeof(string), "O admin %s mudou sua skin para %d.", pNome(playerid),level);
			SendClientMessage(para1, COLOR_LIGHTBLUE, string);
			format(string, sizeof(string), "Você mudou a skin de %s para %d.", pNome(para1),level);
			SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
			SetPlayerSkin(para1, PlayerInfo[para1][user_skin]);
		}
	}
	return true;
}

CMD:setskin(playerid, params[])
{
	if(PlayerInfo[playerid][user_logged] == 0) return SendClientMessage(playerid, COLOR_GRAD1, "Você não está logado.");
	if(PlayerInfo[playerid][user_admin] < 3) return SendClientMessage(playerid, COLOR_GREY, "Você não possui autorização para utilizar esse comando.");
	if (PlayerInfo[playerid][user_admin] < 4 && !AdminTrabalhando[playerid])
        return SendClientMessage(playerid, COLOR_LIGHTRED, "ERRO: Você deve usar o comando /atrabalho antes.");

	new para1, level;
	if(sscanf(params, "ud", para1, level))
	{
		SendClientMessage(playerid, COLOR_GREY, "USE: /setskin [playerid] [skin id]");
		return true;
	}
	if(level < 1 || level > 311)
	{
		SendClientMessage(playerid, COLOR_GREY, "ERRO: ID inválido. USE: ID 1 a 311.");
		return true;
	}
	new string[128];
	if(IsPlayerConnected(para1))
	{
		if(para1 != INVALID_PLAYER_ID)
		{
			GetPlayerName(para1, giveplayer, sizeof(giveplayer));
			GetPlayerName(playerid, sendername, sizeof(sendername));
			PlayerInfo[para1][user_skin] = level;
			format(string, sizeof(string), "O admin %s mudou sua skin para %d.", pNome(playerid) ,level);
			SendClientMessage(para1, COLOR_LIGHTBLUE, string);
			format(string, sizeof(string), "Você mudou a skin de %s para %d.", pNome(para1),level);
			SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
			SetPlayerSkin(para1, PlayerInfo[para1][user_skin]);
		}
	}
	return true;
}

CMD:perto(playerid, params[])
{
	static
	    id = -1;

    if(PlayerInfo[playerid][user_logged] == 0) return SendClientMessage(playerid, COLOR_GRAD1, "Você não está logado.");
	if(PlayerInfo[playerid][user_admin] < 3) return SendClientMessage(playerid, COLOR_GREY, "Você não possui autorização para utilizar esse comando.");
	
	/*if ((id = House_Nearest(playerid)) != -1)
	    SendServerMessage(playerid, "You are standing near house ID: %d.", id);

    if ((id = Business_Nearest(playerid)) != -1)
	    SendServerMessage(playerid, "You are standing near business ID: %d.", id);*/

    if ((id = Entrance_Nearest(playerid)) != -1)
	    SendServerMessage(playerid, "Você está perto da entrada ID: %d.", id);

   /* if ((id = Job_Nearest(playerid)) != -1)
	    SendServerMessage(playerid, "You are standing near job ID: %d.", id);*/

    if ((id = Arrest_Nearest(playerid)) != -1)
	    SendServerMessage(playerid, "Você está perto do ponto de prisão ID: %d.", id);

    /*if ((id = Pump_Nearest(playerid)) != -1)
	    SendServerMessage(playerid, "You are standing near pump ID: %d.", id);

    if ((id = Crate_Nearest(playerid)) != -1)
	    SendServerMessage(playerid, "You are standing near crate ID: %d.", id);

    if ((id = Gate_Nearest(playerid)) != -1)
	    SendServerMessage(playerid, "You are standing near gate ID: %d.", id);

    if ((id = ATM_Nearest(playerid)) != -1)
	    SendServerMessage(playerid, "You are standing near ATM ID: %d.", id);

    if ((id = Garbage_Nearest(playerid)) != -1)
	    SendServerMessage(playerid, "You are standing near garbage bin ID: %d.", id);

    if ((id = Vendor_Nearest(playerid)) != -1)
	    SendServerMessage(playerid, "You are standing near vendor ID: %d.", id);

	if ((id = Rack_Nearest(playerid)) != -1)
 		SendServerMessage(playerid, "You are standing near weapon rack ID: %d.", id);

    if ((id = Speed_Nearest(playerid)) != -1)
 		SendServerMessage(playerid, "You are standing near speed camera ID: %d.", id);*/

    if ((id = Graffiti_Nearest(playerid)) != -1)
 		SendServerMessage(playerid, "Você está perto do ponto de pichação ID: %d.", id);

    /*if ((id = Detector_Nearest(playerid)) != -1)
 		SendServerMessage(playerid, "You are standing near detector ID: %d.", id);*/

	return 1;
}
// FLY

static bool:OnFly[MAX_PLAYERS];		// true = player is flying, false = player on foot
//forward InitFly(playerid);							// call this function in OnPlayerConnect
forward bool:StartFly(playerid);					// start flying
forward Fly(playerid);								// timer
forward bool:StopFly(playerid);						// stop flying
forward static SetPlayerLookAt(playerid,Float:x,Float:y);	// set player face position

CMD:fly(playerid)
{
	if(PlayerInfo[playerid][user_logged] == 0)
	{
		SendClientMessage(playerid, COLOR_GRAD1, "Você não está logado.");
		return true;
	}
	if(PlayerInfo[playerid][user_admin] < 4) return SendClientMessage(playerid, COLOR_GREY, "Você não possui autorização para utilizar esse comando.");
	if (PlayerInfo[playerid][user_admin] < 4 && !AdminTrabalhando[playerid])
        return SendClientMessage(playerid, COLOR_LIGHTRED, "ERRO: Você deve usar o comando /atrabalho antes.");
	
	if(IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, COLOR_GREY, "Você não pode utilizar esse comando estando dentro de um veículo.");
	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);
	SetPlayerHealth(playerid, 99999.0);
	SetTimerEx("DestroyMe", 500, 0, "d", CreateObject(2780, x, y, z - 3.0, 0.0, 0.0, 0.0));
	SendClientMessage(playerid, COLOR_GRAD1, "Para sair do modo de voo digite /stopfly.");
	StartFly(playerid);
	return 1;
}

CMD:stopfly(playerid)
{
	if(PlayerInfo[playerid][user_logged] == 0)
	{
		SendClientMessage(playerid, COLOR_GRAD1, "Você não está logado.");
		return true;
	}
	if(PlayerInfo[playerid][user_admin] < 4) return SendClientMessage(playerid, COLOR_GREY, "Você não possui autorização para utilizar esse comando.");
	if (PlayerInfo[playerid][user_admin] < 4 && !AdminTrabalhando[playerid])
        return SendClientMessage(playerid, COLOR_LIGHTRED, "ERRO: Você deve usar o comando /atrabalho antes.");

	SetPlayerHealth(playerid, 100.0);
	SendClientMessage(playerid, COLOR_GRAD1, "Você saiu do modo de voo.");
	StopFly(playerid);
	return 1;
}

CMD:voar(playerid, params[])
{
    if(PlayerInfo[playerid][user_logged] == 0) return SendClientMessage(playerid, COLOR_GRAD1, "Você não está logado.");
	if(PlayerInfo[playerid][user_admin] < 1) return SendClientMessage(playerid, COLOR_GREY, "Você não possui autorização para utilizar esse comando.");
	if (PlayerInfo[playerid][user_admin] < 4 && !AdminTrabalhando[playerid])
        return SendClientMessage(playerid, COLOR_LIGHTRED, "ERRO: Você deve usar o comando /atrabalho antes.");

	new Float:px, Float:py, Float:pz, Float:pa;
	GetPlayerFacingAngle(playerid,pa);
	if(pa >= 0.0 && pa <= 22.5) //n1
	{
		GetPlayerPos(playerid, px, py, pz);
		SetPlayerPos(playerid, px, py+30, pz+5);
	}
	else if(pa >= 332.5 && pa < 0.0) //n2
	{
		GetPlayerPos(playerid, px, py, pz);
		SetPlayerPos(playerid, px, py+30, pz+5);
	}
	else if(pa >= 22.5 && pa <= 67.5) //nw
	{
		GetPlayerPos(playerid, px, py, pz);
		SetPlayerPos(playerid, px-15, py+15, pz+5);		
	}
	else if(pa >= 67.5 && pa <= 112.5) //w
	{
		GetPlayerPos(playerid, px, py, pz);
		SetPlayerPos(playerid, px-30, py, pz+5);
	}
	else if(pa >= 112.5 && pa <= 157.5) //sw
	{
		GetPlayerPos(playerid, px, py, pz);
		SetPlayerPos(playerid, px-15, py-15, pz+5);
	}
	else if(pa >= 157.5 && pa <= 202.5) //s
	{
		GetPlayerPos(playerid, px, py, pz);
		SetPlayerPos(playerid, px, py-30, pz+5);
	}
	else if(pa >= 202.5 && pa <= 247.5)//se
	{
		GetPlayerPos(playerid, px, py, pz);
		SetPlayerPos(playerid, px+15, py-15, pz+5);
	}
	else if(pa >= 247.5 && pa <= 292.5)//e
	{
		GetPlayerPos(playerid, px, py, pz);
		SetPlayerPos(playerid, px+30, py, pz+5);
	}
	else if(pa >= 292.5 && pa <= 332.5)//e
	{
		GetPlayerPos(playerid, px, py, pz);
		SetPlayerPos(playerid, px+15, py+15, pz+5);
	}
	else
	{
		GetPlayerPos(playerid, px, py, pz);
		SetPlayerPos(playerid, px+15, py+15, pz+5);
	}			
	return true;
}

CMD:voar2(playerid, params[])
{
	if(PlayerInfo[playerid][user_logged] == 0) return SendClientMessage(playerid, COLOR_GRAD1, "Você não está logado.");
	if(PlayerInfo[playerid][user_admin] < 1) return SendClientMessage(playerid, COLOR_GREY, "Você não possui autorização para utilizar esse comando.");
	if (PlayerInfo[playerid][user_admin] < 4 && !AdminTrabalhando[playerid])
        return SendClientMessage(playerid, COLOR_LIGHTRED, "ERRO: Você deve usar o comando /atrabalho antes.");

	new Float:px, Float:py, Float:pz, Float:pa;
	new Float:ppx, Float:ppy, Float:ppz;
	GetPlayerFacingAngle(playerid,pa);
	if(pa >= 0.0 && pa <= 22.5) //n1
	{
		GetPlayerPos(playerid, px, py, pz);
		GetPlayerVelocity(playerid, ppx, ppy, ppz);
		SetPlayerPos(playerid, px, py+35, pz+10);
		SetPlayerVelocity(playerid, ppx, ppy+0.5, ppz+90);
	}
	else if(pa >= 332.5 && pa < 0.0) //n2
	{
		GetPlayerPos(playerid, px, py, pz);
		GetPlayerVelocity(playerid, ppx, ppy, ppz);
		SetPlayerPos(playerid, px, py+35, pz+10);
		SetPlayerVelocity(playerid, ppx, ppy+0.5, ppz+90);
	}
	else if(pa >= 22.5 && pa <= 67.5) //nw
	{
		GetPlayerPos(playerid, px, py, pz);
		GetPlayerVelocity(playerid, ppx, ppy, ppz);
		SetPlayerPos(playerid, px-20, py+20, pz+10);
		SetPlayerVelocity(playerid, ppx-0.5, ppy+0.5, ppz+90);
	}
	else if(pa >= 67.5 && pa <= 112.5) //w
	{
		GetPlayerPos(playerid, px, py, pz);
		GetPlayerVelocity(playerid, ppx, ppy, ppz);
		SetPlayerPos(playerid, px-35, py, pz+10);
		SetPlayerVelocity(playerid, ppx-0.5, ppy, ppz+90);
	}
	else if(pa >= 112.5 && pa <= 157.5) //sw
	{
		GetPlayerPos(playerid, px, py, pz);
		GetPlayerVelocity(playerid, ppx, ppy, ppz);
		SetPlayerPos(playerid, px-20, py-20, pz+10);
		SetPlayerVelocity(playerid, ppx-0.5, ppy-0.5, ppz+90);
	}
	else if(pa >= 157.5 && pa <= 202.5) //s
	{
		GetPlayerPos(playerid, px, py, pz);
		GetPlayerVelocity(playerid, ppx, ppy, ppz);
		SetPlayerPos(playerid, px, py-35, pz+10);
		SetPlayerVelocity(playerid, ppx, ppy-0.5, ppz+90);
	}
	else if(pa >= 202.5 && pa <= 247.5)//se
	{
		GetPlayerPos(playerid, px, py, pz);
		GetPlayerVelocity(playerid, ppx, ppy, ppz);
		SetPlayerPos(playerid, px+20, py-20, pz+10);
		SetPlayerVelocity(playerid, ppx+0.5, ppy-0.5, ppz+90);
	}
	else if(pa >= 247.5 && pa <= 292.5)//e
	{
		GetPlayerPos(playerid, px, py, pz);
		GetPlayerVelocity(playerid, ppx, ppy, ppz);
		SetPlayerPos(playerid, px+35, py, pz+10);
		SetPlayerVelocity(playerid, ppx+0.5, ppy, ppz+90);
	}
	else if(pa >= 292.5 && pa <= 332.5)//e
	{
		GetPlayerPos(playerid, px, py, pz);
		GetPlayerVelocity(playerid, ppx, ppy, ppz);
		SetPlayerPos(playerid, px+20, py+20, pz+10);
		SetPlayerVelocity(playerid, ppx+0.5, ppy+0.5, ppz+90);
	}
	else
	{
		GetPlayerPos(playerid, px, py, pz);
		GetPlayerVelocity(playerid, ppx, ppy, ppz);
		SetPlayerPos(playerid, px+20, py+20, pz+10);
		SetPlayerVelocity(playerid, ppx+0.5, ppy+0.5, ppz+90);
	}
	return true;
}


CMD:voar3(playerid, params[])
{
	if(PlayerInfo[playerid][user_logged] == 0) return SendClientMessage(playerid, COLOR_GRAD1, "Você não está logado.");
	if(PlayerInfo[playerid][user_admin] < 1) return SendClientMessage(playerid, COLOR_GREY, "Você não possui autorização para utilizar esse comando.");
	if (PlayerInfo[playerid][user_admin] < 4 && !AdminTrabalhando[playerid])
        return SendClientMessage(playerid, COLOR_LIGHTRED, "ERRO: Você deve usar o comando /atrabalho antes.");
	
	new Float:px, Float:py, Float:pz, Float:pa;
	new Float:ppx, Float:ppy, Float:ppz;
	GetPlayerFacingAngle(playerid,pa);
	if(pa >= 0.0 && pa <= 22.5) //n1
	{
		GetPlayerPos(playerid, px, py, pz);
		GetPlayerVelocity(playerid, ppx, ppy, ppz);
		SetPlayerPos(playerid, px, py+43, pz+30);
		SetPlayerVelocity(playerid, ppx, ppy+2, ppz+90);

	}
	else if(pa >= 332.5 && pa < 0.0) //n2
	{
		GetPlayerPos(playerid, px, py, pz);
		GetPlayerVelocity(playerid, ppx, ppy, ppz);
		SetPlayerPos(playerid, px, py+43, pz+30);
		SetPlayerVelocity(playerid, ppx, ppy+2, ppz+90);

	}
	else if(pa >= 22.5 && pa <= 67.5) //nw
	{
		GetPlayerPos(playerid, px, py, pz);
		GetPlayerVelocity(playerid, ppx, ppy, ppz);
		SetPlayerPos(playerid, px-43, py+43, pz+30);
		SetPlayerVelocity(playerid, ppx-2, ppy+2, ppz+90);
	}
	else if(pa >= 67.5 && pa <= 112.5) //w
	{
		GetPlayerPos(playerid, px, py, pz);
		GetPlayerVelocity(playerid, ppx, ppy, ppz);
		SetPlayerPos(playerid, px-43, py, pz+30);
		SetPlayerVelocity(playerid, ppx-2, ppy, ppz+90);
	}
	else if(pa >= 112.5 && pa <= 157.5) //sw
	{
		GetPlayerPos(playerid, px, py, pz);
		GetPlayerVelocity(playerid, ppx, ppy, ppz);
		SetPlayerPos(playerid, px-43, py-43, pz+30);
		SetPlayerVelocity(playerid, ppx-2, ppy-2, ppz+90);
	}
	else if(pa >= 157.5 && pa <= 202.5) //s
	{
		GetPlayerPos(playerid, px, py, pz);
		GetPlayerVelocity(playerid, ppx, ppy, ppz);
		SetPlayerPos(playerid, px, py-43, pz+30);
		SetPlayerVelocity(playerid, ppx, ppy-2, ppz+90);
	}
	else if(pa >= 202.5 && pa <= 247.5)//se
	{
		GetPlayerPos(playerid, px, py, pz);
		GetPlayerVelocity(playerid, ppx, ppy, ppz);
		SetPlayerPos(playerid, px+43, py-43, pz+30);
		SetPlayerVelocity(playerid, ppx+2, ppy-2, ppz+90);
	}
	else if(pa >= 247.5 && pa <= 292.5)//e
	{
		GetPlayerPos(playerid, px, py, pz);
		GetPlayerVelocity(playerid, ppx, ppy, ppz);
		SetPlayerPos(playerid, px+40, py, pz+30);
		SetPlayerVelocity(playerid, ppx+2, ppy, ppz+90);
	}
	else if(pa >= 292.5 && pa <= 332.5)//e
	{
		GetPlayerPos(playerid, px, py, pz);
		GetPlayerVelocity(playerid, ppx, ppy, ppz);
		SetPlayerPos(playerid, px+35, py+35, pz+30);
		SetPlayerVelocity(playerid, ppx+2, ppy+2, ppz+90);
	}
	else
	{
		GetPlayerPos(playerid, px, py, pz);
		GetPlayerVelocity(playerid, ppx, ppy, ppz);
		SetPlayerPos(playerid, px+35, py+35, pz+30);
		SetPlayerVelocity(playerid, ppx+2, ppy+2, ppz+90);
	}
	return true;
}

CMD:ajudafly(playerid, params[])
{
    if(PlayerInfo[playerid][user_logged] == 0) return SendClientMessage(playerid, COLOR_GRAD1, "Você não está logado.");
	if(PlayerInfo[playerid][user_admin] < 1) return SendClientMessage(playerid, COLOR_GREY, "Você não possui autorização para utilizar esse comando.");
	if (PlayerInfo[playerid][user_admin] < 4 && !AdminTrabalhando[playerid])
        return SendClientMessage(playerid, COLOR_LIGHTRED, "ERRO: Você deve usar o comando /atrabalho antes.");

	SendClientMessage(playerid, COLOR_GRAD1, "/fly - inicia o modo de voo");
	SendClientMessage(playerid, COLOR_GRAD1, "/stopfly - desliga o modo de voo");
	SendClientMessage(playerid, COLOR_GRAD1, "botão de atirar - aumenta a altura");
	SendClientMessage(playerid, COLOR_GRAD1, "botão de mirar - diminui a altura");
	SendClientMessage(playerid, COLOR_GRAD1, "botão de correr (espaço) - aumenta a velocidade");
	SendClientMessage(playerid, COLOR_GRAD1, "botão de andar (lalt) - diminui a velocidade");
	return 1;
}
bool:StartFly(playerid)
{
	if(OnFly[playerid])
        return false;
    OnFly[playerid] = true;
	new Float:x,Float:y,Float:z;
	GetPlayerPos(playerid,x,y,z);
	SetPlayerPos(playerid,x,y,z);
	ApplyAnimation(playerid,"PARACHUTE","PARA_steerR",6.1,1,1,1,1,0,1);
	Fly(playerid);
	SendClientMessage(playerid, COLOR_LIGHTRED, "Para aprender a voar use /ajudafly.");
	return true;
}

public Fly(playerid)
{
	if(!IsPlayerConnected(playerid))
		return 1;
	new k, ud,lr;
	GetPlayerKeys(playerid,k,ud,lr);
	new Float:v_x,Float:v_y,Float:v_z,
		Float:x,Float:y,Float:z;
	if(ud < 0)	// forward
	{
		GetPlayerCameraFrontVector(playerid,x,y,z);
		v_x = x+0.1;
		v_y = y+0.1;
	}
	if(k & 128)	// down
		v_z = -0.2;
	else if(k & KEY_FIRE)	// up
		v_z = 0.2;
	if(k & KEY_WALK)	// slow
	{
		v_x /=5.0;
		v_y /=5.0;
		v_z /=5.0;
	}
	if(k & KEY_SPRINT)	// fast
	{
		v_x *=4.0;
		v_y *=4.0;
		v_z *=4.0;
	}
	if(v_z == 0.0)
		v_z = 0.025;
	SetPlayerVelocity(playerid,v_x,v_y,v_z);
	if(v_x == 0 && v_y == 0)
	{
		if(GetPlayerAnimationIndex(playerid) == 959)
		ApplyAnimation(playerid,"PARACHUTE","PARA_steerR",6.1,1,1,1,1,0,1);
	}
	else
	{
		GetPlayerCameraFrontVector(playerid,v_x,v_y,v_z);
		GetPlayerCameraPos(playerid,x,y,z);
		SetPlayerLookAt(playerid,v_x*500.0+x,v_y*500.0+y);
		if(GetPlayerAnimationIndex(playerid) != 959)
		ApplyAnimation(playerid,"PARACHUTE","FALL_SkyDive_Accel",6.1,1,1,1,1,0,1);
	}
	if(OnFly[playerid])
		SetTimerEx("Fly",100,false,"i",playerid);
	return 1;
}

bool:StopFly(playerid)
{
	if(!OnFly[playerid])
        return false;
	new Float:x,Float:y,Float:z;
	GetPlayerPos(playerid,x,y,z);
	SetPlayerPos(playerid,x,y,z);
	OnFly[playerid] = false;
	return true;
}

static SetPlayerLookAt(playerid,Float:x,Float:y)
{
	new Float:Px, Float:Py, Float: Pa;
	GetPlayerPos(playerid, Px, Py, Pa);
	Pa = floatabs(atan((y-Py)/(x-Px)));
	if (x <= Px && y >= Py) 		Pa = floatsub(180.0, Pa);
	else if (x < Px && y < Py) 		Pa = floatadd(Pa, 180.0);
	else if (x >= Px && y <= Py)	Pa = floatsub(360.0, Pa);
	Pa = floatsub(Pa, 90.0);
	if (Pa >= 360.0)
		Pa = floatsub(Pa, 360.0);
	SetPlayerFacingAngle(playerid, Pa);
	return;
}

Dialog:TeleportInterior(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    SetPlayerInterior(playerid, g_arrInteriorData[listitem][e_InteriorID]);
	    SetPlayerPos(playerid, g_arrInteriorData[listitem][e_InteriorX], g_arrInteriorData[listitem][e_InteriorY], g_arrInteriorData[listitem][e_InteriorZ]);
	}
	return 1;
}