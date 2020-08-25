#define MAX_WEAPON_NAME 21
#define MAX_LABEL_STRING 256

#define LABEL_COLOR 0x20B2AAFF // light sea green
#define LABEL_DRAW_DISTANCE 20.0
#define LABEL_STREAM_DISTANCE 20.0

enum LabelMode {
	MODE_DISABLED,
	MODE_GLOBAL,
	MODE_PLAYER
}

enum E_PLAYER_DATA {
	Float:PLAYER_POS[3],
	Float:PLAYER_ANGLE,
	Float:PLAYER_HEALTH,
	Float:PLAYER_ARMOUR,
	PLAYER_INTERIOR,
	PLAYER_VIRTUAL_WORLD,
	PLAYER_SKIN,
	PLAYER_PING,
	PLAYER_MONEY,
	PLAYER_WEAPON,
	PLAYER_AMMO,
	PLAYER_SCORE
}

new const WEAPON_NAMES[57][MAX_WEAPON_NAME] = {
	"Punho", 			"Soco inglês", 			"Clube de golfe",
	"Nightstick", 		"Knife", 				"Taco de baseball",
	"Pá", 				"Taco de sinuca", 		"Katana",
	"Motosserra", 		"Dildo roxo", 			"Dildo",
	"Vibrador", 		"Vibrador", 			"Flores",
	"Cana", 			"Granada", 				"Gás lacrimogêneo",
	"Molotov", 			"Arma do veículo", 		"Arma do veículo",
	"Desconhecido", 	"Colt 45", 				"Pistola silenciosa",
	"Deagle", 			"Shotgun", 				"Shotgun serrado",
	"Combat Shotgun", 	"Mac-10", 				"MP5",
	"AK-47", 			"M4", 					"Tec-9",
	"Cuntgun", 			"Sniper", 				"Lançador de foguetes",
	"RPG tele-guiado", 	"Lança-chamas", 		"Minigun",
	"Satchel", 			"Detonator", 			"Spraycan",
	"Extintor", 		"Câmera", 				"Óculos noturno",
	"Óculos IV", 		"Pára-quedas", 			"Pistola falsa",
	"Pistol whip",		"Veículo", 				"Hélices",
	"Explosão", 		"Estacionamento", 		"Afogamento",
	"Collisionh", 		"Splat", 				"Desconhecido"
};

new Text3D:playerLabels[MAX_PLAYERS][MAX_PLAYERS];
new LabelMode:playerLabelMode[MAX_PLAYERS];
new playerLabelTargetID[MAX_PLAYERS];

new playerData[MAX_PLAYERS][E_PLAYER_DATA];

GetLabelString(playerid, targetid, dest[], maxlength = sizeof(dest)) {
	new Float:distance = GetPlayerDistanceFromPoint(playerid, playerData[targetid][PLAYER_POS][0], playerData[targetid][PLAYER_POS][1], playerData[targetid][PLAYER_POS][2]);

    format(dest, maxlength,
		"[id: %i, vida: %0.2f, colete: %0.2f, ping: %i]\n\
		skin: %i, dinheiro: $%i, nível: %i\n\
		distâncie: %0.2f\n\
		arma: %s, munições: %i\n\
		interior: %i, world: %i\n\
		pos: %0.4f, %0.4f, %0.4f, %0.4f",
			targetid, playerData[targetid][PLAYER_HEALTH], playerData[targetid][PLAYER_ARMOUR], playerData[targetid][PLAYER_PING],
	 		playerData[targetid][PLAYER_SKIN], playerData[targetid][PLAYER_MONEY], playerData[targetid][PLAYER_SCORE],
	        distance,
            WEAPON_NAMES[playerData[targetid][PLAYER_WEAPON]], playerData[targetid][PLAYER_AMMO],
        	playerData[targetid][PLAYER_INTERIOR], playerData[targetid][PLAYER_VIRTUAL_WORLD],
            playerData[targetid][PLAYER_POS][0], playerData[targetid][PLAYER_POS][1], playerData[targetid][PLAYER_POS][2], playerData[targetid][PLAYER_ANGLE]
	);

	return 1;
}

