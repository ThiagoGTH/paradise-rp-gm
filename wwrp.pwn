#include <a_samp>
#include <a_mysql>
#include <bcrypt>
#include <pawn.CMD>
#include <easyDialog>
#include <sscanf2>
#include <streamer>
#include <foreach>
#include <SKY>
#include <colandreas>
#include <eSelection>
#include <strlib>
#include <sqlitei>
#include <PreviewModelDialog>

#define	BCRYPT_COST	12

#define MYSQL_HOSTNAME 	"127.0.0.1"
#define MYSQL_USERNAME 	"root"
#define MYSQL_PASSWORD 	""
#define MYSQL_DATABASE 	"samp"

#define SERVER_NAME	"Paradise Roleplay | SA-MP 0.3DL-R1"
#define SERVER_URL	"www.paradise-roleplay.com"
#define SERVER_REVISION	"P:RP v0.01-BETA"
#define SERVER_LANGUAGE	"Brazilian Portuguese"

#define Pasta_Logs          "Logs/%s.txt"

#define MAX_CRATES (200)

#define SendServerMessage(%0,%1) \
	SendClientMessageEx(%0, -1, "SERVER: "%1)

#define SendSyntaxMessage(%0,%1) \
	SendClientMessageEx(%0, COLOR_GREY, "USE: "%1)

#define SendErrorMessage(%0,%1) \
	SendClientMessageEx(%0, COLOR_GREY, "ERRO: "%1)

#define SendAdminAction(%0,%1) \
	SendClientMessageEx(%0, COLOR_LIGHTRED, "AdmCmd: "%1)

#define COLOR_CLIENT       			0xAAC4E5FF
#define DEFAULT_COLOR      			0xFFFFFFFF
#define COLOR_DEPARTMENT   			0xF0CC00FF
#define COLOR_ADMINCHAT    			0x33EE33FF
#define COLOR_DARKBLUE    	 	 	0x1394BFFF
#define COLOR_SERVER       			0xFFFF90FF
#define COLOR_FACTION     			0xBDF38BFF
#define COLOR_GREENCONCE 			0x339933FF
#define COLOR_GREEN2	 			0x319F2BFF
#define COLOR_RADIO        			0x8D8DFFFF
#define COLOR_ANIMS         	 	0xf0f8ffFF
#define Verde                    	0x88AA62FF
#define Azul                     	0xA9C4E4FF
#define Cinza                    	0xB9C9BFFF
#define Rosa                     	0xFF8282FF
#define BRANCO 	 					0xFFFFFFFF
#define CINZA 	 					0xD6D6D6FF
#define VERMELHO  					0xFF0000FF
#define AMARELO  					0xF7E200FF
#define LARANJA   					0xE89200FF
#define COLOR_ERRO  				0xFF0000AA
#define COLOR_AZULBEBE 	 			0x00CCFFAA
#define COLOR_SYSBLUE 	 			0x0F59EFFF
#define colorRed         			0xFF0000FF
#define colorYellow 	 			0xFFFF00FF
#define COLOR_RG                	0xB5CAE6FF
#define COLOR_RG2               	0x9EC7FDFF
#define Color_Admin              	0x33EE33FF
#define COR_PM                   	0x8470FFFF
#define COR_BOPE                 	0x19197096
#define COR_BOPE2                	0x408080FF
#define COR_SWAT                 	0x7D03FFFF
#define COR_EXE                  	0x00660CF6
#define COR_Medicos              	0xFF8282FF
#define COR_AZULZAO              	0x005FFFFF
#define ROXO                     	0xC2A2DAAA
#define COR_CINZA1          		0xB4B5B7FF
#define RED1	   					0xE60000FF
#define GREEN1 	 					0x21DD00FF
#define COR_AZTECAS 	         	0x2641FEAA
#define COR_BOP                  	0x330099AA
#define COR_Rifa 	             	0xC599C8AA
#define COR_BOMBEIROS            	0xF05353AA
#define COR_PRE 	             	0x6699FFFF
#define COR_HITMAN 	             	0x696969FF
#define COR_REPORTER             	0xFF9900FF
#define COR_TAXI 	             	0x33FFFFFF
#define COR_PF 	         			0x91766296
#define COR_PRp          			0x996600FF
#define COR_YAK          			0x00483AF6
#define COLOR_BARZ         			0x00483AAA
#define COLOR_RIFA              	0xFBC63FAA
#define COR_GRO          			0x33FF00FF
#define COR_FARC           			0x676767FF
#define COR_PC              	 	0x666699FF
#define COR_BALLAS          	 	0x9900CCFF
#define COR_VAGOS           		0xFFFF00FF
#define COR_CVSF           			0xB60000AA
#define COR_PR                   	0xF09F50FF
#define COR_HELPER	             	0x55F6ACFF
#define CORGZ_COPS               	0x5B88ACAA
#define COR_TRIADS               	0xB0DDF3FF
#define COR_GI 	         			0x33CCFFAA
#define COR_GIC          			0xFE005DFF
#define COR_WHITE          			0xFFF8F8AA
#define VERDE2 	         			0x33FF00FF
#define COLOR_CORLEONE           	0xFF6200AA
#define	COLOR_VERDE2 	    	 	0x33FF00FF
#define COLOR_DEPTH 	         	0x993333FF
#define COR_ADMIN          			-10043754
#define COLOR_ADMIN      			0xF64CCAFF
#define COR_PCC      	 			0x9ACD32AA
#define COR_CRIPS                	0xFFFF99AA
#define COR_MERCENARIOS          	0xFF333365
#define COR_TALIBAN              	0xFF1493AA
#define COR_COSANOSTRA           	0x33FFFFAA
#define COLOR_WHITE              	0xFFFFFFFF
#define COR_MAYAN  					0x8B2252AA
#define COLOR_CHAT_PCC      	 	0x9ACD32FF
#define LARANJA2          			0xFF6600AA
#define VERDECLARO          		0x00FF0CAA
#define COLOR_ALIANCA 	 			0xA9A9A9FF
#define VERDEFRACO               	0x80cf80AA
#define COLOR_AMARELOR           	0xFFFF00AA
#define VERDEFRACOR              	0x80cf80AA
#define COR_3DLABEL              	0x0FFFC8FF
#define COLOR_AZULBB             	0xE6D4D1FF
#define TEAM_CYAN_COLOR          	0xA92BF6F6
#define TEAM_CYAN_COLOR2         	0xFF8282AA
#define GCOP_COLOR          		0x6666FFC8
#define COLOR_LIGHTRED 	         	0xFF6347AA
#define COLORGZ_BARZINI          	0x006699C8
#define COLORGZ_PF               	0x000000C8
#define COLOR_GREEN              	0x33AA33AA
#define COLOR_PURPLE             	0xC2A2DAAA
#define TEAM_GROVE_COLOR         	0x00D900AA
#define TEAM_BALLAS_COLOR        	0x9900FFAA
#define TEAM_AZTECAS_COLOR       	0x2641FEAA
#define COLOR_GRAD1              	0xB4B5B7FF
#define COLOR_GRAD2              	0xBFC0C2FF
#define COLOR_GRAD3 	         	0xBFC0C2FF
#define COLOR_GRAD4              	0xD8D8D8FF
#define COLOR_GRAD5              	0xF0F0F0FF
#define COLOR_GRAD6              	0xF0F0F0FF
#define COLOR_LIGHTBLUE          	0x33CCFFAA
#define COLOR_DBLUE              	0x2641FEAA
#define COLOR_SAMP               	0xACCBF1FF
#define COLOR_YELLOW             	0xFFFF00FF
#define COLOR_YELLOWF            	0xFFFF00FF
#define COLOR_GREY               	0xAFAFAFAA
#define COLOR_RED                	0xAA3333AA
#define COLOR_LIGHTGREEN         	0x9ACD32AA
#define TEAM_VAGOS_COLOR         	0xFFC801AA
#define CINZA2                    	0xAFAFAFAA
#define PRETO                    	0x000000FF
#define COLOR_FADE4              	0x8C8C8C8C
#define COLOR_FADE5              	0x6E6E6E6E
#define COLOR_FADE3              	0xAAAAAAAA
#define COLOR_RCARRO             	0x80FF8096
#define TEAM_HIT_COLOR           	0xFFFFFF00
#define COLOR_FADE2 	         	0xC8C8C8C8
#define COLOR_NEWS          		0xFFA500AA
#define COLOR_NEWS               	0xFFA500AA
#define COLOR_ALLDEPT            	0xFF8282AA
#define COLOR_FADE1              	0xE6E6E6E6
#define COLOR_R                  	0x6666CCFF
#define COLORGZ_ALCAIDA          	0x10100FAA
#define COLOR_MSG                	0x934FF6F6
#define COLORGZ_Rifa             	0xC599C8AA
#define COLORGZ_GI               	0x00ECF6AA
#define AZUL3                    	0x33CCFFAA
#define CINZA1                   	0xB4B5B7FF
#define AN_COLOR                 	0x00E7C6F6
#define COLOR_YELLOW2 	 			0xF5DEB3AA
#define COLOR_TAXISTA            	0xF68E00F6
#define TEAM_BLUE_COLOR          	0x8D8DFF00
#define COLORGZ_LH               	0x00E7C6C8
#define COLORGZ_EXE              	0x33AA33C8
#define COLOR_EXE                	0x33AA33C8

#define WW::%0(%1) forward %0(%1);\
public %0(%1)

stock KickWW(playerid)return SetTimerEx("Kick_Ex", 110, 0, "i", playerid);
WW::Kick_Ex(playerid)return Kick(playerid);
#define Kick        KickWW
native IsValidVehicle(vehicleid);
new
	MySQL:Database,
	bool:LoggedIn[MAX_PLAYERS]
;

