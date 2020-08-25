stock ban_OnGameModeInit()
{
    mysql_query(Database, "CREATE TABLE IF NOT EXISTS bans(`BanID` int(10) AUTO_INCREMENT PRIMARY KEY, `Username` VARCHAR(24) NOT NULL, `BannedBy` VARCHAR(24) NOT NULL, `BanReason` VARCHAR(128) NOT NULL, `IpAddress` VARCHAR(17) NOT NULL, `Date` VARCHAR(30) NOT NULL);");
	return 1;
}

stock ban_OnPlayerConnect(playerid)
{
	new query[100];
    mysql_format(Database, query, sizeof(query), "SELECT * FROM `bans` WHERE `Username` = '%e';", GetName(playerid));
	mysql_tquery(Database, query, "CheckPlayer", "d", playerid); 
	return 1;
}

forward CheckPlayer(playerid);
public CheckPlayer(playerid)
{
	if(cache_num_rows() != 0) 
	{
		TextDrawHideForPlayer(playerid, TextLogin);
		TextDrawShowForPlayer(playerid, TextBan);
	    new Username[24], BannedBy[24], BanReason[128], Date[20];
	    cache_get_value_name(0, "Username", Username); 
	    cache_get_value_name(0, "BannedBy", BannedBy); 
	    cache_get_value_name(0, "BanReason", BanReason); 
	    cache_get_value_name(0, "Date", Date);
		LimparChat(playerid);
	    new string[800];
		MEGAString[0]=EOS;
		format(string, sizeof(string), "{FF6347}Personagem: {FFFFFF}%s\n", Username);
		strcat(MEGAString,string);
		format(string, sizeof(string), "{FF6347}Banido por: {FFFFFF}%s\n", BannedBy);
		strcat(MEGAString,string);
		format(string, sizeof(string), "{FF6347}Motivo: {FFFFFF}%s\n", BanReason);
		strcat(MEGAString,string);
		format(string, sizeof(string), "{FF6347}Data do banimento: {FFFFFF}%s\n\n", Date);
		strcat(MEGAString,string);

		strcat(MEGAString,"{FF6347}INFO: {FFFFFF}Pressione F8 para tirar uma screenshot e requisitar um apelo no fórum.\n");

		Dialog_Show(playerid, DIALOG_BANNED, DIALOG_STYLE_MSGBOX, " ", MEGAString, "Fechar", "");
	    SetTimerEx("SendToKick", 400, false, "i", playerid); 
	}
	else
	{
		new query[200];
		mysql_format(Database, query, sizeof(query), "SELECT * FROM `players` WHERE `Username` = '%e'", GetName(playerid));
		mysql_tquery(Database, query, "CheckAccount", "d", playerid);
	}
	return 1;
}

forward SendToKick(playerid);
public SendToKick(playerid)
{
	Kick(playerid);
	return 1;
}

CMD:ban(playerid, params[])
{
    if(PlayerInfo[playerid][user_logged] == 0) return SendClientMessage(playerid, COLOR_GRAD1, "Você não está logado.");
	if(PlayerInfo[playerid][user_admin] < 1) return SendClientMessage(playerid, COLOR_GREY, "Você não possui autorização para utilizar esse comando.");
	if (PlayerInfo[playerid][user_admin] < 4 && !AdminTrabalhando[playerid])
        return SendClientMessage(playerid, COLOR_LIGHTRED, "ERRO: Você deve usar o comando /atrabalho antes.");

	new PlayerIP[17];
	new giveplayerid, reason[128], string[150], query[300];
	GetPlayerIp(giveplayerid, PlayerIP, sizeof(PlayerIP)); 
	
	if(sscanf(params, "us[128]", giveplayerid, reason)) return SendClientMessage(playerid, COLOR_GREY, "USE: /ban [playerid] [motivo]");
	if(!IsPlayerConnected(giveplayerid)) return SendClientMessage(playerid, COLOR_GREY, "ERRO: Jogador não conectado."); 
	
	mysql_format(Database, query, sizeof(query), "INSERT INTO `bans` (`Username`, `BannedBy`, `BanReason`, `IpAddress`, `Date`) VALUES ('%e', '%e', '%e', '%e', '%e')", GetName(giveplayerid), GetName(playerid), reason, PlayerIP, ReturnDate());
	mysql_tquery(Database, query, "", "");

	format(string, sizeof(string), "AdmCmd: %s foi banido por %s, motivo: %s.", pNome(giveplayerid), pNome(playerid), reason); // This message will be sent to every player online.
	SendClientMessageToAll(COLOR_LIGHTRED, string);
	SaveLogs("/ban", string);
	SetTimerEx("SendToKick", 500, false, "d", giveplayerid); 
	return 1;
}

