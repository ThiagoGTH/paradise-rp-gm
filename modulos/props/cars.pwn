#define MAX_DYNAMIC_CARS (1500)
#define MAX_IMPOUND_LOTS (20)
#define MAX_CAR_STORAGE (5)
#define MAX_OWNABLE_CARS (5)

enum carData {
	carID,
	carExists,
	carModel,
	carOwner,
	Float:carPos[4],
	carColor1,
	carColor2,
	carPaintjob,
	carLocked,
	carMods[14],
	carImpounded,
	carImpoundPrice,
	carFaction,
	carWeapons[5],
	carAmmo[5],
	carVehicle
};
/*
enum carStorage {
	cItemID,
	cItemExists,
	cItemName[32 char],
	cItemModel,
	cItemQuantity
};*/

enum impoundData {
	impoundID,
	impoundExists,
	Float:impoundLot[3],
	Float:impoundRelease[4],
	Text3D:impoundText3D,
	impoundPickup
};

new CarData[MAX_DYNAMIC_CARS][carData];
//new CarStorage[MAX_DYNAMIC_CARS][MAX_CAR_STORAGE][carStorage];
new ImpoundData[MAX_IMPOUND_LOTS][impoundData];
new ListedVehicles[MAX_PLAYERS][MAX_OWNABLE_CARS];

stock SetVehicleColor(vehicleid, color1, color2)
{
    new id = Car_GetID(vehicleid);

	if (id != -1)
	{
	    CarData[id][carColor1] = color1;
	    CarData[id][carColor2] = color2;
	    Car_Save(id);
	}
	return ChangeVehicleColor(vehicleid, color1, color2);
}

stock SetVehiclePaintjob(vehicleid, paintjobid)
{
    new id = Car_GetID(vehicleid);

	if (id != -1)
	{
	    CarData[id][carPaintjob] = paintjobid;
	    Car_Save(id);
	}
	return ChangeVehiclePaintjob(vehicleid, paintjobid);
}

stock RemoveComponent(vehicleid, componentid)
{
	if (!IsValidVehicle(vehicleid) || (componentid < 1000 || componentid > 1193))
	    return 0;

	new
		id = Car_GetID(vehicleid);

	if (id != -1)
	{
	    CarData[id][carMods][GetVehicleComponentType(componentid)] = 0;
	    Car_Save(id);
	}
	return RemoveVehicleComponent(vehicleid, componentid);
}

stock AddComponent(vehicleid, componentid)
{
	if (!IsValidVehicle(vehicleid) || (componentid < 1000 || componentid > 1193))
	    return 0;

	new
		id = Car_GetID(vehicleid);

	if (id != -1)
	{
	    CarData[id][carMods][GetVehicleComponentType(componentid)] = componentid;
	    Car_Save(id);
	}
	return AddVehicleComponent(vehicleid, componentid);
}


stock IsVehicleImpounded(vehicleid)
{
    new id = Car_GetID(vehicleid);

	if (id != -1 && CarData[id][carImpounded] != -1 && CarData[id][carImpoundPrice] > 0)
	    return 1;

	return 0;
}

stock Impound_Delete(impoundid)
{
    if (impoundid != -1 && ImpoundData[impoundid][impoundExists])
	{
	    new
	        query[64];

		format(query, sizeof(query), "DELETE FROM `impoundlots` WHERE `impoundID` = '%d'", ImpoundData[impoundid][impoundID]);
		mysql_tquery(Database, query);

        if (IsValidDynamic3DTextLabel(ImpoundData[impoundid][impoundText3D]))
		    DestroyDynamic3DTextLabel(ImpoundData[impoundid][impoundText3D]);

	    if (IsValidDynamicPickup(ImpoundData[impoundid][impoundPickup]))
		    DestroyDynamicPickup(ImpoundData[impoundid][impoundPickup]);

		for (new i = 0; i < MAX_DYNAMIC_CARS; i ++) if (CarData[i][carExists] && CarData[i][carImpounded] == ImpoundData[impoundid][impoundID]) {
		    CarData[i][carImpounded] = 0;
		    CarData[i][carImpoundPrice] = 0;
		    Car_Save(i);
		}
        ImpoundData[impoundid][impoundExists] = false;
        ImpoundData[impoundid][impoundID] = 0;
	}
	return 1;
}

stock GetImpoundByID(sqlid)
{
	for (new i = 0; i < MAX_IMPOUND_LOTS; i ++) if (ImpoundData[i][impoundExists] && ImpoundData[i][impoundID] == sqlid) {
	    return i;
	}
	return -1;
}

stock Impound_Nearest(playerid)
{
	for (new i = 0; i < MAX_IMPOUND_LOTS; i ++) if (ImpoundData[i][impoundExists] && IsPlayerInRangeOfPoint(playerid, 20.0, ImpoundData[i][impoundLot][0], ImpoundData[i][impoundLot][1], ImpoundData[i][impoundLot][2])) {
	    return i;
	}
	return -1;
}

stock Impound_Create(Float:x, Float:y, Float:z)
{
	for (new i = 0; i != MAX_IMPOUND_LOTS; i ++) if (!ImpoundData[i][impoundExists])
	{
	    ImpoundData[i][impoundExists] = true;
	    ImpoundData[i][impoundLot][0] = x;
	    ImpoundData[i][impoundLot][1] = y;
	    ImpoundData[i][impoundLot][2] = z;
	    ImpoundData[i][impoundRelease][0] = 0.0;
	    ImpoundData[i][impoundRelease][1] = 0.0;
	    ImpoundData[i][impoundRelease][2] = 0.0;

		mysql_tquery(Database, "INSERT INTO `impoundlots` (`impoundLotX`) VALUES('0.0')", "OnImpoundCreated", "d", i);
		Impound_Refresh(i);

		return i;
	}
	return -1;
}

stock Impound_Refresh(impoundid)
{
	if (impoundid != -1 && ImpoundData[impoundid][impoundExists])
	{
	    new
	        string[64];

		if (IsValidDynamic3DTextLabel(ImpoundData[impoundid][impoundText3D]))
		    DestroyDynamic3DTextLabel(ImpoundData[impoundid][impoundText3D]);

	    if (IsValidDynamicPickup(ImpoundData[impoundid][impoundPickup]))
		    DestroyDynamicPickup(ImpoundData[impoundid][impoundPickup]);

		format(string, sizeof(string), "[Impound %d]\n{FFFFFF}/impound to impound a vehicle.", impoundid);
        ImpoundData[impoundid][impoundText3D] = CreateDynamic3DTextLabel(string, COLOR_DARKBLUE, ImpoundData[impoundid][impoundLot][0], ImpoundData[impoundid][impoundLot][1], ImpoundData[impoundid][impoundLot][2], 20.0);
        ImpoundData[impoundid][impoundPickup] = CreateDynamicPickup(1239, 23, ImpoundData[impoundid][impoundLot][0], ImpoundData[impoundid][impoundLot][1], ImpoundData[impoundid][impoundLot][2]);
	}
	return 1;
}

stock Impound_Save(impoundid)
{
	new
		query[300];

	format(query, sizeof(query), "UPDATE `impoundlots` SET `impoundLotX` = '%.4f', `impoundLotY` = '%.4f', `impoundLotZ` = '%.4f', `impoundReleaseX` = '%.4f', `impoundReleaseY` = '%.4f', `impoundReleaseZ` = '%.4f', `impoundReleaseA` = '%.4f' WHERE `impoundID` = '%d'",
        ImpoundData[impoundid][impoundLot][0],
        ImpoundData[impoundid][impoundLot][1],
        ImpoundData[impoundid][impoundLot][2],
        ImpoundData[impoundid][impoundRelease][0],
        ImpoundData[impoundid][impoundRelease][1],
        ImpoundData[impoundid][impoundRelease][2],
        ImpoundData[impoundid][impoundRelease][3],
        ImpoundData[impoundid][impoundID]
	);
	return mysql_tquery(Database, query);
}

forward OnImpoundCreated(impoundid);
public OnImpoundCreated(impoundid)
{
	if (impoundid == -1 || !ImpoundData[impoundid][impoundExists])
	    return 0;

	ImpoundData[impoundid][impoundID] = cache_insert_id();
	Impound_Save(impoundid);

	return 1;
}