new stock g_arrVehicleNames[][] =
{
	{"Landstalker"},{"Bravura"},{"Buffalo"},{"Linerunner"},{"Perrenial"},{"Sentinel"},{"Dumper"},
	{"Firetruck"},{"Trashmaster"},{"Stretch"},{"Manana"},{"Infernus"},{"Voodoo"},{"Pony"},{"Mule"},
	{"Cheetah"},{"Ambulance"},{"Leviathan"},{"Moonbeam"},{"Esperanto"},{"Taxi"},{"Washington"},
	{"Bobcat"},{"Mr Whoopee"},{"BF Injection"},{"Hunter"},{"Premier"},{"Enforcer"},{"Securicar"},
	{"Banshee"},{"Predator"},{"Bus"},{"Rhino"},{"Barracks"},{"Hotknife"},{"Trailer 1"},{"Previon"},
	{"Coach"},{"Cabbie"},{"Stallion"},{"Rumpo"},{"RC Bandit"},{"Romero"},{"Packer"},{"Monster"},
	{"Admiral"},{"Squalo"},{"Seasparrow"},{"Pizzaboy"},{"Tram"},{"Trailer 2"},{"Turismo"},
	{"Speeder"},{"Reefer"},{"Tropic"},{"Flatbed"},{"Yankee"},{"Caddy"},{"Solair"},{"Berkley's RC Van"},
	{"Skimmer"},{"PCJ-600"},{"Faggio"},{"Freeway"},{"RC Baron"},{"RC Raider"},{"Glendale"},{"Oceanic"},
	{"Sanchez"},{"Sparrow"},{"Patriot"},{"Quad"},{"Coastguard"},{"Dinghy"},{"Hermes"},{"Sabre"},
	{"Rustler"},{"ZR-350"},{"Walton"},{"Regina"},{"Comet"},{"BMX"},{"Burrito"},{"Camper"},{"Marquis"},
	{"Baggage"},{"Dozer"},{"Maverick"},{"News Chopper"},{"Rancher"},{"FBI Rancher"},{"Virgo"},{"Greenwood"},
	{"Jetmax"},{"Hotring"},{"Sandking"},{"Blista Compact"},{"Police Maverick"},{"Boxville"},{"Benson"},
	{"Mesa"},{"RC Goblin"},{"Hotring Racer A"},{"Hotring Racer B"},{"Bloodring Banger"},{"Rancher"},
	{"Super GT"},{"Elegant"},{"Journey"},{"Bike"},{"Mountain Bike"},{"Beagle"},{"Cropdust"},{"Stunt"},
	{"Tanker"}, {"Roadtrain"},{"Nebula"},{"Majestic"},{"Buccaneer"},{"Shamal"},{"Hydra"},{"FCR-900"},
	{"NRG-500"},{"HPV1000"},{"Cement Truck"},{"Tow Truck"},{"Fortune"},{"Cadrona"},{"FBI Truck"},
	{"Willard"},{"Forklift"},{"Tractor"},{"Combine"},{"Feltzer"},{"Remington"},{"Slamvan"},
	{"Blade"},{"Freight"},{"Streak"},{"Vortex"},{"Vincent"},{"Bullet"},{"Clover"},{"Sadler"},
	{"Firetruck LA"},{"Hustler"},{"Intruder"},{"Primo"},{"Cargobob"},{"Tampa"},{"Sunrise"},{"Merit"},
	{"Utility"},{"Nevada"},{"Yosemite"},{"Windsor"},{"Monster A"},{"Monster B"},{"Uranus"},{"Jester"},
	{"Sultan"},{"Stratum"},{"Elegy"},{"Raindance"},{"RC Tiger"},{"Flash"},{"Tahoma"},{"Savanna"},
	{"Bandito"},{"Freight Flat"},{"Streak Carriage"},{"Kart"},{"Mower"},{"Duneride"},{"Sweeper"},
	{"Broadway"},{"Tornado"},{"AT-400"},{"DFT-30"},{"Huntley"},{"Stafford"},{"BF-400"},{"Newsvan"},
	{"Tug"},{"Trailer 3"},{"Emperor"},{"Wayfarer"},{"Euros"},{"Hotdog"},{"Club"},{"Freight Carriage"},
	{"Trailer 3"},{"Andromada"},{"Dodo"},{"RC Cam"},{"Launch"},{"Police Car (LSPD)"},{"Police Car (SFPD)"},
	{"Police Car (LVPD)"},{"Police Ranger"},{"Picador"},{"S.W.A.T. Van"},{"Alpha"},{"Phoenix"},{"Glendale"},
	{"Sadler"},{"Luggage Trailer A"},{"Luggage Trailer B"},{"Stair Trailer"},{"Boxville"},{"Farm Plow"},
	{"Utility Trailer"}
};

new AdminTrabalhando[MAX_PLAYERS];
new bool:ChatKill[MAX_PLAYERS];
new inahorse[MAX_PLAYERS];
new MEGAString[2500];
new giveplayer[MAX_PLAYER_NAME];
new sendername[MAX_PLAYER_NAME];
new Text:TextLogin;
new Text:TextBan;
new BlackRadar;

enum crateData {
	crateID,
	crateExists,
	//crateType,
	//Float:cratePos[4],
	//crateInterior,
	//crateWorld,
	crateObject,
	crateVehicle,
	Text3D:crateText3D
};

new CrateData[MAX_CRATES][crateData];
main( ) { }

enum PlayerData
{
	user_id,
	user_cash,
	user_kills,
	user_deaths,
	user_admin,
	Float:pPosX,
	Float:pPosY,
	Float:pPosZ,
	Float:pPosA,
	user_score,
	Interior,
	VW,
	user_skin,
	pLastShot,
	pShotTime,
	Float:Vida,
	Float:Colete,
// AJAIL SYS
	pJailed,
	pJailedTime,
	//
	pForumName[32],
	pMaterial,
// WEP SYS
	pGuns[13],
	pAmmo[13],
// FACCTION SYS
	pFactionMod,
	pPropertyMod,
	pFaction,
	pFactionID,
	pFactionRank,
	pFactionEdit,
	pSelectedSlot,
	pOnDuty,
	pFactionOffer,
	pFactionOffered,
	pDisableFaction,
// FACCTION SYS
	pGraffiti,
	pGraffitiTime,
	pGraffitiColor,
	pGraffitiText[64 char],
	pEditGraffiti,
	pLoopAnim,
	CurrentDealer,
	CurrentItem[10],
	CurrentAmmo[10],
	CurrentCost[10],
	pBleeding,
	pBleedTime,
	pTazer,
	pCuffed,
	pBeanBag,
	pDragged,
	pDraggedBy,
	pDragTimer,
	pJailTime,
	pPrisoned,
	pEntrance,
	pHouse,
	pBusiness,
	pFreeze,
	pFreezeTimer,
	pStunned,
	pPlayingHours,
	pMinutes,
	pPaycheck,
	Weaponed,
	pCarSeller,
	pCarOffered,
	pCarValue,
	user_logged,
	Nome[MAX_PLAYER_NAME]
};
new PlayerInfo[MAX_PLAYERS][PlayerData];

new const g_aWeaponSlots[] = {
	0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 10, 10, 10, 10, 10, 10, 8, 8, 8, 0, 0, 0, 2, 2, 2, 3, 3, 3, 4, 4, 5, 5, 4, 6, 6, 7, 7, 7, 7, 8, 12, 9, 9, 9, 11, 11, 11
};

stock ABroadCast(COLOR,const striing[],level)
{
	foreach(new i : Player)
	{
		if (PlayerInfo[i][user_admin] >= level)
		{
			SendClientMessage(i, COLOR, striing);
		}
	}
	printf("%s", striing);
	return true;
}

stock SendAdminAlert(color, const str[], {Float,_}:...)
{
	static
	    args,
	    start,
	    end,
	    string[144]
	;
	#emit LOAD.S.pri 8
	#emit STOR.pri args

	if (args > 8)
	{
		#emit ADDR.pri str
		#emit STOR.pri start

	    for (end = start + (args - 8); end > start; end -= 4)
		{
	        #emit LREF.pri end
	        #emit PUSH.pri
		}
		#emit PUSH.S str
		#emit PUSH.C 144
		#emit PUSH.C string

		#emit LOAD.S.pri 8
		#emit ADD.C 4
		#emit PUSH.pri

		#emit SYSREQ.C format
		#emit LCTRL 5
		#emit SCTRL 4

        foreach (new i : Player)
		{
			if (PlayerInfo[i][user_admin] >= 1) {
  				SendClientMessage(i, color, string);
			}
		}
		return 1;
	}
	foreach (new i : Player)
	{
		if (PlayerInfo[i][user_admin] >= 1) {
			SendClientMessage(i, color, str);
		}
	}
	return 1;
}

stock Float:GetPlayerDistanceFromPlayer(playerid, targetid)
{
	new
	    Float:x,
	    Float:y,
	    Float:z;

	GetPlayerPos(targetid, x, y, z);
	return GetPlayerDistanceFromPoint(playerid, x, y, z);
}

// MODULOS
// DISCORD
#include "../gamemodes/modulos/discord/dc.pwn"
#include "../gamemodes/modulos/players/vehicles.pwn"

// FACÇÃO
#include "../gamemodes/modulos/factions/fac.pwn"
#include "../gamemodes/modulos/factions/wf.pwn"
#include "../gamemodes/modulos/factions/arrest.pwn"
#include "../gamemodes/modulos/factions/copobjects.pwn"
#include "../gamemodes/modulos/factions/multas.pwn"

// PROPERTY
#include "../gamemodes/modulos/props/house.pwn"
#include "../gamemodes/modulos/props/entrance.pwn"
#include "../gamemodes/modulos/props/gates.pwn"
#include "../gamemodes/modulos/props/bank.pwn"
#include "../gamemodes/modulos/props/cars.pwn"

// ADMIN
#include "../gamemodes/modulos/admin/comandos.pwn"
#include "../gamemodes/modulos/admin/ban.pwn"
#include "../gamemodes/modulos/admin/ovni.pwn"
#include "../gamemodes/modulos/admin/spec.pwn"

// PLAYERS
#include "../gamemodes/modulos/players/rp.pwn"
#include "../gamemodes/modulos/players/animlist.pwn"
#include "../gamemodes/modulos/players/vehicles.pwn"
#include "../gamemodes/modulos/players/screen.pwn"
#include "../gamemodes/modulos/players/injured.pwn"
#include "../gamemodes/modulos/players/damage.pwn"
#include "../gamemodes/modulos/players/stats.pwn"
#include "../gamemodes/modulos/players/savewep.pwn"

// MAPAS
#include "../gamemodes/modulos/mapas/customaps.pwn"
#include "../gamemodes/modulos/mapas/prison.pwn"
#include "../gamemodes/modulos/mapas/interiormap.pwn"
//
//#include "../gamemodes/modulos/sys/air.pwn"

public OnGameModeInit()
{
	AddPlayerClass(299, 0.0, 0.0, 0.0, 90.0, 0, 0, 0, 0, 0, 0);
	Database = mysql_connect(MYSQL_HOSTNAME, MYSQL_USERNAME, MYSQL_PASSWORD, MYSQL_DATABASE);
	if(Database == MYSQL_INVALID_HANDLE || mysql_errno(Database) != 0)
	{
		print("SERVER: Erro com a conexão com o MySQL, desligando o servidor!");
		SendRconCommand("exit");
		return 1;
	}
	SetTimer("JailRelease", 1000, true);
	SetTimer("PlayerCheck", 1000, true);
	SetTimer("MinuteCheck", 60000, true);

	print("SERVER: Conexão com o MySQL bem sucedida.");

	// MAPAS
	LoadMaps();
	LoadPrison();
	LoadInteriorMap();
	// MAPAS

	print("=> Carregando: World War");
	print(" ");
	print("=> Modo de Jogo: RP");
	print("=> Versão: 0.1 BETA");
	print("=> Idioma: PT/BR");
	print(" ");

	ManualVehicleEngineAndLights();
	new rcon[80];
	format(rcon, sizeof(rcon), "hostname %s", SERVER_NAME);
	SendRconCommand(rcon);
	format(rcon, sizeof(rcon), "weburl %s", SERVER_URL);
	SendRconCommand(rcon);
	format(rcon, sizeof(rcon), "language %s", SERVER_LANGUAGE);
	SendRconCommand(rcon);
	SetGameModeText(SERVER_REVISION);
	DisableInteriorEnterExits();
	EnableStuntBonusForAll(0);
	SetNameTagDrawDistance(10.0);
	ShowPlayerMarkers(0);

	ShowPlayerMarkers(PLAYER_MARKERS_MODE_OFF);

	TextLogin = TextDrawCreate(-1.120055, -0.166664, "mdl-2000:inicial");
	TextDrawTextSize(TextLogin, 641.000000, 448.000000);
	TextDrawAlignment(TextLogin, 1);
	TextDrawColor(TextLogin, -1);
	TextDrawSetShadow(TextLogin, 0);
	TextDrawBackgroundColor(TextLogin, 255);
	TextDrawFont(TextLogin, 4);
	TextDrawSetProportional(TextLogin, 0);

	TextBan = TextDrawCreate(-1.120055, -0.166664, "mdl-2000:banido");
	TextDrawTextSize(TextBan, 641.000000, 448.000000);
	TextDrawAlignment(TextBan, 1);
	TextDrawColor(TextBan, -1);
	TextDrawSetShadow(TextBan, 0);
	TextDrawBackgroundColor(TextBan, 255);
	TextDrawFont(TextBan, 4);
	TextDrawSetProportional(TextBan, 0);

	BlackRadar = GangZoneCreate(-3334.758544, -3039.903808, 3049.241455, 3184.096191);

	// MODULOS
	house_OnGMInit();
	ban_OnGameModeInit();
	spec_OnGameModeInit();
	fac_OnGMInit();
	ent_OnGMinit();
	wf_OnGMInit();
	arrest_OnGameModeInit();
	screen_OnGMInit();
	gat_OnGMInit();
	co_OnGMInit();
	bank_OnGMInit();
	Server_Load();
	return 1;
}