CMD:desbanir(playerid, params[])
{
	if(PlayerInfo[playerid][user_logged] == 0) return SendClientMessage(playerid, COLOR_GRAD1, "Você não está logado.");
	if(PlayerInfo[playerid][user_admin] < 3) return SendClientMessage(playerid, COLOR_GREY, "Você não possui autorização para utilizar esse comando.");
	if (PlayerInfo[playerid][user_admin] < 4 && !AdminTrabalhando[playerid])
        return SendClientMessage(playerid, COLOR_LIGHTRED, "ERRO: Você deve usar o comando /atrabalho antes.");

	new name[MAX_PLAYER_NAME], query[300], string[150], rows;
	if(sscanf(params, "s[128]", name)) return SendClientMessage(playerid, COLOR_GREY, "USE: /desbanir [nome]");
	mysql_format(Database, query, sizeof(query), "SELECT * FROM `bans` WHERE `Username` = '%e' LIMIT 0, 1", name);
	new Cache:result = mysql_query(Database, query);
	cache_get_row_count(rows);
	
	if(!rows)
	{
	    SendClientMessage(playerid, COLOR_GREY, "ERRO: Esse nome não existe ou não está banido.");
	}
	
 	for (new i = 0; i < rows; i ++)
	{
	    mysql_format(Database, query, sizeof(query), "DELETE FROM `bans` WHERE Username = '%e'", name);
	    mysql_tquery(Database, query);

		format(string, sizeof(string), "AdmCmd: %s desbaniu %s.", pNome(playerid), name);
		ABroadCast(COLOR_LIGHTRED,string,1);
		SaveLogs("/desbanir", string);
	}
	cache_delete(result);
	return 1;
}
CMD:oban(playerid, params[])
{
	if(PlayerInfo[playerid][user_logged] == 0) return SendClientMessage(playerid, COLOR_GRAD1, "Você não está logado.");
	if(PlayerInfo[playerid][user_admin] < 2) return SendClientMessage(playerid, COLOR_GREY, "Você não possui autorização para utilizar esse comando.");
	if (PlayerInfo[playerid][user_admin] < 4 && !AdminTrabalhando[playerid])
        return SendClientMessage(playerid, COLOR_LIGHTRED, "ERRO: Você deve usar o comando /atrabalho antes.");

	new name[MAX_PLAYER_NAME], reason[128], query[300], string[100], rows;
	if(sscanf(params, "s[24]s[128]", name, reason)) return SendClientMessage(playerid, COLOR_GREY, "USE: /oban [nome] [motivo]");
	mysql_format(Database, query, sizeof(query), "SELECT `Username` FROM `players` WHERE `Username` = '%e' LIMIT 0,1", name);
	new Cache:result = mysql_query(Database, query);
	cache_get_row_count(rows);

	if(!rows)
	{
	    SendClientMessage(playerid, COLOR_GREY, "ERRO: Esse usuário não existe.");
	}
	
	for (new i = 0; i < rows; i ++)
	{
		mysql_format(Database, query, sizeof(query), "INSERT INTO `bans` (`Username`, `BannedBy`, `BanReason`, `Date`) VALUES ('%e', '%e', '%e', '%e')", name, GetName(playerid), reason, ReturnDate());
		mysql_tquery(Database, query);
		format(string, sizeof(string), "AdmCmd: %s foi banido off-line por %s, motivo: %s.", name, pNome(playerid), reason);
		SendClientMessageToAll(COLOR_LIGHTRED, string);
		SaveLogs("/oban", string);
	}
	cache_delete(result);
	return 1;
}
CMD:baninfo(playerid, params[])
{
	if(PlayerInfo[playerid][user_logged] == 0) return SendClientMessage(playerid, COLOR_GRAD1, "Você não está logado.");
	if(PlayerInfo[playerid][user_admin] < 1) return SendClientMessage(playerid, COLOR_GREY, "Você não possui autorização para utilizar esse comando.");
	if (PlayerInfo[playerid][user_admin] < 4 && !AdminTrabalhando[playerid])
        return SendClientMessage(playerid, COLOR_LIGHTRED, "ERRO: Você deve usar o comando /atrabalho antes.");

    new name[MAX_PLAYER_NAME], query[300], rows;
	if(sscanf(params, "s[24]", name)) return SendClientMessage(playerid, COLOR_GREY, "USE: /baninfo [nome]");
	mysql_format(Database, query, sizeof(query), "SELECT * FROM `bans` where `Username` = '%e' LIMIT 0, 1", name);
	new Cache:result = mysql_query(Database, query);
	cache_get_row_count(rows);

	if(!rows)
	{
	    SendClientMessage(playerid, COLOR_GREY, "ERRO: Esse jogador não existe ou não está banido.");
	}

	for (new i = 0; i < rows; i ++)
	{
		new Username[24], BannedBy[24], BanReason[24], BanID, Date[30];
		cache_get_value_name(0, "Username", Username);
		cache_get_value_name(0, "BannedBy", BannedBy);
		cache_get_value_name(0, "BanReason", BanReason);
		cache_get_value_name_int(0, "BanID", BanID);
		cache_get_value_name(0, "Date", Date);

		new string[500];
		MEGAString[0]=EOS;
		format(string, sizeof(string), "{FF6347}Personagem: {FFFFFF}%s\n", Username);
		strcat(MEGAString,string);
		format(string, sizeof(string), "{FF6347}Banido por: {FFFFFF}%s\n", BannedBy);
		strcat(MEGAString,string);
		format(string, sizeof(string), "{FF6347}Motivo: {FFFFFF}%s\n", BanReason);
		strcat(MEGAString,string);
		/*format(string, sizeof(string), "{FF6347}Dias para o desbanimento: {FFFFFF}%s\n", ConverterNumeros(Days - gettime()));
		strcat(MEGAString,string);*/
		format(string, sizeof(string), "{FF6347}Data do banimento: {FFFFFF}%s\n", Date);
		strcat(MEGAString,string);
		format(string, sizeof(string), "{FF6347}Ban ID: {FFFFFF}%i\n\n", BanID);
		strcat(MEGAString,string);

		if(PlayerInfo[playerid][user_admin] >= 3)
		{
			strcat(MEGAString,"{FF6347}INFO: {FFFFFF}Para desbanir utilize: /desbanir\n");
		}
		Dialog_Show(playerid, DIALOG_BANCHECK, DIALOG_STYLE_MSGBOX, "{FFFFFF}INFORMAÇÕES DO BANIMENTO", MEGAString, "Fechar", "");
	}
	cache_delete(result);
	return 1;
}
