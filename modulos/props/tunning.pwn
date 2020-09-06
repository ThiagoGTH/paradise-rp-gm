#define MODEL_SELECTION_WHEELS (15)

stock tune_OnMSR(playerid, extraid, modelid, response)
{
    if ((response) && (extraid == MODEL_SELECTION_WHEELS))
	{
        new vehicleid = GetPlayerVehicleID(playerid);

		if (!IsPlayerInAnyVehicle(playerid) || !IsDoorVehicle(vehicleid))
	    	return 0;

	    AddComponent(vehicleid, modelid);
	    SendServerMessage(playerid, "Você adicionou as rodas de modelo \"%s\" neste veículo.", GetWheelName(modelid));
	}
    return 1;
}

CMD:atunar(playerid, params[])
{
    if (PlayerInfo[playerid][user_admin] < 4)
	    return SendErrorMessage(playerid, "Você não possui permissão para utilizar esse comando.");

	if (!IsPlayerInAnyVehicle(playerid))
	    return SendErrorMessage(playerid, "Você não está em nenhum veículo.");

	if (!IsDoorVehicle(GetPlayerVehicleID(playerid)))
	    return SendErrorMessage(playerid, "Você não pode tunar este veículo.");

	Dialog_Show(playerid, TuneVehicle, DIALOG_STYLE_LIST, "Modificar Veículo", "Adicionar rodas\nAdicionar NOS\nAdicionar hidraulica", "Selecionar", "Cancelar");
	return 1;
}

CMD:apintarcarro(playerid, params[])
{
	static
	    color1,
	    color2;

    if (PlayerInfo[playerid][user_admin] < 4)
	    return SendErrorMessage(playerid, "Você não possui permissão para utilizar esse comando.");

	if (!IsPlayerInAnyVehicle(playerid))
	    return SendErrorMessage(playerid, "Você não está em nenhum veículo.");

	if (sscanf(params, "dd", color1, color2))
	    return SendSyntaxMessage(playerid, "/apintarcarro [cor 1] [cor 2]");

	if (color1 < 0 || color1 > 255)
	    return SendErrorMessage(playerid, "A primeira cor não pode ser menor que 0 ou maior que 255.");

    if (color2 < 0 || color2 > 255)
	    return SendErrorMessage(playerid, "A segunda cor não pode ser menor que 0 ou maior que 255.");

	SetVehicleColor(GetPlayerVehicleID(playerid), color1, color2);
	SendServerMessage(playerid, "Você mudou as cores deste veículo para %d, %d.", color1, color2);
	return 1;
}

CMD:apaintjob(playerid, params[])
{
	static
	    paintjobid;

    if (PlayerInfo[playerid][user_admin] < 4)
	    return SendErrorMessage(playerid, "Você não possui permissão para utilizar esse comando.");

	if (!IsPlayerInAnyVehicle(playerid))
	    return SendErrorMessage(playerid, "Você não está em nenhum veículo.");

	if (sscanf(params, "d", paintjobid))
	    return SendSyntaxMessage(playerid, "/apaintjob [paintjob ID] (-1 para desativar)");

	if (paintjobid < -1 || paintjobid > 5)
	    return SendErrorMessage(playerid, "O paintjob não pode ser menor que -1 ou maior que 5.");

	if (paintjobid == -1)
		paintjobid = 6;

	SetVehiclePaintjob(GetPlayerVehicleID(playerid), paintjobid);
	SendServerMessage(playerid, "Você mudou o paintjob para o ID %d.", paintjobid);
	return 1;
}

Dialog:TuneVehicle(playerid, response, listitem, inputtext[])
{
	new vehicleid = GetPlayerVehicleID(playerid);

	if (!IsPlayerInAnyVehicle(playerid) || !IsDoorVehicle(vehicleid))
	    return 0;

	if (response)
	{
	    switch (listitem)
	    {
	        case 0:
	            ShowModelSelectionMenu(playerid, "Adicionar rodas", MODEL_SELECTION_WHEELS, {1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1096, 1097, 1098}, 17, 0.0, 0.0, 90.0);

			case 1:
			    Dialog_Show(playerid, AddNOS, DIALOG_STYLE_LIST, "Adicionar NOS", "2x NOS\n5x NOS\n10x NOS", "Selecionar", "Cancelar");

			case 2:
			{
			    AddComponent(vehicleid, 1087);
			    SendServerMessage(playerid, "Você adicionou hidraulica nesse veículo.");
			}
	    }
	}
	return 1;
}

Dialog:AddNOS(playerid, response, listitem, inputtext[])
{
	new vehicleid = GetPlayerVehicleID(playerid);

	if (!IsPlayerInAnyVehicle(playerid) || !IsDoorVehicle(vehicleid))
	    return 0;

	if (response)
	{
	    switch (listitem)
	    {
	        case 0:
			{
			    AddComponent(vehicleid, 1009);
			    SendServerMessage(playerid, "Você adicionou 2x NOS neste veículo.");
			}
			case 1:
			{
			    AddComponent(vehicleid, 1008);
			    SendServerMessage(playerid, "Você adicionou 5x NOS neste veículo.");
			}
            case 2:
			{
			    AddComponent(vehicleid, 1010);
			    SendServerMessage(playerid, "Você adicionou 10x NOS neste veículo.");
			}
		}
	}
	return 1;
}

stock GetWheelName(componentid)
{
	new
		name[12];

	enum g_eWheelData {
	    g_eWheelModel,
	    g_eWheelName[12 char]
	};

	new const g_aWheelData[][g_eWheelData] = {
	    {1025, !"Offroad"},
	    {1073, !"Shadow"},
	    {1074, !"Mega"},
	    {1075, !"Rimshine"},
	    {1076, !"Wires"},
	    {1077, !"Classic"},
	    {1078, !"Twist"},
	    {1079, !"Cutter"},
	    {1080, !"Switch"},
	    {1081, !"Grove"},
	    {1082, !"Import"},
	    {1083, !"Dollar"},
	    {1084, !"Trance"},
	    {1085, !"Atomic"},
	    {1096, !"Ahab"},
	    {1097, !"Virtual"},
	    {1098, !"Access"}
	};
	for (new i = 0; i < sizeof(g_aWheelData); i ++) if (g_aWheelData[i][g_eWheelModel] == componentid) {
	    strunpack(name, g_aWheelData[i][g_eWheelName]);

	    return name;
	}
	strunpack(name, !"Desconhecida");
	return name;
}
