static const VEHICLE_NAMES[][] = {
	"Landstalker", "Bravura", "Buffalo", "Linerunner", "Perrenial", "Sentinel", "Dumper", "Firetruck", "Trashmaster", "Stretch",
	"Manana", "Infernus", "Voodoo", "Pony", "Mule", "Cheetah", "Ambulance", "Leviathan", "Moonbeam", "Esperanto", "Taxi",
	"Washington", "Bobcat", "Mr Whoopee", "BF Injection", "Hunter", "Premier", "Enforcer", "Securicar", "Banshee", "Predator",
	"Bus", "Rhino", "Barracks", "Hotknife", "Trailer 1", "Previon", "Coach", "Cabbie", "Stallion", "Rumpo", "RC Bandit", "Romero",
	"Packer", "Monster", "Admiral", "Squalo", "Seasparrow", "Pizzaboy", "Tram", "Trailer 2", "Turismo", "Speeder", "Reefer", "Tropic",
	"Flatbed", "Yankee", "Caddy", "Solair", "Berkley's RC Van", "Skimmer", "PCJ-600", "Faggio", "Freeway", "RC Baron", "RC Raider",
	"Glendale", "Oceanic", "Sanchez", "Sparrow", "Patriot", "Quad", "Coastguard", "Dinghy", "Hermes", "Sabre", "Rustler", "ZR-350",
	"Walton", "Regina", "Comet", "BMX", "Burrito", "Camper", "Marquis", "Baggage", "Dozer", "Maverick", "News Chopper", "Rancher",
	"FBI Rancher", "Virgo", "Greenwood", "Jetmax", "Hotring", "Sandking", "Blista Compact", "Police Maverick", "Boxville", "Benson",
	"Mesa", "RC Goblin", "Hotring Racer A", "Hotring Racer B", "Bloodring Banger", "Rancher", "Super GT", "Elegant", "Journey",
	"Bike", "Mountain Bike", "Beagle", "Cropdust", "Stunt", "Tanker", "Roadtrain", "Nebula", "Majestic", "Buccaneer", "Shamal",
	"Hydra", "FCR-900", "NRG-500", "HPV1000", "Cement Truck", "Tow Truck", "Fortune", "Cadrona", "FBI Truck", "Willard", "Forklift",
	"Tractor", "Combine", "Feltzer", "Remington", "Slamvan", "Blade", "Freight", "Streak", "Vortex", "Vincent", "Bullet", "Clover",
	"Sadler", "Firetruck LA", "Hustler", "Intruder", "Primo", "Cargobob", "Tampa", "Sunrise", "Merit", "Utility", "Nevada", "Yosemite",
	"Windsor", "Monster A", "Monster B", "Uranus", "Jester", "Sultan", "Stratum", "Elegy", "Raindance", "RC Tiger", "Flash", "Tahoma",
	"Savanna", "Bandito", "Freight Flat", "Streak Carriage", "Kart", "Mower", "Duneride", "Sweeper", "Broadway", "Tornado", "AT-400",
	"DFT-30", "Huntley", "Stafford", "BF-400", "Newsvan", "Tug", "Trailer 3", "Emperor", "Wayfarer", "Euros", "Hotdog", "Club",
	"Freight Carriage", "Trailer 3", "Andromada", "Dodo", "RC Cam", "Launch", "Police Car (LSPD)", "Police Car (SFPD)",
	"Police Car (LVPD)", "Police Ranger", "Picador", "S.W.A.T. Tank", "Alpha", "Phoenix", "Glendale", "Sadler", "Luggage Trailer A",
	"Luggage Trailer B", "Stair Trailer", "Boxville", "Farm Plow", "Utility Trailer"
};

static const Float:VEHICLE_TOP_SPEEDS[] = {
	157.0, 147.0, 186.0, 110.0, 133.0, 164.0, 110.0, 148.0, 100.0, 158.0, 129.0, 221.0, 168.0, 110.0, 105.0, 192.0, 154.0, 270.0, 115.0, 149.0,
	145.0, 154.0, 140.0, 99.0,  135.0, 270.0, 173.0, 165.0, 157.0, 201.0, 190.0, 130.0, 94.0,  110.0, 167.0, 0.0,   149.0, 158.0, 142.0, 168.0,
	136.0, 145.0, 139.0, 126.0, 110.0, 164.0, 270.0, 270.0, 111.0, 0.0,   0.0,   193.0, 270.0, 60.0,  135.0, 157.0, 106.0, 95.0,  157.0, 136.0,
	270.0, 160.0, 111.0, 142.0, 145.0, 145.0, 147.0, 140.0, 144.0, 270.0, 157.0, 110.0, 190.0, 190.0, 149.0, 173.0, 270.0, 186.0, 117.0, 140.0,
	184.0, 73.0,  156.0, 122.0, 190.0, 99.0,  64.0,  270.0, 270.0, 139.0, 157.0, 149.0, 140.0, 270.0, 214.0, 176.0, 162.0, 270.0, 108.0, 123.0,
	140.0, 145.0, 216.0, 216.0, 173.0, 140.0, 179.0, 166.0, 108.0, 79.0,  101.0, 270.0,	270.0, 270.0, 120.0, 142.0, 157.0, 157.0, 164.0, 270.0,
	270.0, 160.0, 176.0, 151.0, 130.0, 160.0, 158.0, 149.0, 176.0, 149.0, 60.0,  70.0,  110.0, 167.0, 168.0, 158.0, 173.0, 0.0,   0.0,   270.0,
	149.0, 203.0, 164.0, 151.0, 150.0, 147.0, 149.0, 142.0, 270.0, 153.0, 145.0, 157.0, 121.0, 270.0, 144.0, 158.0, 113.0, 113.0, 156.0, 178.0,
	169.0, 154.0, 178.0, 270.0, 145.0, 165.0, 160.0, 173.0, 146.0, 0.0,   0.0,   93.0,  60.0,  110.0, 60.0,  158.0, 158.0, 270.0, 130.0, 158.0,
	153.0, 151.0, 136.0, 85.0,  0.0,   153.0, 142.0, 165.0, 108.0, 162.0, 0.0,   0.0,   270.0, 270.0, 130.0, 190.0, 175.0, 175.0, 175.0, 158.0,
	151.0, 110.0, 169.0, 171.0, 148.0, 152.0, 0.0,   0.0,   0.0,   108.0, 0.0,   0.0
};

new Text:playerInfoFrameTD[6];
new Text:playerInfoTD[7];
new Text:vehicleInfoFrameTD[2];
new Text:vehicleInfoTD[4];

new PlayerText:playerInfoPTD[MAX_PLAYERS][8];
new PlayerText:vehicleInfoPTD[MAX_PLAYERS][5];

new playerSpectateID[MAX_PLAYERS];
new bool:playerSpectateTypeVehicle[MAX_PLAYERS];

