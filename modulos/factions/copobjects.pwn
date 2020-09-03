#define     MAX_COP_OBJECTS     (300)
#define     COPOBJECTS_DIALOG   (6450)
#define     SPEEDCAM_RANGE      (30.0)

enum    _:e_object_types
{
	OBJECT_TYPE_ROADBLOCK,
	OBJECT_TYPE_SIGN,
	OBJECT_TYPE_POLICELINE,
	OBJECT_TYPE_SPIKE,
	OBJECT_TYPE_SPEEDCAM
}

enum	e_object_data
{
	Owner[MAX_PLAYER_NAME],
	Type,
	ObjData,
	ObjModel,
	Float: ObjX,
	Float: ObjY,
	Float: ObjZ,
	Float: ObjRX,
	Float: ObjRY,
	Float: ObjRZ,
	ObjInterior,
	ObjVirtualWorld,
	ObjID,
	Text3D: ObjLabel,
	ObjArea,
	bool: ObjCreated
}

enum E_COPOBJECT_DATA {
    COPOBJECT_MODELID
};

// ROAD BLOCK
new const E_COP_OBJECTS[][E_COPOBJECT_DATA ] = {
    {1427},
    {1425},
    {1282},
    {1424},
    {1422},
    {1423},
    {1459},
    {978},
    {979},
    {981},
    {3091},
    {1238},
    {19425},
    {19467}
};

enum E_COPSIGN_DATA {
    COPSIGN_MODELID
};

// SIGN
new const E_COP_SIGN[][E_COPSIGN_DATA ] = {
    {19948},
    {19949},
    {19950},
    {19951},
    {19952},
    {19953},
    {19954},
    {19955},
    {19956},
    {19957},
    {19958},
    {19959},
    {19960},
    {19961},
    {19962},
    {19963},
    {19964},
    {19965},
    {19966},
    {19967},
    {19968},
    {19969},
    {19970},
    {19971},
    {19972},
    {19973},
    {19974},
    {19975},
    {19976},
    {19977},
    {19978},
    {19979},
    {19982},
    {19983},
    {19984},
    {19985},
    {19986},
    {19987},
    {19988},
    {19989},
    {19990},
    {19991},
    {19992}
};

new
	CopObjectData[MAX_COP_OBJECTS][e_object_data],
	EditingCopObjectID[MAX_PLAYERS] = {-1, ...};

new
    Float: zOffsets[5] = {1.35, 3.25, 0.35, 0.4, 5.35},
    Float: streamDistances[5] = {10.0, 10.0, 5.0, 3.0, SPEEDCAM_RANGE};

new
	DB: ObjectDB,
	DBStatement: LoadObjects,
	DBStatement: AddObject,
	DBStatement: UpdateObject,
	DBStatement: RemoveObject;
 
stock GetFreeObjectID()
{
	new id = -1;
	for(new i; i < MAX_COP_OBJECTS; i++)
	{
	    if(!CopObjectData[i][ObjCreated])
	    {
	        id = i;
	        break;
	    }
	}

	return id;
}

stock InsertObjectToDB(id)
{
    stmt_bind_value(AddObject, 0, DB::TYPE_INTEGER, id);
	stmt_bind_value(AddObject, 1, DB::TYPE_STRING, CopObjectData[id][Owner]);
	stmt_bind_value(AddObject, 2, DB::TYPE_INTEGER, CopObjectData[id][Type]);
	stmt_bind_value(AddObject, 3, DB::TYPE_INTEGER, CopObjectData[id][ObjData]);
    stmt_bind_value(AddObject, 4, DB::TYPE_INTEGER, CopObjectData[id][ObjModel]);
	stmt_bind_value(AddObject, 5, DB::TYPE_FLOAT, CopObjectData[id][ObjX]);
	stmt_bind_value(AddObject, 6, DB::TYPE_FLOAT, CopObjectData[id][ObjY]);
	stmt_bind_value(AddObject, 7, DB::TYPE_FLOAT, CopObjectData[id][ObjZ]);
	stmt_bind_value(AddObject, 8, DB::TYPE_FLOAT, CopObjectData[id][ObjRX]);
	stmt_bind_value(AddObject, 9, DB::TYPE_FLOAT, CopObjectData[id][ObjRY]);
	stmt_bind_value(AddObject, 10, DB::TYPE_FLOAT, CopObjectData[id][ObjRZ]);
	stmt_bind_value(AddObject, 11, DB::TYPE_INTEGER, CopObjectData[id][ObjInterior]);
	stmt_bind_value(AddObject, 12, DB::TYPE_INTEGER, CopObjectData[id][ObjVirtualWorld]);
	stmt_execute(AddObject);
	return 1;
}

