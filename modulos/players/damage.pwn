#define		FORMAT:%0(%1)		format(%0, sizeof(%0), %1)

#define		DIALOG_DAMAGE		1927

#define		MAX_DAMAGES			1000

#define		BODY_PART_TORSO 	3
#define 	BODY_PART_GROIN 	4
#define 	BODY_PART_RIGHT_ARM 5
#define 	BODY_PART_LEFT_ARM 	6
#define	 	BODY_PART_RIGHT_LEG 7
#define 	BODY_PART_LEFT_LEG 	8
#define 	BODY_PART_HEAD 		9

enum dmgInfo
{
	dmgDamage,
	dmgWeapon,
	dmgBodypart,
	dmgKevlarhit,
	dmgSeconds,
}
new DamageInfo[MAX_PLAYERS][MAX_DAMAGES][dmgInfo];

stock ResetPlayerDamages(playerid)
{
	for(new id = 0; id < MAX_DAMAGES; id++)
	{
		if(DamageInfo[playerid][id][dmgDamage] != 0)
		{
			DamageInfo[playerid][id][dmgDamage] = 0;
			DamageInfo[playerid][id][dmgWeapon] = 0;
			DamageInfo[playerid][id][dmgBodypart] = 0;
			DamageInfo[playerid][id][dmgKevlarhit] = 0;
			DamageInfo[playerid][id][dmgSeconds] = 0;
		}
	}
	return 1;
}

stock dmg_OnPlayerConnect(playerid)
{
	ResetPlayerDamages(playerid);
	return 1;
}

stock dmg_OnPlayerDeath(playerid)
{
	ResetPlayerDamages(playerid);
	return 1;
}

stock ShowPlayerDamages(playerid, toid)
{
	new 
	str[1000], str1[500], count = 0, name[MAX_PLAYER_NAME];
	GetPlayerName(playerid, name, sizeof(name));
	for(new id = 0; id < MAX_DAMAGES; id++)
	{
		if(DamageInfo[playerid][id][dmgDamage] != 0) count++;
	}
	if(count == 0) return ShowPlayerDialog(toid, DIALOG_DAMAGE, DIALOG_STYLE_LIST, name, "Não há dano para mostrar...", "Fechar", "");
	else if(count > 0)
	{
		for(new id = 0; id < MAX_DAMAGES; id++)
		{
			if(DamageInfo[playerid][id][dmgDamage] != 0)
			{
				FORMAT:str1("%d dano de %s em %s (Kevlarhit: %d) %d segundos atrás\n", DamageInfo[playerid][id][dmgDamage], ReturnWeaponName(DamageInfo[playerid][id][dmgWeapon]), GetBodypartName(DamageInfo[playerid][id][dmgBodypart]), DamageInfo[playerid][id][dmgKevlarhit], gettime() - DamageInfo[playerid][id][dmgSeconds]);
				strcat(str, str1);
			}
		}
		ShowPlayerDialog(toid, DIALOG_DAMAGE, DIALOG_STYLE_LIST, name, str, "Fechar", "");
	}
	return 1;
}

CMD:danos(playerid, params[])
{
	new id;
	if(sscanf(params, "u", id)) return SendSyntaxMessage(playerid, "/danos [playerid]");
	
    if (id == INVALID_PLAYER_ID || !IsPlayerNearPlayer(playerid, id, 5.0))
	    return SendErrorMessage(playerid, "Esse jogador está desconectado ou não está perto de você.");
	
	ShowPlayerDamages(id, playerid);
	return 1;
}

stock dmg_OnPlayerTakeDamage(playerid, Float: amount, weaponid, bodypart)
{
	if(IsPlayerConnected(playerid))
	{
		new 
		id, Float: pHP, Float: pArm;
		GetPlayerHealth(playerid, pHP);
		GetPlayerArmour(playerid, pArm);
		for(new i = 0; i < MAX_DAMAGES; i++)
		{
			if(!DamageInfo[playerid][i][dmgDamage])
			{
				id = i;
				break;
			}
		}
		
		DamageInfo[playerid][id][dmgDamage] = floatround(amount, floatround_round);
		DamageInfo[playerid][id][dmgWeapon] = weaponid;
		DamageInfo[playerid][id][dmgBodypart] = bodypart;
		if(pArm > 0) DamageInfo[playerid][id][dmgKevlarhit] = 1;
		else if(pArm < 1) DamageInfo[playerid][id][dmgKevlarhit] = 0;
		DamageInfo[playerid][id][dmgSeconds] = gettime();
	}
	return 1;
}

stock GetBodypartName(bodypart)
{
	new bodyname[60];
	switch(bodypart)
	{
		case BODY_PART_TORSO: FORMAT:bodyname("TRONCO");
		case BODY_PART_GROIN: FORMAT:bodyname("VIRILHA");
		case BODY_PART_RIGHT_ARM: FORMAT:bodyname("BRAÇO DIREITO");
		case BODY_PART_LEFT_ARM: FORMAT:bodyname("BRAÇO ESQUERDO");
		case BODY_PART_RIGHT_LEG: FORMAT:bodyname("PERNA DIREITA");
		case BODY_PART_LEFT_LEG: FORMAT:bodyname("PERNA ESQUERDA");
		case BODY_PART_HEAD: FORMAT:bodyname("CABEÇA");
	}
	return bodyname;
}