new Iterator:SpectatePlayers<MAX_PLAYERS>;

new playerVirtualWorld[MAX_PLAYERS];

new oldPlayerVirtualWorld[MAX_PLAYERS];
new oldPlayerInterior[MAX_PLAYERS];
new Float:oldPlayerPosition[MAX_PLAYERS][4];
new Float:oldPlayerHealth[MAX_PLAYERS];
new Float:oldPlayerArmour[MAX_PLAYERS];

#define BUTTON_PREVIOUS playerInfoFrameTD[1]
#define BUTTON_NEXT playerInfoFrameTD[2]

CreateTextDraws() {
	/*****************
	* PLAYER INFO FRAME
    *****************/
	playerInfoFrameTD[0] = TextDrawCreate(218.0000, 330.0000, "LD_SPAC:WHITE");
	TextDrawFont(playerInfoFrameTD[0], 4);
	TextDrawLetterSize(playerInfoFrameTD[0], 0.5000, 1.0000);
	TextDrawColor(playerInfoFrameTD[0], 1094795775);
	TextDrawSetShadow(playerInfoFrameTD[0], 0);
	TextDrawSetOutline(playerInfoFrameTD[0], 0);
	TextDrawBackgroundColor(playerInfoFrameTD[0], 255);
	TextDrawSetProportional(playerInfoFrameTD[0], 1);
	TextDrawTextSize(playerInfoFrameTD[0], 200.0000, 70.0000);

	playerInfoFrameTD[1] = TextDrawCreate(219.0000, 331.0000, "LD_SPAC:WHITE");
	TextDrawFont(playerInfoFrameTD[1], 4);
	TextDrawLetterSize(playerInfoFrameTD[1], 0.5000, 1.0000);
	TextDrawColor(playerInfoFrameTD[1], 589505535);
	TextDrawSetShadow(playerInfoFrameTD[1], 0);
	TextDrawSetOutline(playerInfoFrameTD[1], 0);
	TextDrawBackgroundColor(playerInfoFrameTD[1], 255);
	TextDrawSetProportional(playerInfoFrameTD[1], 1);
	TextDrawTextSize(playerInfoFrameTD[1], 30.0000, 68.0000);
	TextDrawSetSelectable(playerInfoFrameTD[1], 1);

	playerInfoFrameTD[2] = TextDrawCreate(387.0000, 331.0000, "LD_SPAC:WHITE");
	TextDrawFont(playerInfoFrameTD[2], 4);
	TextDrawLetterSize(playerInfoFrameTD[2], 0.5000, 1.0000);
	TextDrawColor(playerInfoFrameTD[2], 589505535);
	TextDrawSetShadow(playerInfoFrameTD[2], 0);
	TextDrawSetOutline(playerInfoFrameTD[2], 0);
	TextDrawBackgroundColor(playerInfoFrameTD[2], 255);
	TextDrawSetProportional(playerInfoFrameTD[2], 1);
	TextDrawTextSize(playerInfoFrameTD[2], 30.0000, 68.0000);
	TextDrawSetSelectable(playerInfoFrameTD[2], 1);

	playerInfoFrameTD[3] = TextDrawCreate(250.0000, 331.0000, "LD_SPAC:WHITE");
	TextDrawFont(playerInfoFrameTD[3], 4);
	TextDrawLetterSize(playerInfoFrameTD[3], 0.5000, 1.0000);
	TextDrawColor(playerInfoFrameTD[3], 589505535);
	TextDrawSetShadow(playerInfoFrameTD[3], 0);
	TextDrawSetOutline(playerInfoFrameTD[3], 0);
	TextDrawBackgroundColor(playerInfoFrameTD[3], 255);
	TextDrawSetProportional(playerInfoFrameTD[3], 1);
	TextDrawTextSize(playerInfoFrameTD[3], 136.0000, 68.0000);

	playerInfoFrameTD[4] = TextDrawCreate(224.5000, 349.5000, "LD_BEAT:LEFT");
	TextDrawFont(playerInfoFrameTD[4], 4);
	TextDrawLetterSize(playerInfoFrameTD[4], 0.5000, 1.0000);
	TextDrawColor(playerInfoFrameTD[4], 1684301055);
	TextDrawSetShadow(playerInfoFrameTD[4], 0);
	TextDrawSetOutline(playerInfoFrameTD[4], 0);
	TextDrawBackgroundColor(playerInfoFrameTD[4], 255);
	TextDrawSetProportional(playerInfoFrameTD[4], 1);
	TextDrawTextSize(playerInfoFrameTD[4], 20.0000, 28.0000);

	playerInfoFrameTD[5] = TextDrawCreate(393.5000, 349.5000, "LD_BEAT:RIGHT");
	TextDrawFont(playerInfoFrameTD[5], 4);
	TextDrawLetterSize(playerInfoFrameTD[5], 0.5000, 1.0000);
	TextDrawColor(playerInfoFrameTD[5], 1684301055);
	TextDrawSetShadow(playerInfoFrameTD[5], 0);
	TextDrawSetOutline(playerInfoFrameTD[5], 0);
	TextDrawBackgroundColor(playerInfoFrameTD[5], 255);
	TextDrawSetProportional(playerInfoFrameTD[5], 1);
	TextDrawTextSize(playerInfoFrameTD[5], 20.0000, 28.0000);

	/*****************
	* PLAYER INFO TEXTS
    *****************/
	playerInfoTD[0] = TextDrawCreate(302.0000, 333.5000, "VIGIANDO:");
	TextDrawFont(playerInfoTD[0], 1);
	TextDrawLetterSize(playerInfoTD[0], 0.1399, 0.7999);
	TextDrawColor(playerInfoTD[0], -1768515841);
	TextDrawSetShadow(playerInfoTD[0], 0);
	TextDrawSetOutline(playerInfoTD[0], 0);
	TextDrawBackgroundColor(playerInfoTD[0], 255);
	TextDrawSetProportional(playerInfoTD[0], 1);
	TextDrawTextSize(playerInfoTD[0], 640.0000, 0.0000);

	playerInfoTD[1] = TextDrawCreate(252.0000, 333.5000, "PLAYER_MODEL");
	TextDrawFont(playerInfoTD[1], 5);
	TextDrawLetterSize(playerInfoTD[1], 0.2099, 1.1000);
	TextDrawColor(playerInfoTD[1], -1768515841);
	TextDrawSetShadow(playerInfoTD[1], 0);
	TextDrawSetOutline(playerInfoTD[1], 0);
	TextDrawBackgroundColor(playerInfoTD[1], 1684301055);
	TextDrawSetProportional(playerInfoTD[1], 1);
	TextDrawTextSize(playerInfoTD[1], 49.0000, 49.0000);
	TextDrawSetPreviewModel(playerInfoTD[1], 0);
	TextDrawSetPreviewRot(playerInfoTD[1], 0.0000, 0.0000, 0.0000, 1.0000);

	playerInfoTD[2] = TextDrawCreate(252.0000, 392.0000, "LD_SPAC:WHITE");
	TextDrawFont(playerInfoTD[2], 4);
	TextDrawLetterSize(playerInfoTD[2], 0.2099, 1.1000);
	TextDrawColor(playerInfoTD[2], -1768515841);
	TextDrawSetShadow(playerInfoTD[2], 0);
	TextDrawSetOutline(playerInfoTD[2], 0);
	TextDrawBackgroundColor(playerInfoTD[2], 255);
	TextDrawSetProportional(playerInfoTD[2], 1);
	TextDrawTextSize(playerInfoTD[2], 64.0000, 3.0000);

	playerInfoTD[3] = TextDrawCreate(252.0000, 392.0000, "LD_SPAC:WHITE");
	TextDrawFont(playerInfoTD[3], 4);
	TextDrawLetterSize(playerInfoTD[3], 0.2099, 1.1000);
	TextDrawColor(playerInfoTD[3], -16776961);
	TextDrawSetShadow(playerInfoTD[3], 0);
	TextDrawSetOutline(playerInfoTD[3], 0);
	TextDrawBackgroundColor(playerInfoTD[3], 255);
	TextDrawSetProportional(playerInfoTD[3], 1);
	TextDrawTextSize(playerInfoTD[3], 55.0000, 3.0000);

	playerInfoTD[4] = TextDrawCreate(320.5000, 392.0000, "LD_SPAC:WHITE");
	TextDrawFont(playerInfoTD[4], 4);
	TextDrawLetterSize(playerInfoTD[4], 0.2099, 1.1000);
	TextDrawColor(playerInfoTD[4], -1768515841);
	TextDrawSetShadow(playerInfoTD[4], 0);
	TextDrawSetOutline(playerInfoTD[4], 0);
	TextDrawBackgroundColor(playerInfoTD[4], 255);
	TextDrawSetProportional(playerInfoTD[4], 1);
	TextDrawTextSize(playerInfoTD[4], 64.0000, 3.0000);

	playerInfoTD[5] = TextDrawCreate(321.0000, 392.0000, "LD_SPAC:WHITE");
	TextDrawFont(playerInfoTD[5], 4);
	TextDrawLetterSize(playerInfoTD[5], 0.2099, 1.1000);
	TextDrawColor(playerInfoTD[5], -1);
	TextDrawSetShadow(playerInfoTD[5], 0);
	TextDrawSetOutline(playerInfoTD[5], 0);
	TextDrawBackgroundColor(playerInfoTD[5], 255);
	TextDrawSetProportional(playerInfoTD[5], 1);
	TextDrawTextSize(playerInfoTD[5], 10.5000, 3.0000);

	playerInfoTD[6] = TextDrawCreate(341.0000, 376.0000, "[maximum: 35.0 MPH]");
	TextDrawFont(playerInfoTD[6], 1);
	TextDrawLetterSize(playerInfoTD[6], 0.1199, 0.5999);
	TextDrawColor(playerInfoTD[6], 1684301055);
	TextDrawSetShadow(playerInfoTD[6], 0);
	TextDrawSetOutline(playerInfoTD[6], 0);
	TextDrawBackgroundColor(playerInfoTD[6], 255);
	TextDrawSetProportional(playerInfoTD[6], 1);
	TextDrawTextSize(playerInfoTD[6], 640.0000, 0.0000);

	/*****************
	* VEHICLE INFO FRAME
    *****************/
	vehicleInfoFrameTD[0] = TextDrawCreate(218.0000, 403.5000, "LD_SPAC:WHITE");
	TextDrawFont(vehicleInfoFrameTD[0], 4);
	TextDrawLetterSize(vehicleInfoFrameTD[0], 0.5000, 1.0000);
	TextDrawColor(vehicleInfoFrameTD[0], 1094795775);
	TextDrawSetShadow(vehicleInfoFrameTD[0], 0);
	TextDrawSetOutline(vehicleInfoFrameTD[0], 0);
	TextDrawBackgroundColor(vehicleInfoFrameTD[0], 255);
	TextDrawSetProportional(vehicleInfoFrameTD[0], 1);
	TextDrawTextSize(vehicleInfoFrameTD[0], 200.0000, 32.0000);

	vehicleInfoFrameTD[1] = TextDrawCreate(219.0000, 404.5000, "LD_SPAC:WHITE");
	TextDrawFont(vehicleInfoFrameTD[1], 4);
	TextDrawLetterSize(vehicleInfoFrameTD[1], 0.5000, 1.0000);
	TextDrawColor(vehicleInfoFrameTD[1], 589505535);
	TextDrawSetShadow(vehicleInfoFrameTD[1], 0);
	TextDrawSetOutline(vehicleInfoFrameTD[1], 0);
	TextDrawBackgroundColor(vehicleInfoFrameTD[1], 255);
	TextDrawSetProportional(vehicleInfoFrameTD[1], 1);
	TextDrawTextSize(vehicleInfoFrameTD[1], 198.0000, 30.0000);

	/*****************
	* VEHICLE INFO TEXTS
    *****************/
	vehicleInfoTD[0] = TextDrawCreate(252.0000, 406.0000, "INFO DO VEICULO:");
	TextDrawFont(vehicleInfoTD[0], 1);
	TextDrawLetterSize(vehicleInfoTD[0], 0.1399, 0.7999);
	TextDrawColor(vehicleInfoTD[0], -1768515841);
	TextDrawSetShadow(vehicleInfoTD[0], 0);
	TextDrawSetOutline(vehicleInfoTD[0], 0);
	TextDrawBackgroundColor(vehicleInfoTD[0], 255);
	TextDrawSetProportional(vehicleInfoTD[0], 1);
	TextDrawTextSize(vehicleInfoTD[0], 640.0000, 0.0000);

	vehicleInfoTD[1] = TextDrawCreate(220.5000, 406.5000, "PLAYER_MODEL");
	TextDrawFont(vehicleInfoTD[1], 5);
	TextDrawLetterSize(vehicleInfoTD[1], 0.2099, 1.1000);
	TextDrawColor(vehicleInfoTD[1], -1);
	TextDrawSetShadow(vehicleInfoTD[1], 0);
	TextDrawSetOutline(vehicleInfoTD[1], 0);
	TextDrawBackgroundColor(vehicleInfoTD[1], 842150655);
	TextDrawSetProportional(vehicleInfoTD[1], 1);
	TextDrawTextSize(vehicleInfoTD[1], 30.0000, 26.0000);
	TextDrawSetPreviewModel(vehicleInfoTD[1], 456);
	TextDrawSetPreviewRot(vehicleInfoTD[1], 0.0000, 0.0000, -50.0000, 1.0000);

	vehicleInfoTD[2] = TextDrawCreate(320.5000, 429.0000, "LD_SPAC:WHITE");
	TextDrawFont(vehicleInfoTD[2], 4);
	TextDrawLetterSize(vehicleInfoTD[2], 0.2099, 1.1000);
	TextDrawColor(vehicleInfoTD[2], -1768515841);
	TextDrawSetShadow(vehicleInfoTD[2], 0);
	TextDrawSetOutline(vehicleInfoTD[2], 0);
	TextDrawBackgroundColor(vehicleInfoTD[2], 255);
	TextDrawSetProportional(vehicleInfoTD[2], 1);
	TextDrawTextSize(vehicleInfoTD[2], 94.5000, 3.0000);

	vehicleInfoTD[3] = TextDrawCreate(320.5000, 429.0000, "LD_SPAC:WHITE");
	TextDrawFont(vehicleInfoTD[3], 4);
	TextDrawLetterSize(vehicleInfoTD[3], 0.2099, 1.1000);
	TextDrawColor(vehicleInfoTD[3], -16776961);
	TextDrawSetShadow(vehicleInfoTD[3], 0);
	TextDrawSetOutline(vehicleInfoTD[3], 0);
	TextDrawBackgroundColor(vehicleInfoTD[3], 255);
	TextDrawSetProportional(vehicleInfoTD[3], 1);
	TextDrawTextSize(vehicleInfoTD[3], 94.5000, 3.0000);
}