stock SaveObjectToDB(id)
{
    stmt_bind_value(UpdateObject, 0, DB::TYPE_FLOAT, CopObjectData[id][ObjX]);
	stmt_bind_value(UpdateObject, 1, DB::TYPE_FLOAT, CopObjectData[id][ObjY]);
	stmt_bind_value(UpdateObject, 2, DB::TYPE_FLOAT, CopObjectData[id][ObjZ]);
	stmt_bind_value(UpdateObject, 3, DB::TYPE_FLOAT, CopObjectData[id][ObjRX]);
	stmt_bind_value(UpdateObject, 4, DB::TYPE_FLOAT, CopObjectData[id][ObjRY]);
	stmt_bind_value(UpdateObject, 5, DB::TYPE_FLOAT, CopObjectData[id][ObjRZ]);
	stmt_bind_value(UpdateObject, 6, DB::TYPE_INTEGER, id);
	stmt_execute(UpdateObject);
	return 1;
}

encode_tires(tire1, tire2, tire3, tire4) return tire1 | (tire2 << 1) | (tire3 << 2) | (tire4 << 3);

stock co_OnGMInit()
{
	ObjectDB = db_open("cop_objects.db");
    db_query(ObjectDB, "CREATE TABLE IF NOT EXISTS objects (id INTEGER, owner TEXT, type INTEGER, data INTEGER, model INTEGER, posx FLOAT, posy FLOAT, posz FLOAT, rotx FLOAT, roty FLOAT, rotz FLOAT, interior INTEGER, virtualworld INTEGER)");

    LoadObjects = db_prepare(ObjectDB, "SELECT * FROM objects");
    AddObject = db_prepare(ObjectDB, "INSERT INTO objects (id, owner, type, data, model, posx, posy, posz, rotx, roty, rotz, interior, virtualworld) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
    UpdateObject = db_prepare(ObjectDB, "UPDATE objects SET posx=?, posy=?, posz=?, rotx=?, roty=?, rotz=? WHERE id=?");
	RemoveObject = db_prepare(ObjectDB, "DELETE FROM objects WHERE id=?");
	
	new id, type, data, model, owner[MAX_PLAYER_NAME], Float: pos[3], Float: rot[3], interior, vworld;
	stmt_bind_result_field(LoadObjects, 0, DB::TYPE_INTEGER, id);
	stmt_bind_result_field(LoadObjects, 1, DB::TYPE_STRING, owner, MAX_PLAYER_NAME);
	stmt_bind_result_field(LoadObjects, 2, DB::TYPE_INTEGER, type);
	stmt_bind_result_field(LoadObjects, 3, DB::TYPE_INTEGER, data);
	stmt_bind_result_field(LoadObjects, 4, DB::TYPE_INTEGER, model);
	stmt_bind_result_field(LoadObjects, 5, DB::TYPE_FLOAT, pos[0]);
	stmt_bind_result_field(LoadObjects, 6, DB::TYPE_FLOAT, pos[1]);
	stmt_bind_result_field(LoadObjects, 7, DB::TYPE_FLOAT, pos[2]);
	stmt_bind_result_field(LoadObjects, 8, DB::TYPE_FLOAT, rot[0]);
	stmt_bind_result_field(LoadObjects, 9, DB::TYPE_FLOAT, rot[1]);
	stmt_bind_result_field(LoadObjects, 10, DB::TYPE_FLOAT, rot[2]);
	stmt_bind_result_field(LoadObjects, 11, DB::TYPE_INTEGER, interior);
	stmt_bind_result_field(LoadObjects, 12, DB::TYPE_INTEGER, vworld);

	if(stmt_execute(LoadObjects))
	{
	    new label[96];
	    while(stmt_fetch_row(LoadObjects))
	    {
            CopObjectData[id][ObjCreated] = true;
            CopObjectData[id][Owner] = owner;
		    CopObjectData[id][Type] = type;
		    CopObjectData[id][ObjData] = data;
		    CopObjectData[id][ObjModel] = model;
		    CopObjectData[id][ObjInterior] = interior;
		    CopObjectData[id][ObjVirtualWorld] = vworld;
			CopObjectData[id][ObjX] = pos[0];
			CopObjectData[id][ObjY] = pos[1];
			CopObjectData[id][ObjZ] = pos[2];
			CopObjectData[id][ObjRX] = rot[0];
			CopObjectData[id][ObjRY] = rot[1];
			CopObjectData[id][ObjRZ] = rot[2];
			CopObjectData[id][ObjID] = CreateDynamicObject(model, pos[0], pos[1], pos[2], rot[0], rot[1], rot[2], vworld, interior);
			CopObjectData[id][ObjArea] = -1;
			
			switch(type)
			{
			    case OBJECT_TYPE_ROADBLOCK: format(label, sizeof(label), "Bloqueio de rua (ID: %d)\n{FFFFFF}Colocado por %s", id, CopObjectData[id][Owner]);
			    case OBJECT_TYPE_SIGN: format(label, sizeof(label), "Placa (ID: %d)\n{FFFFFF}Colocada por %s", id, CopObjectData[id][Owner]);
			    case OBJECT_TYPE_POLICELINE: format(label, sizeof(label), "Linha policial (ID: %d)\n{FFFFFF}Colocada por %s", id, CopObjectData[id][Owner]);
			    case OBJECT_TYPE_SPIKE:
				{
					format(label, sizeof(label), "Tapete de pregos (ID: %d)\n{FFFFFF}Colocado por %s", id, CopObjectData[id][Owner]);
					CopObjectData[id][ObjArea] = CreateDynamicSphere(pos[0], pos[1], pos[2], 2.5, vworld, interior);
				}
				
				case OBJECT_TYPE_SPEEDCAM:
				{
					format(label, sizeof(label), "Radar (ID: %d)\n{FFFFFF}Velocidade limite: {E74C3C}%d\n{FFFFFF}Colocado por %s", id, data, CopObjectData[id][Owner]);
					CopObjectData[id][ObjArea] = CreateDynamicSphere(pos[0], pos[1], pos[2], SPEEDCAM_RANGE, vworld, interior);
				}
			}
			
			CopObjectData[id][ObjLabel] = CreateDynamic3DTextLabel(label, 0x3498DBFF, pos[0], pos[1], pos[2] + zOffsets[type], streamDistances[type], _, _, _, vworld, interior);
		}
	}
	return 1;
}

stock co_OnGMExit()
{
	db_close(ObjectDB);
	return 1;
}

stock GetPlayerCarSpeed(playerid)
{
    new Float:vx, Float:vy, Float:vz, Float:vel;
    vel = GetVehicleVelocity(GetPlayerVehicleID(playerid), vx, vy, vz);
    vel = (floatsqroot(((vx*vx)+(vy*vy))+(vz*vz))* 181.5);
    return floatround(vel);
}

stock co_OnPlayerConnect(playerid)
{
	EditingCopObjectID[playerid] = -1;
	return 1;
}

stock co_OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(dialogid == COPOBJECTS_DIALOG)
	{
		if(!response) return 1;
		if(listitem == 0) {
			new subString[64];
			static string[sizeof(E_COP_OBJECTS) * sizeof(subString)];

			if (string[0] == EOS) {
				for (new i; i < sizeof(E_COP_OBJECTS); i++) {
					format(subString, sizeof(subString), "%i(0.0, 0.0, -50.0, 1.5)\tID:%i\n", E_COP_OBJECTS[i][COPOBJECT_MODELID], E_COP_OBJECTS[i][COPOBJECT_MODELID]);
					strcat(string, subString);
				}
			}

			return ShowPlayerDialog(playerid, 3813, DIALOG_STYLE_PREVIEW_MODEL, "Bloqueio de Rua", string, "Selecionar", "Cancelar");
		}

		if(listitem == 1) {
			new subString[64];
			static string[sizeof(E_COP_SIGN) * sizeof(subString)];

			if (string[0] == EOS) {
				for (new i; i < sizeof(E_COP_SIGN); i++) {
					format(subString, sizeof(subString), "%i(0.0, 0.0, -50.0, 1.5)\tID: %i\n", E_COP_SIGN[i][COPSIGN_MODELID], E_COP_SIGN[i][COPSIGN_MODELID]);
					strcat(string, subString);
				}
			}

			return ShowPlayerDialog(playerid, 3814, DIALOG_STYLE_PREVIEW_MODEL, "Placas", string, "Selecionar", "Cancelar");
		}

		if(listitem == 2)
		{
		    new id = GetFreeObjectID();
		    if(id == -1) return SendErrorMessage(playerid, "Os objetos de facções chegaram ao limite do servidor.");
		    CopObjectData[id][ObjCreated] = true;
		    GetPlayerName(playerid, CopObjectData[id][Owner], MAX_PLAYER_NAME);
		    CopObjectData[id][Type] = OBJECT_TYPE_POLICELINE;
		    CopObjectData[id][ObjModel] = 19834;
		    CopObjectData[id][ObjInterior] = GetPlayerInterior(playerid);
		    CopObjectData[id][ObjVirtualWorld] = GetPlayerVirtualWorld(playerid);
		    
		    new Float: x, Float: y, Float: z, Float: a;
		    GetPlayerPos(playerid, x, y, z);
		    GetPlayerFacingAngle(playerid, a);
		    x += (2.0 * floatsin(-a, degrees));
			y += (2.0 * floatcos(-a, degrees));
			CopObjectData[id][ObjX] = x;
			CopObjectData[id][ObjY] = y;
			CopObjectData[id][ObjZ] = z;
			CopObjectData[id][ObjRX] = 0.0;
			CopObjectData[id][ObjRY] = 0.0;
			CopObjectData[id][ObjRZ] = a;
			CopObjectData[id][ObjID] = CreateDynamicObject(19834, x, y, z, 0.0, 0.0, a, CopObjectData[id][ObjVirtualWorld], CopObjectData[id][ObjInterior]);
			CopObjectData[id][ObjArea] = -1;
			
			new string[96];
			format(string, sizeof(string), "Linha policial (ID: %d)\n{FFFFFF}Colocada por %s", id, CopObjectData[id][Owner]);
			CopObjectData[id][ObjLabel] = CreateDynamic3DTextLabel(string, 0x3498DBFF, x, y, z + 0.35, 5.0, _, _, _, CopObjectData[id][ObjVirtualWorld], CopObjectData[id][ObjInterior]);
            InsertObjectToDB(id);
		}
		
		if(listitem == 3)
		{
		    new id = GetFreeObjectID();
		    if(id == -1) return SendErrorMessage(playerid, "Os objetos de facções chegaram ao limite do servidor.");
		    CopObjectData[id][ObjCreated] = true;
		    GetPlayerName(playerid, CopObjectData[id][Owner], MAX_PLAYER_NAME);
		    CopObjectData[id][Type] = OBJECT_TYPE_SPIKE;
		    CopObjectData[id][ObjModel] = 2899;
		    CopObjectData[id][ObjInterior] = GetPlayerInterior(playerid);
		    CopObjectData[id][ObjVirtualWorld] = GetPlayerVirtualWorld(playerid);

		    new Float: x, Float: y, Float: z, Float: a;
		    GetPlayerPos(playerid, x, y, z);
		    GetPlayerFacingAngle(playerid, a);
		    x += (2.0 * floatsin(-a, degrees));
			y += (2.0 * floatcos(-a, degrees));
			
			CopObjectData[id][ObjX] = x;
			CopObjectData[id][ObjY] = y;
			CopObjectData[id][ObjZ] = z - 0.85;
			CopObjectData[id][ObjRX] = 0.0;
			CopObjectData[id][ObjRY] = 0.0;
			CopObjectData[id][ObjRZ] = a + 90.0;
			CopObjectData[id][ObjID] = CreateDynamicObject(2899, x, y, z - 0.85, 0.0, 0.0, a + 90.0, CopObjectData[id][ObjVirtualWorld], CopObjectData[id][ObjInterior]);
			CopObjectData[id][ObjArea] = CreateDynamicSphere(x, y, z - 0.85, 2.5, CopObjectData[id][ObjVirtualWorld], CopObjectData[id][ObjInterior]);
            
			new string[96];
			format(string, sizeof(string), "Tapete de pregos(ID: %d)\n{FFFFFF}Colocado por %s", id, CopObjectData[id][Owner]);
			CopObjectData[id][ObjLabel] = CreateDynamic3DTextLabel(string, 0x3498DBFF, x, y, z - 0.4, 3.0, _, _, _, CopObjectData[id][ObjVirtualWorld], CopObjectData[id][ObjInterior]);
            InsertObjectToDB(id);
		}
		
		if(listitem == 4) ShowPlayerDialog(playerid, COPOBJECTS_DIALOG+1, DIALOG_STYLE_INPUT, "RADAR: Configuração", "Digite um limite de velocidade para esse radar:", "Criar", "Cancelar");
	    return 1;
	}
	
	if(dialogid == COPOBJECTS_DIALOG+1)
	{
		if(!response) return 1;
		if(!strlen(inputtext)) return ShowPlayerDialog(playerid, COPOBJECTS_DIALOG+1, DIALOG_STYLE_INPUT, "RADAR: Configuração", "Digite um limite de velocidade para esse radar:", "Criar", "Cancelar");
		new id = GetFreeObjectID(), limit = strval(inputtext);
	    if(id == -1) return SendErrorMessage(playerid, "Os objetos de facções chegaram ao limite do servidor.");
	    CopObjectData[id][ObjCreated] = true;
	    GetPlayerName(playerid, CopObjectData[id][Owner], MAX_PLAYER_NAME);
	    CopObjectData[id][Type] = OBJECT_TYPE_SPEEDCAM;
	    CopObjectData[id][ObjData] = limit;
	    CopObjectData[id][ObjModel] = 18880;
	    CopObjectData[id][ObjInterior] = GetPlayerInterior(playerid);
	    CopObjectData[id][ObjVirtualWorld] = GetPlayerVirtualWorld(playerid);

	    new Float: x, Float: y, Float: z, Float: a;
	    GetPlayerPos(playerid, x, y, z);
	    GetPlayerFacingAngle(playerid, a);
	    x += (2.0 * floatsin(-a, degrees));
		y += (2.0 * floatcos(-a, degrees));
		CopObjectData[id][ObjX] = x;
		CopObjectData[id][ObjY] = y;
		CopObjectData[id][ObjZ] = z - 1.5;
		CopObjectData[id][ObjRX] = 0.0;
		CopObjectData[id][ObjRY] = 0.0;
		CopObjectData[id][ObjRZ] = 0.0;
		CopObjectData[id][ObjID] = CreateDynamicObject(18880, x, y, z - 1.5, 0.0, 0.0, 0.0, CopObjectData[id][ObjVirtualWorld], CopObjectData[id][ObjInterior]);
		CopObjectData[id][ObjArea] = CreateDynamicSphere(x, y, z - 1.5, SPEEDCAM_RANGE, CopObjectData[id][ObjVirtualWorld], CopObjectData[id][ObjInterior]);
		
		new string[128];
		format(string, sizeof(string), "Radar (ID: %d)\n{FFFFFF}Velocidade limite: {E74C3C}%d\n{FFFFFF}Colocado por %s", id, limit, CopObjectData[id][Owner]);
		CopObjectData[id][ObjLabel] = CreateDynamic3DTextLabel(string, 0x3498DBFF, x, y, z + 3.85, SPEEDCAM_RANGE, _, _, _, CopObjectData[id][ObjVirtualWorld], CopObjectData[id][ObjInterior]);
        InsertObjectToDB(id);
		return 1;
	}
	

	if (dialogid == 3813) 
	{
        if(!response) return 1;
		new id = GetFreeObjectID();
		new modelid = E_COP_OBJECTS[listitem][COPOBJECT_MODELID];
	    if(id == -1) return SendErrorMessage(playerid, "Os objetos de facções chegaram ao limite do servidor.");
	    CopObjectData[id][ObjCreated] = true;		
	    GetPlayerName(playerid, CopObjectData[id][Owner], MAX_PLAYER_NAME);
	    CopObjectData[id][Type] = OBJECT_TYPE_ROADBLOCK;
	    CopObjectData[id][ObjModel] = modelid;
	    CopObjectData[id][ObjInterior] = GetPlayerInterior(playerid);
	    CopObjectData[id][ObjVirtualWorld] = GetPlayerVirtualWorld(playerid);

	    new Float: x, Float: y, Float: z, Float: a;
	    GetPlayerPos(playerid, x, y, z);
	    GetPlayerFacingAngle(playerid, a);
	    x += (2.0 * floatsin(-a, degrees));
		y += (2.0 * floatcos(-a, degrees));
		CopObjectData[id][ObjX] = x;
		CopObjectData[id][ObjY] = y;
		CopObjectData[id][ObjZ] = z;
		CopObjectData[id][ObjRX] = 0.0;
		CopObjectData[id][ObjRY] = 0.0;
		CopObjectData[id][ObjRZ] = a;
		CopObjectData[id][ObjID] = CreateDynamicObject(modelid, x, y, z, 0.0, 0.0, a, CopObjectData[id][ObjVirtualWorld], CopObjectData[id][ObjInterior]);
		CopObjectData[id][ObjArea] = -1;

		new string[96];
		SendServerMessage(playerid, "Você colocou o bloqueio de rua ID: %d", id);
		format(string, sizeof(string), "Bloqueio de rua (ID: %d)\n{FFFFFF}Colocado por %s", id, CopObjectData[id][Owner]);
		CopObjectData[id][ObjLabel] = CreateDynamic3DTextLabel(string, 0x3498DBFF, x, y, z + 1.35, 10.0, _, _, _, CopObjectData[id][ObjVirtualWorld], CopObjectData[id][ObjInterior]);
		InsertObjectToDB(id);
    }

	if (dialogid == 3814) {
	    if(!response) return 1;
		new id = GetFreeObjectID();
	    if(id == -1) return SendErrorMessage(playerid, "Os objetos de facções chegaram ao limite do servidor.");
        new modelid = E_COP_SIGN[listitem][COPSIGN_MODELID];
	    CopObjectData[id][ObjCreated] = true;
	    GetPlayerName(playerid, CopObjectData[id][Owner], MAX_PLAYER_NAME);
	    CopObjectData[id][Type] = OBJECT_TYPE_SIGN;
	    CopObjectData[id][ObjModel] = modelid;
	    CopObjectData[id][ObjInterior] = GetPlayerInterior(playerid);
	    CopObjectData[id][ObjVirtualWorld] = GetPlayerVirtualWorld(playerid);

	    new Float: x, Float: y, Float: z, Float: a;
	    GetPlayerPos(playerid, x, y, z);
	    GetPlayerFacingAngle(playerid, a);
	    x += (2.0 * floatsin(-a, degrees));
		y += (2.0 * floatcos(-a, degrees));
		CopObjectData[id][ObjX] = x;
		CopObjectData[id][ObjY] = y;
		CopObjectData[id][ObjZ] = z - 1.25;
		CopObjectData[id][ObjRX] = 0.0;
		CopObjectData[id][ObjRY] = 0.0;
		CopObjectData[id][ObjRZ] = a;
		CopObjectData[id][ObjID] = CreateDynamicObject(modelid, x, y, z - 1.25, 0.0, 0.0, a, CopObjectData[id][ObjVirtualWorld], CopObjectData[id][ObjInterior]);
		CopObjectData[id][ObjArea] = -1;

		new string[96];
		SendServerMessage(playerid, "Você colocou a placa ID: %d", id);
		format(string, sizeof(string), "Placa (ID: %d)\n{FFFFFF}Colocada por %s", id, CopObjectData[id][Owner]);
		CopObjectData[id][ObjLabel] = CreateDynamic3DTextLabel(string, 0x3498DBFF, x, y, z + 2.0, 10.0, _, _, _, CopObjectData[id][ObjVirtualWorld], CopObjectData[id][ObjInterior]);
		InsertObjectToDB(id);
	}
	return 0;
}