public OnGameModeExit()
{
	foreach(new i: Player)
	{
		if(IsPlayerConnected(i))
		{
		OnPlayerDisconnect(i, 1);
		}
	}
	mysql_close(Database);
	Ovni_OnGameModeExit();
	spec_OnGameModeExit();
	house_OnGMExit();
	gat_OnGMExit();
	co_OnGMExit();
	//air_OnGMExit();
	bank_OnGMExit();
	return 1;
}

public OnPlayerUpdate(playerid) {
	spec_OnPlayerUpdate(playerid);
	inj_OnPlayerUpdate(playerid);

	if (GetPlayerMoney(playerid) != PlayerInfo[playerid][user_cash])
	{
	    ResetPlayerMoney(playerid);
	    GivePlayerMoney(playerid, PlayerInfo[playerid][user_cash]);
	}
	return 1;
}

public OnPlayerConnect(playerid)
{
	SetPlayerWorldBounds(playerid, 20000, -20000, 20000, -20000);
	GangZoneShowForPlayer(playerid, BlackRadar, 0x000000FF);
	new pname[24];
	GetPlayerName(playerid, pname, sizeof(pname));
	if(!NameIsRP(pname))
	{
		LimparChat(playerid);
		SetPlayerVirtualWorld(playerid, 9999);
		SendClientMessage(playerid, COLOR_YELLOW, "SERVER: Você precisa de um nome real para jogar no servidor.");
		SendClientMessage(playerid, COLOR_YELLOW, "EXEMPLO: Nome_Sobrenome");
		SendClientMessage(playerid, COLOR_YELLOW, "DICA: Não use números e muitas letras maiusculas.");
		SendClientMessage(playerid, COLOR_YELLOW, "DICA: Não utilize nome de pessoas famosas.");
		SendClientMessage(playerid, COLOR_YELLOW, "PARA MAIS INFORMAÇÕES: www.paradise-roleplay.com");

		SetTimerEx("Kick_Ex", 1000, 0, "i", playerid);
		return 1;
	}
	SetPlayerColor(playerid, 0xFFFFFFFF);
	SetPVarInt(playerid, "TogAdmin", 0);

	TextDrawShowForPlayer(playerid, TextLogin);

	//RemoveBuildingForPlayer(playerid, -1, 0.0, 0.0, 0.0, 6000.0);
	LoadPrison2(playerid);
	ban_OnPlayerConnect(playerid);
	spec_OnPlayerConnect(playerid);
	dc_OnPlayerConnect(playerid);
	House_PlayerInit(playerid);
	dmg_OnPlayerConnect(playerid);
	gat_OnPlayerConnect(playerid);
	co_OnPlayerConnect(playerid);
	bank_OnPlayerConnect(playerid);
	return 1;
}
public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
	spec_OnPlyIntChange(playerid, newinteriorid);
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	spec_OnPlayerStateChange(playerid, newstate);
	cars_OnPlayerStateChange(playerid, newstate);
	return 1;
}
public OnPlayerSpawn(playerid)
{
	spec_OnPlayerSpawn(playerid);
	inj_OnPlayerSpawn(playerid);
	house_OnPlayerSpawn(playerid);

	return 1;
}

public OnPlayerClickTextDraw(playerid, Text:clickedid)
{
	spec_OnPlyCkTD(playerid, Text:clickedid);
	return 1;
}
public OnPlayerDisconnect(playerid, reason)
{
	SaveAccount(playerid);
	ZerarDados(playerid);
	new string[128];
	switch(reason)
	{
		case 0:format(string,sizeof(string),"* %s saiu do servidor por erro de conexão ou crash.", pNome(playerid));
		case 1:format(string,sizeof(string),"* %s saiu do servidor por vontade própria.", pNome(playerid));
		case 2:format(string,sizeof(string),"* %s saiu do servidor kickado ou banido.", pNome(playerid));
		default:format(string,sizeof(string),"* %s saiu do servidor por causa desconhecida.", pNome(playerid));
	}
	SendClientMessageInRange(30.0, playerid, string, COLOR_YELLOW2,COLOR_YELLOW2,COLOR_YELLOW2,COLOR_YELLOW2,COLOR_YELLOW2);

	TerminateConnection(playerid);
	spec_OnPlayerDisconnect(playerid);
	dc_OnPlayerDisconnect(playerid);
	gat_OnPlayerDisconnect(playerid);
	//air_OnPlayerDisconnect(playerid);
	return 1;
}

public OnPlayerCommandPerformed(playerid, cmd[], params[], result, flags)
{
	if (result == -1) return SendClientMessage(playerid, -1,"ERRO: Desculpe, este comando não existe. Digite /ajuda ou /sos se você precisar de ajuda.");
	return 1;
}

//new SERVER_DOWNLOAD[] = "http://www.dev-wil.com/downloads/038/models";
public OnPlayerRequestDownload(playerid, type, crc)
{
	if(!IsPlayerConnected(playerid))
		return 0;
/*	new filename[64], filefound, url_final[256];

	if(type == DOWNLOAD_REQUEST_TEXTURE_FILE)
	filefound = FindTextureFileNameFromCRC(crc, filename, sizeof(filename));
	else if(type == DOWNLOAD_REQUEST_MODEL_FILE)
	filefound = FindModelFileNameFromCRC(crc, filename, sizeof(filename));

	if(filefound)
	{
format(url_final, sizeof(url_final), "%s/%s", SERVER_DOWNLOAD, filename);
RedirectDownload(playerid, url_final);
	}*/
	return 1;
}

forward SaveAccount(playerid);
public SaveAccount(playerid)
{
	if(PlayerInfo[playerid][user_logged] == 0)
		return 0;

	new query[2048];
	PlayerInfo[playerid][user_skin] = GetPlayerSkinID(playerid);
	PlayerInfo[playerid][user_cash] = GetPlayerMoney(playerid);
	PlayerInfo[playerid][user_score] = GetPlayerScore(playerid);
	PlayerInfo[playerid][VW] = GetPlayerVirtualWorld(playerid);
	PlayerInfo[playerid][Interior] = GetPlayerInterior(playerid);
	GetPlayerHealth(playerid, PlayerInfo[playerid][Vida]);
	GetPlayerArmour(playerid, PlayerInfo[playerid][Colete]);
	GetPlayerPos(playerid, PlayerInfo[playerid][pPosX], PlayerInfo[playerid][pPosY], PlayerInfo[playerid][pPosZ]);
	GetPlayerFacingAngle(playerid, PlayerInfo[playerid][pPosA]);
	UpdateWeapons(playerid);
	mysql_format(Database, query, sizeof(query), "UPDATE `players` SET \
	`Cash` = '%i', \
	`Kills` = '%i', \
	`Deaths` = '%i', \
	`Admin` = '%i', \
	`PosX` = '%f', \
	`PosY` = '%f', \
	`PosZ` = '%f', \
	`PosA` = '%f', \
	`Score` = '%i', \
	`Interior` = '%i', \
	`VW` = '%i', \
	`Skin` = '%i', \
	`Health` = '%f', \
	`Armour` = '%f', \
	`Jailed` = '%i', \
	`JailedTime` = '%i', \
	`ForumName` = '%s', \
	`pFactionMod` = '%i', \
	`pPropertyMod` = '%i', \
	`Faction` = '%i', \
	`FactionRank` = '%i', \
	`Material` = '%i', \
	`JailTime` = '%d', \
	`Prisoned` = '%d', \
	`Entrance` = '%d', \
	`House` = '%d', \
	`PlayingHours` = '%d', \
	`Minutes` = '%d', \
	`Paycheck` = '%i', \
	`Weaponed` = '%d' WHERE `ID` = '%i'",
	PlayerInfo[playerid][user_cash],
	PlayerInfo[playerid][user_kills],
	PlayerInfo[playerid][user_deaths],
	PlayerInfo[playerid][user_admin],
	PlayerInfo[playerid][pPosX],
	PlayerInfo[playerid][pPosY],
	PlayerInfo[playerid][pPosZ],
	PlayerInfo[playerid][pPosA],
	PlayerInfo[playerid][user_score],
	PlayerInfo[playerid][Interior],
	PlayerInfo[playerid][VW],
	PlayerInfo[playerid][user_skin],
	PlayerInfo[playerid][Vida],
	PlayerInfo[playerid][Colete],
	PlayerInfo[playerid][pJailed],
	PlayerInfo[playerid][pJailedTime],
	PlayerInfo[playerid][pForumName],
	// FACCTION SYS
	PlayerInfo[playerid][pFactionMod],
	PlayerInfo[playerid][pPropertyMod],
	PlayerInfo[playerid][pFactionID],
	PlayerInfo[playerid][pFactionRank],
	PlayerInfo[playerid][pMaterial],
	PlayerInfo[playerid][pJailTime],
	PlayerInfo[playerid][pPrisoned],
	// PROPS
	PlayerInfo[playerid][pHouse],
	PlayerInfo[playerid][pEntrance],
	//
	PlayerInfo[playerid][pPlayingHours],
	PlayerInfo[playerid][pMinutes],
	PlayerInfo[playerid][pPaycheck],
	PlayerInfo[playerid][Weaponed],
	PlayerInfo[playerid][user_id]);
	mysql_tquery(Database, query);
	SaveWeaponsSQL(playerid);

	printf("[MYSQL] Dados do jogador %s (ID: %d) foram salvos com sucesso.", pNome(playerid), PlayerInfo[playerid][user_id]);
	return 1;
}

forward MinuteCheck();
public MinuteCheck()
{
    foreach (new i : Player)
	{
	    if (!PlayerInfo[i][user_logged])
	        continue;

        PlayerInfo[i][pMinutes]++;

        if (PlayerInfo[i][pMinutes] >= 60)
       	{
       	    new paycheck = random(100) + 100;

        	PlayerInfo[i][pMinutes] = 0;

			PlayerInfo[i][pPlayingHours]++;
			PlayerInfo[i][pPaycheck] += paycheck;


			SendClientMessageEx(i, COLOR_WHITE, "BANCO: Seu pagamento de {33CC33}%s{FFFFFF} foi recebido, retire-o em algum banco.", formatInt(paycheck));
			return 1;
		}

        //SendClientMessageEx(i, COLOR_WHITE, "BANCO: Seu pagamento de {33CC33}%s{FFFFFF} foi recebido, retire-o em algum banco.", formatInt(paycheck));
	}

	return 1;
}

