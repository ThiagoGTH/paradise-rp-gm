new Injured[MAX_PLAYERS];
new AcceptDeath[MAX_PLAYERS];
new AcceptDeathTimer[MAX_PLAYERS];
new LoseHealthTimer[MAX_PLAYERS];
new Hospitalized[MAX_PLAYERS];
new Float:exx, Float:exy, Float:exz;
new Float:exangle;
new exinterior;
new exworld;
new deathskin;

forward CanAcceptDeath(playerid);
public CanAcceptDeath(playerid)
{
    AcceptDeath[playerid] = 1;
	SendClientMessage(playerid, COLOR_YELLOW, "Você pode aceitar a morte a partir de agora. (( /aceitarmorte ))");
}

forward HospitalTimer(playerid);
public HospitalTimer(playerid)
{
    Hospitalized[playerid] = 0;
	SendClientMessage(playerid, -1, "Você se recuperou no All Saints General Hospital.");
	SetPlayerPos(playerid, 1178.4012, -1323.2754, 14.1183);
	SetPlayerFacingAngle(playerid, 270.0);
	SetCameraBehindPlayer(playerid);
	SetPlayerHealth(playerid, 100.0);
	TogglePlayerControllable(playerid, 1);
}

forward LoseHealth(playerid);
public LoseHealth(playerid)
{
    new Float:health;
	GetPlayerHealth(playerid,health);
	SetPlayerHealth(playerid,health-5);
}

stock inj_OnPlayerUpdate(playerid)
{
	if (Injured[playerid] == 1 && GetPlayerAnimationIndex(playerid) != 386)
	{
		ApplyAnimation(playerid, "CRACK", "crckdeth2", 4.0, 1, 0, 0, 1, 0, 1);
	}
	return 1;
}

stock inj_OnPlayerDeath(playerid)
{
	if (Injured[playerid] == 0)
	{
    	TogglePlayerControllable(playerid, 0);
        GetPlayerPos(playerid, exx, exy, exz);
	    GetPlayerFacingAngle(playerid, exangle);
		exinterior = GetPlayerInterior(playerid);
		exworld = GetPlayerVirtualWorld(playerid);
        deathskin = GetPlayerSkinID(playerid);
		Injured[playerid] = 1;
	}
	else if (Injured[playerid] == 1)
	{
		KillTimer(AcceptDeathTimer[playerid]);
	    KillTimer(LoseHealthTimer[playerid]);
		AcceptDeath[playerid] =	 0;
		Injured[playerid] = 0;
		Hospitalized[playerid] = 1;
	}
	return 1;
}

stock inj_OnPlayerSpawn(playerid)
{
	if (PlayerInfo[playerid][pBleeding])
	{
 		PlayerInfo[playerid][pBleedTime] = 1;
   	}
	if (Injured[playerid] == 1)
	{
		TogglePlayerControllable(playerid, 0);
		SetPlayerPos(playerid, exx, exy, exz);
		SetPlayerFacingAngle(playerid, exangle);
        SetPlayerInterior(playerid, exinterior);
        SetPlayerVirtualWorld(playerid, exworld);
        SetPlayerSkin(playerid, deathskin);
		SetCameraBehindPlayer(playerid);
		SendClientMessage(playerid, COLOR_LIGHTRED, "Você está ferido, espere por ajuda ou digite /aceitarmorte.");
		AcceptDeathTimer[playerid] = SetTimer("CanAcceptDeath", 60000, false);
		LoseHealthTimer[playerid] = SetTimer("LoseHealth", 10000, true);

		ApplyAnimation(playerid, "CRACK", "null", 4.0, 0, 0, 0, 1, 0, 1);
		ApplyAnimation(playerid, "CRACK", "crckdeth4", 4.0, 0, 0, 0, 1, 0, 1);
	}
	
	if (Hospitalized[playerid] == 1)
	{
		SetTimer("HospitalTimer", 10000, false);
		TogglePlayerControllable(playerid, 0);
		SetPlayerPos(playerid, 1169.9645, -1323.8893, 15.6929);
		SetPlayerCameraPos(playerid, 1201.5150, -1323.3530, 24.7329);
		SetPlayerCameraLookAt(playerid, 1173.2358, -1323.2872, 19.4348);
		GameTextForPlayer(playerid, "~n~~w~Recuperando...", 10000, 3);
	}
	return 1;
}