CreatePlayerTextDraws(playerid) {
	/*****************
	* PLAYER INFO TEXTS
    *****************/
	playerInfoPTD[playerid][0] = CreatePlayerTextDraw(playerid, 302.0000, 340.0000, "Username");
	PlayerTextDrawFont(playerid, playerInfoPTD[playerid][0], 1);
	PlayerTextDrawLetterSize(playerid, playerInfoPTD[playerid][0], 0.2399, 1.3000);
	PlayerTextDrawColor(playerid, playerInfoPTD[playerid][0], -7601921);
	PlayerTextDrawSetShadow(playerid, playerInfoPTD[playerid][0], 0);
	PlayerTextDrawSetOutline(playerid, playerInfoPTD[playerid][0], 0);
	PlayerTextDrawBackgroundColor(playerid, playerInfoPTD[playerid][0], 255);
	PlayerTextDrawSetProportional(playerid, playerInfoPTD[playerid][0], 1);
	PlayerTextDrawTextSize(playerid, playerInfoPTD[playerid][0], 640.0000, 0.0000);

	playerInfoPTD[playerid][1] = CreatePlayerTextDraw(playerid, 302.0000, 351.0000, "ID: 13");
	PlayerTextDrawFont(playerid, playerInfoPTD[playerid][1], 1);
	PlayerTextDrawLetterSize(playerid, playerInfoPTD[playerid][1], 0.1199, 0.5999);
	PlayerTextDrawColor(playerid, playerInfoPTD[playerid][1], 1684301055);
	PlayerTextDrawSetShadow(playerid, playerInfoPTD[playerid][1], 0);
	PlayerTextDrawSetOutline(playerid, playerInfoPTD[playerid][1], 0);
	PlayerTextDrawBackgroundColor(playerid, playerInfoPTD[playerid][1], 255);
	PlayerTextDrawSetProportional(playerid, playerInfoPTD[playerid][1], 1);
	PlayerTextDrawTextSize(playerid, playerInfoPTD[playerid][1], 640.0000, 0.0000);

	playerInfoPTD[playerid][2] = CreatePlayerTextDraw(playerid, 251.5000, 384.0000, "VIDA: ~w~80");
	PlayerTextDrawFont(playerid, playerInfoPTD[playerid][2], 1);
	PlayerTextDrawLetterSize(playerid, playerInfoPTD[playerid][2], 0.1399, 0.7999);
	PlayerTextDrawColor(playerid, playerInfoPTD[playerid][2], -1768515841);
	PlayerTextDrawSetShadow(playerid, playerInfoPTD[playerid][2], 0);
	PlayerTextDrawSetOutline(playerid, playerInfoPTD[playerid][2], 0);
	PlayerTextDrawBackgroundColor(playerid, playerInfoPTD[playerid][2], 255);
	PlayerTextDrawSetProportional(playerid, playerInfoPTD[playerid][2], 1);
	PlayerTextDrawTextSize(playerid, playerInfoPTD[playerid][2], 640.0000, 0.0000);

	playerInfoPTD[playerid][3] = CreatePlayerTextDraw(playerid, 320.5000, 384.0000, "COLETE: ~w~10");
	PlayerTextDrawFont(playerid, playerInfoPTD[playerid][3], 1);
	PlayerTextDrawLetterSize(playerid, playerInfoPTD[playerid][3], 0.1399, 0.7999);
	PlayerTextDrawColor(playerid, playerInfoPTD[playerid][3], -1768515841);
	PlayerTextDrawSetShadow(playerid, playerInfoPTD[playerid][3], 0);
	PlayerTextDrawSetOutline(playerid, playerInfoPTD[playerid][3], 0);
	PlayerTextDrawBackgroundColor(playerid, playerInfoPTD[playerid][3], 255);
	PlayerTextDrawSetProportional(playerid, playerInfoPTD[playerid][3], 1);
	PlayerTextDrawTextSize(playerid, playerInfoPTD[playerid][3], 640.0000, 0.0000);

	playerInfoPTD[playerid][4] = CreatePlayerTextDraw(playerid, 302.0000, 360.5000, "ARMA: ~w~M4 (144)");
	PlayerTextDrawFont(playerid, playerInfoPTD[playerid][4], 1);
	PlayerTextDrawLetterSize(playerid, playerInfoPTD[playerid][4], 0.1399, 0.7999);
	PlayerTextDrawColor(playerid, playerInfoPTD[playerid][4], -1768515841);
	PlayerTextDrawSetShadow(playerid, playerInfoPTD[playerid][4], 0);
	PlayerTextDrawSetOutline(playerid, playerInfoPTD[playerid][4], 0);
	PlayerTextDrawBackgroundColor(playerid, playerInfoPTD[playerid][4], 255);
	PlayerTextDrawSetProportional(playerid, playerInfoPTD[playerid][4], 1);
	PlayerTextDrawTextSize(playerid, playerInfoPTD[playerid][4], 640.0000, 0.0000);

	playerInfoPTD[playerid][5] = CreatePlayerTextDraw(playerid, 302.0000, 368.0000, "DINHEIRO: ~g~$~w~99,242,221");
	PlayerTextDrawFont(playerid, playerInfoPTD[playerid][5], 1);
	PlayerTextDrawLetterSize(playerid, playerInfoPTD[playerid][5], 0.1399, 0.7999);
	PlayerTextDrawColor(playerid, playerInfoPTD[playerid][5], -1768515841);
	PlayerTextDrawSetShadow(playerid, playerInfoPTD[playerid][5], 0);
	PlayerTextDrawSetOutline(playerid, playerInfoPTD[playerid][5], 0);
	PlayerTextDrawBackgroundColor(playerid, playerInfoPTD[playerid][5], 255);
	PlayerTextDrawSetProportional(playerid, playerInfoPTD[playerid][5], 1);
	PlayerTextDrawTextSize(playerid, playerInfoPTD[playerid][5], 640.0000, 0.0000);

	playerInfoPTD[playerid][6] = CreatePlayerTextDraw(playerid, 302.0000, 375.0000, "VELO: ~w~0.2 mps");
	PlayerTextDrawFont(playerid, playerInfoPTD[playerid][6], 1);
	PlayerTextDrawLetterSize(playerid, playerInfoPTD[playerid][6], 0.1399, 0.7999);
	PlayerTextDrawColor(playerid, playerInfoPTD[playerid][6], -1768515841);
	PlayerTextDrawSetShadow(playerid, playerInfoPTD[playerid][6], 0);
	PlayerTextDrawSetOutline(playerid, playerInfoPTD[playerid][6], 0);
	PlayerTextDrawBackgroundColor(playerid, playerInfoPTD[playerid][6], 255);
	PlayerTextDrawSetProportional(playerid, playerInfoPTD[playerid][6], 1);
	PlayerTextDrawTextSize(playerid, playerInfoPTD[playerid][6], 640.0000, 0.0000);

	playerInfoPTD[playerid][7] = CreatePlayerTextDraw(playerid, 384.0000, 333.5000, "1/15");
	PlayerTextDrawFont(playerid, playerInfoPTD[playerid][7], 1);
	PlayerTextDrawLetterSize(playerid, playerInfoPTD[playerid][7], 0.1399, 0.7999);
	PlayerTextDrawAlignment(playerid, playerInfoPTD[playerid][7], 3);
	PlayerTextDrawColor(playerid, playerInfoPTD[playerid][7], -1768515841);
	PlayerTextDrawSetShadow(playerid, playerInfoPTD[playerid][7], 0);
	PlayerTextDrawSetOutline(playerid, playerInfoPTD[playerid][7], 0);
	PlayerTextDrawBackgroundColor(playerid, playerInfoPTD[playerid][7], 255);
	PlayerTextDrawSetProportional(playerid, playerInfoPTD[playerid][7], 1);
	PlayerTextDrawTextSize(playerid, playerInfoPTD[playerid][7], 640.0000, 0.0000);

	/*****************
	* VEHICLE INFO TEXTS
    *****************/
	vehicleInfoPTD[playerid][0] = CreatePlayerTextDraw(playerid, 251.5000, 412.0000, "Truck");
	PlayerTextDrawFont(playerid, vehicleInfoPTD[playerid][0], 1);
	PlayerTextDrawLetterSize(playerid, vehicleInfoPTD[playerid][0], 0.2399, 1.3000);
	PlayerTextDrawColor(playerid, vehicleInfoPTD[playerid][0], -1768515841);
	PlayerTextDrawSetShadow(playerid, vehicleInfoPTD[playerid][0], 0);
	PlayerTextDrawSetOutline(playerid, vehicleInfoPTD[playerid][0], 0);
	PlayerTextDrawBackgroundColor(playerid, vehicleInfoPTD[playerid][0], 255);
	PlayerTextDrawSetProportional(playerid, vehicleInfoPTD[playerid][0], 1);
	PlayerTextDrawTextSize(playerid, vehicleInfoPTD[playerid][0], 640.0000, 0.0000);

	vehicleInfoPTD[playerid][1] = CreatePlayerTextDraw(playerid, 251.5000, 423.5000, "ID: 456");
	PlayerTextDrawFont(playerid, vehicleInfoPTD[playerid][1], 1);
	PlayerTextDrawLetterSize(playerid, vehicleInfoPTD[playerid][1], 0.1199, 0.5999);
	PlayerTextDrawColor(playerid, vehicleInfoPTD[playerid][1], 1684301055);
	PlayerTextDrawSetShadow(playerid, vehicleInfoPTD[playerid][1], 0);
	PlayerTextDrawSetOutline(playerid, vehicleInfoPTD[playerid][1], 0);
	PlayerTextDrawBackgroundColor(playerid, vehicleInfoPTD[playerid][1], 255);
	PlayerTextDrawSetProportional(playerid, vehicleInfoPTD[playerid][1], 1);
	PlayerTextDrawTextSize(playerid, vehicleInfoPTD[playerid][1], 640.0000, 0.0000);

	vehicleInfoPTD[playerid][2] = CreatePlayerTextDraw(playerid, 320.5000, 421.0000, "LATARIA: ~w~1000/1000");
	PlayerTextDrawFont(playerid, vehicleInfoPTD[playerid][2], 1);
	PlayerTextDrawLetterSize(playerid, vehicleInfoPTD[playerid][2], 0.1399, 0.7999);
	PlayerTextDrawColor(playerid, vehicleInfoPTD[playerid][2], -1768515841);
	PlayerTextDrawSetShadow(playerid, vehicleInfoPTD[playerid][2], 0);
	PlayerTextDrawSetOutline(playerid, vehicleInfoPTD[playerid][2], 0);
	PlayerTextDrawBackgroundColor(playerid, vehicleInfoPTD[playerid][2], 255);
	PlayerTextDrawSetProportional(playerid, vehicleInfoPTD[playerid][2], 1);
	PlayerTextDrawTextSize(playerid, vehicleInfoPTD[playerid][2], 640.0000, 0.0000);

	vehicleInfoPTD[playerid][3] = CreatePlayerTextDraw(playerid, 320.5000, 406.0000, "VELO: ~w~60 kps");
	PlayerTextDrawFont(playerid, vehicleInfoPTD[playerid][3], 1);
	PlayerTextDrawLetterSize(playerid, vehicleInfoPTD[playerid][3], 0.1399, 0.7999);
	PlayerTextDrawColor(playerid, vehicleInfoPTD[playerid][3], -1768515841);
	PlayerTextDrawSetShadow(playerid, vehicleInfoPTD[playerid][3], 0);
	PlayerTextDrawSetOutline(playerid, vehicleInfoPTD[playerid][3], 0);
	PlayerTextDrawBackgroundColor(playerid, vehicleInfoPTD[playerid][3], 255);
	PlayerTextDrawSetProportional(playerid, vehicleInfoPTD[playerid][3], 1);
	PlayerTextDrawTextSize(playerid, vehicleInfoPTD[playerid][3], 640.0000, 0.0000);

	vehicleInfoPTD[playerid][4] = CreatePlayerTextDraw(playerid, 320.5000, 413.5000, "[maximo: 120 kps]");
	PlayerTextDrawFont(playerid, vehicleInfoPTD[playerid][4], 1);
	PlayerTextDrawLetterSize(playerid, vehicleInfoPTD[playerid][4], 0.1199, 0.5999);
	PlayerTextDrawColor(playerid, vehicleInfoPTD[playerid][4], 1684301055);
	PlayerTextDrawSetShadow(playerid, vehicleInfoPTD[playerid][4], 0);
	PlayerTextDrawSetOutline(playerid, vehicleInfoPTD[playerid][4], 0);
	PlayerTextDrawBackgroundColor(playerid, vehicleInfoPTD[playerid][4], 255);
	PlayerTextDrawSetProportional(playerid, vehicleInfoPTD[playerid][4], 1);
	PlayerTextDrawTextSize(playerid, vehicleInfoPTD[playerid][4], 640.0000, 0.0000);
}

