CMD:ame(playerid, params[])  
{
	if(PlayerInfo[playerid][user_logged] == 0)
	{
		SendClientMessage(playerid, COLOR_GRAD1, "Você não está logado.");
		return true;
	}
    new opcao[256], string[256];
	if (sscanf(params, "s[256]", opcao)) return SendClientMessage(playerid, COLOR_LIGHTRED,"{FF6347}USE:{FFFFFF} /ame [ação]");
	else
	{
	    format(string, sizeof(string),"> %s %s", pNome(playerid), opcao);
		SendClientMessage(playerid, COLOR_PURPLE, string);
		SetPlayerChatBubble(playerid, string, COLOR_PURPLE, 35.0, 10000);
		
		format(string, sizeof(string), " `LOG-ME:` [%s] /me de **%s** *(%s)*: %s", ReturnDate(), pNome(playerid), ReturnIP(playerid), opcao);
		DCC_SendChannelMessage(DC_Logs2, string);
	}
	return true;
}

CMD:me(playerid, params[])  
{
	if(PlayerInfo[playerid][user_logged] == 0)
	{
		SendClientMessage(playerid, COLOR_GRAD1, "Você não está logado.");
		return true;
	}
    new opcao[256], string[256];
	if (sscanf(params, "s[256]", opcao)) return SendClientMessage(playerid, COLOR_LIGHTRED,"{FF6347}USE:{FFFFFF} /me [ação]");
	else
	{
	    format(string,sizeof(string),"* %s %s", pNome(playerid), opcao);
		SendClientMessageInRange(18.0, playerid, string,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		
		format(string, sizeof(string), " `LOG-ME:` [%s] /me de **%s** *(%s)*: %s", ReturnDate(), pNome(playerid), ReturnIP(playerid), opcao);
		DCC_SendChannelMessage(DC_Logs2, string);
	}
	return true;
}

CMD:ado(playerid, params[])  
{
	if(PlayerInfo[playerid][user_logged] == 0)
	{
		SendClientMessage(playerid, COLOR_GRAD1, "Você não está logado.");
		return true;
	}
    new opcao[256], string[256];
	if (sscanf(params, "s[256]", opcao)) return SendClientMessage(playerid, COLOR_LIGHTRED,"{FF6347}USE:{FFFFFF} /ado [ação]");
	else
	{
	    format(string, sizeof(string),"> %s (( %s ))", opcao, pNome(playerid));
		SendClientMessage(playerid, COLOR_PURPLE, string);
		SetPlayerChatBubble(playerid, string, COLOR_PURPLE, 35.0, 10000);

		format(string, sizeof(string), " `LOG-DO:` [%s] /do de **%s** *(%s)*: %s", ReturnDate(), pNome(playerid), ReturnIP(playerid), opcao);
		DCC_SendChannelMessage(DC_Logs2, string);
	}
	return true;
}

CMD:do(playerid, params[])
{
    if(PlayerInfo[playerid][user_logged] == 0)
	{
		SendClientMessage(playerid, COLOR_GRAD1, "Você não está logado.");
		return true;
	}
    new opcao[256], string[256];
	if (sscanf(params, "s[256]", opcao)) return SendClientMessage(playerid, COLOR_LIGHTRED,"{FF6347}USE:{FFFFFF} /do [ação]");
	else
	{
	    format(string,sizeof(string),"* %s (( %s ))", opcao, pNome(playerid));
		SendClientMessageInRange(18.0, playerid, string,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		
		format(string, sizeof(string), " `LOG-DO:` [%s] /do de **%s** *(%s)*: %s", ReturnDate(), pNome(playerid), ReturnIP(playerid), opcao);
		DCC_SendChannelMessage(DC_Logs2, string);
	}
	return 1;
}

CMD:g(playerid, params[])
{
	new string[256];
	if(PlayerInfo[playerid][user_logged] == 0)
	{
		SendClientMessage(playerid, COLOR_GRAD1, "Você não está logado.");
		return true;
	}
	if (isnull(params))
	    return SendSyntaxMessage(playerid, "/(g)ritar [texto]");

	if (strlen(params) > 64) {
	    SendNearbyMessage(playerid, 30.0, COLOR_WHITE, "%s grita: %.64s", pNome(playerid), params);
	    SendNearbyMessage(playerid, 30.0, COLOR_WHITE, "...%s", params[64]);
	}
	else {
	    SendNearbyMessage(playerid, 30.0, COLOR_WHITE, "%s grita: %s", pNome(playerid), params);
	}

	format(string, sizeof(string), " `LOG-GRITO:` [%s] Grito de **%s** *(%s)*: %s", ReturnDate(), pNome(playerid), ReturnIP(playerid), params);
	DCC_SendChannelMessage(DC_Logs2, string);
	return 1;
}

CMD:s(playerid, params[])
{
	new userid, text[128];
	new string [256];
    if (sscanf(params, "us[128]", userid, text))
	    return SendSyntaxMessage(playerid, "/(s)ussurrar [playerid/nome] [nome]");

	if (userid == INVALID_PLAYER_ID || !IsPlayerNearPlayer(playerid, userid, 5.0))
	    return SendErrorMessage(playerid, "Esse jogador está desconectado ou não está perto de você.");

	if (userid == playerid)
		return SendErrorMessage(playerid, "Você não pode sussurrar pra si mesmo.");

    if (strlen(text) > 64) {
	    SendClientMessageEx(userid, COLOR_YELLOW, "** Sussurro de %s (%d): %.64s", pNome(playerid), playerid, text);
	    SendClientMessageEx(userid, COLOR_YELLOW, "...%s **", text[64]);

	    SendClientMessageEx(playerid, COLOR_YELLOW, "** Sussurro para %s (%d): %.64s", pNome(userid), userid, text);
	    SendClientMessageEx(playerid, COLOR_YELLOW, "...%s **", text[64]);
	}
	else {
	    SendClientMessageEx(userid, COLOR_YELLOW, "** Sussurro de %s (%d): %s **", pNome(playerid), playerid, text);
	    SendClientMessageEx(playerid, COLOR_YELLOW, "** Sussurro para %s (%d): %s **", pNome(userid), userid, text);
	}
	SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s sussurra alguma coisa na orelha de %s.", pNome(playerid), pNome(userid));
	
	format(string, sizeof(string), " `LOG-WHISPER:` [%s] Sussurro de **%s** *(%s)* para **%s** *(%s)*: %s", ReturnDate(), pNome(playerid), ReturnIP(playerid), pNome(userid), ReturnIP(userid), text);
	DCC_SendChannelMessage(DC_Logs2, string);
	return 1;
}


CMD:baixo(playerid, result[])
{
	if(PlayerInfo[playerid][user_logged] == 0)
	{
		SendClientMessage(playerid, COLOR_GRAD1, "Você não está logado.");
		return true;
	}
	if(isnull(result))
	{
		SendClientMessage(playerid, COLOR_GRAD2, "USE: /baixo [texto]");
		return true;
	}
	new string[256];
	format(string, sizeof(string), "[baixo] %s diz: %s", pNome(playerid), result);
	SendClientMessageInRange(3.0, playerid, string,COLOR_FADE1,COLOR_FADE2,COLOR_FADE3,COLOR_FADE4,COLOR_FADE5);
	
	format(string, sizeof(string), " `LOG-BAIXO:` [%s] Baixo de **%s** *(%s)*: %s", ReturnDate(), pNome(playerid), ReturnIP(playerid), result);
	DCC_SendChannelMessage(DC_Logs2, string);
	return true;
}

CMD:b(playerid, params[])
{
    if(PlayerInfo[playerid][user_logged] == 0)
	{
		SendClientMessage(playerid, COLOR_GRAD1, "Você não está logado.");
		return true;
	}
    new opcao[256], string[256];
	if (sscanf(params, "s[256]", opcao)) return SendClientMessage(playerid, COLOR_LIGHTRED,"{FF6347}USE:{FFFFFF} /b [texto]");
	else
	{
	    new foi = 0;
		if(PlayerInfo[playerid][user_admin] > 0)
	    	if(AdminTrabalhando[playerid] == 1) { format(string,sizeof(string),"(( [%d] {587b95}%s{C8C8C8}: %s ))", playerid, pNome(playerid), opcao); foi = 1; }

		if(foi == 0)
		{
			format(string,sizeof(string),"(( [%d] %s: %s ))", playerid, pNome(playerid), opcao);
		}
		ProxDetector(10.0, playerid, string,COLOR_FADE2,COLOR_FADE2,COLOR_FADE2,COLOR_FADE2,COLOR_FADE2);

		format(string, sizeof(string), " `LOG-B:` [%s] /b de **%s** *(%s)*: %s", ReturnDate(), pNome(playerid), ReturnIP(playerid), opcao);
		DCC_SendChannelMessage(DC_Logs2, string);
	}
	return 1;
}

CMD:id(playerid, params[])
{
    if(PlayerInfo[playerid][user_logged] == 0)
	{
		SendClientMessage(playerid, COLOR_GRAD1, "Você não está logado.");
		return true;
	}
	if (isnull(params))
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "USE: /id [playerid/nome]");

	if (strlen(params) < 3)
		return SendClientMessage(playerid, COLOR_LIGHTRED, "Você deve especificar pelo menos 3 caracteres do nome do jogador.");

	new count, stringaap[64];

	foreach (new i : Player)
	{
	    new pnames[24];
		GetPlayerName(i, pnames, sizeof(pnames));
	    if (strfind(pnames, params, true) != -1)
	    {
	        format(stringaap, sizeof(stringaap), "%s - ID: %d (Nivel: %d)", pNome(i),i, PlayerInfo[i][user_score]);
			SendClientMessage(playerid, COLOR_GREY, stringaap);
	        count++;
		}
	}
	if (!count)
	{
		format(stringaap, sizeof(stringaap), "Não foi encontrado nenhum player com os caracteres: %s.", params);
		SendClientMessage(playerid, COLOR_LIGHTRED, stringaap);
	}
	return 1;
}
CMD:limparmeuchat(playerid, params[])
{
    if(PlayerInfo[playerid][user_logged] == 0)
	{
		SendClientMessage(playerid, COLOR_GRAD1, "Você não está logado.");
		return true;
	}
	LimparChat(playerid);
	return 1;
}

CMD:consertarvw(playerid, params[])
{
	if(PlayerInfo[playerid][user_logged] == 0)
	{
		SendClientMessage(playerid, COLOR_GRAD1, "Você não está logado.");
		return true;
	}
	
	if (GetPlayerInterior(playerid) == 0 && GetPlayerVirtualWorld(playerid) > 0)
	{
	    SetPlayerVirtualWorld(playerid, 0);
	    SendClientMessage(playerid, -1, "SERVER: Você consertou seu virtual world.");
	}
	else SendClientMessage(playerid, COLOR_GREY, "ERRO: Seu virtual world não esta bugado.");
	return 1;
}

CMD:ajuda(playerid, params[])
{
	if(PlayerInfo[playerid][user_logged] == 0)
	{
		SendClientMessage(playerid, COLOR_GRAD1, "Você não está logado.");
		return true;
	}

	new option[32];
	if(sscanf(params,"s[32]",option))
	{
	    SendClientMessage(playerid, COLOR_WHITE, "COMANDOS UTEIS:");
    	SendClientMessage(playerid, COLOR_GRAD2, "[CHAT] /me /do /ame /ado /b /g /baixo /id /animlist /pm");
		SendClientMessage(playerid, COLOR_GRAD2, "[GERAL] /tempo /consertarvw /limparmeuchat /mudarsenha /passararma");
    	SendClientMessage(playerid, COLOR_GRAD2, "[GERAL] /pagar");
		SendClientMessage(playerid, COLOR_YELLOW,"OUTROS: /ajuda tela, /ajuda veiculo, /ajuda facção");
	    if(PlayerInfo[playerid][user_admin] >= 1)
		{
			SendClientMessage(playerid, COLOR_LIGHTRED, "[ADMIN] AJUDA ADMINISTRATIVA: /aa");
		}
		return 1;
	}
    if(strcmp(option, "tela", true) == 0)
    {
    	SendClientMessage(playerid, COLOR_WHITE,"AJUDA TELA:");
		SendClientMessage(playerid, COLOR_GRAD2, "UTILIZE: /tela [syntax]");
		SendClientMessage(playerid, COLOR_GRAD2, "SYNTAXES: 0 para desativar, 1 para tela preta, 2 para marrom, 3 para cinza.");
		SendClientMessage(playerid, COLOR_GRAD2, "SYNTAXES: 4 para laranja.");
		SendClientMessage(playerid, COLOR_YELLOW,"OUTROS: /ajuda, /ajuda veiculo, /ajuda facção");
	}
	else if(strcmp(option, "veiculo", true) == 0)
	{
		SendClientMessage(playerid, COLOR_WHITE,"AJUDA VEÍCULO:");
		SendClientMessage(playerid, COLOR_GRAD2,"COMANDOS: /motor, /luzes, /capo, /janela");
		SendClientMessage(playerid, COLOR_YELLOW,"- OUTROS - /ajuda, /ajuda tela, /ajuda facção");
	}
	else if(strcmp(option, "ft", true) == 0)
	{
		if (PlayerInfo[playerid][pFactionMod] < 1)
			return SendErrorMessage(playerid, "Você não possui autorização para utilizar esse comando.");

		SendClientMessage(playerid, COLOR_WHITE,"FACTION TEAM:");
		SendClientMessage(playerid, COLOR_GRAD2, "COMANDOS: /criarfac, /destruirfac, /editarfac, /cor, /listafaccoes, /setarlider");
		SendClientMessage(playerid, COLOR_GRAD2, "COMANDOS: /setarfac, /setarcargo, /wfmenu, /criarpichacao, /destruirpichacao, /darmaterial");
		SendClientMessage(playerid, COLOR_GRAD2, "COMANDOS: /criarprisao, /destruirprisao");
	}
	else if(strcmp(option, "pt", true) == 0)
	{
		if (PlayerInfo[playerid][pPropertyMod] < 1)
			return SendErrorMessage(playerid, "Você não possui autorização para utilizar esse comando.");

		SendClientMessage(playerid, COLOR_WHITE,"PROPERTY TEAM:");
		SendClientMessage(playerid, COLOR_GRAD2, "COMANDOS: /criarentrada, /destruirentrada, /editarentrada");
	}
	else if(strcmp(option, "facção", true) == 0)
	{
		if (PlayerInfo[playerid][pFaction] == -1)
			return SendErrorMessage(playerid, "Você precisa ser membro de uma facção.");

		if (PlayerInfo[playerid][pFaction] != -1)
		{
			SendClientMessage(playerid, COLOR_WHITE,"AJUDA FACÇÃO:");
			SendClientMessage(playerid, COLOR_CLIENT, "FACÇÃO: /membros, /f, /sairfac, /armario, /convidar, /expulsar, /promover");

			if (GetFactionType(playerid) == FACTION_POLICE) {
				SendClientMessage(playerid, COLOR_CLIENT, "FACÇÃO: /dep, /sirene, /callsign, /m, /arrastar, /prender, /algemar, /desalgemar, /deter");
				SendClientMessage(playerid, COLOR_CLIENT, "FACÇÃO: /abrircela, /taser, /beanbag");
			}
			else if (GetFactionType(playerid) == FACTION_NEWS) {
				SendClientMessage(playerid, COLOR_CLIENT, "FACÇÃO: /callsign");
			}
			else if (GetFactionType(playerid) == FACTION_MEDIC) {
				SendClientMessage(playerid, COLOR_CLIENT, "FACÇÃO: /dep, /callsign, /m");
			}
			else if (GetFactionType(playerid) == FACTION_GOV) {
				SendClientMessage(playerid, COLOR_CLIENT, "FACÇÃO: /dep, /cofresacar, /cofredepositar, /callsign");
			}
			else if (GetFactionType(playerid) == FACTION_GANG) {
				SendClientMessage(playerid, COLOR_CLIENT, "FACÇÃO: /pichar, /wf, /materiais");
			}
		}
	}
	return 1;
}

CMD:pm(playerid, params[])
{
	static
	    userid,
	    text[128],
		string[512];

	if (sscanf(params, "us[128]", userid, text))
	    return SendSyntaxMessage(playerid, "/pm [playerid/name] [message]");

	if(GetPVarInt(playerid, "TogPM") == 1)
		return SendErrorMessage(playerid, "Você deve ativar o recebimento de mensagens privadas primeiro.");

	if (userid == INVALID_PLAYER_ID)
	    return SendErrorMessage(playerid, "Você específicou um jogador inválido.");

	if (userid == playerid)
	    return SendErrorMessage(playerid, "Você não pode enviar mensagens privadas para si mesmo.");

	if(GetPVarInt(userid, "TogPM") == 1) 
	    return SendErrorMessage(playerid, "Este jogador desativou as mensagens privadas.");

	format(string,sizeof(string),"(( PM para %s (%d): %s ))", pNome(userid), userid, text);
	SendClientMessage(playerid, COLOR_YELLOW,string);

	format(string,sizeof(string),"(( PM de %s (%d): %s ))", pNome(playerid), playerid, text);
	SendClientMessage(userid, COLOR_YELLOW,string);

	format(string, sizeof(string), " `LOG-PM:` [%s] PM de **%s** *(%s)* para **%s** *(%s)*: ", ReturnDate(), pNome(playerid), ReturnIP(playerid), pNome(userid), ReturnIP(userid), text);
	DCC_SendChannelMessage(DC_Logs2, string);
	return 1;
}

CMD:passararma(playerid, params[])
{
	new
	    weaponid = GetWeapon(playerid),
	    ammo = GetPlayerAmmo(playerid),
		userid;
	new string[258];

	if (!weaponid)
	    return SendErrorMessage(playerid, "Vou não está segurando nenhuma arma para passar.");

	if (sscanf(params, "u", userid))
	    return SendSyntaxMessage(playerid, "/passararma [playerid/nome]");

	if (userid == INVALID_PLAYER_ID || !IsPlayerNearPlayer(playerid, userid, 5.0))
	    return SendErrorMessage(playerid, "Este jogador está desconectado ou não está próximo.");

	if (userid == playerid)
		return SendErrorMessage(playerid, "Você não pode dar uma arma para si mesmo.");

	if (PlayerInfo[userid][pGuns][g_aWeaponSlots[weaponid]] != 0)
	    return SendErrorMessage(playerid, "Este jogador já tem uma arma nesse slot.");

	ResetWeapon(playerid, weaponid);
	GiveWeaponToPlayer(userid, weaponid, ammo);

	SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s entregou uma %s para %s.", pNome(playerid), ReturnWeaponName(weaponid), pNome(userid));
	
	format(string, sizeof(string), " `LOG-WEP:` [%s] **%s** *(%s)* deu uma %s com %d munições para **%s** *(%s)*", ReturnDate(), pNome(playerid), ReturnIP(playerid), ReturnWeaponName(weaponid), ammo, pNome(userid), ReturnIP(userid));
	DCC_SendChannelMessage(DC_Logs1, string);
	return 1;
}

CMD:pagar(playerid, params[])
{
	static
	    userid,
	    amount;

	if (sscanf(params, "ud", userid, amount))
	    return SendSyntaxMessage(playerid, "/pagar [playerid/nome] [quantidade]");

	if (userid == INVALID_PLAYER_ID || !IsPlayerNearPlayer(playerid, userid, 5.0))
	    return SendErrorMessage(playerid, "Este jogador está desconectado ou não está perto de você.");

	if (userid == playerid)
		return SendErrorMessage(playerid, "Você não pode dar dinheiro para si mesmo.");

	if (amount < 1)
	    return SendErrorMessage(playerid, "Você não pode pagar menos que $1.");

	/*if (amount > 100 && PlayerInfo[playerid][pPlayingHours] < 2)
	    return SendErrorMessage(playerid, "You can't pay above $100 with less than 2 playing hours.");
*/
	if (amount > GetMoney(playerid))
	    return SendErrorMessage(playerid, "Você não tem isso tudo de dinheiro.");

	static
	    string[128];

	GiveMoney(playerid, -amount);
	GiveMoney(userid, amount);

	format(string, sizeof(string), "SERVER: Você recebeu $%s de %s.", FormatNumber(amount), pNome(playerid));
	SendClientMessage(playerid, COLOR_YELLOW, string);

	format(string, sizeof(string), "SERVER: Você deu $%s para %s.", FormatNumber(amount), pNome(userid));
	SendClientMessage(playerid, COLOR_YELLOW, string);

	SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s entrega $%s para %s.", pNome(playerid), FormatNumber(amount), pNome(userid));
	
	format(string, sizeof(string), " `LOG-PAYMENT:` [%s] **%s** *(%s)* pagou %s para **%s** *(%s)*", ReturnDate(), pNome(playerid), ReturnIP(playerid), FormatNumber(amount), pNome(userid), ReturnIP(userid));
	DCC_SendChannelMessage(DC_Logs1, string);
	return 1;
}