public OnPlayerEnterDynamicArea(playerid, areaid)
{
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{
		for(new i; i < MAX_COP_OBJECTS; i++)
		{
		    if(!CopObjectData[i][ObjCreated]) continue;
		    if(areaid == CopObjectData[i][ObjArea])
		    {
				switch(CopObjectData[i][Type])
				{
				    case OBJECT_TYPE_SPIKE:
				    {
						new panels, doors, lights, tires;
			        	GetVehicleDamageStatus(GetPlayerVehicleID(playerid), panels, doors, lights, tires);
			        	UpdateVehicleDamageStatus(GetPlayerVehicleID(playerid), panels, doors, lights, encode_tires(1, 1, 1, 1));
			        	PlayerPlaySound(playerid, 1190, 0.0, 0.0, 0.0);
					}

					case OBJECT_TYPE_SPEEDCAM:
					{
					    new radar;
						radar = GetPlayerCarSpeed(playerid);
					    if(radar > CopObjectData[i][ObjData])
					    {
					        // detected by a speed camera
					        PlayerPlaySound(playerid, 1132, 0.0, 0.0, 0.0);
					        SendServerMessage(playerid, "Você foi multado por exceder o limite de velocidade. Valor: $850.");
					    	Ticket_Add(playerid, 850, "Exceder o limite de velocidade.");
						}
					}
				}

				break;
		    }
		}
	}
	
	return 1;
}