stock Car_GetRealID(carid)
{
	if (carid == -1 || !CarData[carid][carExists] || CarData[carid][carVehicle] == INVALID_VEHICLE_ID)
	    return INVALID_VEHICLE_ID;

	return CarData[carid][carVehicle];
}

stock Car_GetID(vehicleid)
{
	for (new i = 0; i != MAX_DYNAMIC_CARS; i ++) if (CarData[i][carExists] && CarData[i][carVehicle] == vehicleid) {
	    return i;
	}
	return -1;
}

stock Car_Spawn(carid)
{
	if (carid != -1 && CarData[carid][carExists])
	{
		if (IsValidVehicle(CarData[carid][carVehicle]))
		    DestroyVehicle(CarData[carid][carVehicle]);

		if (CarData[carid][carColor1] == -1)
		    CarData[carid][carColor1] = random(127);

		if (CarData[carid][carColor2] == -1)
		    CarData[carid][carColor2] = random(127);

        CarData[carid][carVehicle] = CreateVehicle(CarData[carid][carModel], CarData[carid][carPos][0], CarData[carid][carPos][1], CarData[carid][carPos][2], CarData[carid][carPos][3], CarData[carid][carColor1], CarData[carid][carColor2], (CarData[carid][carOwner] != 0) ? (-1) : (1200000));

        if (CarData[carid][carVehicle] != INVALID_VEHICLE_ID)
        {
            if (CarData[carid][carPaintjob] != -1)
            {
                ChangeVehiclePaintjob(CarData[carid][carVehicle], CarData[carid][carPaintjob]);
			}
			if (CarData[carid][carLocked])
			{
			    new
					engine, lights, alarm, doors, bonnet, boot, objective;

				GetVehicleParamsEx(CarData[carid][carVehicle], engine, lights, alarm, doors, bonnet, boot, objective);
			    SetVehicleParamsEx(CarData[carid][carVehicle], engine, lights, alarm, 1, bonnet, boot, objective);
			}
			for (new i = 0; i < 14; i ++)
			{
			    if (CarData[carid][carMods][i]) AddVehicleComponent(CarData[carid][carVehicle], CarData[carid][carMods][i]);
			}
   			ResetVehicle(CarData[carid][carVehicle]);
			return 1;
		}
	}
	return 0;
}

forward Car_Load();
public Car_Load()
{
	static
	    rows,
		str[128];

	cache_get_row_count(rows);

	for (new i = 0; i < rows; i ++) if (i < MAX_DYNAMIC_CARS)
	{
	    CarData[i][carExists] = true;

		cache_get_value_name_int(i, "carID",  CarData[i][carID]);
		cache_get_value_name_int(i, "carModel", CarData[i][carModel]);
		cache_get_value_name_int(i, "carOwner", CarData[i][carOwner]);

		cache_get_value_name_float(i, "carPosX", CarData[i][carPos][0]);
		cache_get_value_name_float(i, "carPosY", CarData[i][carPos][1]);
		cache_get_value_name_float(i, "carPosZ", CarData[i][carPos][2]);
		cache_get_value_name_float(i, "carPosR", CarData[i][carPos][3]);

		cache_get_value_name_int(i, "carColor1", CarData[i][carColor1]);
		cache_get_value_name_int(i, "carColor2", CarData[i][carColor2]);

		cache_get_value_name_int(i, "carPaintjob", CarData[i][carPaintjob]);
		cache_get_value_name_int(i, "carLocked", CarData[i][carLocked]);
		cache_get_value_name_int(i, "carImpounded", CarData[i][carImpounded]);
		cache_get_value_name_int(i, "carImpoundPrice", CarData[i][carImpoundPrice]);

		cache_get_value_name_int(i, "carFaction", CarData[i][carFaction]);

		for (new j = 0; j < 14; j ++)
		{
		    if (j < 5)
		    {
				format(str, sizeof(str), "carWeapon%d", j + 1);
	        	cache_get_value_name_int(i, str, CarData[i][carWeapons][j]);

				format(str, sizeof(str), "carAmmo%d", j + 1);
	        	cache_get_value_name_int(i, str, CarData[i][carAmmo][j]);
	        }
			format(str, sizeof(str), "carMod%d", j + 1);
	        cache_get_value_name_int(i, str, CarData[i][carMods][j]);
	    }
	    Car_Spawn(i);
	}
	/*
	for (new i = 0; i < MAX_DYNAMIC_CARS; i ++) if (CarData[i][carExists]) {
		format(str, sizeof(str), "SELECT * FROM `carstorage` WHERE `ID` = '%d'", CarData[i][carID]);

		mysql_tquery(Database, str, "OnLoadCarStorage", "d", i);
	}*/
	return 1;
}

Car_GetCount(playerid)
{
	new
		count = 0;

	for (new i = 0; i != MAX_DYNAMIC_CARS; i ++)
	{
		if (CarData[i][carExists] && CarData[i][carOwner] == PlayerInfo[playerid][user_id])
   		{
   		    count++;
		}
	}
	return count;
}

Car_IsOwner(playerid, carid)
{
	if (!PlayerInfo[playerid][user_logged] || PlayerInfo[playerid][user_id] == -1)
	    return 0;

    if ((CarData[carid][carExists] && CarData[carid][carOwner] != 0) && CarData[carid][carOwner] == PlayerInfo[playerid][user_id])
		return 1;

	return 0;
}

Car_WeaponStorage(playerid, carid)
{
    if (!CarData[carid][carExists] || CarData[carid][carLocked])
	    return 0;

    static
	    string[164];

	string[0] = 0;

	for (new i = 0; i < 5; i ++)
	{
	    if (22 <= CarData[carid][carWeapons][i] <= 38)
	        format(string, sizeof(string), "%s%s - Ammo: %d\n", string, ReturnWeaponName(CarData[carid][carWeapons][i]), CarData[carid][carAmmo][i]);

		else
		    format(string, sizeof(string), "%s%s\n", string, (CarData[carid][carWeapons][i]) ? (ReturnWeaponName(CarData[carid][carWeapons][i])) : ("Empty Slot"));
	}
	Dialog_Show(playerid, Trunk, DIALOG_STYLE_LIST, "Car Trunk", string, "Select", "Cancel");
	return 1;
}

Car_ShowTrunk(playerid, carid)
{
	static
	    string[MAX_CAR_STORAGE * 32];
		//name[32];
/*
	string[0] = 0;

	for (new i = 0; i != MAX_CAR_STORAGE; i ++)
	{
	    if (!CarStorage[carid][i][cItemExists])
	        format(string, sizeof(string), "%sEmpty Slot\n", string);

		else {
			strunpack(name, CarStorage[carid][i][cItemName]);

			if (CarStorage[carid][i][cItemQuantity] == 1) {
                format(string, sizeof(string), "%s%s\n", string, name);
			}
			else format(string, sizeof(string), "%s%s (%d)\n", string, name, CarStorage[carid][i][cItemQuantity]);
		}
	}*/
	strcat(string, "Weapon Storage");

//	PlayerInfo[playerid][pStorageSelect] = 0;
	Dialog_Show(playerid, CarStorage, DIALOG_STYLE_LIST, "Car Storage", string, "Select", "Cancel");
	return 1;
}


Car_Create(ownerid, modelid, Float:x, Float:y, Float:z, Float:angle, color1, color2, type = 0)
{
    for (new i = 0; i != MAX_DYNAMIC_CARS; i ++)
	{
		if (!CarData[i][carExists])
   		{
   		    if (color1 == -1)
   		        color1 = random(127);

			if (color2 == -1)
			    color2 = random(127);

   		    CarData[i][carExists] = true;
            CarData[i][carModel] = modelid;
            CarData[i][carOwner] = ownerid;

            CarData[i][carPos][0] = x;
            CarData[i][carPos][1] = y;
            CarData[i][carPos][2] = z;
            CarData[i][carPos][3] = angle;

            CarData[i][carColor1] = color1;
            CarData[i][carColor2] = color2;
            CarData[i][carPaintjob] = -1;
            CarData[i][carLocked] = false;
            CarData[i][carImpounded] = -1;
            CarData[i][carImpoundPrice] = 0;
            CarData[i][carFaction] = type;

            for (new j = 0; j < 14; j ++)
			{
                if (j < 5)
				{
                    CarData[i][carWeapons][j] = 0;
                    CarData[i][carAmmo][j] = 0;
                }
                CarData[i][carMods][j] = 0;
            }
            CarData[i][carVehicle] = CreateVehicle(modelid, x, y, z, angle, color1, color2, -1);

            if (CarData[i][carVehicle] != INVALID_VEHICLE_ID) {
                ResetVehicle(CarData[i][carVehicle]);
            }
            mysql_tquery(Database, "INSERT INTO `cars` (`carModel`) VALUES(0)", "OnCarCreated", "d", i);
            return i;
		}
	}
	return -1;
}

