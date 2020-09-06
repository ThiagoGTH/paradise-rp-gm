CMD:stats(playerid, params[])
{
	ShowStatsForPlayer(playerid, playerid);
	return 1;
}

CMD:checkstats(playerid, params[])
{
    static
	    userid;

    if (PlayerInfo[playerid][user_admin] < 2)
	    return SendErrorMessage(playerid, "Você não possui autorização para utilizar esse comando.");

	if (sscanf(params, "u", userid))
	    return SendSyntaxMessage(playerid, "/checkstats [playerid/nome]");

    if (userid == INVALID_PLAYER_ID)
	    return SendErrorMessage(playerid, "Você específicou um jogador inválido.");

	if (!PlayerInfo[userid][user_logged])
	    return SendErrorMessage(playerid, "Esse jogador ainda não está online.");

	ShowStatsForPlayer(playerid, userid);
	return 1;
}

ShowStatsForPlayer(playerid, targetid)
{
    new string[256];
    new origin[32];
	new hora, minuto, segundo, dia, mes, ano;
	getdate(ano, mes, dia);
	gettime(hora, minuto, segundo); 
    new Float:plrtempheal;
	new Float:plrarmour;
    GetPlayerArmour(targetid, plrarmour);
	GetPlayerHealth(targetid, plrtempheal);
    new level = PlayerInfo[targetid][user_score];
    new jogatina = PlayerInfo[targetid][pPlayingHours];
    new paycheck = PlayerInfo[targetid][pPaycheck];

    new atext[20];
    if(PlayerInfo[targetid][pGender] == 1) { atext = "Masculino"; }
    else if(PlayerInfo[targetid][pGender] == 2) { atext = "Feminino"; }
    else { atext = "Desconhecido"; }

    format(origin, 32, "%.16s", PlayerInfo[targetid][pOrigin]);
	if (strlen(PlayerInfo[targetid][pOrigin]) > 16)
	strcat(origin, "...");

    format(string, sizeof (string), "> Estatísticas de %s < [%d:%d:%d - %d/%d/%d]",pNome(targetid), hora, minuto, segundo, dia, mes, ano);
    SendClientMessage(playerid, COLOR_GREEN, string);
    format(string, sizeof(string), "CONTA > Usuário: %s | Vida: %0.2f/100.0 | Colete: %0.2f/100.0 | Respeitos: 0/0", pNome(targetid), plrtempheal, plrarmour);
    SendClientMessage(playerid, COLOR_GREY, string);
    format(string, sizeof(string), "CONTA > Horas Jogadas: %d | Nível: %d", jogatina, level);
    SendClientMessage(playerid, COLOR_GREY, string);
    format(string, sizeof(string), "PERSONAGEM > Sexo: %s | Nascimento: %s | Origem: %s", atext, PlayerInfo[targetid][pBirthdate], origin);
    SendClientMessage(playerid, COLOR_GREY, string);
    format(string, sizeof(string), "PERSONAGEM > Dinheiro: %s | Banco: N/A | Paycheck a receber: %s", formatInt(PlayerInfo[targetid][user_cash]), formatInt(paycheck));
    SendClientMessage(playerid, COLOR_GREY, string);
    if(PlayerInfo[targetid][pFaction] != -1)
    {
        format(string, sizeof(string), "FACÇÃO > Facção: '%s' | Rank: '%s'", FactionData[PlayerInfo[targetid][pFaction]][factionName], Faction_GetRank(targetid));
        SendClientMessage(playerid, COLOR_GREY, string);
        return 1;
    }

    /*format(string, sizeof(string), "PERSONAGEM > Arma na mão: '%s' Munição: '%d'  Numeração '%d'.", ReturnWeaponName(ArmaData[armaid][ArmaModelo]), ammo, ArmaData[armaid][ArmaNumeracao]);
    SendClientMessage(playerid, COLOR_GREY, string);
    format(string, sizeof(string), "PERSONAGEM > Arma no corpo: '%s' Munição: '%d'  Numeração '%d'.", ReturnWeaponName(ArmaData[armaid2][ArmaModelo]), PlayerInfo[playerid][pAmmo][6], ArmaData[armaid2][ArmaNumeracao]);
    SendClientMessage(playerid, COLOR_GREY, string);*/
    return 1;
}
