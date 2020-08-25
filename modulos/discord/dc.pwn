#define CMD_PREFIX "!"
#define BOT_CHANNEL "bot-channel"
#define BOT_NAME "C3PO"
#define CHANNEL_ID "745322875287765043"

#include <discord-connector>
#include <dcc>

new DCC_Channel:DC_Logs1;
new DCC_Channel:DC_Logs2;
new DCC_Channel:DC_Logs3;
new DCC_Channel:DC_LogAdmin;
new DCC_Channel:DC_LogFac;

public OnDCCommandPerformed(args[], success)
{
	if(!success) return SendDC(CHANNEL_ID, "```js\nComando inválido!\n```");
	return 1;
}

DC_CMD:test(user, args)
{
	SendDC(CHANNEL_ID, "Funciona!");
	return 1;
}

DC_CMD:aooc(user, args)
{
    new str[145], message[512];
    new string[256];
    if (sscanf(args, "s[512]", message)) return SendDC(CHANNEL_ID, "**USE:** `!aooc [mensagem]`");
    //utf8encode(user, str);
	format(str, sizeof str, "(( [DISCORD OOC] %s: %s ))", user, message);
    SendDC(CHANNEL_ID, "%s, sua mensagem foi enviada com sucesso!", user);
    SendClientMessageToAll(0xB1C8FBAA, str);

    format(string, sizeof string, "`DISCORD-OOC:` [%s] Mensagem OOC enviada pelo Discord por %s: %s.", ReturnDate(), user, message);
    DCC_SendChannelMessage(DC_Logs1, string);
    return 1;
}

DC_CMD:kick(user, args)
{
    new targetid, reason[128], string[512];
    if(sscanf(args, "us[128]", targetid, reason)) return SendDC(CHANNEL_ID, "**USE:** `!kick [playerid] [motivo]`");
    if(!IsPlayerConnected(targetid)) return SendDC(CHANNEL_ID, "**ERRO:** Jogador desconectado.");

    SendDC(CHANNEL_ID, "%s, o jogador %s foi kickado do servidor.", user, pNome(targetid));

    format(string, sizeof(string), "DiscordCmd: %s kickou %s, motivo: %s.", user, pNome(targetid), reason);
	SendClientMessageToAll(COLOR_LIGHTRED, string);

    SetTimerEx("Kick_Ex", 400, false, "i", targetid);
    return 1;
}

DC_CMD:onlines(user, args)
{
    new count = 0;
	new name[24];
	SendDC(CHANNEL_ID, "**JOGADORES ONLINE:**");
	for(new i=0; i < MAX_PLAYERS; i++) {
	if(!IsPlayerConnected(i)) continue;
	GetPlayerName(i, name, MAX_PLAYER_NAME);
	{
	   SendDC(CHANNEL_ID, "`%s [%d] (IP: %s)`", pNome(i), i, ReturnIP(i));
	   count++; }
	}
	if (count == 0) return SendDC(CHANNEL_ID, "Não possui nenhum jogador online no momento.");
	return 1;
}

DC_CMD:a(user, args)
{
    new str[256], message[512];
    if (sscanf(args, "s[512]", message)) return SendDC(CHANNEL_ID, "**USE:** `!a [mensagem]`");
	format(str, sizeof str, "(( [DISCORD] %s: %s ))", user, message);
    ABroadCast(COLOR_ADMINCHAT , str, 1);
	return true;
}

DC_CMD:ajailoff(user, args)
{
	new name[MAX_PLAYER_NAME], reason[128], query[300], time, string[1024], rows;
	if(sscanf(args, "s[24]ds[512]", name, time, reason)) return SendDC(CHANNEL_ID, "**USE:** `!ajailoff [nome] [tempo] [motivo]`");
	mysql_format(Database, query, sizeof(query), "SELECT `Username` FROM `players` WHERE `Username` = '%e' LIMIT 0,1", name);
	new Cache:result = mysql_query(Database, query);
	cache_get_row_count(rows);

	if(!rows) return SendDC(CHANNEL_ID, "**ERRO:** Este usúario não existe!");
	
	if(time < 1) return SendDC(CHANNEL_ID, "**ERRO:** Você não pode prender um jogador por menos de um minuto!");

	for (new i = 0; i < rows; i ++)
	{
		mysql_format(Database, query, sizeof(query), "UPDATE `players` SET `Jailed` = '%i', `JailedTime` = '%i' WHERE `Username` = '%e'", 1, time, name);
		mysql_tquery(Database, query);
        
		format(string, sizeof(string), "DiscordCmd: %s foi preso off-line por %s por %d minutos, motivo: %s.", name, user, time, reason);
		SendClientMessageToAll(COLOR_LIGHTRED, string);
		
        format(string, sizeof(string), " `LOG-AJAILDC:` [%s] **%s** prendeu **%s** na prisão administrativa enquanto off-line por **%d minutos**, motivo: **%s**. ", ReturnDate(), user, name, time, reason);
        DCC_SendChannelMessage(DC_LogAdmin, string);
	}
	cache_delete(result);
	return 1;
}


stock dc_OnPlayerConnect(playerid)
{
    if (_:DC_Logs1 == 0) // Info Logs
    DC_Logs1 = DCC_FindChannelById("745332395472846848"); 
 
    if (_:DC_Logs2 == 0) // Logs de interpretação
    DC_Logs2 = DCC_FindChannelById("745366696616788039"); 

    if (_:DC_Logs3 == 0) // /A
    DC_Logs3 = DCC_FindChannelById("745322875287765043"); 

    if (_:DC_LogAdmin == 0) // ADMINLOG
    DC_LogAdmin = DCC_FindChannelById("745420881144316025"); 

    if (_:DC_LogFac == 0) // FACTIONLOG
    DC_LogFac = DCC_FindChannelById("745736465958305802"); 

    new string[128];
    format(string, sizeof string, " `LOG-CONNECT:` [%s] **%s** *(%s)* entrou no servidor.", ReturnDate(), pNome(playerid), ReturnIP(playerid));
    DCC_SendChannelMessage(DC_Logs1, string);
    return 1;
}

stock dc_OnPlayerDisconnect(playerid)
{
    if (_:DC_Logs1 == 0)
    DC_Logs1 = DCC_FindChannelById("745332395472846848"); 

    if (_:DC_Logs2 == 0)
    DC_Logs2 = DCC_FindChannelById("745366696616788039"); 

    if (_:DC_Logs3 == 0) // /A
    DC_Logs3 = DCC_FindChannelById("745322875287765043"); 
 
    if (_:DC_LogAdmin == 0) // ADMINLOG
    DC_LogAdmin = DCC_FindChannelById("745420881144316025"); 

    if (_:DC_LogFac == 0) // FACTIONLOG
    DC_LogFac = DCC_FindChannelById("745736465958305802"); 

    new string[128];
    format(string, sizeof string, " `LOG-DISCONNECT:` [%s] **%s** (%s) saiu do servidor.", ReturnDate(), pNome(playerid), ReturnIP(playerid));
    DCC_SendChannelMessage(DC_Logs1, string);
    return 1;
}