stock co_OnPlayerEditDynamicObject(playerid, objectid, response, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz)
{
	if(EditingCopObjectID[playerid] != -1)
	{
	    new id = EditingCopObjectID[playerid];

	    switch(response)
	    {
			case EDIT_RESPONSE_FINAL:
			{
			    CopObjectData[id][ObjX] = x;
				CopObjectData[id][ObjY] = y;
				CopObjectData[id][ObjZ] = z;
				CopObjectData[id][ObjRX] = rx;
				CopObjectData[id][ObjRY] = ry;
				CopObjectData[id][ObjRZ] = rz;
			    SetDynamicObjectPos(objectid, x, y, z);
	            SetDynamicObjectRot(objectid, rx, ry, rz);
	            
	            Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, CopObjectData[id][ObjLabel], E_STREAMER_X, x);
	            Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, CopObjectData[id][ObjLabel], E_STREAMER_Y, y);
	            Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, CopObjectData[id][ObjLabel], E_STREAMER_Z, z + zOffsets[ CopObjectData[id][Type] ]);
	            
	            if(IsValidDynamicArea(CopObjectData[id][ObjArea]))
	            {
	                Streamer_SetFloatData(STREAMER_TYPE_AREA, CopObjectData[id][ObjArea], E_STREAMER_X, x);
		            Streamer_SetFloatData(STREAMER_TYPE_AREA, CopObjectData[id][ObjArea], E_STREAMER_Y, y);
		            Streamer_SetFloatData(STREAMER_TYPE_AREA, CopObjectData[id][ObjArea], E_STREAMER_Z, z + zOffsets[ CopObjectData[id][Type] ]);
	            }

				SaveObjectToDB(id);
			    EditingCopObjectID[playerid] = -1;
			}
			
	        case EDIT_RESPONSE_CANCEL:
	        {
	            SetDynamicObjectPos(objectid, CopObjectData[id][ObjX], CopObjectData[id][ObjY], CopObjectData[id][ObjZ]);
	            SetDynamicObjectRot(objectid, CopObjectData[id][ObjRX], CopObjectData[id][ObjRY], CopObjectData[id][ObjRZ]);
	            EditingCopObjectID[playerid] = -1;
	        }
	    }
	}
	
	return 1;
}