public OnPlayerEditDynamicObject(playerid, objectid, response, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz)
{
	Graf_OnPEDObject(playerid, response, Float:x, Float:y, Float:z, Float:rz);
	house_OnPEDObject(playerid, objectid, response, Float: x, Float: y, Float: z, Float: rx, Float: ry, Float: rz);
	gat_OnPlayerEditDynamicObject(playerid, STREAMER_TAG_OBJECT objectid, response, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz);
	co_OnPlayerEditDynamicObject(playerid, objectid, response, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz);
	bank_OnPlayerEditDynamicObject(playerid, STREAMER_TAG_OBJECT objectid, response, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz);
	return 1;
}
forward ZerarDados(playerid);
stock ZerarDados(playerid)
{
	PlayerInfo[playerid][user_id] = 0;
	PlayerInfo[playerid][user_cash] = 0;
	PlayerInfo[playerid][user_kills] = 0;
	PlayerInfo[playerid][user_deaths] = 0;
	PlayerInfo[playerid][user_admin] = 0;
	PlayerInfo[playerid][pPosX] = 0;
	PlayerInfo[playerid][pPosY] = 0;
	PlayerInfo[playerid][pPosZ] = 0;
	PlayerInfo[playerid][pPosA] = 0;
	PlayerInfo[playerid][user_score] = 0;
	PlayerInfo[playerid][Interior] = 0;
	PlayerInfo[playerid][VW] = 0;
	PlayerInfo[playerid][user_skin] = 0;
	PlayerInfo[playerid][Vida] = 0;
	PlayerInfo[playerid][Colete] = 0;
	PlayerInfo[playerid][user_logged] = 0;
	PlayerInfo[playerid][pJailed] = 0;
	PlayerInfo[playerid][pFreeze] = 0;
	PlayerInfo[playerid][pJailedTime] = 0;
	PlayerInfo[playerid][pJailTime] = 0;
	PlayerInfo[playerid][pPrisoned] = 0;
	PlayerInfo[playerid][pDragged] = 0;
	PlayerInfo[playerid][pPlayingHours] = 0;
	PlayerInfo[playerid][pMinutes] = 0;
	PlayerInfo[playerid][pPaycheck] = 0;
	PlayerInfo[playerid][Weaponed] = 0;
    PlayerInfo[playerid][pDraggedBy] = INVALID_PLAYER_ID;
	PlayerInfo[playerid][pLastShot] = INVALID_PLAYER_ID;
	PlayerInfo[playerid][pShotTime] = 0;
	PlayerInfo[playerid][pFactionOffer] = INVALID_PLAYER_ID;
	PlayerInfo[playerid][pFactionOffered] = -1;
	PlayerInfo[playerid][pFaction] = -1;
	PlayerInfo[playerid][pFactionID] = -1;
	PlayerInfo[playerid][pFactionRank] = 0;
	PlayerInfo[playerid][pFactionEdit] = -1;
	PlayerInfo[playerid][pBleeding] = 0;
	PlayerInfo[playerid][pBleedTime] = 0;
	PlayerInfo[playerid][pCuffed] = 0;
	PlayerInfo[playerid][pTazer] = 0;
	PlayerInfo[playerid][pBeanBag] = 0;
	PlayerInfo[playerid][pOnDuty] = 0;
	PlayerInfo[playerid][pForumName] = 0;
	PlayerInfo[playerid][pMaterial] = 0;
	PlayerInfo[playerid][pFactionMod] = 0;
	PlayerInfo[playerid][pPropertyMod] = 0;
	PlayerInfo[playerid][pSelectedSlot] = 0;
	PlayerInfo[playerid][pDisableFaction] = 0;
	AdminTrabalhando[playerid] = 0;
	ChatKill[playerid] = false;
	inahorse[playerid] = 0;
	PlayerInfo[playerid][pGraffiti] = -1;
	PlayerInfo[playerid][pGraffitiTime] = 0;
	PlayerInfo[playerid][pGraffitiColor] = 0;
	PlayerInfo[playerid][pEditGraffiti] = -1;
	PlayerInfo[playerid][pLoopAnim] = 0;
	PlayerInfo[playerid][pHouse] = -1;
	PlayerInfo[playerid][pBusiness] = -1;
	PlayerInfo[playerid][pEntrance] = -1;
	PlayerInfo[playerid][CurrentDealer] = 0;
	PlayerInfo[playerid][CurrentItem] = 0;
	PlayerInfo[playerid][CurrentAmmo] = 0;
	PlayerInfo[playerid][CurrentCost] = 0;

	PlayerInfo[playerid][pCarSeller] = INVALID_PLAYER_ID;
	PlayerInfo[playerid][pCarOffered] = -1;
	PlayerInfo[playerid][pCarValue] = 0;

	Injured[playerid] = 0;

	foreach (new i : Player) if (PlayerInfo[i][pDraggedBy] == playerid) {
	    StopDragging(i);
	}
	if (PlayerInfo[playerid][pDragged]) {
	    StopDragging(playerid);
	}
	for (new i = 0; i < 12; i ++) {
		PlayerInfo[playerid][pGuns][i] = 0;
		PlayerInfo[playerid][pAmmo][i] = 0;
	}
	for (new i = 0; i != MAX_PLAYER_TICKETS; i ++) {
	    TicketData[playerid][i][ticketID] = 0;
		TicketData[playerid][i][ticketExists] = false;
		TicketData[playerid][i][ticketFee] = 0;
	}

}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if (Injured[playerid] != -1 || !IsPlayerSpawned(playerid) || PlayerInfo[playerid][pCuffed] || Hospitalized[playerid])
	    return 0;

	if (newkeys & KEY_SPRINT && IsPlayerSpawned(playerid) && PlayerInfo[playerid][pLoopAnim])
	{
		ClearAnimations(playerid);

		PlayerInfo[playerid][pLoopAnim] = false;
	}
	//air_OnPKSC(playerid, newkeys, oldkeys);
	return 1;
}

public OnPlayerGiveDamage(playerid, damagedid, Float:amount, weaponid)
{
	inj_OnPlayerGiveDamage(playerid, damagedid, weaponid);
	if (damagedid != INVALID_PLAYER_ID)
	{
		PlayerInfo[damagedid][pLastShot] = playerid;
		PlayerInfo[damagedid][pShotTime] = gettime();
	}

	if (GetFactionType(playerid) == FACTION_POLICE && PlayerInfo[playerid][pTazer] && PlayerInfo[damagedid][pStunned] < 1 && weaponid == 23)
    {
		if (GetPlayerState(damagedid) != PLAYER_STATE_ONFOOT)
			return SendErrorMessage(playerid, "O jogador precisa estar em pé para ser stunado.");

        if (GetPlayerDistanceFromPlayer(playerid, damagedid) > 10.0)
            return SendErrorMessage(playerid, "Você precisa estar mais perto para stunar um jogador.");

		PlayerInfo[damagedid][pStunned] = 10;
		TogglePlayerControllable(damagedid, 0);

        ApplyAnimation(damagedid, "CRACK", "crckdeth4", 4.0, 0, 0, 0, 1, 0, 1);
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s acertou %s com o taser.", pNome(playerid), pNome(damagedid));
    }
    if (GetFactionType(playerid) == FACTION_POLICE && PlayerInfo[playerid][pBeanBag] && PlayerInfo[damagedid][pStunned] < 1 && weaponid == 25)
    {
		if (GetPlayerState(damagedid) != PLAYER_STATE_ONFOOT)
			return SendErrorMessage(playerid, "O jogador precisa estar em pé para ser stunado.");

        if (GetPlayerDistanceFromPlayer(playerid, damagedid) > 10.0)
            return SendErrorMessage(playerid, "Você precisa estar mais perto para stunar um jogador.");

        PlayerInfo[damagedid][pStunned] = 10;
        TogglePlayerControllable(damagedid, 0);

        ApplyAnimation(damagedid, "CRACK", "crckdeth4", 4.0, 0, 0, 0, 1, 0, 1);

		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s acertou %s com um tiro de bala de borracha.", pNome(playerid), pNome(damagedid));
    }
	return 1;
}
public OnPlayerText(playerid, text[])
{
	if(PlayerInfo[playerid][user_logged] == 0)
	{
		SendClientMessage(playerid, COLOR_GRAD1, "Você não está logado.");
		return 0;
	}

	if (IsPlayerInAnyVehicle(playerid) && IsWindowedVehicle(GetPlayerVehicleID(playerid)) && !CoreVehicles[GetPlayerVehicleID(playerid)][vehWindowsDown])
	SendVehicleMessage(GetPlayerVehicleID(playerid), -1, "[Janelas Fechadas] %s diz: %s", pNome(playerid), text);
	else SendNearbyMessage(playerid, 20.0, COLOR_WHITE, "%s diz: %s", pNome(playerid), text);

	return false;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	if(killerid != INVALID_PLAYER_ID)
	{
		//new string[256];
		PlayerInfo[killerid][user_kills]++;

		/*if (reason == 50 && killerid != INVALID_PLAYER_ID)
		format(string, sizeof(string), "AdmCmd: %s matou %s utilizando um helicóptero.", pNome(killerid), pNome(playerid));
		ABroadCast(COLOR_LIGHTRED, string, 1);


		if (reason == 29 && killerid != INVALID_PLAYER_ID && GetPlayerState(killerid) == PLAYER_STATE_DRIVER)
		format(string, sizeof(string), "AdmCmd: %s matou %s atropelado.", pNome(killerid), pNome(playerid));
		ABroadCast(COLOR_LIGHTRED, string, 1);*/
	}
	PlayerInfo[playerid][user_deaths]++;

	spec_OnPlayerDeath(playerid);
	inj_OnPlayerDeath(playerid);
	dmg_OnPlayerDeath(playerid);
	//air_OnPlayerDeath(playerid);
	return 1;
}

forward CheckAccount(playerid);
public CheckAccount(playerid)
{
	new string[300];
	if(cache_num_rows())
	{
		TextDrawShowForPlayer(playerid, TextLogin);
		LimparChat(playerid);
		TogglePlayerSpectating(playerid, 1);
		format(string, sizeof(string), "Bem vindo novamente ao servidor, %s.\nSERVER: Você só poderá errar sua senha três (3) vezes.\nINFO: Nosso UCP é o www.paradiseroleplay.com\n\nDigite sua senha:", pNome(playerid));
		Dialog_Show(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, " ", string, "Entrar", "Sair");
	}
	else
	{
		TextDrawShowForPlayer(playerid, TextLogin);
		LimparChat(playerid);
		TogglePlayerSpectating(playerid, 1);
		format(string, sizeof(string), "{FFFFFF}Bem vindo ao nosso servidor, %s. Digite uma senha forte para continuar.", pNome(playerid));
		Dialog_Show(playerid, DIALOG_REGISTER, DIALOG_STYLE_PASSWORD, "Registrar no servidor", string, "Registrar", "Sair");
	}
	return 1;
}

Dialog:DIALOG_REGISTER(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		bcrypt_hash(inputtext, BCRYPT_COST, "OnPasswordHashed", "d", playerid);
	}
	else
		Kick(playerid);
	return 1;
}

Dialog:DIALOG_LOGIN(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new query[300], Password[BCRYPT_HASH_LENGTH];
		mysql_format(Database, query, sizeof(query), "SELECT `Password` FROM `players` WHERE `Username` = '%e'", GetName(playerid));
		mysql_query(Database, query);
		cache_get_value_name(0, "Password", Password, BCRYPT_HASH_LENGTH);
		bcrypt_check(inputtext, Password, "OnPasswordChecked", "d", playerid);
	}
	else
		Kick(playerid);
	return 1;
}

forward LimparChat(playerid);
public LimparChat(playerid)
{
	for(new i; i < 20; i++)
	{
		SendClientMessage(playerid, -1, "");
	}
	return 1;
}