Float:GetSpeed(Float:vx, Float:vy, Float:vz) { // units: KM/H
    return floatsqroot(floatpower(vx, 2.0) + floatpower(vy, 2.0) + floatpower(vz, 2.0)) * 180.0;
}

GetVehicleModelName(modelid, dest[], maxlength) {
	return format(dest, maxlength, VEHICLE_NAMES[modelid - 400]);
}

Float:GetVehicleModelTopSpeed(modelid) {
	return VEHICLE_TOP_SPEEDS[modelid - 400];
}

FormatNumber(number) { // i didn't made it, idk who did!
	new numOfPeriods = 0;
	new tmp = number;
	new ret[32];

	while(tmp > 1000) {
		tmp = floatround(tmp / 1000, floatround_floor);
		++numOfPeriods;
	}

	valstr(ret, number);

	new slen = strlen(ret);
	for(new i = 1; i != (numOfPeriods + 1); ++i) {
		strins(ret, ",", (slen - 3 * i));
	}

	return ret;
}

ShowPlayerInfo(playerid, targetid) {
	TextDrawSetPreviewModel(playerInfoTD[1], GetPlayerSkinID(targetid));

	new name[MAX_PLAYER_NAME];
	GetPlayerName(targetid, name, MAX_PLAYER_NAME);
	PlayerTextDrawSetString(playerid, playerInfoPTD[playerid][0], name);
	PlayerTextDrawColor(playerid, playerInfoPTD[playerid][0], ((GetPlayerColor(targetid) & ~0xFF) | 0xFF));

	new string[128];
	format(string, sizeof(string), "ID: %i", targetid);
	PlayerTextDrawSetString(playerid, playerInfoPTD[playerid][1], string);

	for (new i = 0; i < sizeof(playerInfoPTD[]); i++) {
	    PlayerTextDrawShow(playerid, playerInfoPTD[playerid][i]);
	}

	for (new i = 0; i < sizeof(playerInfoFrameTD); i++) {
	    TextDrawShowForPlayer(playerid, playerInfoFrameTD[i]);
	}

	for (new i = 0; i < sizeof(playerInfoTD); i++) {
	    TextDrawShowForPlayer(playerid, playerInfoTD[i]);
	}
}