Car_Delete(carid)
{
    if (carid != -1 && CarData[carid][carExists])
	{
	    new
	        string[64];

		format(string, sizeof(string), "DELETE FROM `cars` WHERE `carID` = '%d'", CarData[carid][carID]);
		mysql_tquery(Database, string);

		if (IsValidVehicle(CarData[carid][carVehicle]))
			DestroyVehicle(CarData[carid][carVehicle]);

		/*for (new i = 0; i < MAX_BACKPACKS; i ++) if (BackpackData[i][backpackExists] && BackpackData[i][backpackVehicle] == CarData[carid][carID]) {
		    Backpack_Delete(i);
		}*/
		Car_RemoveAllItems(carid);

        CarData[carid][carExists] = false;
	    CarData[carid][carID] = 0;
	    CarData[carid][carOwner] = 0;
	    CarData[carid][carVehicle] = 0;
	}
	return 1;
}

Car_Save(carid)
{
	static
	    query[900];

	if (CarData[carid][carVehicle] != INVALID_VEHICLE_ID)
	{
	    for (new i = 0; i < 14; i ++) {
			CarData[carid][carMods][i] = GetVehicleComponentInSlot(CarData[carid][carVehicle], i);
	    }
	}
	format(query, sizeof(query), "UPDATE `cars` SET `carModel` = '%d', `carOwner` = '%d', `carPosX` = '%.4f', `carPosY` = '%.4f', `carPosZ` = '%.4f', `carPosR` = '%.4f', `carColor1` = '%d', `carColor2` = '%d', `carPaintjob` = '%d', `carLocked` = '%d'",
        CarData[carid][carModel],
        CarData[carid][carOwner],
        CarData[carid][carPos][0],
        CarData[carid][carPos][1],
        CarData[carid][carPos][2],
        CarData[carid][carPos][3],
        CarData[carid][carColor1],
        CarData[carid][carColor2],
        CarData[carid][carPaintjob],
        CarData[carid][carLocked]
	);
	format(query, sizeof(query), "%s, `carMod1` = '%d', `carMod2` = '%d', `carMod3` = '%d', `carMod4` = '%d', `carMod5` = '%d', `carMod6` = '%d', `carMod7` = '%d', `carMod8` = '%d', `carMod9` = '%d', `carMod10` = '%d', `carMod11` = '%d', `carMod12` = '%d', `carMod13` = '%d', `carMod14` = '%d'",
		query,
		CarData[carid][carMods][0],
		CarData[carid][carMods][1],
		CarData[carid][carMods][2],
		CarData[carid][carMods][3],
		CarData[carid][carMods][4],
		CarData[carid][carMods][5],
		CarData[carid][carMods][6],
		CarData[carid][carMods][7],
		CarData[carid][carMods][8],
		CarData[carid][carMods][9],
		CarData[carid][carMods][10],
		CarData[carid][carMods][11],
		CarData[carid][carMods][12],
		CarData[carid][carMods][13]
	);
	format(query, sizeof(query), "%s, `carImpounded` = '%d', `carImpoundPrice` = '%d', `carFaction` = '%d', `carWeapon1` = '%d', `carWeapon2` = '%d', `carWeapon3` = '%d', `carWeapon4` = '%d', `carWeapon5` = '%d', `carAmmo1` = '%d', `carAmmo2` = '%d', `carAmmo3` = '%d', `carAmmo4` = '%d', `carAmmo5` = '%d' WHERE `carID` = '%d'",
		query,
		CarData[carid][carImpounded],
		CarData[carid][carImpoundPrice],
		CarData[carid][carFaction],
		CarData[carid][carWeapons][0],
		CarData[carid][carWeapons][1],
		CarData[carid][carWeapons][2],
		CarData[carid][carWeapons][3],
		CarData[carid][carWeapons][4],
		CarData[carid][carAmmo][0],
		CarData[carid][carAmmo][1],
		CarData[carid][carAmmo][2],
		CarData[carid][carAmmo][3],
		CarData[carid][carAmmo][4],
		CarData[carid][carID]
	);
	return mysql_tquery(Database, query);
}

Car_Nearest(playerid)
{
	static
	    Float:fX,
	    Float:fY,
	    Float:fZ;

	for (new i = 0; i != MAX_DYNAMIC_CARS; i ++) if (CarData[i][carExists]) {
		GetVehiclePos(CarData[i][carVehicle], fX, fY, fZ);

		if (IsPlayerInRangeOfPoint(playerid, 3.0, fX, fY, fZ)) {
		    return i;
		}
	}
	return -1;
}

/*
stock Car_GetItemID(carid, item[])
{
	if (carid == -1 || !CarData[carid][carExists])
	    return 0;

	for (new i = 0; i < MAX_CAR_STORAGE; i ++)
	{
	    if (!CarStorage[carid][i][cItemExists])
	        continue;

		if (!strcmp(CarStorage[carid][i][cItemName], item)) return i;
	}
	return -1;
}

stock Car_GetFreeID(carid)
{
	if (carid == -1 || !CarData[carid][carExists])
	    return 0;

	for (new i = 0; i < MAX_CAR_STORAGE; i ++)
	{
	    if (!CarStorage[carid][i][cItemExists])
	        return i;
	}
	return -1;
}

stock Car_AddItem(carid, item[], model, quantity = 1, slotid = -1)
{
    if (carid == -1 || !CarData[carid][carExists])
	    return 0;

	new
		itemid = Car_GetItemID(carid, item),
		string[128];

	if (itemid == -1)
	{
	    itemid = Car_GetFreeID(carid);

	    if (itemid != -1)
	    {
	        if (slotid != -1)
	            itemid = slotid;

	        CarStorage[carid][itemid][cItemExists] = true;
	        CarStorage[carid][itemid][cItemModel] = model;
	        CarStorage[carid][itemid][cItemQuantity] = quantity;

	        strpack(CarStorage[carid][itemid][cItemName], item, 32 char);

			format(string, sizeof(string), "INSERT INTO `carstorage` (`ID`, `itemName`, `itemModel`, `itemQuantity`) VALUES('%d', '%s', '%d', '%d')", CarData[carid][carID], item, model, quantity);
			mysql_tquery(Database, string, "OnCarStorageAdd", "dd", carid, itemid);

	        return itemid;
		}
		return -1;
	}
	else
	{
	    format(string, sizeof(string), "UPDATE `carstorage` SET `itemQuantity` = `itemQuantity` + %d WHERE `ID` = '%d' AND `itemID` = '%d'", quantity, CarData[carid][carID], CarStorage[carid][itemid][cItemID]);
	    mysql_tquery(Database, string);

	    CarStorage[carid][itemid][cItemQuantity] += quantity;
	}
	return itemid;
}

stock Car_RemoveItem(carid, item[], quantity = 1)
{
    if (carid == -1 || !CarData[carid][carExists])
	    return 0;

	new
		itemid = Car_GetItemID(carid, item),
		string[128];

	if (itemid != -1)
	{
	    if (CarStorage[carid][itemid][cItemQuantity] > 0)
	    {
	        CarStorage[carid][itemid][cItemQuantity] -= quantity;
		}
		if (quantity == -1 || CarStorage[carid][itemid][cItemQuantity] < 1)
		{
		    CarStorage[carid][itemid][cItemExists] = false;
		    CarStorage[carid][itemid][cItemModel] = 0;
		    CarStorage[carid][itemid][cItemQuantity] = 0;

		    format(string, sizeof(string), "DELETE FROM `carstorage` WHERE `ID` = '%d' AND `itemID` = '%d'", CarData[carid][carID], CarStorage[carid][itemid][cItemID]);
	        mysql_tquery(Database, string);
		}
		else if (quantity != -1 && CarStorage[carid][itemid][cItemQuantity] > 0)
		{
			format(string, sizeof(string), "UPDATE `carstorage` SET `itemQuantity` = `itemQuantity` - %d WHERE `ID` = '%d' AND `itemID` = '%d'", quantity, CarData[carid][carID], CarStorage[carid][itemid][cItemID]);
            mysql_tquery(Database, string);
		}
		return 1;
	}
	return 0;
}
*/
Car_RemoveAllItems(carid)
{
	/*static
	    query[64];

	for (new i = 0; i != MAX_CAR_STORAGE; i ++) {
        CarStorage[carid][i][cItemExists] = false;
        CarStorage[carid][i][cItemModel] = 0;
        CarStorage[carid][i][cItemQuantity] = 0;
	}
	format(query, 64, "DELETE FROM `carstorage` WHERE `ID` = '%d'", CarData[carid][carID]);
	mysql_tquery(Database, query);*/

	for (new i = 0; i < 5; i ++) {
	    CarData[carid][carWeapons][i] = 0;
	    CarData[carid][carAmmo][i] = 0;
	}
	return 1;
}