forward OnPasswordHashed(playerid);
public OnPasswordHashed(playerid)
{
	new hash[BCRYPT_HASH_LENGTH], query[3000];
	bcrypt_get_hash(hash);
	mysql_format(Database, query, sizeof(query), "INSERT INTO `players` (`Username`, `Password`, `IPAddress`, `Cash`, `Kills`, `Deaths`, `Admin`, `PosX`, `PosY`, `PosZ`, `PosA`, `Score`, `Interior`, `VW`, `Skin`, `Health`, `Armour`, `ForumName`)\
	VALUES ('%e', '%e', '%e', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)", GetName(playerid), hash, ReturnIP(playerid));
	mysql_tquery(Database, query, "OnPlayerRegister", "d", playerid);
	RecordData(playerid);
	return 1;
}
forward OnPlayerRegister(playerid);
public OnPlayerRegister(playerid)
{
	new query[1080];

	PlayerInfo[playerid][user_id] = cache_insert_id(); // Adiciona o id no player
	printf("[MYSQL] Jogador %s registrado como ID %d", pNome(playerid), PlayerInfo[playerid][user_id]); // Apenas um debug, pra saber se deu tudo certo.

	mysql_format(Database, query, sizeof(query), "SELECT * FROM players WHERE ID='%i'", PlayerInfo[playerid][user_id]); // Seleciona todas as informações desse player AONDE o id dele é o id dele
	mysql_query(Database, query); // Executa o comando acima

	return 1;
}

stock TerminateConnection(playerid)
{
	foreach (new i : Player)
	{
		if (PlayerInfo[i][pLastShot] == playerid)
		{
		PlayerInfo[i][pLastShot] = INVALID_PLAYER_ID;
		}
	}
	return 1;
}

stock GetDuration(time)
{
	new
		str[32];

	if (time < 0 || time == gettime()) {
		format(str, sizeof(str), "Nunca");
		return str;
	}
	else if (time < 60)
		format(str, sizeof(str), "%d segundos", time);

	else if (time >= 0 && time < 60)
		format(str, sizeof(str), "%d segundos", time);

	else if (time >= 60 && time < 3600)
		format(str, sizeof(str), (time >= 120) ? ("%d minutos") : ("%d minuto"), time / 60);

	else if (time >= 3600 && time < 86400)
		format(str, sizeof(str), (time >= 7200) ? ("%d horas") : ("%d hora"), time / 3600);

	else if (time >= 86400 && time < 2592000)
		format(str, sizeof(str), (time >= 172800) ? ("%d dias") : ("%d dia"), time / 86400);

	else if (time >= 2592000 && time < 31536000)
		format(str, sizeof(str), (time >= 5184000) ? ("%d meses") : ("%d mês"), time / 2592000);

	else if (time >= 31536000)
		format(str, sizeof(str), (time >= 63072000) ? ("%d anos") : ("%d ano"), time / 31536000);

	strcat(str, " atrás");

	return str;
}

stock RecordData(playerid)
{
	PlayerInfo[playerid][user_skin] = 60;
	PlayerInfo[playerid][user_score] = 1;
	PlayerInfo[playerid][Vida] = 100;
	PlayerInfo[playerid][Colete] = 0;
	PlayerInfo[playerid][Interior] = 0;
	PlayerInfo[playerid][VW] = 0;
	PlayerInfo[playerid][pPosX] = 1642.2025;
	PlayerInfo[playerid][pPosY] = -2335.0376;
	PlayerInfo[playerid][pPosZ] = -2.6797;
	PlayerInfo[playerid][pPosA] = 358.5789;
	PlayerInfo[playerid][Weaponed] = 0;
	SetPlayerHealth(playerid, PlayerInfo[playerid][Vida]);
	SetPlayerArmour(playerid, PlayerInfo[playerid][Colete]);
	SetPlayerScore(playerid, PlayerInfo[playerid][user_score]);
	GiveMoney(playerid, 500);
	SetPlayerInterior(playerid, PlayerInfo[playerid][Interior]);
	SetPlayerVirtualWorld(playerid, PlayerInfo[playerid][VW]);
	SetSpawnInfo(playerid, 0, PlayerInfo[playerid][user_skin], PlayerInfo[playerid][pPosX], PlayerInfo[playerid][pPosY], PlayerInfo[playerid][pPosZ], PlayerInfo[playerid][pPosA], 0, 0, 0, 0 ,0, 0);
	SpawnPlayer(playerid);
	TextDrawHideForPlayer(playerid, TextLogin);
	TogglePlayerSpectating(playerid, 0);
	new query [90];
	mysql_format(Database, query, sizeof(query), "INSERT INTO `pweapons` (`ID`)\
    VALUES ('%d')", PlayerInfo[playerid][user_id]);
    mysql_tquery(Database, query);


	LoggedIn[playerid] = true;
	PlayerInfo[playerid][user_logged] = 1;
	AdminTrabalhando[playerid] = 0;
	ChatKill[playerid] = false;
	inahorse[playerid] = 0;
	LimparChat(playerid);
	new stringl[256];
	format(stringl, sizeof(stringl), "SERVER: Bem vindo ao servidor, %s.",pNome(playerid));
	SendClientMessage(playerid, -1, stringl);
	format(stringl, sizeof stringl, " `LOG-REGISTER:` [%s] **%s** (%s) registrou no servidor.", ReturnDate(), pNome(playerid), ReturnIP(playerid));
   	DCC_SendChannelMessage(DC_Logs1, stringl);

	//OnPlayerLoad(playerid);
}

forward OnPasswordChecked(playerid);
public OnPasswordChecked(playerid)
{
	new bool:match = bcrypt_is_equal();
	if(match)
	{
		new query[300];
		mysql_format(Database, query, sizeof(query), "SELECT * FROM `players` WHERE `Username` = '%e'", GetName(playerid));
		mysql_tquery(Database, query, "OnPlayerLoad", "d", playerid);
	}
	else
	{
		new string[100];
		TogglePlayerSpectating(playerid, 1);
		format(string, sizeof(string), "Senha errada!\nDigite a senha correta.");
		Dialog_Show(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "Logar no servidor", string, "Entrar", "Sair");
	}
	return 1;
}

forward OnPlayerLoad(playerid);
public OnPlayerLoad(playerid)
{
	TextDrawHideForPlayer(playerid, TextLogin);
	TogglePlayerSpectating(playerid, 0);
	new string[256];
	cache_get_value_name_int(0, "ID", PlayerInfo[playerid][user_id]);
	cache_get_value_name_int(0, "Cash", PlayerInfo[playerid][user_cash]);
	cache_get_value_name_int(0, "Kills", PlayerInfo[playerid][user_kills]);
	cache_get_value_name_int(0, "Deaths", PlayerInfo[playerid][user_deaths]);
	cache_get_value_name_int(0, "Admin", PlayerInfo[playerid][user_admin]);
	cache_get_value_name_float(0, "PosX", PlayerInfo[playerid][pPosX]);
	cache_get_value_name_float(0, "PosY", PlayerInfo[playerid][pPosY]);
	cache_get_value_name_float(0, "PosZ", PlayerInfo[playerid][pPosZ]);
	cache_get_value_name_float(0, "PosA", PlayerInfo[playerid][pPosA]);
	cache_get_value_name_int(0, "Score", PlayerInfo[playerid][user_score]);
	cache_get_value_name_int(0, "Interior", PlayerInfo[playerid][Interior]);
	cache_get_value_name_int(0, "VW", PlayerInfo[playerid][VW]);
	cache_get_value_name_int(0, "Skin", PlayerInfo[playerid][user_skin]);
	cache_get_value_name_float(0, "Health", PlayerInfo[playerid][Vida]);
	cache_get_value_name_float(0, "Armour", PlayerInfo[playerid][Colete]);
	cache_get_value_name_int(0, "Jailed", PlayerInfo[playerid][pJailed]);
	cache_get_value_name_int(0, "JailedTime", PlayerInfo[playerid][pJailedTime]);
	cache_get_value_name(0, "ForumName", PlayerInfo[playerid][pForumName]);

	cache_get_value_name_int(0, "PlayingHours", PlayerInfo[playerid][pPlayingHours]);
	cache_get_value_name_int(0, "Minutes", PlayerInfo[playerid][pMinutes]);
	cache_get_value_name_int(0, "Paycheck", PlayerInfo[playerid][pPaycheck]);
	cache_get_value_name_int(0, "Weaponed", PlayerInfo[playerid][Weaponed]);

	cache_get_value_name_int(0, "JailTime", PlayerInfo[playerid][pJailTime]);
	cache_get_value_name_int(0, "Prisoned", PlayerInfo[playerid][pPrisoned]);

	cache_get_value_name_int(0, "pFactionMod", PlayerInfo[playerid][pFactionMod]);
	cache_get_value_name_int(0, "pPropertyMod", PlayerInfo[playerid][pPropertyMod]);
	cache_get_value_name_int(0, "Faction", PlayerInfo[playerid][pFactionID]);
	cache_get_value_name_int(0, "FactionRank", PlayerInfo[playerid][pFactionRank]);
	cache_get_value_name_int(0, "Material", PlayerInfo[playerid][pMaterial]);

	cache_get_value_name_int(0, "House", PlayerInfo[playerid][pHouse]);
	cache_get_value_name_int(0, "Entrance", PlayerInfo[playerid][pEntrance]);

	new query[1080];
	mysql_format(Database, query, sizeof(query), "SELECT * FROM `pweapons` WHERE `ID` = '%i'", PlayerInfo[playerid][user_id]);
	mysql_tquery(Database, query, "OnPlayerLoadWeapons", "d", playerid);

	mysql_format(Database, query, sizeof(query), "SELECT * FROM `tickets` WHERE `ID` = '%i'", PlayerInfo[playerid][user_id]);
	mysql_tquery(Database, query, "OnPlayerLoadTickets", "d", playerid);


	LoggedIn[playerid] = true;
	PlayerInfo[playerid][user_logged] = 1;
	AdminTrabalhando[playerid] = 0;
	ChatKill[playerid] = false;
	inahorse[playerid] = 0;
	LimparChat(playerid);
	SetPlayerHealth(playerid, PlayerInfo[playerid][Vida]);
	SetPlayerArmour(playerid, PlayerInfo[playerid][Colete]);
	SetPlayerScore(playerid, PlayerInfo[playerid][user_score]);
	GiveMoney(playerid, PlayerInfo[playerid][user_cash]);
	//SetWeapons(playerid);
	SetPlayerInterior(playerid, PlayerInfo[playerid][Interior]);
	SetPlayerVirtualWorld(playerid, PlayerInfo[playerid][VW]);
	SetSpawnInfo(playerid, 0, PlayerInfo[playerid][user_skin], PlayerInfo[playerid][pPosX], PlayerInfo[playerid][pPosY], PlayerInfo[playerid][pPosZ], PlayerInfo[playerid][pPosA], 0, 0, 0, 0 ,0, 0);
	SpawnPlayer(playerid);
	SetPlayerSkin(playerid, PlayerInfo[playerid][user_skin]);

	new stringl[124];
	format(stringl,sizeof(stringl),"~w~Bem vindo ~n~~Y~%s", pNome(playerid));
	GameTextForPlayer(playerid, stringl,6000,1);
	LimparChat(playerid);
	format(stringl, sizeof(stringl), "SERVER: Bem vindo ao servidor novamente, %s.",pNome(playerid));
	SendClientMessage(playerid, -1, stringl);

	if(PlayerInfo[playerid][pJailed] > 0)
	{
		format(string, sizeof(string), "SERVER: Você está em prisão administrativa e ainda lhe resta %i minutos preso.", PlayerInfo[playerid][pJailedTime] / 60);
		SendClientMessage(playerid, COLOR_YELLOW, string);
		SetPlayerPos(playerid, 2307.6868,576.3664,106.5366);
		SetPlayerFacingAngle( playerid, 269.2296);
		SetPlayerInterior(playerid, 0);
		SetPlayerVirtualWorld(playerid, 1338);
		SetPlayerHealth(playerid, 99999);
		ResetWeapons(playerid);
	}

	if (PlayerInfo[playerid][pJailTime] > 0)
	{
	    if (PlayerInfo[playerid][pPrisoned])
	    {
	        SetPlayerInPrison(playerid);
	    }
	    SendServerMessage(playerid, "Ainda lhe resta %d minutos preso.", PlayerInfo[playerid][pJailTime] / 60);
	}

	if(PlayerInfo[playerid][user_admin] > 0)
	{
		format(string, sizeof(string), "Você logou como administrador nível %i.", PlayerInfo[playerid][user_admin]);
		SendClientMessage(playerid, COLOR_LIGHTRED, string);
	}
	SaveAccount(playerid);
	return 1;
}
/*
forward OnLoadPlayerWeapons(playerid);
public OnLoadPlayerWeapons(playerid)
{
	new rows = cache_num_rows();
	if(rows)
	{
		static
			weaponid,
			ammo;

		//for(new i; i < rows; i++)
		for(new i = 0; i < rows; i++) // loop through all the rows that were found
		{
			cache_get_value_name_int(i, "weaponid", weaponid);
			cache_get_value_name_int(i, "ammo", ammo);
			if(!(0 <= weaponid <= 46)) // check if weapon is valid (should be)
			{
				printf("Warning: OnLoadPlayerWeapons - Unknown weaponid '%d'. Pulando.", weaponid);
				continue;
			}
			GiveWeaponToPlayer(playerid, weaponid, ammo);
		}
	}
    return 1;
}*/