HidePlayerInfo(playerid) {
	for (new i = 0; i < sizeof(playerInfoPTD[]); i++) {
	    PlayerTextDrawHide(playerid, playerInfoPTD[playerid][i]);
	}

	for (new i = 0; i < sizeof(playerInfoFrameTD); i++) {
	    TextDrawHideForPlayer(playerid, playerInfoFrameTD[i]);
	}

	for (new i = 0; i < sizeof(playerInfoTD); i++) {
	    TextDrawHideForPlayer(playerid, playerInfoTD[i]);
	}
}

UpdatePlayerInfo(playerid, targetid) {
	new Float:amount;
	GetPlayerHealth(targetid, amount);

	new string[128];
	format(string, sizeof(string), "VIDA: ~w~%i", floatround(amount));
	PlayerTextDrawSetString(playerid, playerInfoPTD[playerid][2], string);

	new Float:barLength = ((clamp(floatround(amount), 0, 100) / 100.0) * 64.0);
	TextDrawTextSize(playerInfoTD[3], barLength, 3.0000);
 	TextDrawShowForPlayer(playerid, playerInfoTD[3]);

	GetPlayerArmour(targetid, amount);
	format(string, sizeof(string), "COLETE: ~w~%i", floatround(amount));
	PlayerTextDrawSetString(playerid, playerInfoPTD[playerid][3], string);

	barLength = ((clamp(floatround(amount), 0, 100) / 100.0) * 64.0);
	TextDrawTextSize(playerInfoTD[5], barLength, 3.0000);
 	TextDrawShowForPlayer(playerid, playerInfoTD[5]);

	if (GetPlayerWeapon(targetid) == 0) {
	    string = "ARMA: ~w~Desarmado";
	}
	else {
		GetWeaponName(GetPlayerWeapon(targetid), string, sizeof(string));
		format(string, sizeof(string), "ARMA: ~w~%s (%i)", string, GetPlayerAmmo(targetid));
	}
	PlayerTextDrawSetString(playerid, playerInfoPTD[playerid][4], string);

	format(string, sizeof(string), "DINHEIRO: ~g~$~w~%s", FormatNumber(GetPlayerMoney(targetid)));
	PlayerTextDrawSetString(playerid, playerInfoPTD[playerid][5], string);

	new Float:vx, Float:vy, Float:vz;
	GetPlayerVelocity(targetid, vx, vy, vz);
	format(string, sizeof(string), "VELO: ~w~%0.1f MPH", (GetSpeed(vx, vy, vz) / 1.609344));
	PlayerTextDrawSetString(playerid, playerInfoPTD[playerid][6], string);
	
	new index;
	foreach (new i : SpectatePlayers) {
		++index;
		if (i == targetid) {
			break;
		}
 	}
	format(string, sizeof(string), "%i/%i", index, Iter_Count(SpectatePlayers));
	PlayerTextDrawSetString(playerid, playerInfoPTD[playerid][7], string);
}