CMD:colocarobjeto(playerid, params[])
{
	if (GetFactionType(playerid) != FACTION_POLICE && GetFactionType(playerid) != FACTION_MEDIC && GetFactionType(playerid) != FACTION_GOV)
		return SendErrorMessage(playerid, "Você não faz parte de uma facção governamental.");

 	if(IsPlayerInAnyVehicle(playerid)) return SendErrorMessage(playerid, "Você não pode utilizar esse comando dentro de um veículo.");
 	ShowPlayerDialog(playerid, COPOBJECTS_DIALOG, DIALOG_STYLE_LIST, "OBJETOS: Escolha uma categoria", "Bloqueios\nPlacas\nLinha policial\nTapete de pregos\nRadar", "Escolher", "Cancelar");
	return 1;
}

CMD:editarobjeto(playerid, params[])
{
    if (GetFactionType(playerid) != FACTION_POLICE && GetFactionType(playerid) != FACTION_MEDIC && GetFactionType(playerid) != FACTION_GOV)
		return SendErrorMessage(playerid, "Você não faz parte de uma facção governamental.");

	if(EditingCopObjectID[playerid] != -1) return SendErrorMessage(playerid, "Você já está editando um objeto.");
	if(isnull(params)) return SendSyntaxMessage(playerid, "/editarobjeto [id]");
	new id = strval(params[0]);
	if(!(0 <= id <= MAX_COP_OBJECTS - 1)) return SendErrorMessage(playerid, "ID do objeto inexistente.");
	if(!CopObjectData[id][ObjCreated]) return SendErrorMessage(playerid, "Objeto não existe.");
	if(!IsPlayerInRangeOfPoint(playerid, 16.0, CopObjectData[id][ObjX], CopObjectData[id][ObjY], CopObjectData[id][ObjZ])) return SendErrorMessage(playerid, "Você não está perto do objeto que deseja editar.");
	new name[MAX_PLAYER_NAME];
	GetPlayerName(playerid, name, MAX_PLAYER_NAME);
	if(!IsPlayerAdmin(playerid) && strcmp(CopObjectData[id][Owner], name)) return SendErrorMessage(playerid, "Este objeto não é seu, você não pode edita-lo.");
    EditingCopObjectID[playerid] = id;
	EditDynamicObject(playerid, CopObjectData[id][ObjID]);
	return 1;
}
/*
CMD:gotoobject(playerid, params[])
{
	if(!IsPlayerAdmin(playerid)) return SendErrorMessage(playerid, "Only RCON admins can use this command.");
	if(isnull(params)) return SendSyntaxMessage(playerid, "/gotoobject [id]");
	new id = strval(params[0]);
	if(!(0 <= id <= MAX_COP_OBJECTS - 1)) return SendErrorMessage(playerid, "ID do objeto inexistente.");
	if(!CopObjectData[id][ObjCreated]) return SendErrorMessage(playerid, "Objeto não existe.");
	SetPlayerPos(playerid, CopObjectData[id][ObjX], CopObjectData[id][ObjY], CopObjectData[id][ObjZ] + 1.75);
	SetPlayerInterior(playerid, CopObjectData[id][ObjInterior]);
	SetPlayerVirtualWorld(playerid, CopObjectData[id][ObjVirtualWorld]);
	SendServerMessage(playerid, "Teleported to object.");
	return 1;
}*/