CMD:mudarsenha(playerid, params[])
{
	new string[128];
	format(string, sizeof(string), "{FFFFFF}Troca de senha de acesso ao servidor\nDigite a nova senha que você deseja em sua conta.");
	Dialog_Show(playerid, DIALOG_PASSWORDCHANGE, DIALOG_STYLE_PASSWORD, "Trocar senha", string, "Mudar", "Fechar");
	return 1;
}

CMD:pegaradm(playerid, params[])
{
	PlayerInfo[playerid][user_admin] = 5;
	SendClientMessage(playerid, -1, "Você pegou ADM nível 5!");
	SaveAccount(playerid);
	return 1;
}
Dialog:DIALOG_PASSWORDCHANGE(playerid, response, listitem, inputtext[])
{
	if(response)
	{
bcrypt_hash(inputtext, BCRYPT_COST, "OnPasswordChanged", "i", playerid);
	}
	return 1;
}

public OnPlayerClickMap(playerid, Float:fX, Float:fY, Float:fZ)
{
	if(PlayerInfo[playerid][user_admin] >= 4)
	{
		SetPVarFloat(playerid, "FindX", fX);
		SetPVarFloat(playerid, "FindY", fY);
		SetPVarFloat(playerid, "FindZ", fZ);
		ShowPlayerDialog(playerid, 4600, DIALOG_STYLE_MSGBOX, "Teleporte Mapa", "Você deseja ir ao local que marcou no mapa?", #Sim, #Não);
	}
	return 1;
}

Crate_Delete(crateid)
{
	if (crateid != -1 && CrateData[crateid][crateExists])
	{
		/*new
			string[64];

		format(string, sizeof(string), "DELETE FROM `crates` WHERE `crateID` = '%d'", CrateData[crateid][crateID]);
		mysql_tquery(g_iHandle, string);*/

		if (IsValidDynamic3DTextLabel(CrateData[crateid][crateText3D]))
			DestroyDynamic3DTextLabel(CrateData[crateid][crateText3D]);

		if (IsValidDynamicObject(CrateData[crateid][crateObject]))
			DestroyDynamicObject(CrateData[crateid][crateObject]);

		/*foreach (new i : Player) if (PlayerInfo[i][pCarryCrate] == crateid) {
			PlayerInfo[i][pCarryCrate] = -1;

			RemovePlayerAttachedObject(i, 4);
			SetPlayerSpecialAction(i, SPECIAL_ACTION_NONE);
		}*/
		CrateData[crateid][crateExists] = false;
		CrateData[crateid][crateID] = 0;
		CrateData[crateid][crateVehicle] = INVALID_VEHICLE_ID;
	}
	return 1;
}

forward PlayerCheck();
public PlayerCheck()
{
	TotalledCheck();
	static
		str[128];

	foreach (new i : Player)
	{
		//if (GetPlayerSpecialAction(i) == SPECIAL_ACTION_USEJETPACK && !PlayerInfo[i][pJetpack])
		if (GetPlayerSpecialAction(i) == SPECIAL_ACTION_USEJETPACK)
		{
			new string [128];
			format(string, sizeof(string), "AdmCmd: %s spawnou um jetpack usando hack.", pNome(i));
			ABroadCast(COLOR_LIGHTRED, string, 1);
			format(string, sizeof string, " `LOG-CHEAT:` [%s] **%s** (%s) spawnou um jetpack usando hack.", ReturnDate(), pNome(i), ReturnIP(i));
			DCC_SendChannelMessage(DC_Logs1, string);
		}
		if (GetPlayerSpeed(i) > 210 && PlayerInfo[i][user_admin] < 1)
		{
			if (!IsAPlane(GetPlayerVehicleID(i)) && GetPlayerState(i) != PLAYER_STATE_PASSENGER)
			{
				new string [128];
				format(string, sizeof(string), "AdmCmd: %s provavelmente está utilizando Speed Hack (%.0f mph).", pNome(i), GetPlayerSpeed(i));
				ABroadCast(COLOR_LIGHTRED, string, 1);
				format(string, sizeof string, " `LOG-CHEAT:` [%s] **%s** (%s) provavelmente está utilizando Speed Hack (%.0f mph).", ReturnDate(), pNome(i), ReturnIP(i), GetPlayerSpeed(i));
				DCC_SendChannelMessage(DC_Logs1, string);
			}
		}
		else if (PlayerInfo[i][pGraffiti] != -1 && PlayerInfo[i][pGraffitiTime] > 0)
		{
			if (Graffiti_Nearest(i) != PlayerInfo[i][pGraffiti])
			{
				PlayerInfo[i][pGraffiti] = -1;
				PlayerInfo[i][pGraffitiTime] = 0;
			}
			else
			{
			PlayerInfo[i][pGraffitiTime]--;

			if (PlayerInfo[i][pGraffitiTime] < 1){
			strunpack(str, PlayerInfo[i][pGraffitiText]);
			format(GraffitiData[PlayerInfo[i][pGraffiti]][graffitiText], 64, str);

			GraffitiData[PlayerInfo[i][pGraffiti]][graffitiColor] = PlayerInfo[i][pGraffitiColor];

			Graffiti_Refresh(PlayerInfo[i][pGraffiti]);
			Graffiti_Save(PlayerInfo[i][pGraffiti]);

			ClearAnimations(i, 1);
			SendNearbyMessage(i, 30.0, COLOR_PURPLE, "* %s finaliza a pichação.", pNome(i));

			PlayerInfo[i][pGraffiti] = -1;
			PlayerInfo[i][pGraffitiTime] = 0;
			}
			}
		}
		else if (PlayerInfo[i][pBleeding] && PlayerInfo[i][pBleedTime] > 0)
		{
		    if (--PlayerInfo[i][pBleedTime] == 0)
		    {
		        SetPlayerHealth(i, ReturnHealth(i) - 5.0);
			    PlayerInfo[i][pBleedTime] = 10;
			}
		}
		else if (PlayerInfo[i][pJailTime] > 0)
		{
		    static
		        hours,
		        minutes,
		        seconds;

		    PlayerInfo[i][pJailTime]--;

			GetElapsedTime(PlayerInfo[i][pJailTime], hours, minutes, seconds);

		    if (!PlayerInfo[i][pJailTime])
		    {
		        PlayerInfo[i][pPrisoned] = 0;

		        //SetDefaultSpawn(i);
		        //ShowHungerTextdraw(i, 1);

				SendServerMessage(i, "Você pagou a sua dívida com a sociedade.");
			}
		}
		else if (PlayerInfo[i][pStunned] > 0)
		{
            PlayerInfo[i][pStunned]--;

			if (GetPlayerAnimationIndex(i) != 388)
            	ApplyAnimation(i, "CRACK", "crckdeth4", 4.0, 0, 0, 0, 1, 0, 1);

            if (!PlayerInfo[i][pStunned])
            {
                TogglePlayerControllable(i, 1);
			}
		}
	}
	return 1;
}

public OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ)
{
	if (weaponid == 23 && PlayerInfo[playerid][pTazer] && GetFactionType(playerid) == FACTION_POLICE) {
	    PlayerPlaySoundEx(playerid, 6003);
	}
	return 1;
}
public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(strlen(inputtext) > 128)return SendClientMessage(playerid, COLOR_GREY, "O link que você digitou está muito grande !");
	if(strfind(inputtext,"%", true) != -1)return SendClientMessage(playerid, COLOR_GREY, "Você não pode usar esse tipo de caractere.");

	if(dialogid == 4600)
	{
		if(!response)return SendClientMessage(playerid, COLOR_GRAD1, "Você não quis ir ao local que marcou no mapa.");
		if(PlayerInfo[playerid][user_admin] >= 4)
		{
			SetPlayerPos(playerid, GetPVarFloat(playerid, "FindX"), GetPVarFloat(playerid, "FindY"), GetPVarFloat(playerid, "FindZ")+4);
			SendClientMessage(playerid, COLOR_GRAD1, "Você foi ao local que marcou no mapa.");
		}
		return true;
	}
	house_OnDialogResponse(playerid, dialogid, response, listitem, inputtext);
	wf_OnDialogResponse(playerid, dialogid, response, listitem, inputtext);
	gat_OnDialogResponse(playerid, dialogid, response, listitem, inputtext);
	co_OnDialogResponse(playerid, dialogid, response, listitem, inputtext);
	bank_OnDialogResponse(playerid, dialogid, response, listitem, inputtext);
	return true;
}

forward OnPasswordChanged(playerid);
public OnPasswordChanged(playerid)
{
	new hash[BCRYPT_HASH_LENGTH], query[300];
	bcrypt_get_hash(hash);
	mysql_format(Database, query, sizeof(query), "UPDATE `players` SET `Password` = '%e' WHERE `Username` = '%e'", hash, GetName(playerid));
	mysql_query(Database, query);
	SaveAccount(playerid);
	SendClientMessage(playerid, -1, "Você trocou a senha com sucesso.");
	return 1;
}

GetName(playerid)
{
	new name[MAX_PLAYER_NAME];
	GetPlayerName(playerid, name, sizeof(name));
	return name;
}

ReturnIP(playerid)
{
	new PlayerIP[17];
	GetPlayerIp(playerid, PlayerIP, sizeof(PlayerIP));
	return PlayerIP;
}

public OnPlayerTakeDamage(playerid, issuerid, Float:amount, weaponid, bodypart)
{
	inj_OnPlayerTakeDamage(playerid, issuerid, weaponid, bodypart);
	dmg_OnPlayerTakeDamage(playerid, Float: amount, weaponid, bodypart);
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
	ovni_OnVehicleDeath(vehicleid);
	veh_OnVehicleDeath(vehicleid);
	return 1;
}