ShowVehicleInfo(playerid, vehicleid) {
	new modelid = GetVehicleModel(vehicleid);
	TextDrawSetPreviewModel(vehicleInfoTD[1], modelid);

	new string[128];
    GetVehicleModelName(modelid, string, sizeof(string));
	PlayerTextDrawSetString(playerid, vehicleInfoPTD[playerid][0], string);

	format(string, sizeof(string), "ID: %i", modelid);
	PlayerTextDrawSetString(playerid, vehicleInfoPTD[playerid][1], string);

	format(string, sizeof(string), "[maximo: %0.1f km/h]", GetVehicleModelTopSpeed(modelid));
	PlayerTextDrawSetString(playerid, vehicleInfoPTD[playerid][4], string);

	for (new i = 0; i < sizeof(vehicleInfoPTD[]); i++) {
	    PlayerTextDrawShow(playerid, vehicleInfoPTD[playerid][i]);
	}

	for (new i = 0; i < sizeof(vehicleInfoFrameTD); i++) {
	    TextDrawShowForPlayer(playerid, vehicleInfoFrameTD[i]);
	}

	for (new i = 0; i < sizeof(vehicleInfoTD); i++) {
	    TextDrawShowForPlayer(playerid, vehicleInfoTD[i]);
	}
}

HideVehicleInfo(playerid) {
	for (new i = 0; i < sizeof(vehicleInfoPTD[]); i++) {
	    PlayerTextDrawHide(playerid, vehicleInfoPTD[playerid][i]);
	}

	for (new i = 0; i < sizeof(vehicleInfoFrameTD); i++) {
	    TextDrawHideForPlayer(playerid, vehicleInfoFrameTD[i]);
	}

	for (new i = 0; i < sizeof(vehicleInfoTD); i++) {
	    TextDrawHideForPlayer(playerid, vehicleInfoTD[i]);
	}
}