forward OnCarCreated(carid);
public OnCarCreated(carid)
{
	if (carid == -1 || !CarData[carid][carExists])
	    return 0;

	CarData[carid][carID] = cache_insert_id();
	Car_Save(carid);
	return 1;
}

Car_Inside(playerid)
{
	new carid;

	if (IsPlayerInAnyVehicle(playerid) && (carid = Car_GetID(GetPlayerVehicleID(playerid))) != -1)
	    return carid;

	return -1;
}

public OnVehicleMod(playerid, vehicleid, componentid)
{
	new
		id = Car_GetID(vehicleid),
		slot = GetVehicleComponentType(componentid);

	if (id != -1)
	{
	    CarData[id][carMods][slot] = componentid;
	    Car_Save(id);
	}
	return 1;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
    if (IsPlayerNPC(playerid))
	    return 1;

	if (GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_CUFFED || GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_CARRY) {
	    ClearAnimations(playerid);

	    return 0;
	}
	new id = Car_GetID(vehicleid);

	if (!ispassenger && id != -1 && CarData[id][carFaction] > 0 && GetFactionType(playerid) != CarData[id][carFaction]) {
	    ClearAnimations(playerid);

	    return SendErrorMessage(playerid, "You don't have the keys to this vehicle.");
	}
	return 1;
}

stock cars_OnPlayerStateChange(playerid, newstate)
{
	if (IsPlayerNPC(playerid))
	    return 1;

	new vehicleid = GetPlayerVehicleID(playerid);

	if (newstate == PLAYER_STATE_DRIVER)
	{
	    new id = Car_GetID(vehicleid);

		if (id != -1 && CarData[id][carFaction] > 0 && GetFactionType(playerid) != CarData[id][carFaction]) {
		    RemovePlayerFromVehicle(playerid);

	    	return SendErrorMessage(playerid, "You don't have the keys to this vehicle.");
		}
        return 1;
    }
    return 1;
}
/*
Dialog:CarDeposit(playerid, response, listitem, inputtext[])
{
	static
	    carid = -1,
	    string[32];

    if ((carid = Car_Nearest(playerid)) != -1 && !CarData[carid][carLocked])
	{
	    strunpack(string, InventoryData[playerid][PlayerInfo[playerid][pInventoryItem]][invItem]);

		if (response)
		{
			new amount = strval(inputtext);

			if (amount < 1 || amount > InventoryData[playerid][PlayerInfo[playerid][pInventoryItem]][invQuantity])
			    return Dialog_Show(playerid, CarDeposit, DIALOG_STYLE_INPUT, "Car Deposit", "Item: %s (Quantity: %d)\n\nPlease enter the quantity that you wish to store for this item:", "Store", "Back", string, InventoryData[playerid][PlayerInfo[playerid][pInventoryItem]][invQuantity]);

			Car_AddItem(carid, string, InventoryData[playerid][PlayerInfo[playerid][pInventoryItem]][invModel], amount);
			Inventory_Remove(playerid, string, amount);

			SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s has stored a \"%s\" into the trunk.", pNome(playerid), string);
			Car_ShowTrunk(playerid, carid);
		}
		else Car_ShowTrunk(playerid, carid);
	}
	return 1;
}

Dialog:CarTake(playerid, response, listitem, inputtext[])
{
	static
	    carid = -1,
	    string[32];

    if ((carid = Car_Nearest(playerid)) != -1 && !CarData[carid][carLocked])
	{
	    strunpack(string, CarStorage[carid][PlayerInfo[playerid][pStorageItem]][cItemName]);

		if (response)
		{
			new amount = strval(inputtext);

			if (amount < 1 || amount > CarStorage[carid][PlayerInfo[playerid][pStorageItem]][cItemQuantity])
			    return Dialog_Show(playerid, CarTake, DIALOG_STYLE_INPUT, "Car Take", "Item: %s (Quantity: %d)\n\nPlease enter the quantity that you wish to take for this item:", "Take", "Back", string, CarStorage[carid][PlayerInfo[playerid][pInventoryItem]][cItemQuantity]);

			new id = Inventory_Add(playerid, string, CarStorage[carid][PlayerInfo[playerid][pStorageItem]][cItemModel], amount);

			if (id == -1)
				return SendErrorMessage(playerid, "You don't have any inventory slots left.");

			Car_RemoveItem(carid, string, amount);

			SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s has taken a \"%s\" from the trunk.", pNome(playerid), string);
			Car_ShowTrunk(playerid, carid);
		}
		else Car_ShowTrunk(playerid, carid);
	}
	return 1;
}
*/
Dialog:CarStorage(playerid, response, listitem, inputtext[])
{
	static
	    carid = -1;

	if ((carid = Car_Nearest(playerid)) != -1 && !CarData[carid][carLocked])
	{
		if (response)
		{
		    if (listitem == MAX_CAR_STORAGE) {
    			Car_WeaponStorage(playerid, carid);
		    }
		    /*else if (CarStorage[carid][listitem][cItemExists])
			{
   				PlayerInfo[playerid][pStorageItem] = listitem;
   				PlayerInfo[playerid][pInventoryItem] = listitem;

				strunpack(string, CarStorage[carid][listitem][cItemName]);

				format(string, sizeof(string), "%s (Quantity: %d)", string, CarStorage[carid][listitem][cItemQuantity]);
				Dialog_Show(playerid, TrunkOptions, DIALOG_STYLE_LIST, string, "Take Item\nStore Item", "Select", "Back");
			}
			else {
   				OpenInventory(playerid);

				PlayerInfo[playerid][pStorageSelect] = 2;
			}*/
		}
	}
	return 1;
}
/*
Dialog:TrunkOptions(playerid, response, listitem, inputtext[])
{
    static
	    carid = -1,
		itemid = -1,
		backpack = -1,
		string[32];

	if ((carid = Car_Nearest(playerid)) != -1 && !CarData[carid][carLocked])
	{
	    itemid = PlayerInfo[playerid][pStorageItem];

	    strunpack(string, CarStorage[carid][itemid][cItemName]);

		if (response)
		{
			switch (listitem)
			{
			    case 0:
			    {
			        if (CarStorage[carid][itemid][cItemQuantity] == 1)
			        {
			            if (!strcmp(string, "Backpack") && Inventory_HasItem(playerid, "Backpack"))
			                return SendErrorMessage(playerid, "You already have a backpack in your inventory.");

			            new id = Inventory_Add(playerid, string, CarStorage[carid][itemid][cItemModel], 1);

						if (id == -1)
        					return SendErrorMessage(playerid, "You don't have any inventory slots left.");

                        if (!strcmp(string, "Backpack") && (backpack = GetVehicleBackpack(carid)) != -1)
						{
						    BackpackData[backpack][backpackVehicle] = 0;
						    BackpackData[backpack][backpackPlayer] = PlayerInfo[playerid][pID];

						    Backpack_Save(backpack);
						    SetAccessories(playerid);
						}
			            Car_RemoveItem(carid, string);

			            SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s has taken a \"%s\" from the trunk.", pNome(playerid), string);
						Car_ShowTrunk(playerid, carid);
			        }
			        else
			        {
			            Dialog_Show(playerid, CarTake, DIALOG_STYLE_INPUT, "Car Take", "Item: %s (Quantity: %d)\n\nPlease enter the quantity that you wish to take for this item:", "Take", "Back", string, CarStorage[carid][itemid][cItemQuantity]);
			        }
			    }
				case 1:
				{
					new id = Inventory_GetItemID(playerid, string);

					if (!strcmp(string, "Backpack")) {
					    Car_ShowTrunk(playerid, carid);

						return SendErrorMessage(playerid, "You can only store one backpack in your trunk.");
					}
					else if (id == -1) {
						Car_ShowTrunk(playerid, carid);

						return SendErrorMessage(playerid, "You don't have anymore of this item to store!");
					}
					else if (InventoryData[playerid][id][invQuantity] == 1)
					{
					    Car_AddItem(carid, string, InventoryData[playerid][id][invModel], 1);
						Inventory_Remove(playerid, string);

						SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s has stored a \"%s\" into the trunk.", pNome(playerid), string);
						Car_ShowTrunk(playerid, carid);
					}
					else if (InventoryData[playerid][id][invQuantity] > 1) {
					    PlayerInfo[playerid][pInventoryItem] = id;

                        Dialog_Show(playerid, CarDeposit, DIALOG_STYLE_INPUT, "Car Deposit", "Item: %s (Quantity: %d)\n\nPlease enter the quantity that you wish to store for this item:", "Store", "Back", string, InventoryData[playerid][id][invQuantity]);
					}
				}
			}
		}
		else
		{
		    Car_ShowTrunk(playerid, carid);
		}
	}
	return 1;
}
*/

