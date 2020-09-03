#include <a_samp>

new Platform[MAX_PLAYERS];
new AirTimer[MAX_PLAYERS];
new porcovoando;
new bool:toggle[MAX_PLAYERS];

#define HOLDING(%0) \
	((newkeys & (%0)) == (%0))
	
#define RELEASED(%0) \
	(((newkeys & (%0)) != (%0)) && ((oldkeys & (%0)) == (%0)))

stock air_OnGMExit()
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	if(IsValidPlayerObject(i,Platform[i])) DestroyPlayerObject(i,Platform[i]);
	return 1;
}

stock air_OnPlayerDisconnect(playerid)
{
    toggle[playerid] = false;
    porcovoando = -1;
    if(AirTimer[playerid] != -1)
	{
	    KillTimer(AirTimer[playerid]);
	    AirTimer[playerid] = -1;
        porcovoando = -1;
		DestroyPlayerObject(playerid,Platform[playerid]);
	}
	return 1;
}

stock air_OnPlayerDeath(playerid)
{
    toggle[playerid] = false;
    if(AirTimer[playerid] != -1)
	{
	    KillTimer(AirTimer[playerid]);
	    AirTimer[playerid] = -1;
		DestroyPlayerObject(playerid,Platform[playerid]);
	}
	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
    if(porcovoando > 0)
    {
        toggle[playerid] = false;
	    KillTimer(AirTimer[playerid]);
	    AirTimer[playerid] = -1;
        porcovoando = -1;
		DestroyPlayerObject(playerid,Platform[playerid]);
        SendServerMessage(playerid, "Você pulou de um carro em modo de vôo ativado, desativando essa merda.");
    }
    return 1;
}

CMD:porcovoador(playerid, params[])
{
    if(!IsPlayerInAnyVehicle(playerid))
        return SendErrorMessage(playerid, "Você não é o Super Man para voar, bobinho.");
        
    if(porcovoando < 1)
    {
        new Float:AirX, Float:AirY, Float:AirZ,Float:AirA; GetPlayerPos(playerid,AirX,AirY,AirZ); GetPlayerFacingAngle(playerid,AirA);
        Platform[playerid] = CreatePlayerObject(playerid,8355,AirX,180,AirZ-0.91,0,0,AirA,50.0);
        for(new i; i< 10; i++) { SetPlayerObjectMaterial(playerid, Platform[playerid], i, 0, "none", "none", HexToInt("0xRRGGBB00")); }
        AirTimer[playerid] = SetTimerEx("UpdateAirObject", 500, true, "i", playerid);
        porcovoando = 1;
        toggle[playerid] = true;
        SendServerMessage(playerid, "Modo de vôo ativado!");
    }
    else
    {
	    toggle[playerid] = false;
	    KillTimer(AirTimer[playerid]);
	    AirTimer[playerid] = -1;
        porcovoando = -1;
		DestroyPlayerObject(playerid,Platform[playerid]);
        SendServerMessage(playerid, "Modo de vôo desativado!");
    }
    return 1;
}


forward UpdateAirObject(playerid);
public UpdateAirObject(playerid)
{
    new Float:AirX, Float:AirY, Float:AirZ,Float:AirA;
	if(IsPlayerInAnyVehicle(playerid))
	{
	    GetPlayerPos(playerid,AirX,AirY,AirZ); GetVehicleZAngle(GetPlayerVehicleID(playerid),AirA);
	    if(toggle[playerid] == true)
	    {
			SetPlayerObjectPos(playerid,Platform[playerid],AirX,AirY,AirZ-0.7);
			SetPlayerObjectRot(playerid,Platform[playerid],0.0,180.0,AirA);
		}
		else
		{
			SetPlayerObjectPos(playerid,Platform[playerid],AirX,AirY,AirZ-7.0);
			SetPlayerObjectRot(playerid,Platform[playerid],0.0,180.0,AirA);
		}
	}
	return 1;
}

stock air_OnPKSC(playerid, newkeys, oldkeys)
{
    new Float:AirX,Float:AirY,Float:AirZ;
	if(newkeys == KEY_YES)
	{
		if(IsPlayerInAnyVehicle(playerid))
		{
		    GetVehicleVelocity(GetPlayerVehicleID(playerid),AirX,AirY,AirZ);
		    SetVehicleVelocity(GetPlayerVehicleID(playerid),AirX,AirY,AirZ+0.2);
	 	}
	 	return 1;
 	}
 	else if(HOLDING(KEY_NO) && IsPlayerInAnyVehicle(playerid))
	{
		toggle[playerid] = false;
 	}
 	else if(RELEASED(KEY_NO) && IsPlayerInAnyVehicle(playerid))
	{
		toggle[playerid] = true;
		RepairVehicle(GetPlayerVehicleID(playerid));
 	}
	return 1;
}

stock HexToInt(string[])
{
    if (string[0] == 0)
    {
        return 0;
    }
    new i;
    new cur = 1;
    new res = 0;
    for (i = strlen(string); i > 0; i--)
    {
        if (string[i-1] < 58)
        {
            res = res + cur * (string[i - 1] - 48);
        }
        else
        {
            res = res + cur * (string[i-1] - 65 + 10);
            cur = cur * 16;
        }
    }
    return res;
}
