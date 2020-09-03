forward SaveWeaponsSQL(playerid);
public SaveWeaponsSQL(playerid)
{
    new query[1028];
    print("Fui chamado! [1]");
    UpdateWeapons(playerid);
    mysql_format(Database, query, sizeof(query), "UPDATE `pweapons` SET \
	`Guns1` = '%d', \
	`Ammo1` = '%d', \
	`Guns2` = '%d', \
	`Ammo2` = '%d', \
	`Guns3` = '%d', \
	`Ammo3` = '%d', \
	`Guns4` = '%d', \
	`Ammo4` = '%d', \
	`Guns5` = '%d', \
	`Ammo5` = '%d', \
	`Guns6` = '%d', \
	`Ammo6` = '%d', \
	`Guns7` = '%d', \
	`Ammo7` = '%d', \
	`Guns8` = '%d', \
	`Ammo8` = '%d', \
	`Guns9` = '%d', \
	`Ammo9` = '%d', \
	`Guns10` = '%d', \
	`Ammo10` = '%d', \
	`Guns11` = '%d', \
	`Ammo11` = '%d', \
	`Guns12` = '%d', \
	`Ammo12` = '%d', \
	`Guns13` = '%d', \
	`Ammo13` = '%d' WHERE `ID` = '%i'",
	PlayerInfo[playerid][pGuns][0],
	PlayerInfo[playerid][pAmmo][0],
	PlayerInfo[playerid][pGuns][1],
	PlayerInfo[playerid][pAmmo][1],
	PlayerInfo[playerid][pGuns][2],
	PlayerInfo[playerid][pAmmo][2],
	PlayerInfo[playerid][pGuns][3],
	PlayerInfo[playerid][pAmmo][3],
	PlayerInfo[playerid][pGuns][4],
	PlayerInfo[playerid][pAmmo][4],
	PlayerInfo[playerid][pGuns][5],
	PlayerInfo[playerid][pAmmo][5],
	PlayerInfo[playerid][pGuns][6],
	PlayerInfo[playerid][pAmmo][6],
	PlayerInfo[playerid][pGuns][7],
	PlayerInfo[playerid][pAmmo][7],
	PlayerInfo[playerid][pGuns][8],
	PlayerInfo[playerid][pAmmo][8],
	PlayerInfo[playerid][pGuns][9],
	PlayerInfo[playerid][pAmmo][9],
	PlayerInfo[playerid][pGuns][10],
	PlayerInfo[playerid][pAmmo][10],
	PlayerInfo[playerid][pGuns][11],
	PlayerInfo[playerid][pAmmo][11],
	PlayerInfo[playerid][pGuns][12],
	PlayerInfo[playerid][pAmmo][12],
	PlayerInfo[playerid][user_id]);
	mysql_tquery(Database, query);
}

forward OnPlayerLoadWeapons(playerid);
public OnPlayerLoadWeapons(playerid)
{
	cache_get_value_name_int(0, "Guns1", PlayerInfo[playerid][pGuns][0]);
	cache_get_value_name_int(0, "Ammo1", PlayerInfo[playerid][pAmmo][0]);
	cache_get_value_name_int(0, "Guns2", PlayerInfo[playerid][pGuns][1]);
	cache_get_value_name_int(0, "Ammo2", PlayerInfo[playerid][pAmmo][1]);
	cache_get_value_name_int(0, "Guns3", PlayerInfo[playerid][pGuns][2]);
	cache_get_value_name_int(0, "Ammo3", PlayerInfo[playerid][pAmmo][2]);
	cache_get_value_name_int(0, "Guns4", PlayerInfo[playerid][pGuns][3]);
	cache_get_value_name_int(0, "Ammo4", PlayerInfo[playerid][pAmmo][3]);
	cache_get_value_name_int(0, "Guns5", PlayerInfo[playerid][pGuns][4]);
	cache_get_value_name_int(0, "Ammo5", PlayerInfo[playerid][pAmmo][4]);
	cache_get_value_name_int(0, "Guns6", PlayerInfo[playerid][pGuns][5]);
	cache_get_value_name_int(0, "Ammo6", PlayerInfo[playerid][pAmmo][5]);
	cache_get_value_name_int(0, "Guns7", PlayerInfo[playerid][pGuns][6]);
	cache_get_value_name_int(0, "Ammo7", PlayerInfo[playerid][pAmmo][6]);
	cache_get_value_name_int(0, "Guns8", PlayerInfo[playerid][pGuns][7]);
	cache_get_value_name_int(0, "Ammo8", PlayerInfo[playerid][pAmmo][7]);
	cache_get_value_name_int(0, "Guns9", PlayerInfo[playerid][pGuns][8]);
	cache_get_value_name_int(0, "Ammo9", PlayerInfo[playerid][pAmmo][8]);
	cache_get_value_name_int(0, "Guns10", PlayerInfo[playerid][pGuns][9]);
	cache_get_value_name_int(0, "Ammo10", PlayerInfo[playerid][pAmmo][9]);
	cache_get_value_name_int(0, "Guns11", PlayerInfo[playerid][pGuns][10]);
	cache_get_value_name_int(0, "Ammo11", PlayerInfo[playerid][pAmmo][10]);
	cache_get_value_name_int(0, "Guns12", PlayerInfo[playerid][pGuns][11]);
	cache_get_value_name_int(0, "Ammo12", PlayerInfo[playerid][pAmmo][11]);
	cache_get_value_name_int(0, "Guns13", PlayerInfo[playerid][pGuns][12]);
	cache_get_value_name_int(0, "Ammo13", PlayerInfo[playerid][pAmmo][12]);
    print("Fui chamado! [2]");
    SetWeapons(playerid);
	return 1;
}