Dialog:ReleaseCar(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    new
			carid = ListedVehicles[playerid][listitem],
			id = GetImpoundByID(CarData[carid][carImpounded]);

	    if (carid != -1 && id != -1 && CarData[carid][carExists] && CarData[carid][carImpounded] != -1)
	    {
	        if (GetMoney(playerid) < CarData[carid][carImpoundPrice])
	            return SendErrorMessage(playerid, "You can't afford to release this vehicle.");

            GiveMoney(playerid, -CarData[carid][carImpoundPrice]);

            CarData[carid][carPos][0] = ImpoundData[id][impoundRelease][0];
            CarData[carid][carPos][1] = ImpoundData[id][impoundRelease][1];
            CarData[carid][carPos][2] = ImpoundData[id][impoundRelease][2];
            CarData[carid][carPos][3] = ImpoundData[id][impoundRelease][3];

			SetVehiclePos(CarData[carid][carVehicle], CarData[carid][carPos][0], CarData[carid][carPos][1], CarData[carid][carPos][2]);
			SetVehicleZAngle(CarData[carid][carVehicle], CarData[carid][carPos][3]);

			SendServerMessage(playerid, "You have released your %s for %s.", ReturnVehicleModelName(CarData[carid][carModel]), FormatNumber(CarData[carid][carImpoundPrice]));

            CarData[carid][carImpounded] = -1;
            CarData[carid][carImpoundPrice] = 0;

            Car_Save(carid);
	    }
	}
	return 1;
}

Dialog:Trunk(playerid, response, listitem, inputtext[])
{
    new carid = Car_Nearest(playerid);

	if (CarData[carid][carImpounded] != -1)
    	return SendErrorMessage(playerid, "This vehicle is impounded and you can't use it.");

	if (carid != -1 && !CarData[carid][carLocked])
 	{
		if (response)
		{
			if (!CarData[carid][carWeapons][listitem])
			{
			    if (!GetWeapon(playerid))
			        return SendErrorMessage(playerid, "You aren't holding any weapon.");

       			if (GetWeapon(playerid) == 23 && PlayerInfo[playerid][pTazer])
	    			return SendErrorMessage(playerid, "You can't store a tazer into your trunk.");

                if (GetWeapon(playerid) == 25 && PlayerInfo[playerid][pBeanBag])
	    			return SendErrorMessage(playerid, "You can't store a beanbag shotgun into your trunk.");

				if (!Car_IsOwner(playerid, carid) && GetFactionType(playerid) == FACTION_POLICE)
        			return SendErrorMessage(playerid, "You can't store weapons since you're a police officer.");

	   			CarData[carid][carWeapons][listitem] = GetWeapon(playerid);
	            CarData[carid][carAmmo][listitem] = GetPlayerAmmo(playerid);

	            ResetWeapon(playerid, CarData[carid][carWeapons][listitem]);
	            SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s stored a %s into the trunk.", pNome(playerid), ReturnWeaponName(CarData[carid][carWeapons][listitem]));

	            Car_Save(carid);
				Car_WeaponStorage(playerid, carid);
			}
			else
			{
			    GiveWeaponToPlayer(playerid, CarData[carid][carWeapons][listitem], CarData[carid][carAmmo][listitem]);
	            SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s takes a %s from the trunk.", pNome(playerid), ReturnWeaponName(CarData[carid][carWeapons][listitem]));

	            CarData[carid][carWeapons][listitem] = 0;
	            CarData[carid][carAmmo][listitem] = 0;

	            Car_Save(carid);
	            Car_WeaponStorage(playerid, carid);
			}
	    }
		else {
		    Car_ShowTrunk(playerid, carid);
		}
	}
	return 1;
}

CMD:abandon(playerid, params[])
{
	static
	    id = -1;

	if ((id = Car_Inside(playerid)) != -1 && Car_IsOwner(playerid, id))
	{
	    if (isnull(params) || (!isnull(params) && strcmp(params, "confirm", true) != 0))
	    {
	        SendSyntaxMessage(playerid, "/abandon [confirm]");
	        SendClientMessage(playerid, COLOR_LIGHTRED, "[WARNING]:{FFFFFF} You are about to abandon your vehicle with no refund.");
		}
		else if (CarData[id][carImpounded] != -1)
    		return SendErrorMessage(playerid, "This vehicle is impounded and you can't use it.");

		else if (!strcmp(params, "confirm", true))
		{
			new
			    model = CarData[id][carModel];

			Car_Delete(id);

			SendServerMessage(playerid, "You have abandoned your %s.", ReturnVehicleModelName(model));
			//Log_Write("logs/car_log.txt", "[%s] %s has abandoned their %s.", ReturnDate(), ReturnName(playerid), ReturnVehicleModelName(model));
		}
	}
	else SendErrorMessage(playerid, "You are not in range of anything you can abandon.");
	return 1;
}

CMD:lock(playerid, params[])
{
	static
	    id = -1;

	if ((id = Car_Nearest(playerid)) != -1)
	{
	    static
	        engine,
	        lights,
	        alarm,
	        doors,
	        bonnet,
	        boot,
	        objective;

	    GetVehicleParamsEx(CarData[id][carVehicle], engine, lights, alarm, doors, bonnet, boot, objective);

	    if (Car_IsOwner(playerid, id) || (PlayerInfo[playerid][pFaction] != -1 && CarData[id][carFaction] == GetFactionType(playerid)))
	    {
			if (!CarData[id][carLocked])
			{
				CarData[id][carLocked] = true;
				Car_Save(id);

				GameTextForPlayer(playerid,"~w~Carro ~r~trancado~w~!",3000,4);
				PlayerPlaySound(playerid, 1145, 0.0, 0.0, 0.0);

				SetVehicleParamsEx(CarData[id][carVehicle], engine, lights, alarm, 1, bonnet, boot, objective);
			}
			else
			{
				CarData[id][carLocked] = false;
				Car_Save(id);

				GameTextForPlayer(playerid,"~w~Carro ~g~destrancado~w~!",3000,4);
				PlayerPlaySound(playerid, 1145, 0.0, 0.0, 0.0);

				SetVehicleParamsEx(CarData[id][carVehicle], engine, lights, alarm, 0, bonnet, boot, objective);
			}
		}
	}
	else SendErrorMessage(playerid, "You are not in range of anything you can lock.");
	return 1;
}

