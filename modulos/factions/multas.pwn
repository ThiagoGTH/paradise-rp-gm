#define MAX_PLAYER_TICKETS (10)
enum ticketData {
	ticketID,
	ticketExists,
	ticketFee,
	ticketDate[36],
	ticketReason[64]
};
new TicketData[MAX_PLAYERS][MAX_PLAYER_TICKETS][ticketData];



forward OnPlayerLoadTickets(playerid);
public OnPlayerLoadTickets(playerid)
{
    static
	    rows;
	cache_get_row_count(rows);

	for (new i = 0; i < rows && i < MAX_PLAYER_TICKETS; i ++) 
    {
		cache_get_value_name(i, "ticketReason", TicketData[playerid][i][ticketReason]);
	    cache_get_value_name(i, "ticketDate", TicketData[playerid][i][ticketDate]);
        TicketData[playerid][i][ticketExists] = true;
        cache_get_value_name_int(i, "ticketID", TicketData[playerid][i][ticketID]);
		cache_get_value_name_int(i, "ticketFee", TicketData[playerid][i][ticketFee]);
	}
    return 1;
}

Ticket_Add(suspectid, price, reason[])
{
	new
	    string[160];

	for (new i = 0; i != MAX_PLAYER_TICKETS; i ++) if (!TicketData[suspectid][i][ticketExists])
	{
	    TicketData[suspectid][i][ticketExists] = true;
	    TicketData[suspectid][i][ticketFee] = price;

	    format(TicketData[suspectid][i][ticketDate], 36, ReturnDate());
	    format(TicketData[suspectid][i][ticketReason], 64, reason);

		format(string, sizeof(string), "INSERT INTO `tickets` (`ID`, `ticketFee`, `ticketDate`, `ticketReason`) VALUES('%d', '%d', '%s', '%s')", PlayerInfo[suspectid][user_id], price, TicketData[suspectid][i][ticketDate], SQL_ReturnEscaped(reason));
		mysql_tquery(Database, string, "OnTicketCreated", "d", suspectid, i);

		return i;
	}
	return -1;
}

Ticket_Remove(playerid, ticketid)
{
	if (ticketid != -1 && TicketData[playerid][ticketid][ticketExists])
	{
	    new
	        string[90];

		format(string, sizeof(string), "DELETE FROM `tickets` WHERE `ID` = '%d' AND `ticketID` = '%d'", PlayerInfo[playerid][user_id], TicketData[playerid][ticketid][ticketID]);
		mysql_tquery(Database, string);

	    TicketData[playerid][ticketid][ticketExists] = false;
	    TicketData[playerid][ticketid][ticketID] = 0;
	    TicketData[playerid][ticketid][ticketFee] = 0;
	}
	return 1;
}

forward OnTicketCreated(playerid, ticketid);
public OnTicketCreated(playerid, ticketid)
{
	TicketData[playerid][ticketid][ticketID] = cache_insert_id();
	return 1;
}

CMD:multar(playerid, params[])
{
	static
	    userid,
	    price,
	    reason[64];

	if (GetFactionType(playerid) != FACTION_POLICE)
		return SendErrorMessage(playerid, "Você precisa ser de uma facção policial para poder utilizar esse comando.");

	if (sscanf(params, "uds[64]", userid, price, reason))
		return SendSyntaxMessage(playerid, "/multar [playerid/nome] [valor] [motivo]");

	if (userid == INVALID_PLAYER_ID || !IsPlayerNearPlayer(playerid, userid, 5.0))
	    return SendErrorMessage(playerid, "Este jogador está desconectado ou não está perto de você.");

	if (userid == playerid)
	    return SendErrorMessage(playerid, "Você não pode escrever uma multa pra si mesmo.");

	if (price < 1 || price > 10000)
	    return SendErrorMessage(playerid, "O valor não pode ser menor que $1 ou maior que $10,000.");

	new id = Ticket_Add(userid, price, reason);

	if (id != -1) {
	    SendServerMessage(playerid, "Você escreveu uma multa para %s no valor de %s, motivo: %s", pNome(userid), FormatNumber(price), reason);
	    SendServerMessage(userid, "%s escreveu uma multa para você no valor de %s, motivo: %s", pNome(playerid), FormatNumber(price), reason);

	    SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s escreveu uma multa para %s.", pNome(playerid), pNome(userid));
	    //Log_Write("logs/ticket_log.txt", "[%s] %s has written a %s ticket to %s, reason: %s", ReturnDate(), pNome(playerid), FormatNumber(price), pNome(userid), reason);
	}
	else {
	    SendErrorMessage(playerid, "Este jogador já possui %d multas não pagas.", MAX_PLAYER_TICKETS);
	}
	return 1;
}

Dialog:MyTickets(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    if (!TicketData[playerid][listitem][ticketExists])
	        return SendErrorMessage(playerid, "Não há nenhuma multa neste slot.");

		if (GetMoney(playerid) < TicketData[playerid][listitem][ticketFee])
		    return SendErrorMessage(playerid, "Você não possui dinheiro para pagar essa multa.");

		GiveMoney(playerid, -TicketData[playerid][listitem][ticketFee]);
        Tax_AddMoney(TicketData[playerid][listitem][ticketFee]);

		SendServerMessage(playerid, "Você pagou uma multa no valor de %s pelo motivo \"%s\".", FormatNumber(TicketData[playerid][listitem][ticketFee]), TicketData[playerid][listitem][ticketReason]);
		Ticket_Remove(playerid, listitem);
	}
	return 1;
}

CMD:multas(playerid, params[])
{
	static
	    string[MAX_PLAYER_TICKETS * 64];

	/*if (!IsPlayerInRangeOfPoint(playerid, 3.0, 361.2687, 171.5613, 1008.3828))
	    return SendErrorMessage(playerid, "Você precisa estar na prefeitura para pagar suas multas.");*/

	string[0] = 0;

	for (new i = 0; i < MAX_PLAYER_TICKETS; i ++)
	{
	    if (TicketData[playerid][i][ticketExists])
	        format(string, sizeof(string), "%s%s (%s - %s)\n", string, TicketData[playerid][i][ticketReason], FormatNumber(TicketData[playerid][i][ticketFee]), TicketData[playerid][i][ticketDate]);

		else format(string, sizeof(string), "%sSlot vazio\n", string);
	}
	return Dialog_Show(playerid, MyTickets, DIALOG_STYLE_LIST, "Minhas multas", string, "Pagar", "Cancelar");
}