CMD:aceitarmorte(playerid, params[])
{
  if (Injured[playerid] == 1)
  {
	if (AcceptDeath[playerid] == 1)
	{
		SetPlayerHealth(playerid, 0.0);
		KillTimer(LoseHealthTimer[playerid]);
		Hospitalized[playerid] = 1;
		SendClientMessage(playerid, COLOR_YELLOW, "Você aceitou a morte.");
		
	}
	else if (AcceptDeath[playerid] == 0)
	{
		SendErrorMessage(playerid, "Você precisa esperar um minuto para poder aceitar a morte.");
	}
  }
  else if (Injured[playerid] == 0)
  {
	SendErrorMessage(playerid, "Você não está ferido.");
  }
  return 1; 
}

CMD:reviver(playerid, params[])
{
    new targetid;
	
	if(PlayerInfo[playerid][user_logged] == 0) return SendClientMessage(playerid, COLOR_GRAD1, "Você não está logado.");
	if(PlayerInfo[playerid][user_admin] < 1) return SendClientMessage(playerid, COLOR_GREY, "Você não possui autorização para utilizar esse comando.");
    if(sscanf(params, "u", targetid)) return SendSyntaxMessage(playerid, "/reviver [playerid/nome]");
	if (targetid == INVALID_PLAYER_ID) return SendErrorMessage(playerid, "Você especificou um jogador inválido..");
	if (Injured[targetid] == 0) return SendErrorMessage(playerid, "Este jogador não está ferido.");
		
	new string[24+MAX_PLAYER_NAME];
	
	format(string, sizeof(string), "Você reviveu %s.", pNome(targetid));
    SendClientMessage(playerid, -1, string);
	
	format(string, sizeof(string), "O administrador %s reviveu você.", pNome(playerid));
    SendClientMessage(targetid, -1, string);
	TogglePlayerControllable(targetid, true);
	KillTimer(AcceptDeathTimer[targetid]);
	KillTimer(LoseHealthTimer[targetid]);
	AcceptDeath[targetid] = 0;
	Injured[targetid] = 0;
	ClearAnimations(targetid);
	SetPlayerHealth(targetid, 100.0);

    return 1;
}

CMD:sangramento(playerid, params[])
{
	static
	    userid;

    if(PlayerInfo[playerid][user_logged] == 0) return SendClientMessage(playerid, COLOR_GRAD1, "Você não está logado.");
	if(PlayerInfo[playerid][user_admin] < 3) return SendClientMessage(playerid, COLOR_GREY, "Você não possui autorização para utilizar esse comando.");

	if (sscanf(params, "u", userid))
	    return SendSyntaxMessage(playerid, "/sangramento [playerid/nome]");

    if (userid == INVALID_PLAYER_ID)
	    return SendErrorMessage(playerid, "Você específicou um ID inválido.");

	switch (PlayerInfo[userid][pBleeding])
	{
	    case 0:
	    {
	        PlayerInfo[userid][pBleeding] = 1;
	        PlayerInfo[userid][pBleedTime] = 10;

			SendServerMessage(playerid, "Você ativou o sangramento de %s.", pNome(userid));
		}
		case 1:
	    {
	        PlayerInfo[userid][pBleeding] = 0;
	        PlayerInfo[userid][pBleedTime] = 0;

			SendServerMessage(playerid, "Você desativou o sangramento de %s.", pNome(userid));
		}
	}
	return 1;
}

