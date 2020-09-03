stock ViewCharges(playerid, name[])
{
	new
	    string[128];

	format(string, sizeof(string), "SELECT * FROM `warrants` WHERE `Suspect` = '%s' ORDER BY `ID` DESC", SQL_ReturnEscaped(name));
	mysql_tquery(Database, string, "OnViewCharges", "ds", playerid, name);
	return 1;
}

stock AddWarrant(targetid, playerid, const description[])
{
	new
	    string[255];

	format(string, sizeof(string), "INSERT INTO `warrants` (`Suspect`, `Username`, `Date`, `Description`) VALUES('%s', '%s', '%s', '%s')", ReturnName(targetid), ReturnName(playerid), ReturnDate(), SQL_ReturnEscaped(description));
	mysql_tquery(Database, string);
}

forward OnViewCharges(extraid, name[]);
public OnViewCharges(extraid, name[])
{
	if (GetFactionType(extraid) != FACTION_POLICE)
	    return 0;

	static
	    rows,
	    fields;

	cache_get_data(rows, fields, Database);

	if (!rows)
	    return SendErrorMessage(extraid, "No results found for charges on \"%s\".", name);

	static
	    string[1024],
		desc[128],
		date[36];

	string[0] = 0;

	for (new i = 0; i < rows; i ++) {
	    cache_get_field_content(i, "Description", desc, Database);
	    cache_get_field_content(i, "Date", date, Database);

	    format(string, sizeof(string), "%s%s (%s)\n", string, desc, date);
	}
	format(desc, sizeof(desc), "Charges: %s", name);
	Dialog_Show(extraid, ChargeList, DIALOG_STYLE_LIST, desc, string, "Close", "");
	return 1;
}

Dialog:MainMDC(playerid, response, listitem, inputtext[])
{
	if (GetFactionType(playerid) != FACTION_POLICE || !IsACruiser(GetPlayerVehicleID(playerid)))
	    return 0;

	if (response)
	{
	    switch (listitem)
	    {
	        case 0:
	        {
	            static
	                string[512];

				string[0] = 0;

				foreach (new i : Player) if (PlayerInfo[i][pWarrants] > 0) {
				    format(string, sizeof(string), "%s%s (%d warrants)\n", string, pNome(i), PlayerInfo[i][pWarrants]);
				}
				if (!strlen(string))
				    return SendErrorMessage(playerid, "There are no active warrants.");

				Dialog_Show(playerid, Warrants, DIALOG_STYLE_LIST, "Active Warrants", string, "Select", "Back");
    		}
    		case 1:
    		{
    		    Dialog_Show(playerid, ChargeName, DIALOG_STYLE_INPUT, "Place Charges", "Please enter the name or ID of the player:", "Submit", "Back");
			}
			case 2:
    		{
    		    Dialog_Show(playerid, ViewCharges, DIALOG_STYLE_INPUT, "View Charges", "Please enter the name or ID of the player:", "Submit", "Back");
			}
	    }
	}
	return 1;
}


Dialog:ChargeName(playerid, response, listitem, inputtext[])
{
	if (GetFactionType(playerid) != FACTION_POLICE || !IsACruiser(GetPlayerVehicleID(playerid)))
	    return 0;

	if (response)
	{
	    new targetid;

	    if (sscanf(inputtext, "u", targetid))
	        return Dialog_Show(playerid, ChargeName, DIALOG_STYLE_INPUT, "Place Charges", "Error: Please enter a valid user.\n\nPlease enter the name or ID of the player:", "Submit", "Back");

		if (targetid == INVALID_PLAYER_ID)
		    return Dialog_Show(playerid, ChargeName, DIALOG_STYLE_INPUT, "Place Charges", "Error: Invalid user specified.\n\nPlease enter the name or ID of the player:", "Submit", "Back");

        if (PlayerInfo[targetid][pWarrants] > 14)
		    return Dialog_Show(playerid, ChargeName, DIALOG_STYLE_INPUT, "Place Charges", "Error: The user already has 15 active warrants.\n\nPlease enter the name or ID of the player:", "Submit", "Back");

		PlayerInfo[playerid][pMDCPlayer] = targetid;
		Dialog_Show(playerid, PlaceCharge, DIALOG_STYLE_INPUT, "Place Charge", "Please enter the description of the crime committed by %s:", "Submit", "Back", ReturnName(PlayerInfo[playerid][pMDCPlayer], 0));
	}
	else cmd_mdc(playerid, "\1");
	return 1;
}

Dialog:PlaceCharge(playerid, response, listitem, inputtext[])
{
	if (GetFactionType(playerid) != FACTION_POLICE || !IsACruiser(GetPlayerVehicleID(playerid)) || PlayerInfo[playerid][pMDCPlayer] == INVALID_PLAYER_ID)
	    return 0;

	if (response)
	{
	    if (isnull(inputtext))
			return Dialog_Show(playerid, PlaceCharge, DIALOG_STYLE_INPUT, "Place Charge", "Please enter the description of the crime committed by %s:", "Submit", "Back", ReturnName(PlayerInfo[playerid][pMDCPlayer], 0));

	    PlayerInfo[PlayerInfo[playerid][pMDCPlayer]][pWarrants]++;

	    AddWarrant(PlayerInfo[playerid][pMDCPlayer], playerid, inputtext);
	    SendFactionMessage(PlayerInfo[playerid][pFaction], COLOR_RADIO, "RADIO: %s has placed a charge on %s for \"%s\".", pNome(playerid), ReturnName(PlayerInfo[playerid][pMDCPlayer], 0), inputtext);

	    cmd_mdc(playerid, "\1");
	}
	else
	{
	    PlayerInfo[playerid][pMDCPlayer] = INVALID_PLAYER_ID;
	    cmd_mdc(playerid, "\1");
	}
	return 1;
}

Dialog:ViewCharges(playerid, response, listitem, inputtext[])
{
	if (GetFactionType(playerid) != FACTION_POLICE || !IsACruiser(GetPlayerVehicleID(playerid)))
	    return 0;

	if (response)
	{
		if (isnull(inputtext) || strlen(inputtext) > 24)
		    return Dialog_Show(playerid, ViewCharges, DIALOG_STYLE_INPUT, "View Charges", "Please enter the name or ID of the player:", "Submit", "Back");

		if (IsNumeric(inputtext) && IsPlayerConnected(strval(inputtext))) {
	        ViewCharges(playerid, ReturnName(strval(inputtext)));
		}
	    else if (!IsNumeric(inputtext)) {
	        ViewCharges(playerid, inputtext);
		}
		else {
		    Dialog_Show(playerid, ViewCharges, DIALOG_STYLE_INPUT, "View Charges", "Error: Invalid user specified.\n\nPlease enter the name or ID of the player:", "Submit", "Back");
		}
	}
	else cmd_mdc(playerid, "\1");
	return 1;
}

CMD:mdc(playerid, params[])
{
    if (GetFactionType(playerid) != FACTION_POLICE)
		return SendErrorMessage(playerid, "You must be a police officer.");

	if (!IsACruiser(GetPlayerVehicleID(playerid)))
	    return SendErrorMessage(playerid, "You must be inside a police cruiser.");

	Dialog_Show(playerid, MainMDC, DIALOG_STYLE_LIST, "Mobile Data Computer", "Active Warrants\nPlace Charges\nView Charges", "Select", "Cancel");
	return 1;
}