UpdateVehicleInfo(playerid, vehicleid) {
	new Float:amount;
	GetVehicleHealth(vehicleid, amount);
	
	new string[128];
	format(string, sizeof(string), "LATARIA: ~w~%i/1000", floatround(amount));
	PlayerTextDrawSetString(playerid, vehicleInfoPTD[playerid][2], string);

	new Float:barLength = ((clamp(floatround(amount), 0, 1000) / 1000.0) * 94.5);
	TextDrawTextSize(vehicleInfoTD[3], barLength, 3.0000);
	TextDrawShowForPlayer(playerid, vehicleInfoTD[3]);

	new Float:vx, Float:vy, Float:vz;
	GetVehicleVelocity(vehicleid, vx, vy, vz);
	format(string, sizeof(string), "VELO: ~w~%0.1f KM/H", GetSpeed(vx, vy, vz));
	PlayerTextDrawSetString(playerid, vehicleInfoPTD[playerid][3], string);
}

GetNextPlayer(current) {
	new next = INVALID_PLAYER_ID;

	if (Iter_Count(SpectatePlayers) > 1) {
		if (Iter_Contains(SpectatePlayers, current)) {
			next = Iter_Next(SpectatePlayers, current);

			if (next == Iter_End(SpectatePlayers)) {
			    next = Iter_First(SpectatePlayers);
			}
		}
	}

	return next;
}

GetPreviousPlayer(current) {
	new prev = INVALID_PLAYER_ID;

	if (Iter_Count(SpectatePlayers) > 1) {
		if (Iter_Contains(SpectatePlayers, current)) {
			prev = Iter_Prev(SpectatePlayers, current);

			if (prev == Iter_Begin(SpectatePlayers)) {
			    prev = Iter_Last(SpectatePlayers);
			}
		}
	}

	return prev;
}

StartSpectate(playerid, targetid) {
	TogglePlayerSpectating(playerid, 1);

    SetPlayerInterior(playerid, GetPlayerInterior(targetid));
	SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(targetid));

	new vehicleid = GetPlayerVehicleID(targetid);
	if (vehicleid != 0) {
		PlayerSpectateVehicle(playerid, vehicleid, SPECTATE_MODE_NORMAL);
		ShowPlayerInfo(playerid, targetid);
		ShowVehicleInfo(playerid, vehicleid);
	}
	else {
	    PlayerSpectatePlayer(playerid, targetid, SPECTATE_MODE_NORMAL);
		ShowPlayerInfo(playerid, targetid);
		HideVehicleInfo(playerid);
	}

    playerSpectateID[playerid] = targetid;
    playerSpectateTypeVehicle[playerid] = (vehicleid != 0);

	return SelectTextDraw(playerid, 0xAA0000FF);
}

StopSpectate(playerid) {
	TogglePlayerSpectating(playerid, 0);

    HidePlayerInfo(playerid);
    HideVehicleInfo(playerid);

	playerSpectateID[playerid] = INVALID_PLAYER_ID;
    playerSpectateTypeVehicle[playerid] = false;

	return CancelSelectTextDraw(playerid);
}

stock spec_OnGameModeInit() {
    CreateTextDraws();

	return 1;
}

stock spec_OnGameModeExit() {
	for (new i = 0; i < sizeof(playerInfoFrameTD); i++) {
	    TextDrawDestroy(playerInfoFrameTD[i]);
	}

	for (new i = 0; i < sizeof(playerInfoTD); i++) {
	    TextDrawDestroy(playerInfoTD[i]);
	}

	for (new i = 0; i < sizeof(vehicleInfoFrameTD); i++) {
	    TextDrawDestroy(vehicleInfoFrameTD[i]);
	}

	for (new i = 0; i < sizeof(vehicleInfoTD); i++) {
	    TextDrawDestroy(vehicleInfoTD[i]);
	}

	return 1;
}

stock spec_OnPlayerConnect(playerid) {
    playerSpectateID[playerid] = INVALID_PLAYER_ID;
    playerSpectateTypeVehicle[playerid] = false;

    CreatePlayerTextDraws(playerid);

	return 1;
}

stock spec_OnPlayerStateChange(playerid, newstate) {
	if (newstate == PLAYER_STATE_DRIVER || newstate == PLAYER_STATE_PASSENGER) {
	    new vehicleid = GetPlayerVehicleID(playerid);
	    
	    foreach (new i : Player) {
			if (playerSpectateID[i] == playerid) {
    			PlayerSpectateVehicle(i, vehicleid, SPECTATE_MODE_NORMAL);
    			
				ShowVehicleInfo(i, vehicleid);
    			playerSpectateTypeVehicle[i] = true;
			}
		}
	}
	else if (newstate == PLAYER_STATE_ONFOOT) {
	    foreach (new i : Player) {
			if (playerSpectateID[i] == playerid) {
    			PlayerSpectatePlayer(i, playerid, SPECTATE_MODE_NORMAL);

				HideVehicleInfo(i);
    			playerSpectateTypeVehicle[i] = false;
			}
		}
	}
	else if (newstate == PLAYER_STATE_SPECTATING) {
        new prev = GetPreviousPlayer(playerid);

        if (prev == INVALID_PLAYER_ID) {
		    foreach (new i : Player) {
				if (playerSpectateID[i] == playerid) {
					StopSpectate(i);
				}
			}
		}
		else {
		    foreach (new i : Player) {
				if (playerSpectateID[i] == playerid) {
					StartSpectate(i, prev);
				}
			}
		}

    	Iter_Remove(SpectatePlayers, playerid);
	}

	return 1;
}

