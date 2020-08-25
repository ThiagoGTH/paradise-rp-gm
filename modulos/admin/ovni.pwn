new
	ShipObject[MAX_VEHICLES] = {INVALID_OBJECT_ID, ...};

stock Ovni_OnGameModeExit()
{
	for(new i; i < MAX_VEHICLES; ++i)
	{
	    if(IsValidVehicle(i) && IsValidObject(ShipObject[i]))
	    {
	        DestroyVehicle(i);
	        DestroyObject(ShipObject[i]);
	        ShipObject[i] = INVALID_OBJECT_ID;
	    }
	}

	return 1;
}

CMD:ovni(playerid, params[])
{
	if(PlayerInfo[playerid][user_logged] == 0) return SendClientMessage(playerid, COLOR_GRAD1, "Você não está logado.");
    if(PlayerInfo[playerid][user_admin] < 4) return SendClientMessage(playerid, COLOR_GREY, "Você não possui autorização para utilizar esse comando.");
    if (PlayerInfo[playerid][user_admin] < 4 && !AdminTrabalhando[playerid])
    return SendClientMessage(playerid, COLOR_LIGHTRED, "ERRO: Você deve usar o comando /atrabalho antes.");
	if(IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, COLOR_LIGHTRED, "ERRO: Você não pode utilizar este comando dentro de um veículo.");
	if(GetPlayerInterior(playerid) > 0) return SendClientMessage(playerid, COLOR_LIGHTRED, "ERRO: Você não pode utilizar este comando dentro de um interior.");
	new Float: x, Float: y, Float: z, Float: a;
	GetPlayerPos(playerid, x, y, z);
	GetPlayerFacingAngle(playerid, a);
	new id = CreateVehicle(501, x, y, z, a, 1, 1, -1);
  	LinkVehicleToInterior(id, 1);
	ShipObject[id] = CreateObject(18846, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
	AttachObjectToVehicle(ShipObject[id], id, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
	PutPlayerInVehicle(playerid, id, 0);
	SendClientMessage(playerid, COLOR_GREY, "Você entrou em um OVNI, para sair digite: /ovnisair.");
	return 1;
}

CMD:ovnisair(playerid, params[])
{
	if(PlayerInfo[playerid][user_logged] == 0) return SendClientMessage(playerid, COLOR_GRAD1, "Você não está logado.");
    if(PlayerInfo[playerid][user_admin] < 4) return SendClientMessage(playerid, COLOR_GREY, "Você não possui autorização para utilizar esse comando.");
    if (PlayerInfo[playerid][user_admin] < 4 && !AdminTrabalhando[playerid])
    return SendClientMessage(playerid, COLOR_LIGHTRED, "ERRO: Você deve usar o comando /atrabalho antes.");

	//if(IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, COLOR_LIGHTRED, "ERRO: Você não pode utilizar este comando se não estiver em um veículo.");
	if(!IsValidObject(ShipObject[ GetPlayerVehicleID(playerid) ])) return SendClientMessage(playerid, COLOR_LIGHTRED, "ERRO: Você não está utilizando um OVNI.");
	new id = GetPlayerVehicleID(playerid);
	DestroyVehicle(id);
	DestroyObject(ShipObject[id]);
	ShipObject[id] = INVALID_OBJECT_ID;
	return 1;
}

stock ovni_OnVehicleDeath(vehicleid)
{
	if(IsValidObject(ShipObject[vehicleid]))
	{
	    DestroyVehicle(vehicleid);
	    DestroyObject(ShipObject[vehicleid]);
	    ShipObject[vehicleid] = INVALID_OBJECT_ID;
	}
	return 1;
}