stock inj_OnPlayerTakeDamage(playerid, issuerid, weaponid, bodypart)
{
    new Float: health;
    new Float: armour;
    GetPlayerHealth(playerid, health);
    GetPlayerArmour(playerid, armour);
    if(issuerid != INVALID_PLAYER_ID)
    {
        if(weaponid == 0)
        {
            switch(armour)
            {
                case 0:
                {
                    switch(bodypart)
                    {
                        case 3: SetPlayerHealth(playerid, health - 2); // Torso.
                        case 4: SetPlayerHealth(playerid, health - 2); // Groin.
                        case 5: SetPlayerHealth(playerid, health - 2);  // Left Arm.
                        case 6: SetPlayerHealth(playerid, health - 2); // Right Arm.
                        case 7: SetPlayerHealth(playerid, health - 2);  // Left Leg.
                        case 8: SetPlayerHealth(playerid, health - 2); // Right Leg.
                        case 9: SetPlayerHealth(playerid, health - 2); // Head.
                    }
                }
                default:
                {
                    switch(bodypart)
                    {
                        case 3: SetPlayerHealth(playerid, health - 2); // Torso.
                        case 4: SetPlayerHealth(playerid, health - 2); // Groin.
                        case 5: SetPlayerHealth(playerid, health - 2);  // Left Arm.
                        case 6: SetPlayerHealth(playerid, health - 2); // Right Arm.
                        case 7: SetPlayerHealth(playerid, health - 2);  // Left Leg.
                        case 8: SetPlayerHealth(playerid, health - 2); // Right Leg.
                        case 9: SetPlayerHealth(playerid, health - 2); // Head.
                    }
                }
            }
        }
        else if(weaponid == 3)
        {
            switch(armour)
            {
                case 0:
                {
                    switch(bodypart)
                    {
                        case 3: SetPlayerHealth(playerid, health - 8); // Torso.
                        case 4: SetPlayerHealth(playerid, health - 8); // Groin.
                        case 5: SetPlayerHealth(playerid, health - 8);  // Left Arm.
                        case 6: SetPlayerHealth(playerid, health - 8); // Right Arm.
                        case 7: SetPlayerHealth(playerid, health - 8);  // Left Leg.
                        case 8: SetPlayerHealth(playerid, health - 8); // Right Leg.
                        case 9: SetPlayerHealth(playerid, health - 8); // Head.
                    }
                }
                default:
                {
                    switch(bodypart)
                    {
                        case 3: SetPlayerArmour(playerid, armour - 8); // Torso.
                        case 4: SetPlayerArmour(playerid, armour - 8); // Groin.
                        case 5: SetPlayerArmour(playerid, armour - 8);  // Left Arm.
                        case 6: SetPlayerArmour(playerid, armour - 8); // Right Arm.
                        case 7: SetPlayerArmour(playerid, armour - 8);  // Left Leg.
                        case 8: SetPlayerArmour(playerid, armour - 8); // Right Leg.
                        case 9: SetPlayerArmour(playerid, armour - 8); // Head.
                    }
                }
            }
        }
        else if(weaponid == 4)
        {
            switch(armour)
            {
                case 0:
                {
                    switch(bodypart)
                    {
                        case 3: SetPlayerHealth(playerid, health - 11); // Torso.
                        case 4: SetPlayerHealth(playerid, health - 11); // Groin.
                        case 5: SetPlayerHealth(playerid, health - 11);  // Left Arm.
                        case 6: SetPlayerHealth(playerid, health - 11); // Right Arm.
                        case 7: SetPlayerHealth(playerid, health - 11);  // Left Leg.
                        case 8: SetPlayerHealth(playerid, health - 11); // Right Leg.
                        case 9: SetPlayerHealth(playerid, health - 11); // Head.
                    }
                }
                default:
                {
                    switch(bodypart)
                    {
                        case 3: SetPlayerHealth(playerid, health - 11); // Torso.
                        case 4: SetPlayerHealth(playerid, health - 11); // Groin.
                        case 5: SetPlayerHealth(playerid, health - 11);  // Left Arm.
                        case 6: SetPlayerHealth(playerid, health - 11); // Right Arm.
                        case 7: SetPlayerHealth(playerid, health - 11);  // Left Leg.
                        case 8: SetPlayerHealth(playerid, health - 11); // Right Leg.
                        case 9: SetPlayerHealth(playerid, health - 11); // Head.
                    }
                }
            }
        }
        else if(weaponid == 5)
        {
            switch(armour)
            {
                case 0:
                {
                    switch(bodypart)
                    {
                        case 3: SetPlayerHealth(playerid, health - 11); // Torso.
                        case 4: SetPlayerHealth(playerid, health - 11); // Groin.
                        case 5: SetPlayerHealth(playerid, health - 11);  // Left Arm.
                        case 6: SetPlayerHealth(playerid, health - 11); // Right Arm.
                        case 7: SetPlayerHealth(playerid, health - 11);  // Left Leg.
                        case 8: SetPlayerHealth(playerid, health - 11); // Right Leg.
                        case 9: SetPlayerHealth(playerid, health - 11); // Head.
                    }
                }
                default:
                {
                    switch(bodypart)
                    {
                        case 3: SetPlayerHealth(playerid, health - 11); // Torso.
                        case 4: SetPlayerHealth(playerid, health - 11); // Groin.
                        case 5: SetPlayerHealth(playerid, health - 11);  // Left Arm.
                        case 6: SetPlayerHealth(playerid, health - 11); // Right Arm.
                        case 7: SetPlayerHealth(playerid, health - 11);  // Left Leg.
                        case 8: SetPlayerHealth(playerid, health - 11); // Right Leg.
                        case 9: SetPlayerHealth(playerid, health - 11); // Head.
                    }
                }
            }
        }
        else if(weaponid == 8)
        {
            switch(armour)
            {
                case 0:
                {
                    switch(bodypart)
                    {
                        case 3: SetPlayerHealth(playerid, health - 13); // Torso.
                        case 4: SetPlayerHealth(playerid, health - 13); // Groin.
                        case 5: SetPlayerHealth(playerid, health - 13);  // Left Arm.
                        case 6: SetPlayerHealth(playerid, health - 13); // Right Arm.
                        case 7: SetPlayerHealth(playerid, health - 13);  // Left Leg.
                        case 8: SetPlayerHealth(playerid, health - 13); // Right Leg.
                        case 9: SetPlayerHealth(playerid, health - 99); // Head.
                    }
                }
                default:
                {
                    switch(bodypart)
                    {
                        case 3: SetPlayerHealth(playerid, health - 13); // Torso.
                        case 4: SetPlayerHealth(playerid, health - 13); // Groin.
                        case 5: SetPlayerHealth(playerid, health - 13);  // Left Arm.
                        case 6: SetPlayerHealth(playerid, health - 13); // Right Arm.
                        case 7: SetPlayerHealth(playerid, health - 13);  // Left Leg.
                        case 8: SetPlayerHealth(playerid, health - 13); // Right Leg.
                        case 9: SetPlayerHealth(playerid, health - 99); // Head.
                    }
                }
            }
        }
        else if(weaponid == 22)
        {
            switch(armour)
            {
                case 0:
                {
                    switch(bodypart)
                    {
                        case 3: SetPlayerHealth(playerid, health - 18); // Torso.
                        case 4: SetPlayerHealth(playerid, health - 15); // Groin.
                        case 5: SetPlayerHealth(playerid, health - 15);  // Left Arm.
                        case 6: SetPlayerHealth(playerid, health - 15); // Right Arm.
                        case 7: SetPlayerHealth(playerid, health - 15);  // Left Leg.
                        case 8: SetPlayerHealth(playerid, health - 15); // Right Leg.
                        case 9: SetPlayerHealth(playerid, health - 45); // Head.
                    }
                }
                default:
                {
                    switch(bodypart)
                    {
                        case 3: SetPlayerHealth(playerid, health - 18); // Torso.
                        case 4: SetPlayerHealth(playerid, health - 11); // Groin.
                        case 5: SetPlayerHealth(playerid, health - 11);  // Left Arm.
                        case 6: SetPlayerHealth(playerid, health - 11); // Right Arm.
                        case 7: SetPlayerHealth(playerid, health - 11);  // Left Leg.
                        case 8: SetPlayerHealth(playerid, health - 11); // Right Leg.
                        case 9: SetPlayerHealth(playerid, health - 45); // Head.
                    }
                }
            }
        }
        else if(weaponid == 23)
        {
            switch(armour)
            {
                case 0:
                {
                    switch(bodypart)
                    {
                        case 3: SetPlayerHealth(playerid, health - 11); // Torso.
                        case 4: SetPlayerHealth(playerid, health - 11); // Groin.
                        case 5: SetPlayerHealth(playerid, health - 11);  // Left Arm.
                        case 6: SetPlayerHealth(playerid, health - 11); // Right Arm.
                        case 7: SetPlayerHealth(playerid, health - 11);  // Left Leg.
                        case 8: SetPlayerHealth(playerid, health - 11); // Right Leg.
                        case 9: SetPlayerHealth(playerid, health - 45); // Head.
                    }
                }
                default:
                {
                    switch(bodypart)
                    {
                        case 3: SetPlayerHealth(playerid, health - 11); // Torso.
                        case 4: SetPlayerHealth(playerid, health - 11); // Groin.
                        case 5: SetPlayerHealth(playerid, health - 11);  // Left Arm.
                        case 6: SetPlayerHealth(playerid, health - 11); // Right Arm.
                        case 7: SetPlayerHealth(playerid, health - 11);  // Left Leg.
                        case 8: SetPlayerHealth(playerid, health - 11); // Right Leg.
                        case 9: SetPlayerHealth(playerid, health - 45); // Head.
                    }
                }
            }
        }
        else if(weaponid == 24)
        {
            switch(armour)
            {
                case 0:
                {
                    switch(bodypart)
                    {
                        case 3: SetPlayerHealth(playerid, health - 30); // Torso.
                        case 4: SetPlayerHealth(playerid, health - 20); // Groin.
                        case 5: SetPlayerHealth(playerid, health - 15);  // Left Arm.
                        case 6: SetPlayerHealth(playerid, health - 15); // Right Arm.
                        case 7: SetPlayerHealth(playerid, health - 15);  // Left Leg.
                        case 8: SetPlayerHealth(playerid, health - 15); // Right Leg.
                        case 9: SetPlayerHealth(playerid, health - 60); // Head.
                    }
                }
                default:
                {
                    switch(bodypart)
                    {
                        case 3: SetPlayerArmour(playerid, armour - 15); // Torso.
                        case 4: SetPlayerArmour(playerid, armour - 10); // Groin.
                        case 5: SetPlayerArmour(playerid, armour - 8);  // Left Arm.
                        case 6: SetPlayerArmour(playerid, armour - 8); // Right Arm.
                        case 7: SetPlayerArmour(playerid, armour - 8);  // Left Leg.
                        case 8: SetPlayerArmour(playerid, armour - 8); // Right Leg.
                        case 9: SetPlayerArmour(playerid, armour - 40); // Head.
                    }
                }
            }
        }
        else if(weaponid == 25)
        {
            switch(armour) // Creates a switch that switches through the armour float, and checks the value.
            {
                case 0: // If the value is 0, the codes underneath will activate.
                {
                    switch(bodypart)
                    {
                        case 3: SetPlayerHealth(playerid, health - 40); // Torso.
                        case 4: SetPlayerHealth(playerid, health - 20); // Groin.
                        case 5: SetPlayerHealth(playerid, health - 15);  // Left Arm.
                        case 6: SetPlayerHealth(playerid, health - 15); // Right Arm.
                        case 7: SetPlayerHealth(playerid, health - 15);  // Left Leg.
                        case 8: SetPlayerHealth(playerid, health - 15); // Right Leg.
                        case 9: SetPlayerHealth(playerid, health - 100); // Head.
                    }
                }
                default: 
                {
                    switch(bodypart)
                    {
                        case 3: SetPlayerArmour(playerid, armour - 20); // Torso.
                        case 4: SetPlayerArmour(playerid, armour - 10); // Groin.
                        case 5: SetPlayerArmour(playerid, armour - 7);  // Left Arm.
                        case 6: SetPlayerArmour(playerid, armour - 7); // Right Arm.
                        case 7: SetPlayerArmour(playerid, armour - 7);  // Left Leg.
                        case 8: SetPlayerArmour(playerid, armour - 7); // Right Leg.
                        case 9: SetPlayerArmour(playerid, armour - 50); // Head.
                    }
                }
            }
        }
        else if(weaponid == 29)
        {
            switch(armour)
            {
                case 0:
                {
                    switch(bodypart)
                    {
                        case 3: SetPlayerHealth(playerid, health - 15); // Torso.
                        case 4: SetPlayerHealth(playerid, health - 10); // Groin.
                        case 5: SetPlayerHealth(playerid, health - 10);  // Left Arm.
                        case 6: SetPlayerHealth(playerid, health - 10); // Right Arm.
                        case 7: SetPlayerHealth(playerid, health - 10);  // Left Leg.
                        case 8: SetPlayerHealth(playerid, health - 10); // Right Leg.
                        case 9: SetPlayerHealth(playerid, health - 50); // Head.
                    }
                }
                default:
                {
                    switch(bodypart)
                    {
                        case 3: SetPlayerArmour(playerid, armour - 10); // Torso.
                        case 4: SetPlayerArmour(playerid, armour - 10); // Groin.
                        case 5: SetPlayerArmour(playerid, armour - 5);  // Left Arm.
                        case 6: SetPlayerArmour(playerid, armour - 5); // Right Arm.
                        case 7: SetPlayerArmour(playerid, armour - 5);  // Left Leg.
                        case 8: SetPlayerArmour(playerid, armour - 5); // Right Leg.
                        case 9: SetPlayerArmour(playerid, armour - 25); // Head.
                    }
                }
            }
        }
        else if(weaponid == 30)
        {
            switch(armour) // Creates a switch that switches through the armour float, and checks the value.
            {
                case 0: // If the value is 0, the codes underneath will activate.
                {
                    switch(bodypart)
                    {
                        case 3: SetPlayerHealth(playerid, health - 35); // Torso.
                        case 4: SetPlayerHealth(playerid, health - 35); // Groin.
                        case 5: SetPlayerHealth(playerid, health - 20);  // Left Arm.
                        case 6: SetPlayerHealth(playerid, health - 20); // Right Arm.
                        case 7: SetPlayerHealth(playerid, health - 14);  // Left Leg.
                        case 8: SetPlayerHealth(playerid, health - 14); // Right Leg.
                        case 9: SetPlayerHealth(playerid, health - 50); // Head.
                    }
                }
                default: 
                {
                    switch(bodypart)
                    {
                        case 3: SetPlayerArmour(playerid, armour - 15); // Torso.
                        case 4: SetPlayerArmour(playerid, armour - 15); // Groin.
                        case 5: SetPlayerArmour(playerid, armour - 10);  // Left Arm.
                        case 6: SetPlayerArmour(playerid, armour - 10); // Right Arm.
                        case 7: SetPlayerArmour(playerid, armour - 7);  // Left Leg.
                        case 8: SetPlayerArmour(playerid, armour - 7); // Right Leg.
                        case 9: SetPlayerArmour(playerid, armour - 50); // Head.
                    }
                }
            }
        }
        else if(weaponid == 31)
        {
            switch(armour) // Creates a switch that switches through the armour float, and checks the value.
            {
                case 0: // If the value is 0, the codes underneath will activate.
                {
                    switch(bodypart)
                    {
                        case 3: SetPlayerHealth(playerid, health - 20); // Torso.
                        case 4: SetPlayerHealth(playerid, health - 20); // Groin.
                        case 5: SetPlayerHealth(playerid, health - 10);  // Left Arm.
                        case 6: SetPlayerHealth(playerid, health - 10); // Right Arm.
                        case 7: SetPlayerHealth(playerid, health - 7);  // Left Leg.
                        case 8: SetPlayerHealth(playerid, health - 7); // Right Leg.
                        case 9: SetPlayerHealth(playerid, health - 100); // Head.
                    }
                }
                default: 
                {
                    switch(bodypart)
                    {
                        case 3: SetPlayerArmour(playerid, armour - 10); // Torso.
                        case 4: SetPlayerArmour(playerid, armour - 10); // Groin.
                        case 5: SetPlayerArmour(playerid, armour - 5);  // Left Arm.
                        case 6: SetPlayerArmour(playerid, armour - 4); // Right Arm.
                        case 7: SetPlayerArmour(playerid, armour - 4);  // Left Leg.
                        case 8: SetPlayerArmour(playerid, armour - 4); // Right Leg.
                        case 9: SetPlayerArmour(playerid, armour - 50); // Head.
                    }
                }
            }
        }
        else if(weaponid == 32)
        {
            switch(armour)
            {
                case 0:
                {
                    switch(bodypart)
                    {
                        case 3: SetPlayerHealth(playerid, health - 15); // Torso.
                        case 4: SetPlayerHealth(playerid, health - 15); // Groin.
                        case 5: SetPlayerHealth(playerid, health - 15);  // Left Arm.
                        case 6: SetPlayerHealth(playerid, health - 15); // Right Arm.
                        case 7: SetPlayerHealth(playerid, health - 15);  // Left Leg.
                        case 8: SetPlayerHealth(playerid, health - 15); // Right Leg.
                        case 9: SetPlayerHealth(playerid, health - 50); // Head.
                    }
                }
                default:
                {
                    switch(bodypart)
                    {
                        case 3: SetPlayerArmour(playerid, armour - 10); // Torso.
                        case 4: SetPlayerArmour(playerid, armour - 10); // Groin.
                        case 5: SetPlayerArmour(playerid, armour - 10);  // Left Arm.
                        case 6: SetPlayerArmour(playerid, armour - 10); // Right Arm.
                        case 7: SetPlayerArmour(playerid, armour - 10);  // Left Leg.
                        case 8: SetPlayerArmour(playerid, armour - 10); // Right Leg.
                        case 9: SetPlayerArmour(playerid, armour - 25); // Head.
                    }
                }
            }
        }
        else if(weaponid == 33)
        {
            switch(armour)
            {
                case 0:
                {
                    switch(bodypart)
                    {
                        case 3: SetPlayerHealth(playerid, health - 40); // Torso.
                        case 4: SetPlayerHealth(playerid, health - 25); // Groin.
                        case 5: SetPlayerHealth(playerid, health - 15);  // Left Arm.
                        case 6: SetPlayerHealth(playerid, health - 15); // Right Arm.
                        case 7: SetPlayerHealth(playerid, health - 15);  // Left Leg.
                        case 8: SetPlayerHealth(playerid, health - 15); // Right Leg.
                        case 9: SetPlayerHealth(playerid, health - 100); // Head.
                    }
                }
                default:
                {
                    switch(bodypart)
                    {
                        case 3: SetPlayerArmour(playerid, armour - 25); // Torso.
                        case 4: SetPlayerArmour(playerid, armour - 15); // Groin.
                        case 5: SetPlayerArmour(playerid, armour - 5);  // Left Arm.
                        case 6: SetPlayerArmour(playerid, armour - 5); // Right Arm.
                        case 7: SetPlayerArmour(playerid, armour - 5);  // Left Leg.
                        case 8: SetPlayerArmour(playerid, armour - 5); // Right Leg.
                        case 9: SetPlayerArmour(playerid, armour - 70); // Head.
                    }
                }
            }
        }
        else if(weaponid == 34)
        {
            switch(armour) // Creates a switch that switches through the armour float, and checks the value.
            {
                case 0: // If the value is 0, the codes underneath will activate.
                {
                    switch(bodypart)
                    {
                        case 3: SetPlayerHealth(playerid, health - 60); // Torso.
                        case 4: SetPlayerHealth(playerid, health - 35); // Groin.
                        case 5: SetPlayerHealth(playerid, health - 20);  // Left Arm.
                        case 6: SetPlayerHealth(playerid, health - 20); // Right Arm.
                        case 7: SetPlayerHealth(playerid, health - 20);  // Left Leg.
                        case 8: SetPlayerHealth(playerid, health - 20); // Right Leg.
                        case 9: SetPlayerHealth(playerid, health - 100); // Head.
                    }
                }
                default: 
                {
                    switch(bodypart)
                    {
                        case 3: SetPlayerArmour(playerid, armour - 25); // Torso.
                        case 4: SetPlayerArmour(playerid, armour - 15); // Groin.
                        case 5: SetPlayerArmour(playerid, armour - 5);  // Left Arm.
                        case 6: SetPlayerArmour(playerid, armour - 5); // Right Arm.
                        case 7: SetPlayerArmour(playerid, armour - 5);  // Left Leg.
                        case 8: SetPlayerArmour(playerid, armour - 5); // Right Leg.
                        case 9: SetPlayerArmour(playerid, armour - 70); // Head.
                    }
                }
            }
        }
    }
    return 1;
}

stock inj_OnPlayerGiveDamage(playerid, damagedid, weaponid)
{
	if (IsBleedableWeapon(weaponid) && !PlayerInfo[damagedid][pBleeding] && ReturnArmour(damagedid) < 1 && Hospitalized[damagedid] == -1)
	{
		if (!PlayerHasTazer(playerid) && !PlayerHasBeanBag(playerid))
		{
			PlayerInfo[damagedid][pBleeding] = 1;
			PlayerInfo[damagedid][pBleedTime] = 10;
		}
	}
	return 1;
}
stock IsBleedableWeapon(weaponid)
{
	switch (weaponid) {
	    case 4, 8, 9, 22..38: return 1;
	}
	return 0;
}