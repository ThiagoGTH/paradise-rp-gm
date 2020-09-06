enum DEALERSHIP_DATA {
    VEH_MODELID,
    VEH_NAME[35],
    VEH_PRICE,
    VEH_ID
};

new const CAR_SHOP[][DEALERSHIP_DATA] = {
    {411, "Infernus", 10000000, 411},
    {541, "Bullet", 5000000, 541}
};

new const BOAT_SHOP[][DEALERSHIP_DATA] = {
    {446, "Squallo", 20, 446},
    {452, "Speeder", 20, 452}
};

new const BIKE_SHOP[][DEALERSHIP_DATA] = {
    {461, "PCJ-600", 20, 461},
    {521, "FCR-900", 20, 521}
};


CMD:concessionaria(playerid)
{
    if(IsPlayerInAnyVehicle(playerid))
		return SendErrorMessage(playerid, "Você não pode utilizar esse comando dentro de um veículo.");

    ShowPlayerDialog(playerid, 4690, DIALOG_STYLE_LIST, "Concessionária de Veículos","Motocicletas\nEsportivos\nBarcos", "Selecionar", "Fechar");
    return 1;
}

stock deal_OnDialogResponse(playerid, dialogid, response, listitem)
{
    if(dialogid == 4690)
    {
        if(response)
        {
            if(listitem == 0)
            {
                new subString[64];
                static string[sizeof(BIKE_SHOP) * sizeof(subString)];

                if (string[0] == EOS) 
                {
                    for (new i; i < sizeof(BIKE_SHOP); i++) 
                    {
                        format(subString, sizeof(subString), "%i(0.0, 0.0, -50.0, 1.5)\t%s~n~~g~~h~$%i\n", BIKE_SHOP[i][VEH_MODELID], BIKE_SHOP[i][VEH_NAME], BIKE_SHOP[i][VEH_PRICE]);
                        strcat(string, subString);
                    }
                }
                return ShowPlayerDialog(playerid, 4691, DIALOG_STYLE_PREVIEW_MODEL, "Concessionaria de Veiculos", string, "Comprar", "Cancelar");
            }

            else if(listitem == 1)
            {
                new subString[64];
                static string[sizeof(CAR_SHOP) * sizeof(subString)];

                if (string[0] == EOS) 
                {
                    for (new i; i < sizeof(CAR_SHOP); i++) 
                    {
                        format(subString, sizeof(subString), "%i(0.0, 0.0, -50.0, 1.5)\t%s~n~~g~~h~$%i\n", CAR_SHOP[i][VEH_MODELID], CAR_SHOP[i][VEH_NAME], CAR_SHOP[i][VEH_PRICE]);
                        strcat(string, subString);
                    }
                }
                return ShowPlayerDialog(playerid, 4692, DIALOG_STYLE_PREVIEW_MODEL, "Concessionaria de Veiculos", string, "Comprar", "Cancelar");
            }

			else if(listitem == 2)
            {
                new subString[64];
                static string[sizeof(BOAT_SHOP) * sizeof(subString)];

                if (string[0] == EOS) 
                {
                    for (new i; i < sizeof(BOAT_SHOP); i++) 
                    {
                        format(subString, sizeof(subString), "%i(0.0, 0.0, -50.0, 1.5)\t%s~n~~g~~h~$%i\n", BOAT_SHOP[i][VEH_MODELID], BOAT_SHOP[i][VEH_NAME], BOAT_SHOP[i][VEH_PRICE]);
                        strcat(string, subString);
                    }
                }
                return ShowPlayerDialog(playerid, 4693, DIALOG_STYLE_PREVIEW_MODEL, "Concessionaria de Veiculos", string, "Comprar", "Cancelar");
            }
        }
        return 1;
    }

    // CONFIRMANDO COMPRA
    if (dialogid == 4691) 
    {
        if (response) 
        {
            if (GetMoney(playerid) < BIKE_SHOP[listitem][VEH_PRICE])
	    	    return SendErrorMessage(playerid, "Você não pode pagar pelo veículo escolhido. ($%s).", FormatNumber(BIKE_SHOP[listitem][VEH_PRICE]));
            
           // new string[128];

            ShowPlayerDialog(playerid, 5558, DIALOG_STYLE_MSGBOX, "CONFIRMAR COMPRA", "Você tem certeza que deseja comprar esse(a) '%s'?\n\nAtenção: Este veículo custa $%s nessa concessionária.", #Sim, #Não);
            print("Roi1");
            /*format(string, sizeof(string), "Você tem certeza que deseja comprar esse(a) '%s'?\n\nAtenção: Este veículo custa $%s nessa concessionária.", ReturnVehicleModelName(BIKE_SHOP[listitem][VEH_MODELID]), FormatNumber(BIKE_SHOP[listitem][VEH_PRICE]));
            ShowPlayerDialog(playerid, 5558, DIALOG_STYLE_MSGBOX, "CONFIRMAR COMPRA", string, "Sim", "Não");*/
            return 1;
        }
    }

    if (dialogid == 4692) 
    {
        if (response) 
        {
            if (GetMoney(playerid) < CAR_SHOP[listitem][VEH_PRICE])
	    	    return SendErrorMessage(playerid, "Você não pode pagar pelo veículo escolhido. ($%s).", FormatNumber(CAR_SHOP[listitem][VEH_PRICE]));
            
            new string[128];
            format(string, sizeof(string), "Você tem certeza que deseja comprar esse(a) '%s'?\n\nAtenção: Este veículo custa $%s nessa concessionária.", ReturnVehicleModelName(CAR_SHOP[listitem][VEH_MODELID]), FormatNumber(CAR_SHOP[listitem][VEH_PRICE]));
            ShowPlayerDialog(playerid, 4801, DIALOG_STYLE_MSGBOX, "CONFIRMAR COMPRA", string, "Sim", "Não");
            return 1;
        }
    }

    if (dialogid == 4693) 
    {
        if (response) 
        {
            if (GetMoney(playerid) < BOAT_SHOP[listitem][VEH_PRICE])
	    	    return SendErrorMessage(playerid, "Você não pode pagar pelo veículo escolhido. ($%s).", FormatNumber(BOAT_SHOP[listitem][VEH_PRICE]));
            
            new string[128];
            format(string, sizeof(string), "Você tem certeza que deseja comprar esse(a) '%s'?\n\nAtenção: Este veículo custa $%s nessa concessionária.", ReturnVehicleModelName(BOAT_SHOP[listitem][VEH_MODELID]), FormatNumber(BOAT_SHOP[listitem][VEH_PRICE]));
            ShowPlayerDialog(playerid, 4802, DIALOG_STYLE_MSGBOX, "CONFIRMAR COMPRA", string, "Sim", "Não");
            return 1;
        }
    }

    // FINALIZANDO COMPRA
    if (dialogid == 5558)
    {
        if (response)
        {
            static
                Float:x,
                Float:y,
                Float:z,
                Float:angle,
                id = -1;

            if (GetMoney(playerid) < BIKE_SHOP[listitem][VEH_PRICE])
                return SendErrorMessage(playerid, "Você não possui dinheiro o suficiente para comprar este veículo.");

            if (Car_GetCount(playerid) >= MAX_OWNABLE_CARS)
                return SendErrorMessage(playerid, "Você já possui %d veículos (máximo do servidor).", MAX_OWNABLE_CARS);

            GetPlayerPos(playerid, x, y, z);
            GetPlayerFacingAngle(playerid, angle);

            id = Car_Create(PlayerInfo[playerid][user_id], BIKE_SHOP[listitem][VEH_MODELID], x, y, z, angle, 1, 1);

            if (id == -1)
	            return SendErrorMessage(playerid, "O servidor chegou ao limite de veículos.");

            SendServerMessage(playerid, "Você comprou um %s por $%s!", ReturnVehicleModelName(BIKE_SHOP[listitem][VEH_MODELID]), FormatNumber(BIKE_SHOP[listitem][VEH_PRICE]));
            GiveMoney(playerid, -BIKE_SHOP[listitem][VEH_PRICE]);
            //PutPlayerInVehicle(playerid, id, 0);
            print("Roi4");
        }
        return 1;
    }

    if (dialogid == 4801)
    {
        if (response)
        {
            new
                model = CAR_SHOP[listitem][VEH_MODELID],
                price = CAR_SHOP[listitem][VEH_PRICE];

            static
                id = -1;

            if (GetMoney(playerid) < price)
                return SendErrorMessage(playerid, "Você não possui dinheiro o suficiente para comprar este veículo.");

            if (Car_GetCount(playerid) >= MAX_OWNABLE_CARS)
                return SendErrorMessage(playerid, "Você já possui %d veículos (máximo do servidor).", MAX_OWNABLE_CARS);

            static
            Float:x,
            Float:y,
            Float:z,
            Float:angle;

            GetPlayerPos(playerid, x, y, z);
            GetPlayerFacingAngle(playerid, angle);

            id = Car_Create(PlayerInfo[playerid][user_id], model, x, y, z, angle, 1, 1);

            if (id == -1)
	            return SendErrorMessage(playerid, "O servidor chegou ao limite de veículos.");

            SendServerMessage(playerid, "Você comprou um %s por $%s!", ReturnVehicleModelName(CAR_SHOP[listitem][VEH_MODELID]), FormatNumber(price));
            GiveMoney(playerid, -price);
            //PutPlayerInVehicle(playerid, id, 0);
        }
        return 1;
    }

    if (dialogid == 4802)
    {
        if (response)
        {
            new
                model = BOAT_SHOP[listitem][VEH_MODELID],
                price = BOAT_SHOP[listitem][VEH_PRICE];

            static
                id = -1;

            if (GetMoney(playerid) < price)
                return SendErrorMessage(playerid, "Você não possui dinheiro o suficiente para comprar este veículo.");

            if (Car_GetCount(playerid) >= MAX_OWNABLE_CARS)
                return SendErrorMessage(playerid, "Você já possui %d veículos (máximo do servidor).", MAX_OWNABLE_CARS);

            static
            Float:x,
            Float:y,
            Float:z,
            Float:angle;

            GetPlayerPos(playerid, x, y, z);
            GetPlayerFacingAngle(playerid, angle);

            id = Car_Create(PlayerInfo[playerid][user_id], model, x, y, z, angle, 1, 1);

            if (id == -1)
	            return SendErrorMessage(playerid, "O servidor chegou ao limite de veículos.");

            SendServerMessage(playerid, "Você comprou um %s por $%s!", ReturnVehicleModelName(BOAT_SHOP[listitem][VEH_MODELID]), FormatNumber(price));
            GiveMoney(playerid, -price);
            //PutPlayerInVehicle(playerid, id, 0);
        }
        return 1;
    }

    return 1;
}