CreatePlayerLabel(playerid, targetid) {
	new string[MAX_LABEL_STRING];
	GetLabelString(playerid, targetid, string);
	
    playerLabels[playerid][targetid] = CreateDynamic3DTextLabel(string, LABEL_COLOR, 0.0, 0.0, 0.0, LABEL_DRAW_DISTANCE, targetid, _, _, _, _, playerid, LABEL_STREAM_DISTANCE);

	return 1;
}

DestroyPlayerLabel(playerid) {
    foreach (new i : Player) {
		DestroyDynamic3DTextLabel(playerLabels[i][playerid]);

		if (playerLabelMode[i] == MODE_PLAYER && playerLabelTargetID[i] == playerid) {
			playerLabelMode[i] = MODE_DISABLED;
			SendClientMessage(i, 0xFFFFFFFF, "SERVER: Player labels disabled");
		}
	}
	
	return 1;
}

UpdatePlayerLabel(playerid, targetid) {
	new string[MAX_LABEL_STRING];

	if (playerLabelMode[playerid] == MODE_DISABLED)
		return 0;

	if (playerLabelMode[playerid] == MODE_PLAYER && playerLabelTargetID[playerid] != targetid)
		return 0;

	if (!IsPlayerInRangeOfPoint(playerid, LABEL_STREAM_DISTANCE, playerData[targetid][PLAYER_POS][0], playerData[targetid][PLAYER_POS][1], playerData[targetid][PLAYER_POS][2]))
		return 0;

	GetLabelString(playerid, targetid, string);
	UpdateDynamic3DTextLabelText(playerLabels[playerid][targetid], LABEL_COLOR, string);

	return 1;
}

stock pl_OnPlayerConnect(playerid) {
	for (new i = 0; i < MAX_PLAYERS; i++) {
		playerLabels[playerid][i] = Text3D:-1;
	}

	playerLabelMode[playerid] = MODE_DISABLED;
	playerLabelTargetID[playerid] = INVALID_PLAYER_ID;

	return 1;
}

stock pl_OnPlayerDisconnect(playerid) {
	foreach (new i : Player) {
		DestroyDynamic3DTextLabel(playerLabels[i][playerid]);
		
		if (playerLabelMode[i] == MODE_PLAYER && playerLabelTargetID[i] == playerid) {
			playerLabelMode[i] = MODE_DISABLED;
			SendClientMessage(i, 0xFFFFFFFF, "SERVER: Player label desativada!");
		}
	}

	return 1;
}

stock pl_OnPlayerSpawn(playerid) {
    foreach (new i : Player) {
		if (i != playerid) {
            CreatePlayerLabel(i, playerid);
		}
	}

	return 1;
}

stock pl_OnPlayerDeath(playerid) {
    DestroyPlayerLabel(playerid);

	return 1;
}

stock pl_OnPlyIntChange(playerid, newinteriorid) {
    playerData[playerid][PLAYER_INTERIOR] = newinteriorid;

    foreach (new i : Player) {
 		if (i != playerid) {
	    	UpdatePlayerLabel(i, playerid);
		}
	}

	return 1;
}