CMD:sell(playerid, params[])
{
	static
	    targetid,
	    type[24],
	    string[128];

	if (sscanf(params, "us[24]S()[128]", targetid, type, string))
	{
	    SendSyntaxMessage(playerid, "/sell [playerid/name] [name]");
	    SendClientMessage(playerid, COLOR_YELLOW, "[NAMES]:{FFFFFF} house, business, vehicle");
	    return 1;
	}
	if (targetid == INVALID_PLAYER_ID || !IsPlayerNearPlayer(playerid, targetid, 5.0))
	{
		SendErrorMessage(playerid, "The player is disconnected or not near you.");
		return 1;
	}
	if (targetid == playerid)
	{
		SendErrorMessage(playerid, "You cannot sell to yourself.");
		return 1;
	}
	if (!strcmp(type, "vehicle", true))
	{
		static
		    price,
			carid = -1;

		if (sscanf(string, "d", price))
			return SendSyntaxMessage(playerid, "/sell [playerid/name] [veh] [price]");

		if (price < 1)
		    return SendErrorMessage(playerid, "The price you've entered cannot below the value of $1.");

		if ((carid = Car_Inside(playerid)) != -1 && Car_IsOwner(playerid, carid)) {
			PlayerInfo[targetid][pCarSeller] = playerid;
			PlayerInfo[targetid][pCarOffered] = carid;
			PlayerInfo[targetid][pCarValue] = price;

		    SendServerMessage(playerid, "You have requested %s to purchase your %s (%s).", pNome(targetid), ReturnVehicleModelName(CarData[carid][carModel]), FormatNumber(price));
            SendServerMessage(targetid, "%s has offered you their %s for %s (type \"/approve car\" to accept).", pNome(playerid), ReturnVehicleModelName(CarData[carid][carModel]), FormatNumber(price));
		}
		else SendErrorMessage(playerid, "You are not inside any of your vehicles.");
	}
	return 1;
}

CMD:approve(playerid, params[])
{
	if (isnull(params))
 	{
	 	SendSyntaxMessage(playerid, "/approve [name]");
		SendClientMessage(playerid, COLOR_YELLOW, "[NAMES]:{FFFFFF} house, business, car, food, faction, greet, frisk");
		return 1;
	}
    if (!strcmp(params, "car", true) && PlayerInfo[playerid][pCarSeller] != INVALID_PLAYER_ID)
	{
	    new
	        sellerid = PlayerInfo[playerid][pCarSeller],
	        carid = PlayerInfo[playerid][pCarOffered],
	        price = PlayerInfo[playerid][pCarValue];

		if (!IsPlayerNearPlayer(playerid, sellerid, 6.0))
		    return SendErrorMessage(playerid, "You are not near that player.");

		if (GetMoney(playerid) < price)
		    return SendErrorMessage(playerid, "You have insufficient funds to purchase this vehicle.");

		if (Car_Nearest(playerid) != carid)
		    return SendErrorMessage(playerid, "You must be near the vehicle to purchase it.");

		if (!Car_IsOwner(sellerid, carid))
		    return SendErrorMessage(playerid, "This vehicle offer is no longer valid.");

		SendServerMessage(playerid, "You have successfully purchased %s's %s for %s.", pNome(sellerid), ReturnVehicleModelName(CarData[carid][carModel]), FormatNumber(price));
		SendServerMessage(sellerid, "%s has successfully purchased your %s for %s.", pNome(playerid), ReturnVehicleModelName(CarData[carid][carModel]), FormatNumber(price));

		CarData[carid][carOwner] = GetPlayerSQLID(playerid);
		Car_Save(carid);

		GiveMoney(playerid, -price);
		GiveMoney(sellerid, price);

		//Log_Write("logs/offer_log.txt", "[%s] %s (%s) has sold a %s to %s (%s) for %s.", ReturnDate(), pNome(playerid), PlayerInfo[playerid][pIP], ReturnVehicleModelName(CarData[carid][carModel]), pNome(sellerid), PlayerInfo[sellerid][pIP], FormatNumber(price));

		PlayerInfo[playerid][pCarSeller] = INVALID_PLAYER_ID;
		PlayerInfo[playerid][pCarOffered] = -1;
		PlayerInfo[playerid][pCarValue] = 0;
	}
    return 1;
}