CMD:removerobjeto(playerid, params[])
{
    if (GetFactionType(playerid) != FACTION_POLICE && GetFactionType(playerid) != FACTION_MEDIC && GetFactionType(playerid) != FACTION_GOV)
		return SendErrorMessage(playerid, "Você não faz parte de uma facção governamental.");

	if(isnull(params)) return SendSyntaxMessage(playerid, "/removerobjeto [id]");
	new id = strval(params[0]);
	if(!(0 <= id <= MAX_COP_OBJECTS - 1)) return SendErrorMessage(playerid, "ID do objeto inexistente.");
	if(!CopObjectData[id][ObjCreated]) return SendErrorMessage(playerid, "Objeto não existe.");
	if(EditingCopObjectID[playerid] == id) return SendErrorMessage(playerid, "Você não pode remover um objeto que esta sendo editado.");
	new name[MAX_PLAYER_NAME];
	GetPlayerName(playerid, name, MAX_PLAYER_NAME);
	if(strcmp(CopObjectData[id][Owner], name)) return SendErrorMessage(playerid, "Esse objeto não é seu, então não pode ser removido.");
	CopObjectData[id][ObjCreated] = false;
	DestroyDynamicObject(CopObjectData[id][ObjID]);
	DestroyDynamic3DTextLabel(CopObjectData[id][ObjLabel]);
	if(IsValidDynamicArea(CopObjectData[id][ObjArea])) DestroyDynamicArea(CopObjectData[id][ObjArea]);
	CopObjectData[id][ObjID] = -1;
	CopObjectData[id][ObjLabel] = Text3D: -1;
	CopObjectData[id][ObjArea] = -1;
	stmt_bind_value(RemoveObject, 0, DB::TYPE_INTEGER, id);
	stmt_execute(RemoveObject);
	
	SendServerMessage(playerid, "Objeto removido com sucesso.");
	return 1;
}