forward ProxDetector(Float:radi, playerid, string[], col1, col2, col3, col4, col5);
public ProxDetector(Float:radi, playerid, string[], col1, col2, col3, col4, col5)
{
	if(IsPlayerConnected(playerid))
	{
		new Float:posx, Float:posy, Float:posz;
		new Float:oldposx, Float:oldposy, Float:oldposz;
		new Float:tempposx, Float:tempposy, Float:tempposz;
		GetPlayerPos(playerid, oldposx, oldposy, oldposz);
		for(new i = 0; i < MAX_PLAYERS; i++)
		{
			if(IsPlayerConnected(i))
			{
				GetPlayerPos(i, posx, posy, posz);
				tempposx = (oldposx -posx);
				tempposy = (oldposy -posy);
				tempposz = (oldposz -posz);
				if (((tempposx < radi/16) && (tempposx > -radi/16)) && ((tempposy < radi/16) && (tempposy > -radi/16)) && ((tempposz < radi/16) && (tempposz > -radi/16)))
				{
					SendClientMessage(i, col1, string);
				}
				else if (((tempposx < radi/8) && (tempposx > -radi/8)) && ((tempposy < radi/8) && (tempposy > -radi/8)) && ((tempposz < radi/8) && (tempposz > -radi/8)))
				{
					SendClientMessage(i, col2, string);
				}
				else if (((tempposx < radi/4) && (tempposx > -radi/4)) && ((tempposy < radi/4) && (tempposy > -radi/4)) && ((tempposz < radi/4) && (tempposz > -radi/4)))
				{
					SendClientMessage(i, col3, string);
				}
				else if (((tempposx < radi/2) && (tempposx > -radi/2)) && ((tempposy < radi/2) && (tempposy > -radi/2)) && ((tempposz < radi/2) && (tempposz > -radi/2)))
				{
					SendClientMessage(i, col4, string);
				}
				else if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
				{
					SendClientMessage(i, col5, string);
				}
			}
		}
	}
	return 1;
}

stock AdminRankName(playerid)
{
	new astring[28];
	if (PlayerInfo[playerid][user_admin] == 1)format(astring, sizeof(astring), "Tester");
	else if (PlayerInfo[playerid][user_admin] == 2)format(astring, sizeof(astring), "Game Admin");
	else if (PlayerInfo[playerid][user_admin] == 3)format(astring, sizeof(astring), "Senior Admin");
	else if (PlayerInfo[playerid][user_admin] == 4)format(astring, sizeof(astring), "Lead Admin");
	else if (PlayerInfo[playerid][user_admin] == 5)format(astring, sizeof(astring), "Head Admin");
	return astring;
}

stock ProxDetectorS(Float:radi, playerid, targetid)
{
	if(IsPlayerConnected(targetid))
	{
		new Float:posx, Float:posy, Float:posz;
		GetPlayerPos(targetid, posx, posy, posz);
		if (IsPlayerInRangeOfPoint(playerid, radi, posx, posy, posz))
		{
			return true;
		}
	}
	return 0;
}

stock SendClientMessageInRange(Float:_r, playerid, _s[],c1,c2,c3,c4,c5)
{
	new Float:_x, Float:_y, Float:_z;
	new BigEar[MAX_PLAYERS];
	GetPlayerPos(playerid, _x, _y, _z);
	for(new i = 0, j = GetPlayerPoolSize(); i <= j; i++)
	{
		if(!BigEar[i])
		{
			if(GetPlayerVirtualWorld(i) != GetPlayerVirtualWorld(playerid))continue;
			if(GetPlayerDistanceFromPoint(i,_x,_y,_z) < _r/16)
			SendClientMessage(i, c1, _s);
			else if(GetPlayerDistanceFromPoint(i,_x,_y,_z) < _r/8)
			SendClientMessage(i, c2, _s);
			else if(GetPlayerDistanceFromPoint(i,_x,_y,_z) < _r/4)
			SendClientMessage(i, c3, _s);
			else if(GetPlayerDistanceFromPoint(i,_x,_y,_z) < _r/2)
			SendClientMessage(i, c4, _s);
			else if(GetPlayerDistanceFromPoint(i,_x,_y,_z) < _r)
			SendClientMessage(i, c5, _s);
		}
		else
		{
			SendClientMessage(i, c1, _s);
		}
	}
	return true;
}

forward Float:GetDistanceBetweenPoints(Float:x1,Float:y1,Float:z1,Float:x2,Float:y2,Float:z2);
public Float:GetDistanceBetweenPoints(Float:x1,Float:y1,Float:z1,Float:x2,Float:y2,Float:z2)
{
	new Float:val = floatadd(floatadd(floatsqroot(floatpower(floatsub(x1,x2),2)),floatsqroot(floatpower(floatsub(y1,y2),2))),floatsqroot(floatpower(floatsub(z1,z2),2)));
	return val;
}

forward Float:GetDistanceToPoint(playerid,Float:x1,Float:y1,Float:z1);
public Float:GetDistanceToPoint(playerid,Float:x1,Float:y1,Float:z1)
{
	if (PlayerInfo[playerid][user_logged])
	{
		new Float:x2,Float:y2,Float:z2;
		GetPlayerPos(playerid,x2,y2,z2);
		return GetDistanceBetweenPoints(x1,y1,z1,x2,y2,z2);
	}
	return 999999999.9;
}

forward GetDistanceBetweenPlayers(playerid,playerid2);
public GetDistanceBetweenPlayers(playerid,playerid2)
{
	new Float:x1,Float:y1,Float:z1,Float:x2,Float:y2,Float:z2;
	new Float:tmpdis;
	GetPlayerPos(playerid,x1,y1,z1);
	GetPlayerPos(playerid2,x2,y2,z2);
	tmpdis = floatsqroot(floatpower(floatabs(floatsub(x2,x1)),2)+floatpower(floatabs(floatsub(y2,y1)),2)+floatpower(floatabs(floatsub(z2,z1)),2));
	return floatround(tmpdis);
}

stock pNome(playerid)
{
	new name[MAX_PLAYER_NAME];
	GetPlayerName(playerid, name, sizeof(name));
	for(new i = 0; i < MAX_PLAYER_NAME; i++)
	{
		if(name[i] == '_') name[i] = ' ';
	}
	return name;
}

forward JailRelease(playerid);
public JailRelease(playerid)
{
	foreach(new i: Player)
	{
		if(PlayerInfo[i][pJailed])
		{
			PlayerInfo[i][pJailedTime]--;
			if(PlayerInfo[i][pJailedTime] < 1)
			{
				new string[256];
				PlayerInfo[i][pJailed] = false;
				PlayerInfo[i][pJailedTime] = 0;
				SetPlayerVirtualWorld(i, 0);
				SetPlayerInterior(i, 0);
				SetPlayerPos(i, 1642.2025,-2335.0376,-2.6797);
				SetPlayerHealth(playerid, 100);
				SendClientMessage(i, COLOR_YELLOW, "SERVER: Você cumpriu sua pena com o servidor e foi solto.");
				format(string, sizeof(string), "AdmCmd: %s foi solto da prisão administrativa após cumprir sua pena.", GetName(i));
				ABroadCast(COLOR_LIGHTRED, string, 1);
			}
		}
	}
	return 1;
}

NameIsRP(name[])
{
	new len;
	len=strlen(name[0]);
	if(InvalidCaps(name[0]) || NumOccurences(name[0],'_') != 1) return 0;
	while(len--) {
	if(IsInvalid(name[len])) return 0;
	}
	if(TooManyCaps(name[0])) return 0;
	if(ConsecutiveCaps(name[0])) return 0;
	if(CapsOnEnd(name[0])) return 0;
	if(TooShortOnEnd(name[0])) return 0;
	return 1;
}

TooShortOnEnd(name[])
{
	new pnt;
	pnt=FirstSeperationLoc(name[0]);
	name[pnt]=0;
	if((strlen(name[0])<3)||strlen(name[pnt+1])<3) {
	name[pnt]='_';
	return 1;
	}
	name[pnt]='_';
	return 0;
}
CapsOnEnd(name[])
{
	new sz;
	sz=strlen(name[0]);
	if(IsUpper(name[sz-1])) return 1;
	if(IsUpper(name[FirstSeperationLoc(name[0])-1])) return 1;
	return 0;
}
ConsecutiveCaps(name[])
{
	new sz,lastcaps;
	sz=strlen(name[0]);
	while(sz--) {
	if(IsUpper(name[sz])) {
	if(lastcaps==1) {
	return 1;
	}
	lastcaps=1;
	} else lastcaps=0;
	}
	return 0;
}
IsUpper(ch)
{
	if(ch>64&&ch<91) return 1;
	return 0;
}
TooManyCaps(name[])
{
	new Float:caps,num,sz;
	sz=strlen(name[0]);
	while(sz--) {
	if(IsUpper(name[sz])) num++;
	}
	caps=floatdiv(num,float(strlen(name[0])-1));
	caps=floatmul(caps,float(100));
	if(caps>40) return 1;
	return 0;
}
InvalidCaps(string[])
{
	if(!IsUpper(string[0])||!IsUpper(string[FirstSeperationLoc(string[0])+1])) return 1;
	return 0;
}
FirstSeperationLoc(string[])
{
	new stringl;
	stringl=strlen(string);
	while(stringl--) {
	if(string[stringl]=='_') return stringl;
	}
	return 0;
}
NumOccurences(string[],ch)
{
	new num=0,stringl;
	stringl=strlen(string);
	while(stringl--) {
	if(string[stringl]==ch) num++;
	}
	return num;
}

IsInvalid(x)
{
	if(x==95) return 0;
	if(x>64&&x<91) return 0;
	if(x>96&&x<123) return 0;
	return 1;
}

IsNumeric(const str[])
{
	for (new i = 0, l = strlen(str); i != l; i ++)
	{
if (i == 0 && str[0] == '-')
	continue;

else if (str[i] < '0' || str[i] > '9')
	return 0;
	}
	return 1;
}

stock getVehicleName(vehicleid){
	new vehmodel = GetVehicleModel(vehicleid);
	new nameVeh[75];

	if (vehmodel < 400 || vehmodel > 611) {
		strcat(nameVeh, "Nenhum");
		return nameVeh;
	}
	strcat(nameVeh, VehicleNames[vehmodel - 400]);
	return nameVeh;
}

stock UpdateWeapons(playerid)
{
	for (new i = 0; i < 13; i ++) if (PlayerInfo[playerid][pGuns][i])
	{
		if ((i == 2 && PlayerInfo[playerid][pTazer]) || (i == 3 && PlayerInfo[playerid][pBeanBag]))
		continue;

		GetPlayerWeaponData(playerid, i, PlayerInfo[playerid][pGuns][i], PlayerInfo[playerid][pAmmo][i]);

		if (PlayerInfo[playerid][pGuns][i] != 0 && !PlayerInfo[playerid][pAmmo][i]) {
			PlayerInfo[playerid][pGuns][i] = 0;
		}
	}
	return 1;
}

stock GiveGMX()
{

	foreach(new i : Player)
	{
		SendClientMessage(i, COLOR_LIGHTRED, "O servidor sofrerá um GMX em cinco minutos. Finalize o que você está fazendo e deslogue.");
		SaveAccount(i);
		printf("[GMX] Reiniciando o servidor em cinco minutos.");
	}
	SetTimer("GMXA", 300000, 0);
}
forward GMXA();
public GMXA()
{
	foreach(new i : Player)
	{
		SendClientMessage(i, COLOR_YELLOW, "O servidor sofrerá um GMX AGORA. Você será KICKADO.");
		SaveAccount(i);
		Kick(i);
		printf("[GMX] Reiniciando o servidor.");
	}
	SetTimer("GMXF", 400, 0);
}
forward GMXF();
public GMXF()
{
	foreach(new i : Player)
	{
		SendRconCommand("gmx");
	}
}