stock spec_OnPlyIntChange(playerid, newinteriorid) {
	foreach (new i : Player) {
		if (playerSpectateID[i] == playerid) {
			SetPlayerInterior(i, newinteriorid);
  		}
	}
 	return 1;
}

stock spec_OnPlayerDisconnect(playerid) {
    new prev = GetPreviousPlayer(playerid);

    if (prev == INVALID_PLAYER_ID) {
	    foreach (new i : Player) {
			if (playerSpectateID[i] == playerid) {
				StopSpectate(i);
			}
		}
	}
	else {
	    foreach (new i : Player) {
			if (playerSpectateID[i] == playerid) {
				StartSpectate(i, prev);
			}
		}
	}

   	Iter_Remove(SpectatePlayers, playerid);

	return 1;
}

stock spec_OnPlayerDeath(playerid) {
	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);

    new Float:cx, Float:cy, Float:cz;
	GetPlayerCameraPos(playerid, cx, cy, cz);

	cz += !GetPlayerInterior(playerid) ? 5.0 : 0.5;

	foreach (new i : Player) {
		if (playerSpectateID[i] == playerid) {
			SetPlayerCameraPos(i, cx, cy, cz);
			SetPlayerCameraLookAt(i, x, y, z);
		}
	}

	Iter_Remove(SpectatePlayers, playerid);

	return 1;
}

stock spec_OnPlayerSpawn(playerid) {
	Iter_Add(SpectatePlayers, playerid);
	
	foreach (new i : Player) {
		if (playerSpectateID[i] == playerid) {
			StartSpectate(i, playerid);
		}
	}

	return 1;
}

stock spec_OnPlyCkTD(playerid, Text:clickedid) {
	if (playerSpectateID[playerid] != INVALID_PLAYER_ID) {
		if (clickedid == Text:INVALID_TEXT_DRAW) {
			return SelectTextDraw(playerid, 0xAA0000FF);
		}
		else if (clickedid == BUTTON_PREVIOUS) {
		    new prev = GetPreviousPlayer(playerSpectateID[playerid]);
		    if (prev == INVALID_PLAYER_ID) {
			    PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
			}
			else {
			    StartSpectate(playerid, prev);
			}
		}
		else if (clickedid == BUTTON_NEXT) {
		    new next = GetNextPlayer(playerSpectateID[playerid]);
		    if (next == INVALID_PLAYER_ID) {
			    PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
			}
			else {
			    StartSpectate(playerid, next);
			}
		}
	}

	return 0;
}

stock spec_OnPlayerUpdate(playerid) {
	new worldid = GetPlayerVirtualWorld(playerid);
	if (playerVirtualWorld[playerid] != worldid) {
        playerVirtualWorld[playerid] = worldid;

		foreach (new i : Player) {
			if (playerSpectateID[i] == playerid) {
				SetPlayerVirtualWorld(i, worldid);
	  		}
		}
	}

    if (playerSpectateID[playerid] != INVALID_PLAYER_ID) {
		UpdatePlayerInfo(playerid, playerSpectateID[playerid]);
		
		if (playerSpectateTypeVehicle[playerid]) {
			UpdateVehicleInfo(playerid, GetPlayerVehicleID(playerSpectateID[playerid]));
		}
	}
	return 1;
}

CMD:spec(playerid, params[]) 
{
	new targetid;
	if(PlayerInfo[playerid][user_logged] == 0) return SendClientMessage(playerid, COLOR_GRAD1, "Você não está logado.");
	if(PlayerInfo[playerid][user_admin] < 1) return SendClientMessage(playerid, COLOR_GREY, "Você não possui autorização para utilizar esse comando.");
	if (PlayerInfo[playerid][user_admin] < 4 && !AdminTrabalhando[playerid])
        return SendClientMessage(playerid, COLOR_LIGHTRED, "ERRO: Você deve usar o comando /atrabalho antes."); 

	if (sscanf(params, "u", targetid)) 
	{
		return SendClientMessage(playerid, COLOR_GREY, "USE: /spec [player/id]");
	}

	if (targetid == INVALID_PLAYER_ID || targetid == playerid) 
	{
		return SendClientMessage(playerid, COLOR_GREY, "ERRO: Player invalido.");
	}

	if (GetPlayerState(targetid) == PLAYER_STATE_WASTED || GetPlayerState(targetid) == PLAYER_STATE_SPECTATING) 
	{
		return SendClientMessage(playerid, COLOR_GREY, "ERRO: Player não spawnou.");
	}

    oldPlayerVirtualWorld[playerid] = GetPlayerVirtualWorld(playerid);
	oldPlayerInterior[playerid] = GetPlayerInterior(playerid);
	GetPlayerPos(playerid, oldPlayerPosition[playerid][0], oldPlayerPosition[playerid][1], oldPlayerPosition[playerid][2]);
	GetPlayerFacingAngle(playerid, oldPlayerPosition[playerid][3]);
	GetPlayerHealth(playerid, oldPlayerHealth[playerid]);
	GetPlayerArmour(playerid, oldPlayerArmour[playerid]);
	new string[128];
	format(string, sizeof(string), "SERVER: Você agora está dando spec em %s (ID: %d).", pNome(targetid), targetid);
	SendClientMessage(playerid, COLOR_LIGHTGREEN, string);
    StartSpectate(playerid, targetid);
	return 1;
}

CMD:specoff(playerid, params[]) {

	if(PlayerInfo[playerid][user_logged] == 0) return SendClientMessage(playerid, COLOR_GRAD1, "Você não está logado.");
	if(PlayerInfo[playerid][user_admin] < 1) return SendClientMessage(playerid, COLOR_GREY, "Você não possui autorização para utilizar esse comando.");
	if (PlayerInfo[playerid][user_admin] < 4 && !AdminTrabalhando[playerid])
        return SendClientMessage(playerid, COLOR_LIGHTRED, "ERRO: Você deve usar o comando /atrabalho antes."); 

	if (GetPlayerState(playerid) != PLAYER_STATE_SPECTATING) 
	{
		return SendClientMessage(playerid, COLOR_GREY, "ERRO: Você não está vigiando ninguém no momento.");
	}

    StopSpectate(playerid);

    SetPlayerVirtualWorld(playerid, oldPlayerVirtualWorld[playerid]);
	SetPlayerInterior(playerid, oldPlayerInterior[playerid]);
	SetPlayerPos(playerid, oldPlayerPosition[playerid][0], oldPlayerPosition[playerid][1], oldPlayerPosition[playerid][2]);
	SetPlayerFacingAngle(playerid, oldPlayerPosition[playerid][3]);
	SetPlayerHealth(playerid, oldPlayerHealth[playerid]);
	SetPlayerArmour(playerid, oldPlayerArmour[playerid]);
	return 1;
}