CMD:destruirobjeto(playerid, params[])
{
    if(PlayerInfo[playerid][user_logged] == 0) return SendClientMessage(playerid, COLOR_GRAD1, "Você não está logado.");
	if(PlayerInfo[playerid][user_admin] < 1) return SendClientMessage(playerid, COLOR_GREY, "Você não possui autorização para utilizar esse comando.");

	if(isnull(params)) return SendSyntaxMessage(playerid, "/destruirobjeto [id]");
	new id = strval(params[0]);
	if(!(0 <= id <= MAX_COP_OBJECTS - 1)) return SendErrorMessage(playerid, "ID do objeto inexistente.");
	if(!CopObjectData[id][ObjCreated]) return SendErrorMessage(playerid, "Objeto não existe.");
	if(EditingCopObjectID[playerid] == id) return SendErrorMessage(playerid, "Você não pode remover um objeto que esta sendo editado.");
	new name[MAX_PLAYER_NAME];
	GetPlayerName(playerid, name, MAX_PLAYER_NAME);
	CopObjectData[id][ObjCreated] = false;
	DestroyDynamicObject(CopObjectData[id][ObjID]);
	DestroyDynamic3DTextLabel(CopObjectData[id][ObjLabel]);
	if(IsValidDynamicArea(CopObjectData[id][ObjArea])) DestroyDynamicArea(CopObjectData[id][ObjArea]);
	CopObjectData[id][ObjID] = -1;
	CopObjectData[id][ObjLabel] = Text3D: -1;
	CopObjectData[id][ObjArea] = -1;
	stmt_bind_value(RemoveObject, 0, DB::TYPE_INTEGER, id);
	stmt_execute(RemoveObject);
	
	SendServerMessage(playerid, "Objeto removido com sucesso.");
	return 1;
}