WW::DestroyMe(objectid)
{
	return DestroyObject(objectid);
}

stock NomeArma(armaid)
{
	new nomegun[35];
	if(armaid < 1 || armaid > 47)nomegun = "Nenhuma";
	else if(armaid == 18)nomegun = "Molotov";
	else if(armaid == 44 || armaid == 45)nomegun = "Visão Noturna";
	else if(armaid == 47)nomegun = "Explosivo";
	else GetWeaponName(armaid, nomegun, sizeof nomegun);
	return nomegun;
}

ReturnWeaponName(weaponid)
{
	static
		name[32];

	GetWeaponName(weaponid, name, sizeof(name));

	if (!weaponid)
		name = "Nenhuma";

	else if (weaponid == 18)
		name = "Molotov";

	else if (weaponid == 44)
		name = "Visão Noturna";

	else if (weaponid == 45)
		name = "Explosivo";

	return name;
}

GiveMoney(playerid, amount)
{
	PlayerInfo[playerid][user_cash] += amount;
	GivePlayerMoney(playerid, amount);
	return 1;
}

GiveMaterial(playerid, amount)
{
	PlayerInfo[playerid][pMaterial] += amount;
	return 1;
}

GetMaterial(playerid)
{
	return (PlayerInfo[playerid][pMaterial]);
}

GetMoney(playerid)
{
	return (PlayerInfo[playerid][user_cash]);
}

stock IsPlayerInWater(playerid)
{
	new anim = GetPlayerAnimationIndex(playerid);
	if (((anim >=  1538) && (anim <= 1542)) || (anim == 1544) || (anim == 1250) || (anim == 1062)) return true;
	return false;
}

stock SaveLogs(log[], string[])
{
	new entry[256], strlog[128],
	dia, mes, ano, hora, minuto, segundo;

	getdate(ano, mes, dia);
	gettime(hora, minuto, segundo);

	format(entry, sizeof(entry), "[%02d/%02d/%02d - %02d:%02d:%02d] - %s\r\n",
	dia, mes, ano, hora, minuto, segundo, string);

	new File:hFile;
	format(strlog, sizeof strlog, Pasta_Logs, log);
	hFile = fopen(strlog, io_append);
	fwrite(hFile, entry);
	fclose(hFile);
	return 0;
}

stock SendClientMessageEx(playerid, color, const text[], {Float, _}:...)
{
	static
args,
str[144];

	if ((args = numargs()) == 3)
	{
SendClientMessage(playerid, color, text);
	}
	else
	{
while (--args >= 3)
{
	#emit LCTRL 5
	#emit LOAD.alt args
	#emit SHL.C.alt 2
	#emit ADD.C 12
	#emit ADD
	#emit LOAD.I
	#emit PUSH.pri
}
#emit PUSH.S text
#emit PUSH.C 144
#emit PUSH.C str
#emit PUSH.S 8
#emit SYSREQ.C format
#emit LCTRL 5
#emit SCTRL 4

SendClientMessage(playerid, color, str);

#emit RETN
	}
	return 1;
}

SendPlayerToPlayer(playerid, targetid)
{
	new
		Float:x,
		Float:y,
		Float:z;

	GetPlayerPos(targetid, x, y, z);

	if (IsPlayerInAnyVehicle(playerid))
	{
		SetVehiclePos(GetPlayerVehicleID(playerid), x, y + 2, z);
		LinkVehicleToInterior(GetPlayerVehicleID(playerid), GetPlayerInterior(targetid));
	}
	else

	SetPlayerPos(playerid, x + 1, y, z);

	SetPlayerInterior(playerid, GetPlayerInterior(targetid));
	SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(targetid));

	PlayerInfo[playerid][pHouse] = PlayerInfo[targetid][pHouse];
	//PlayerInfo[playerid][pBusiness] = PlayerInfo[targetid][pBusiness];
	PlayerInfo[playerid][pEntrance] = PlayerInfo[targetid][pEntrance];
	//PlayerInfo[playerid][pHospitalInt]  = PlayerInfo[targetid][pHospitalInt];
}

stock SendNearbyMessage(playerid, Float:radius, color, const str[], {Float,_}:...)
{
	static
		args,
		start,
		end,
		string[144];

	#emit LOAD.S.pri 8
	#emit STOR.pri args

	if (args > 16)
	{
		#emit ADDR.pri str
		#emit STOR.pri start

		for (end = start + (args - 16); end > start; end -= 4)
		{
			#emit LREF.pri end
			#emit PUSH.pri
		}
		#emit PUSH.S str
		#emit PUSH.C 144
		#emit PUSH.C string

		#emit LOAD.S.pri 8
		#emit CONST.alt 4
		#emit SUB
		#emit PUSH.pri

		#emit SYSREQ.C format
		#emit LCTRL 5
		#emit SCTRL 4

		foreach (new i : Player)
		{
				if (IsPlayerNearPlayer(i, playerid, radius)) {
			SendClientMessage(i, color, string);
			}
		}
		return 1;
	}
	foreach (new i : Player)
	{
		if (IsPlayerNearPlayer(i, playerid, radius)) {
			SendClientMessage(i, color, str);
		}
	}
	return 1;
}

stock GetWeapon(playerid)
{
	new weaponid = GetPlayerWeapon(playerid);

	if (1 <= weaponid <= 46 && PlayerInfo[playerid][pGuns][g_aWeaponSlots[weaponid]] == weaponid)
		return weaponid;

	return 0;
}

GiveWeaponToPlayer(playerid, weaponid, ammo)
{
	if (weaponid < 0 || weaponid > 46)
	return 0;

	PlayerInfo[playerid][pGuns][g_aWeaponSlots[weaponid]] = weaponid;
	PlayerInfo[playerid][pAmmo][g_aWeaponSlots[weaponid]] += ammo;

	return GivePlayerWeapon(playerid, weaponid, ammo);
}

SetWeapons(playerid)
{
	ResetPlayerWeapons(playerid);

	for (new i = 0; i < 13; i ++) if (PlayerInfo[playerid][pGuns][i] > 0 && PlayerInfo[playerid][pAmmo][i] > 0) {
		GivePlayerWeapon(playerid, PlayerInfo[playerid][pGuns][i], PlayerInfo[playerid][pAmmo][i]);
	}
	return 1;
}

ResetWeapons(playerid)
{
	ResetPlayerWeapons(playerid);

	for (new i = 0; i < 13; i ++) {
		PlayerInfo[playerid][pGuns][i] = 0;
		PlayerInfo[playerid][pAmmo][i] = 0;
	}
	return 1;
}

ResetWeapon(playerid, weaponid)
{
	ResetPlayerWeapons(playerid);

	for (new i = 0; i < 13; i ++)
	{
		if (PlayerInfo[playerid][pGuns][i] != weaponid) {
			GivePlayerWeapon(playerid, PlayerInfo[playerid][pGuns][i], PlayerInfo[playerid][pAmmo][i]);
		}
		else {
			PlayerInfo[playerid][pGuns][i] = 0;
			PlayerInfo[playerid][pAmmo][i] = 0;
		}
	}
	return 1;
}

stock IsPlayerSpawned(playerid)
{
	if (playerid < 0 || playerid >= MAX_PLAYERS)
		return 0;

	return (GetPlayerState(playerid) != PLAYER_STATE_SPECTATING && GetPlayerState(playerid) != PLAYER_STATE_NONE && GetPlayerState(playerid) != PLAYER_STATE_WASTED);
}

stock PlayerHasWeapon(playerid, weaponid)
{
	new
		weapon,
		ammo;

	for (new i = 0; i < 13; i ++) if (PlayerInfo[playerid][pGuns][i] == weaponid)
	{
		GetPlayerWeaponData(playerid, i, weapon, ammo);

		if (weapon == weaponid && ammo > 0) return 1;
	}
	return 0;
}

stock ReturnDate()
{
	new sendString[90], month, day, year;
	new hour, minute, second;

	gettime(hour, minute, second);
	getdate(year, month, day);

	format(sendString, 90, "%d/%d/%d - %02d:%02d:%02d", day, month, year, hour, minute, second);
	return sendString;
}

stock GetInitials(const string[])
{
	new
		ret[32],
		index = 0;

	for (new i = 0, l = strlen(string); i != l; i ++)
	{
		if (('A' <= string[i] <= 'Z') && (i == 0 || string[i - 1] == ' '))
			ret[index++] = string[i];
	}
	return ret;
}

stock ApplyAnimationEx(playerid, animlib[], animname[], Float:fDelta, loop, lockx, locky, freeze, time, forcesync = 0)
{
	ApplyAnimation(playerid, animlib, animname, fDelta, loop, lockx, locky, freeze, time, forcesync);

	PlayerInfo[playerid][pLoopAnim] = true;
	return 1;
}

stock PlayerHasTazer(playerid)
{
	return (GetPlayerWeapon(playerid) == 23 && PlayerInfo[playerid][pTazer]);
}

stock PlayerHasBeanBag(playerid)
{
	return (GetPlayerWeapon(playerid) == 25 && PlayerInfo[playerid][pBeanBag]);
}

ReturnArmour(playerid)
{
	static
	    Float:amount;

	GetPlayerArmour(playerid, amount);
	return floatround(amount, floatround_round);
}

ReturnHealth(playerid)
{
	static
	    Float:amount;

	GetPlayerHealth(playerid, amount);
	return floatround(amount, floatround_round);
}

stock GetElapsedTime(time, &hours, &minutes, &seconds)
{
	hours = 0;
	minutes = 0;
	seconds = 0;

	if (time >= 3600)
	{
		hours = (time / 3600);
		time -= (hours * 3600);
	}
	while (time >= 60)
	{
	    minutes++;
	    time -= 60;
	}
	return (seconds = time);
}

stock PlayerPlaySoundEx(playerid, sound)
{
	new
	    Float:x,
	    Float:y,
	    Float:z;

	GetPlayerPos(playerid, x, y, z);

	foreach (new i : Player) if (IsPlayerInRangeOfPoint(i, 20.0, x, y, z)) {
	    PlayerPlaySound(i, sound, x, y, z);
	}
	return 1;
}


stock SetPlayerPosEx(playerid, Float:x, Float:y, Float:z, time = 2000)
{
	if (PlayerInfo[playerid][pFreeze])
	{
	    KillTimer(PlayerInfo[playerid][pFreezeTimer]);

	    PlayerInfo[playerid][pFreeze] = 0;
	    TogglePlayerControllable(playerid, 1);
	}
	SetPlayerPos(playerid, x, y, z + 0.5);
	TogglePlayerControllable(playerid, 0);

	PlayerInfo[playerid][pFreeze] = 1;
	PlayerInfo[playerid][pFreezeTimer] = SetTimerEx("SetPlayerToUnfreeze", time, false, "dfff", playerid, x, y, z);
	return 1;
}

forward SetPlayerToUnfreeze(playerid, Float:x, Float:y, Float:z);
public SetPlayerToUnfreeze(playerid, Float:x, Float:y, Float:z)
{
	if (!IsPlayerInRangeOfPoint(playerid, 15.0, x, y, z))
	    return 0;

	PlayerInfo[playerid][pFreeze] = 0;

	SetPlayerPos(playerid, x, y, z);
	TogglePlayerControllable(playerid, 1);
	return 1;
}

stock GetPlayerSkinID(playerid) return (GetPlayerCustomSkin(playerid) ? GetPlayerCustomSkin(playerid) : GetPlayerSkin(playerid));