CMD:park(playerid, params[])
{
	new
	    carid = GetPlayerVehicleID(playerid);

	if (!carid)
	    return SendErrorMessage(playerid, "You must be inside your vehicle.");

    if (IsVehicleImpounded(carid))
    	return SendErrorMessage(playerid, "This vehicle is impounded and you can't use it.");

	if ((carid = Car_GetID(carid)) != -1 && Car_IsOwner(playerid, carid))
	{
	    if (GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
	        return SendErrorMessage(playerid, "You must be the driver!");

	    static
			g_arrSeatData[10] = {INVALID_PLAYER_ID, ...},
			g_arrDamage[4],
			Float:health,
			seatid;

        for (new i = 0; i < 14; i ++) {
			CarData[carid][carMods][i] = GetVehicleComponentInSlot(CarData[carid][carVehicle], i);
	    }
		GetVehicleDamageStatus(CarData[carid][carVehicle], g_arrDamage[0], g_arrDamage[1], g_arrDamage[2], g_arrDamage[3]);
		GetVehicleHealth(CarData[carid][carVehicle], health);

		foreach (new i : Player) if (IsPlayerInVehicle(i, CarData[carid][carVehicle])) {
		    seatid = GetPlayerVehicleSeat(i);

		    g_arrSeatData[seatid] = i;
		}
		GetVehiclePos(CarData[carid][carVehicle], CarData[carid][carPos][0], CarData[carid][carPos][1], CarData[carid][carPos][2]);
		GetVehicleZAngle(CarData[carid][carVehicle], CarData[carid][carPos][3]);

		Car_Spawn(carid);
		Car_Save(carid);

		SendServerMessage(playerid, "You have successfully parked your %s.", ReturnVehicleName(CarData[carid][carVehicle]));

        UpdateVehicleDamageStatus(CarData[carid][carVehicle], g_arrDamage[0], g_arrDamage[1], g_arrDamage[2], g_arrDamage[3]);
		SetVehicleHealth(CarData[carid][carVehicle], health);

		for (new i = 0; i < sizeof(g_arrSeatData); i ++) if (g_arrSeatData[i] != INVALID_PLAYER_ID) {
		    PutPlayerInVehicle(g_arrSeatData[i], CarData[carid][carVehicle], i);

		    g_arrSeatData[i] = INVALID_PLAYER_ID;
		}
	}
	else SendErrorMessage(playerid, "You are not inside anything you can park.");
	return 1;
}

CMD:unmod(playerid, params[])
{
	new
	    carid = GetPlayerVehicleID(playerid);

	if (!carid)
	    return SendErrorMessage(playerid, "You must be inside your vehicle.");

    if (IsVehicleImpounded(carid))
    	return SendErrorMessage(playerid, "This vehicle is impounded and you can't use it.");

	if ((carid = Car_GetID(carid)) != -1 && Car_IsOwner(playerid, carid))
	{
	    if (GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
	        return SendErrorMessage(playerid, "You must be the driver!");

		for (new i = 0; i < 14; i ++) {
		    RemoveVehicleComponent(CarData[carid][carVehicle], CarData[carid][carMods][i]);

		    CarData[carid][carMods][i] = 0;
		}
		Car_Save(carid);
		SendServerMessage(playerid, "You have removed the modifications from this vehicle.");
	}
	else SendErrorMessage(playerid, "You are not inside anything you can unmodify.");
	return 1;
}

CMD:trunk(playerid, params[])
{
	new
	    id = -1;

	if ((id = Car_Nearest(playerid)) != -1)
	{
	    if (IsVehicleImpounded(CarData[id][carVehicle]))
	        return SendErrorMessage(playerid, "This vehicle is impounded and you can't use it.");

	    if (IsPlayerInAnyVehicle(playerid))
	        return SendErrorMessage(playerid, "You must exit the vehicle first.");

		if (!IsDoorVehicle(CarData[id][carVehicle]))
		    return SendErrorMessage(playerid, "This vehicle doesn't have a trunk.");

		if (CarData[id][carLocked])
		    return SendErrorMessage(playerid, "The vehicle's trunk is locked.");

		Car_ShowTrunk(playerid, id);
	}
	else SendErrorMessage(playerid, "You are not in range of any vehicle.");
	return 1;
}


CMD:createcar(playerid, params[])
{
	static
		model[32],
		color1,
		color2,
		id = -1,
		type = 0;

    if (PlayerInfo[playerid][user_admin] < 5)
	    return SendErrorMessage(playerid, "You don't have permission to use this command.");

	if (sscanf(params, "s[32]I(-1)I(-1)I(0)", model, color1, color2, type))
 	{
	 	SendSyntaxMessage(playerid, "/createcar [model id/name] [color 1] [color 2] <faction>");
	 	SendClientMessage(playerid, COLOR_YELLOW, "[TYPES]:{FFFFFF} 1: Police | 2: News | 3: Medical | 4: Government");
	 	return 1;
	}
	if ((model[0] = GetVehicleModelByName(model)) == 0)
	    return SendErrorMessage(playerid, "Invalid model ID.");

	static
	    Float:x,
		Float:y,
		Float:z,
		Float:angle;

    GetPlayerPos(playerid, x, y, z);
	GetPlayerFacingAngle(playerid, angle);

	id = Car_Create(0, model[0], x, y, z, angle, color1, color2, type);

	if (id == -1)
	    return SendErrorMessage(playerid, "The server has reached the limit for dynamic vehicles.");

	SetPlayerPosEx(playerid, x, y, z + 2, 1000);
	SendServerMessage(playerid, "You have successfully created vehicle ID: %d.", CarData[id][carVehicle]);
	return 1;
}

CMD:releasecar(playerid, params[])
{
	if (!IsPlayerInRangeOfPoint(playerid, 3.0, 361.1653, 175.8127, 1008.3828))
	    return SendErrorMessage(playerid, "You must be at city hall to release a vehicle.");

	new
	    string[32 * MAX_OWNABLE_CARS],
		count;

	for (new i = 0; i < MAX_DYNAMIC_CARS; i ++) if (count < MAX_OWNABLE_CARS && CarData[i][carExists] && Car_IsOwner(playerid, i) && CarData[i][carImpounded] != -1)
	{
		format(string, sizeof(string), "%s%d: %s (%s)\n", string, count + 1, ReturnVehicleName(CarData[i][carVehicle]), FormatNumber(CarData[i][carImpoundPrice]));
        ListedVehicles[playerid][count++] = i;
	}
	if (!count)
	    SendErrorMessage(playerid, "You don't have any impounded vehicles.");

	else Dialog_Show(playerid, ReleaseCar, DIALOG_STYLE_LIST, "Release Vehicle", string, "Select", "Cancel");
	return 1;
}

CMD:tow(playerid, params[])
{
	if (GetVehicleModel(GetPlayerVehicleID(playerid)) != 525)
	    return SendErrorMessage(playerid, "You are not driving a tow truck.");

	if (GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
	    return SendErrorMessage(playerid, "You are not the driver.");

	new vehicleid = GetVehicleFromBehind(GetPlayerVehicleID(playerid));

	if (vehicleid == INVALID_VEHICLE_ID)
	    return SendErrorMessage(playerid, "There is no vehicle in range.");

	if (!IsDoorVehicle(vehicleid) || IsAPlane(vehicleid) || IsABoat(vehicleid) || IsAHelicopter(vehicleid))
	    return SendErrorMessage(playerid, "You can't tow this vehicle.");

	AttachTrailerToVehicle(vehicleid, GetPlayerVehicleID(playerid));
	SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s has hooked a %s onto their tow truck.", pNome(playerid), ReturnVehicleName(vehicleid));
	return 1;
}

CMD:untow(playerid, params[])
{
	if (GetVehicleModel(GetPlayerVehicleID(playerid)) != 525)
	    return SendErrorMessage(playerid, "You are not driving a tow truck.");

	if (GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
	    return SendErrorMessage(playerid, "You are not the driver.");

	new
	    trailerid = GetVehicleTrailer(GetPlayerVehicleID(playerid));

    if (!trailerid)
	    return SendErrorMessage(playerid, "There is no vehicle hooked onto the truck.");

	DetachTrailerFromVehicle(GetPlayerVehicleID(playerid));
	SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s has unhooked the %s from the tow truck.", pNome(playerid), ReturnVehicleName(trailerid));

	return 1;
}

CMD:impound(playerid, params[])
{
	new
		price,
		id = Impound_Nearest(playerid),
		vehicleid = GetPlayerVehicleID(playerid);

    if (GetFactionType(playerid) != FACTION_POLICE)
		return SendErrorMessage(playerid, "You must be a police officer.");

    if (sscanf(params, "d", price))
        return SendSyntaxMessage(playerid, "/impound [price]");

	if (price < 1 || price > 1000)
	    return SendErrorMessage(playerid, "The price can't be above $1,000 or below $1.");

	if (GetVehicleModel(vehicleid) != 525)
	    return SendErrorMessage(playerid, "You are not driving a tow truck.");

	if (id == -1)
	    return SendErrorMessage(playerid, "You are not in range of any impound lot.");

	if (!GetVehicleTrailer(vehicleid))
	    return SendErrorMessage(playerid, "There is no vehicle hooked.");

 	vehicleid = Car_GetID(GetVehicleTrailer(vehicleid));

	if (vehicleid == -1)
	    return SendErrorMessage(playerid, "You can't tow this vehicle.");

	if (CarData[vehicleid][carImpounded] != -1)
	    return SendErrorMessage(playerid, "This vehicle is already impounded.");

	CarData[vehicleid][carImpounded] = ImpoundData[id][impoundID];
	CarData[vehicleid][carImpoundPrice] = price;

	Tax_AddMoney(price);

	GetVehiclePos(CarData[vehicleid][carVehicle], CarData[vehicleid][carPos][0], CarData[vehicleid][carPos][1], CarData[vehicleid][carPos][2]);
	Car_Save(vehicleid);

	SendFactionMessage(PlayerInfo[playerid][pFaction], COLOR_RADIO, "RADIO: %s has impounded a %s for %s.", pNome(playerid), ReturnVehicleModelName(CarData[vehicleid][carModel]), FormatNumber(price));
 	DetachTrailerFromVehicle(GetPlayerVehicleID(playerid));

	return 1;
}

CMD:listcars(playerid, params[])
{
	new
	    Float:fX,
	    Float:fY,
	    Float:fZ,
		userid,
		count;

	if (sscanf(params, "u", userid))
	{
		SendClientMessage(playerid, COLOR_GREY, "-----------------------------------------------------------");

		for (new i = 0; i < MAX_DYNAMIC_CARS; i ++) if (Car_IsOwner(playerid, i)) {
		    GetVehiclePos(CarData[i][carVehicle], fX, fY, fZ);

		    SendClientMessageEx(playerid, COLOR_WHITE, "** ID: %d | Model: %s | Location: %s", CarData[i][carVehicle], ReturnVehicleModelName(CarData[i][carModel]), GetLocation(fX, fY, fZ));
		    count++;
		}
		if (!count)
		    SendClientMessage(playerid, COLOR_WHITE, "You don't own any vehicles.");

		SendClientMessage(playerid, COLOR_GREY, "-----------------------------------------------------------");
	}
	else if (PlayerInfo[playerid][user_admin] >= 3)
	{
		if (userid == INVALID_PLAYER_ID)
	    	return SendErrorMessage(playerid, "You have specified an invalid player.");

		SendClientMessage(playerid, COLOR_GREY, "-----------------------------------------------------------");
  		SendClientMessageEx(playerid, COLOR_YELLOW, "Vehicles registered to %s (ID: %d):", pNome(userid), userid);

		for (new i = 0; i < MAX_DYNAMIC_CARS; i ++) if (Car_IsOwner(userid, i)) {
  			GetVehiclePos(CarData[i][carVehicle], fX, fY, fZ);

			SendClientMessageEx(playerid, COLOR_WHITE, "** ID: %d | Model: %s | Location: %s", CarData[i][carVehicle], ReturnVehicleModelName(CarData[i][carModel]), GetLocation(fX, fY, fZ));
			count++;
		}
		if (!count)
		    SendClientMessage(playerid, COLOR_WHITE, "That player doesn't own any vehicles.");

		SendClientMessage(playerid, COLOR_GREY, "-----------------------------------------------------------");
	}
	return 1;
}

CMD:editcar(playerid, params[])
{
	static
	    id,
	    type[24],
	    string[128];

	if (PlayerInfo[playerid][user_admin] < 5)
	    return SendErrorMessage(playerid, "You don't have permission to use this command.");

	if (sscanf(params, "ds[24]S()[128]", id, type, string))
 	{
	 	SendSyntaxMessage(playerid, "/editcar [id] [name]");
	    SendClientMessage(playerid, COLOR_YELLOW, "[NAMES]:{FFFFFF} location, faction, color1, color2");
		return 1;
	}
	if (!IsValidVehicle(id) || Car_GetID(id) == -1)
	    return SendErrorMessage(playerid, "You have specified an invalid vehicle ID.");

	id = Car_GetID(id);

	if (!strcmp(type, "location", true))
	{
 		GetPlayerPos(playerid, CarData[id][carPos][0], CarData[id][carPos][1], CarData[id][carPos][2]);
		GetPlayerFacingAngle(playerid, CarData[id][carPos][3]);

		Car_Save(id);
		Car_Spawn(id);

		SetPlayerPosEx(playerid, CarData[id][carPos][0], CarData[id][carPos][1], CarData[id][carPos][2] + 2.0, 1000);
		SendAdminAlert(COLOR_LIGHTRED, "[ADMIN]: %s has adjusted the location of vehicle ID: %d.", pNome(playerid), CarData[id][carVehicle]);
	}
	else if (!strcmp(type, "faction", true))
	{
	    new typeint;

	    if (sscanf(string, "d", typeint))
     	{
     	    SendSyntaxMessage(playerid, "/editcar [id] [faction] [type]");
		 	SendClientMessage(playerid, COLOR_YELLOW, "[TYPES]:{FFFFFF} 1: Police | 2: News | 3: Medical | 4: Government");
		 	return 1;
		}
		if (typeint < 0 || typeint > 4)
		    return SendErrorMessage(playerid, "The specified type can't be below 0 or above 4.");

		CarData[id][carFaction] = typeint;

		Car_Save(id);
		SendAdminAlert(COLOR_LIGHTRED, "[ADMIN]: %s has adjusted the type of vehicle ID: %d to %d.", pNome(playerid), CarData[id][carVehicle], typeint);
	}
    else if (!strcmp(type, "color1", true))
	{
	    new color1;

	    if (sscanf(string, "d", color1))
			return SendSyntaxMessage(playerid, "/editcar [id] [color1] [color 1]");

		if (color1 < 0 || color1 > 255)
		    return SendErrorMessage(playerid, "The specified color can't be below 0 or above 255.");

		CarData[id][carColor1] = color1;
		ChangeVehicleColor(CarData[id][carVehicle], CarData[id][carColor1], CarData[id][carColor2]);

		Car_Save(id);
		SendAdminAlert(COLOR_LIGHTRED, "[ADMIN]: %s has adjusted the color 1 of vehicle ID: %d to %d.", pNome(playerid), CarData[id][carVehicle], color1);
	}
    else if (!strcmp(type, "color2", true))
	{
	    new color2;

	    if (sscanf(string, "d", color2))
			return SendSyntaxMessage(playerid, "/editcar [id] [color2] [color 2]");

		if (color2 < 0 || color2 > 255)
		    return SendErrorMessage(playerid, "The specified color can't be below 0 or above 255.");

		CarData[id][carColor2] = color2;
		ChangeVehicleColor(CarData[id][carVehicle], CarData[id][carColor1], CarData[id][carColor2]);

		Car_Save(id);
		SendAdminAlert(COLOR_LIGHTRED, "[ADMIN]: %s has adjusted the color 2 of vehicle ID: %d to %d.", pNome(playerid), CarData[id][carVehicle], color2);
	}
	return 1;
}


CMD:givecar(playerid, params[])
{
	static
		userid,
	    model[32];

    if (PlayerInfo[playerid][user_admin] < 4)
	    return SendErrorMessage(playerid, "You don't have permission to use this command.");

	if (sscanf(params, "us[32]", userid, model))
	    return SendSyntaxMessage(playerid, "/givecar [playerid/name] [modelid/name]");

	if (Car_GetCount(userid) >= MAX_OWNABLE_CARS)
	    return SendErrorMessage(playerid, "This player already owns the maximum amount of cars.");

    if ((model[0] = GetVehicleModelByName(model)) == 0)
	    return SendErrorMessage(playerid, "Invalid model ID.");

	static
	    Float:x,
		Float:y,
		Float:z,
		Float:angle,
		id = -1;

    GetPlayerPos(userid, x, y, z);
	GetPlayerFacingAngle(userid, angle);

	id = Car_Create(PlayerInfo[userid][user_id], model[0], x, y + 2, z + 1, angle, random(127), random(127), 0);

	if (id == -1)
	    return SendErrorMessage(playerid, "The server has reached the limit for dynamic vehicles.");

	SendServerMessage(playerid, "You have created vehicle ID: %d for %s.", CarData[id][carVehicle], pNome(userid));
	return 1;
}


CMD:createimpound(playerid, params[])
{
	static
	    id = -1,
		Float:x,
		Float:y,
		Float:z;

    if (PlayerInfo[playerid][user_admin] < 5)
	    return SendErrorMessage(playerid, "You don't have permission to use this command.");

	if (GetPlayerInterior(playerid) > 0 || GetPlayerVirtualWorld(playerid) > 0)
 		return SendErrorMessage(playerid, "You can only create impound lots outside interiors.");

	GetPlayerPos(playerid, x, y, z);

	id = Impound_Create(x, y, z);

	if (id == -1)
	    return SendErrorMessage(playerid, "The server has reached the limit for impound lots.");

	SendServerMessage(playerid, "You have successfully created impound lot ID: %d.", id);
	return 1;
}

CMD:destroyimpound(playerid, params[])
{
	static
	    id = 0;

    if (PlayerInfo[playerid][user_admin] < 5)
	    return SendErrorMessage(playerid, "You don't have permission to use this command.");

	if (sscanf(params, "d", id))
	    return SendSyntaxMessage(playerid, "/destroyimpound [impound id]");

	if ((id < 0 || id >= MAX_IMPOUND_LOTS) || !ImpoundData[id][impoundExists])
	    return SendErrorMessage(playerid, "You have specified an invalid impound lot ID.");

	Impound_Delete(id);
	SendServerMessage(playerid, "You have successfully destroyed impound lot ID: %d.", id);
	return 1;
}

CMD:editimpound(playerid, params[])
{
	static
	    id,
	    type[24],
	    string[128];

	if (PlayerInfo[playerid][user_admin] < 5)
	    return SendErrorMessage(playerid, "You don't have permission to use this command.");

	if (sscanf(params, "ds[24]S()[128]", id, type, string))
 	{
	 	SendSyntaxMessage(playerid, "/editimpound [id] [name]");
	    SendClientMessage(playerid, COLOR_YELLOW, "[NAMES]:{FFFFFF} location, release");
		return 1;
	}
	if ((id < 0 || id >= MAX_IMPOUND_LOTS) || !ImpoundData[id][impoundExists])
	    return SendErrorMessage(playerid, "You have specified an invalid impound lot ID.");

	if (!strcmp(type, "location", true))
	{
	    static
	        Float:x,
	        Float:y,
	        Float:z;

	    GetPlayerPos(playerid, x, y, z);

		ImpoundData[id][impoundLot][0] = x;
		ImpoundData[id][impoundLot][1] = y;
		ImpoundData[id][impoundLot][2] = z;

		Impound_Refresh(id);
		Impound_Save(id);

		SendAdminAlert(COLOR_LIGHTRED, "[ADMIN]: %s has adjusted the location of impound ID: %d.", pNome(playerid), id);
	}
	else if (!strcmp(type, "release", true))
	{
	    static
	        Float:x,
	        Float:y,
	        Float:z,
			Float:angle;

	    GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, angle);

		ImpoundData[id][impoundRelease][0] = x;
		ImpoundData[id][impoundRelease][1] = y;
		ImpoundData[id][impoundRelease][2] = z;
		ImpoundData[id][impoundRelease][3] = angle;

		Impound_Save(id);
		SendAdminAlert(COLOR_LIGHTRED, "[ADMIN]: %s has adjusted the release point of impound ID: %d.", pNome(playerid), id);
	}
	return 1;
}

GetPlayerSQLID(playerid)
{
	return (PlayerInfo[playerid][user_id]);
}