stock pl_OnPlayerUpdate(playerid) {
	new worldid = GetPlayerVirtualWorld(playerid);
	if (worldid != playerData[playerid][PLAYER_VIRTUAL_WORLD]) {
	    playerData[playerid][PLAYER_VIRTUAL_WORLD] = worldid;
	    goto Update;
	}

	new skinid = GetPlayerSkin(playerid);
	if (skinid != playerData[playerid][PLAYER_SKIN]) {
	    playerData[playerid][PLAYER_SKIN] = skinid;
	    goto Update;
	}

	new score = GetPlayerScore(playerid);
	if (score != playerData[playerid][PLAYER_SCORE]) {
	    playerData[playerid][PLAYER_SCORE] = score;
	    goto Update;
	}

	new money = GetPlayerMoney(playerid);
	if (money != playerData[playerid][PLAYER_MONEY]) {
	    playerData[playerid][PLAYER_MONEY] = money;
	    goto Update;
	}

	new weapon = GetPlayerWeapon(playerid);
	if (weapon != playerData[playerid][PLAYER_WEAPON]) {
	    playerData[playerid][PLAYER_WEAPON] = weapon;
	    playerData[playerid][PLAYER_AMMO] = GetPlayerAmmo(playerid);
	    goto Update;
	}

	new ammo = GetPlayerAmmo(playerid);
	if (ammo != playerData[playerid][PLAYER_AMMO]) {
	    playerData[playerid][PLAYER_AMMO] = ammo;
	    goto Update;
	}

	new Float:health;
	GetPlayerHealth(playerid, health);
	if (health != playerData[playerid][PLAYER_HEALTH]) {
	    playerData[playerid][PLAYER_HEALTH] = health;
	    goto Update;
	}

	new Float:armour;
	GetPlayerArmour(playerid, armour);
	if (armour != playerData[playerid][PLAYER_ARMOUR]) {
	    playerData[playerid][PLAYER_ARMOUR] = armour;
	    goto Update;
	}

	new Float:angle;
	GetPlayerFacingAngle(playerid, angle);
	if (angle != playerData[playerid][PLAYER_ANGLE]) {
	    playerData[playerid][PLAYER_ANGLE] = angle;
	    goto Update;
	}

	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);
	if (x != playerData[playerid][PLAYER_POS][0] || y != playerData[playerid][PLAYER_POS][1] || z != playerData[playerid][PLAYER_POS][2]) {
	    playerData[playerid][PLAYER_POS][0] = x;
	    playerData[playerid][PLAYER_POS][1] = y;
	    playerData[playerid][PLAYER_POS][2] = z;
	    goto Update;
	}

	new ping = GetPlayerPing(playerid);
	if (ping != playerData[playerid][PLAYER_PING]) {
	    playerData[playerid][PLAYER_PING] = ping;
	    goto Update;
	}

Update:
	foreach (new i : Player) {
 		if (i != playerid) {
	    	UpdatePlayerLabel(i, playerid);
		}
	}

	return 1;
}

CMD:pl(playerid, params[]) {

    if(PlayerInfo[playerid][user_logged] == 0) return SendClientMessage(playerid, COLOR_GRAD1, "Você não está logado.");
	if(PlayerInfo[playerid][user_admin] < 2) return SendClientMessage(playerid, COLOR_GREY, "Você não possui autorização para utilizar esse comando.");
	if (PlayerInfo[playerid][user_admin] < 4 && !AdminTrabalhando[playerid])
        return SendClientMessage(playerid, COLOR_LIGHTRED, "ERRO: Você deve usar o comando /atrabalho antes.");

	if (playerLabelMode[playerid] != MODE_DISABLED) {
        playerLabelMode[playerid] = MODE_DISABLED;
        
        foreach (new i : Player) {
			DestroyDynamic3DTextLabel(playerLabels[playerid][i]);
			playerLabels[playerid][i] = Text3D:-1;
		}
        
        return SendClientMessage(playerid, 0xFFFFFFFF, "SERVER: Player labels desativado.");
	}

    new targetid;
	if (sscanf(params, "u", targetid)) {
		targetid = INVALID_PLAYER_ID;
	}
	else {
	    if (!IsPlayerConnected(targetid))
	        return SendClientMessage(playerid, COLOR_GREY, "ERRO: Jogador desconectado.");

	    if (targetid == playerid)
	        return SendClientMessage(playerid, COLOR_GREY, "ERRO: O jogador inserido é você mesmo.");
	}

	if (targetid == INVALID_PLAYER_ID) {
		playerLabelMode[playerid] = MODE_GLOBAL;
		playerLabelTargetID[playerid] = INVALID_PLAYER_ID;

		foreach (new i : Player) {
		    if (i != playerid) {
		        CreatePlayerLabel(playerid, i);
			}
		}
	}
	else {
		playerLabelMode[playerid] = MODE_PLAYER;
		playerLabelTargetID[playerid] = targetid;

		CreatePlayerLabel(playerid, targetid);
	}

    SendClientMessage(playerid, 0xFFFFFFFF, "SERVER: Player labels ativado.");
    
	return 1;
}