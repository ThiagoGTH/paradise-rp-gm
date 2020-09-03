/* A FAZERES:

SAVE INTERIOR AND VIRTUAL WORLD

*/
#include    <YSI\y_iterate>     

#define     MAX_BANKERS     (10)
#define     MAX_ATMS        (50)

#define     BANKER_ICON_RANGE       (10.0)		
#define     ATM_ICON_RANGE       	(100.0)		
#define     ACCOUNT_PRICE           (100)      	
#define     ACCOUNT_CLIMIT          (3)         
#define     ACCOUNT_LIMIT           (1000000000) 

enum    _:E_BANK_DIALOG
{
    DIALOG_BANK_MENU_NOLOGIN = 12450,
    DIALOG_BANK_MENU,
    DIALOG_BANK_CREATE_ACCOUNT,
    DIALOG_BANK_ACCOUNTS,
    DIALOG_BANK_LOGIN_ID,
	DIALOG_BANK_LOGIN_PASS,
	DIALOG_BANK_DEPOSIT,
	DIALOG_BANK_WITHDRAW,
	DIALOG_BANK_TRANSFER_1,
	DIALOG_BANK_TRANSFER_2,
	DIALOG_BANK_PASSWORD,
	DIALOG_BANK_REMOVE,
	DIALOG_BANK_LOGS,
	DIALOG_BANK_LOG_PAGE
}

enum    _:E_BANK_LOGTYPE
{
	TYPE_NONE,
	TYPE_LOGIN,
	TYPE_DEPOSIT,
	TYPE_WITHDRAW,
	TYPE_TRANSFER,
	TYPE_PASSCHANGE
}

enum    E_BANKER
{
	// saved
	Skin,
	Float: bankerX,
	Float: bankerY,
	Float: bankerZ,
	Float: bankerA,
	bankerVW,
	bankerI,
	// temp
	bankerActorID,
	Text3D: bankerLabel
}

enum    E_ATM
{
	// saved
	Float: atmX,
	Float: atmY,
	Float: atmZ,
	Float: atmRX,
	Float: atmRY,
	Float: atmRZ,
	// temp
	atmObjID,
		
	Text3D: atmLabel
}

new
	BankerData[MAX_BANKERS][E_BANKER],
	ATMData[MAX_ATMS][E_ATM];

new
	Iterator: Bankers<MAX_BANKERS>,
	Iterator: ATMs<MAX_ATMS>;

new
	CurrentAccountID[MAX_PLAYERS] = {-1, ...},
	LogListType[MAX_PLAYERS] = {TYPE_NONE, ...},
	LogListPage[MAX_PLAYERS],
	EditingATMID[MAX_PLAYERS] = {-1, ...};

formatInt(intVariable, iThousandSeparator = ',', iCurrencyChar = '$')
{
 	static
		s_szReturn[ 32 ],
		s_szThousandSeparator[ 2 ] = { ' ', EOS },
		s_szCurrencyChar[ 2 ] = { ' ', EOS },
		s_iVariableLen,
		s_iChar,
		s_iSepPos,
		bool:s_isNegative
	;

	format( s_szReturn, sizeof( s_szReturn ), "%d", intVariable );

	if(s_szReturn[0] == '-')
		s_isNegative = true;
	else
		s_isNegative = false;

	s_iVariableLen = strlen( s_szReturn );

	if ( s_iVariableLen >= 4 && iThousandSeparator)
	{
		s_szThousandSeparator[ 0 ] = iThousandSeparator;

		s_iChar = s_iVariableLen;
		s_iSepPos = 0;

		while ( --s_iChar > _:s_isNegative )
		{
			if ( ++s_iSepPos == 3 )
			{
				strins( s_szReturn, s_szThousandSeparator, s_iChar );

				s_iSepPos = 0;
			}
		}
	}
	if(iCurrencyChar) {
		s_szCurrencyChar[ 0 ] = iCurrencyChar;
		strins( s_szReturn, s_szCurrencyChar, _:s_isNegative );
	}
	return s_szReturn;
}

IsPlayerNearBanker(playerid)
{
	foreach(new i : Bankers)
	{
	    if(IsPlayerInRangeOfPoint(playerid, 3.0, BankerData[i][bankerX], BankerData[i][bankerY], BankerData[i][bankerZ])) return 1;
	}

	return 0;
}

GetClosestATM(playerid, Float: range = 3.0)
{
	new id = -1, Float: dist = range, Float: tempdist;
	foreach(new i : ATMs)
	{
	    tempdist = GetPlayerDistanceFromPoint(playerid, ATMData[i][atmX], ATMData[i][atmY], ATMData[i][atmZ]);

	    if(tempdist > range) continue;
		if(tempdist <= dist)
		{
			dist = tempdist;
			id = i;
		}
	}

	return id;
}

Bank_SaveLog(playerid, type, accid, toaccid, amount)
{
	if(type == TYPE_NONE) return 1;
	new query[256];

	switch(type)
	{
	    case TYPE_LOGIN, TYPE_PASSCHANGE: mysql_format(Database, query, sizeof(query), "INSERT INTO bank_logs SET AccountID=%d, Type=%d, Player='%e', Date=UNIX_TIMESTAMP()", accid, type, Player_GetName(playerid));
	    case TYPE_DEPOSIT, TYPE_WITHDRAW: mysql_format(Database, query, sizeof(query), "INSERT INTO bank_logs SET AccountID=%d, Type=%d, Player='%e', Amount=%d, Date=UNIX_TIMESTAMP()", accid, type, Player_GetName(playerid), amount);
		case TYPE_TRANSFER: mysql_format(Database, query, sizeof(query), "INSERT INTO bank_logs SET AccountID=%d, ToAccountID=%d, Type=%d, Player='%e', Amount=%d, Date=UNIX_TIMESTAMP()", accid, toaccid, type, Player_GetName(playerid), amount);
	}

	mysql_tquery(Database, query);
	return 1;
}

Bank_ShowMenu(playerid)
{
	new string[256], using_atm = GetPVarInt(playerid, "usingATM");
	if(CurrentAccountID[playerid] == -1) {
		format(string, sizeof(string), "{%06x}Criar conta\t{2ECC71}%s\nMinhas contas\t{F1C40F}%d\nLogin da conta", (using_atm ? 0xE74C3CFF >>> 8 : 0xFFFFFFFF >>> 8), (using_atm ? ("") : formatInt(ACCOUNT_PRICE)), Bank_AccountCount(playerid));
		ShowPlayerDialog(playerid, DIALOG_BANK_MENU_NOLOGIN, DIALOG_STYLE_TABLIST, "{F1C40F}Banco: {FFFFFF}Menu", string, "Escolher", "Fechar");
	}else{
	    new balance = Bank_GetBalance(CurrentAccountID[playerid]), menu_title[64];
		format(menu_title, sizeof(menu_title), "{F1C40F}Banco: {FFFFFF}Menu (Conta ID: {F1C40F}%d{FFFFFF})", CurrentAccountID[playerid]);

	    format(
			string,
			sizeof(string),
			"{%06x}Criar conta\t{2ECC71}%s\nMinhas contas\t{F1C40F}%d\nDepositar\t{2ECC71}%s\nSacar\t{2ECC71}%s\nTransferir\t{2ECC71}%s\n{%06x}Extratos\n{%06x}Mudar senha\n{%06x}Deletar conta\nDeslogar",
			(using_atm ? 0xE74C3CFF >>> 8 : 0xFFFFFFFF >>> 8),
			(using_atm ? ("") : formatInt(ACCOUNT_PRICE)),
			Bank_AccountCount(playerid),
			formatInt(GetPlayerMoney(playerid)),
			formatInt(balance),
			formatInt(balance),
			(using_atm ? 0xE74C3CFF >>> 8 : 0xFFFFFFFF >>> 8),
			(using_atm ? 0xE74C3CFF >>> 8 : 0xFFFFFFFF >>> 8),
			(using_atm ? 0xE74C3CFF >>> 8 : 0xFFFFFFFF >>> 8)
		);

		ShowPlayerDialog(playerid, DIALOG_BANK_MENU, DIALOG_STYLE_TABLIST, menu_title, string, "Escolher", "Fechar");
	}

	DeletePVar(playerid, "bankLoginAccount");
	DeletePVar(playerid, "bankTransferAccount");
	return 1;
}

Bank_ShowLogMenu(playerid)
{
	LogListType[playerid] = TYPE_NONE;
	LogListPage[playerid] = 0;
	ShowPlayerDialog(playerid, DIALOG_BANK_LOGS, DIALOG_STYLE_LIST, "{F1C40F}Banco: {FFFFFF}Extratos", "Dinheiro depositado\nDinheiro retirado\nTransferências\nLogins\nTrocas de senha", "Mostrar", "Voltar");
	return 1;
}

Bank_AccountCount(playerid)
{
	new query[144], Cache: find_accounts;
	mysql_format(Database, query, sizeof(query), "SELECT null FROM bank_accounts WHERE Owner='%e' && Disabled=0", Player_GetName(playerid));
	find_accounts = mysql_query(Database, query);

	new count = cache_num_rows();
	cache_delete(find_accounts);
	return count;
}

Bank_GetBalance(accountid)
{
	new query[144], Cache: get_balance;
	mysql_format(Database, query, sizeof(query), "SELECT Balance FROM bank_accounts WHERE ID=%d && Disabled=0", accountid);
	get_balance = mysql_query(Database, query);

	new balance;
	cache_get_value_name_int(0, "Balance", balance);
	cache_delete(get_balance);
	return balance;
}

Bank_GetOwner(accountid)
{
	new query[144], owner[MAX_PLAYER_NAME], Cache: get_owner;
	mysql_format(Database, query, sizeof(query), "SELECT Owner FROM bank_accounts WHERE ID=%d && Disabled=0", accountid);
	get_owner = mysql_query(Database, query);

	cache_get_value_name(0, "Owner", owner);
	cache_delete(get_owner);
	return owner;
}

Bank_ListAccounts(playerid)
{
    new query[256], Cache: get_accounts;
    mysql_format(Database, query, sizeof(query), "SELECT ID, Balance, LastAccess, FROM_UNIXTIME(CreatedOn, '%%d/%%m/%%Y %%H:%%i:%%s') AS Created, FROM_UNIXTIME(LastAccess, '%%d/%%m/%%Y %%H:%%i:%%s') AS Last FROM bank_accounts WHERE Owner='%e' && Disabled=0 ORDER BY CreatedOn DESC", Player_GetName(playerid));
	get_accounts = mysql_query(Database, query);
    new rows = cache_num_rows();

	if(rows) {
	    new string[1024], acc_id, balance, last_access, cdate[24], ldate[24];
    	format(string, sizeof(string), "ID\tSaldo\tCriada em\tÚltimo acesso\n");
	    for(new i; i < rows; ++i)
	    {
	        cache_get_value_name_int(i, "ID", acc_id);
	        cache_get_value_name_int(i, "Balance", balance);
	        cache_get_value_name_int(i, "LastAccess", last_access);
        	cache_get_value_name(i, "Created", cdate);
        	cache_get_value_name(i, "Last", ldate);
        	
	        format(string, sizeof(string), "%s{FFFFFF}%d\t{2ECC71}%s\t{FFFFFF}%s\t%s\n", string, acc_id, formatInt(balance), cdate, (last_access == 0) ? ("Nunca") : ldate);
	    }

		ShowPlayerDialog(playerid, DIALOG_BANK_ACCOUNTS, DIALOG_STYLE_TABLIST_HEADERS, "{F1C40F}Banco: {FFFFFF}Minhas contas", string, "Logar", "Voltar");
	}else{
	    SendErrorMessage(playerid, "Você não possui nenhuma conta no banco.");
		Bank_ShowMenu(playerid);
	}

    cache_delete(get_accounts);
	return 1;
}

Bank_ShowLogs(playerid)
{
	new query[196], type = LogListType[playerid], Cache: bank_logs;
	mysql_format(Database, query, sizeof(query), "SELECT *, FROM_UNIXTIME(Date, '%%d/%%m/%%Y %%H:%%i:%%s') as ActionDate FROM bank_logs WHERE AccountID=%d && Type=%d ORDER BY Date DESC LIMIT %d, 15", CurrentAccountID[playerid], type, LogListPage[playerid] * 15);
	bank_logs = mysql_query(Database, query);

	new rows = cache_num_rows();
	if(rows) {
		new list[1512], title[96], name[MAX_PLAYER_NAME], date[24];
		switch(type)
		{
		    case TYPE_LOGIN:
			{
				format(list, sizeof(list), "Por\tData da ação\n");
				format(title, sizeof(title), "{F1C40F}Banco: {FFFFFF}Histórico de login (Pag %d)", LogListPage[playerid] + 1);
			}

			case TYPE_DEPOSIT:
			{
				format(list, sizeof(list), "Por\tQuantidade\tData do depósito\n");
				format(title, sizeof(title), "{F1C40F}Banco: {FFFFFF}Histórico de depósitos (Pag %d)", LogListPage[playerid] + 1);
			}

			case TYPE_WITHDRAW:
			{
				format(list, sizeof(list), "Por\tQuantidade\tData de saque\n");
				format(title, sizeof(title), "{F1C40F}Banco: {FFFFFF}Histórico de saques (Pag %d)", LogListPage[playerid] + 1);
			}

			case TYPE_TRANSFER:
			{
				format(list, sizeof(list), "Por\tPara\tQuantidade\tData de transferência\n");
				format(title, sizeof(title), "{F1C40F}Banco: {FFFFFF}Histórico de transferências (Pag %d)", LogListPage[playerid] + 1);
			}

			case TYPE_PASSCHANGE:
			{
				format(list, sizeof(list), "Por\tData da ação\n");
				format(title, sizeof(title), "{F1C40F}Banco: {FFFFFF}Trocas de senha (Pag %d)", LogListPage[playerid] + 1);
			}
		}

		new amount, to_acc_id;
	    for(new i; i < rows; ++i)
	    {
	        cache_get_value_name(i, "Player", name);
        	cache_get_value_name(i, "ActionDate", date);

            switch(type)
			{
			    case TYPE_LOGIN:
				{
					format(list, sizeof(list), "%s%s\t%s\n", list, name, date);
				}

				case TYPE_DEPOSIT:
				{
				    cache_get_value_name_int(i, "Amount", amount);
					format(list, sizeof(list), "%s%s\t{2ECC71}%s\t%s\n", list, name, formatInt(amount), date);
				}

				case TYPE_WITHDRAW:
				{
				    cache_get_value_name_int(i, "Amount", amount);
					format(list, sizeof(list), "%s%s\t{2ECC71}%s\t%s\n", list, name, formatInt(amount), date);
				}

				case TYPE_TRANSFER:
				{
				    cache_get_value_name_int(i, "ToAccountID", to_acc_id);
				    cache_get_value_name_int(i, "Amount", amount);
				    
					format(list, sizeof(list), "%s%s\t%d\t{2ECC71}%s\t%s\n", list, name, to_acc_id, formatInt(amount), date);
				}

				case TYPE_PASSCHANGE:
				{
					format(list, sizeof(list), "%s%s\t%s\n", list, name, date);
				}
			}
	    }

		ShowPlayerDialog(playerid, DIALOG_BANK_LOG_PAGE, DIALOG_STYLE_TABLIST_HEADERS, title, list, "Próximo", "Anterior");
	}else{
		SendErrorMessage(playerid, "Não foi possível achar nenhum registro.");
		Bank_ShowLogMenu(playerid);
	}

	cache_delete(bank_logs);
	return 1;
}

stock bank_OnGMInit()
{
    for(new i; i < MAX_BANKERS; i++)
    {
        BankerData[i][bankerActorID] = -1;
        BankerData[i][bankerLabel] = Text3D: -1;
    }

    for(new i; i < MAX_ATMS; i++)
    {
        ATMData[i][atmObjID] = -1;

        ATMData[i][atmLabel] = Text3D: -1;
    }

	// create tables if they don't exist
	mysql_tquery(Database, "CREATE TABLE IF NOT EXISTS `bankers` (\
	  `ID` int(11) NOT NULL,\
	  `Skin` smallint(3) NOT NULL,\
	  `PosX` float NOT NULL,\
	  `PosY` float NOT NULL,\
	  `PosZ` float NOT NULL,\
	  `PosA` float NOT NULL,\
	  `VW` int(11) NOT NULL, \
	  `Interior` int(11) NOT NULL \
	) ENGINE=InnoDB DEFAULT CHARSET=utf8;");

    mysql_tquery(Database, "CREATE TABLE IF NOT EXISTS `bank_atms` (\
	  `ID` int(11) NOT NULL,\
	  `PosX` float NOT NULL,\
	  `PosY` float NOT NULL,\
	  `PosZ` float NOT NULL,\
	  `RotX` float NOT NULL,\
	  `RotY` float NOT NULL,\
	  `RotZ` float NOT NULL\
	) ENGINE=InnoDB DEFAULT CHARSET=utf8;");

	mysql_tquery(Database, "CREATE TABLE IF NOT EXISTS `bank_accounts` (\
	  `ID` int(11) NOT NULL auto_increment,\
	  `Owner` varchar(24) NOT NULL,\
	  `Password` varchar(32) NOT NULL,\
	  `Balance` int(11) NOT NULL,\
	  `CreatedOn` int(11) NOT NULL,\
	  `LastAccess` int(11) NOT NULL,\
	  `Disabled` smallint(1) NOT NULL,\
	  PRIMARY KEY  (`ID`)\
	) ENGINE=InnoDB DEFAULT CHARSET=utf8;");

	new query[512];
	mysql_format(Database, query, sizeof(query), "CREATE TABLE IF NOT EXISTS `bank_logs` (\
	  	`ID` int(11) NOT NULL auto_increment,\
	  	`AccountID` int(11) NOT NULL,\
	  	`ToAccountID` int(11) NOT NULL default '-1',\
	  	`Type` smallint(1) NOT NULL,\
	  	`Player` varchar(24) NOT NULL,\
	  	`Amount` int(11) NOT NULL,\
	  	`Date` int(11) NOT NULL,");

	mysql_format(Database, query, sizeof(query), "%s\
 		PRIMARY KEY  (`ID`),\
 		KEY `bank_logs_ibfk_1` (`AccountID`),\
 		CONSTRAINT `bank_logs_ibfk_1` FOREIGN KEY (`AccountID`) REFERENCES `bank_accounts` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE\
		) ENGINE=InnoDB DEFAULT CHARSET=utf8;", query);

	mysql_tquery(Database, query);
	mysql_tquery(Database, "SELECT * FROM bankers", "LoadBankers");
	mysql_tquery(Database, "SELECT * FROM bank_atms", "LoadATMs");
	return 1;
}

stock bank_OnGMExit()
{
	foreach(new i : Bankers)
	{
	    if(IsValidActor(BankerData[i][bankerActorID])) DestroyActor(BankerData[i][bankerActorID]);
	}

    print("BANK SYSTEM: Unloaded.");
	mysql_close(Database);
	return 1;
}

stock bank_OnPlayerConnect(playerid)
{
	CurrentAccountID[playerid] = -1;
	LogListType[playerid] = TYPE_NONE;
	LogListPage[playerid] = 0;

	EditingATMID[playerid] = -1;
	return 1;
}

stock bank_OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch(dialogid)
	{
	    /* ---------------------------------------------------------------------- */
	    case DIALOG_BANK_MENU_NOLOGIN:
	    {
	        if(!response) return 1;
	        if(listitem == 0)
	        {
	            if(GetPVarInt(playerid, "usingATM"))
				{
				    SendErrorMessage(playerid, "Você não pode fazer isso em um ATM, procure um banco.");
					return Bank_ShowMenu(playerid);
				}

	            if(ACCOUNT_PRICE > GetPlayerMoney(playerid))
	            {
	                SendErrorMessage(playerid, "Você não possui dinheiro o suficiente para criar uma conta bancária.");
	                return Bank_ShowMenu(playerid);
	            }

				#if defined ACCOUNT_CLIMIT
				if(Bank_AccountCount(playerid) >= ACCOUNT_CLIMIT)
	            {
	                SendErrorMessage(playerid, "Você não pode criar mais contas no banco.");
	                return Bank_ShowMenu(playerid);
	            }
				#endif

				ShowPlayerDialog(playerid, DIALOG_BANK_CREATE_ACCOUNT, DIALOG_STYLE_INPUT, "{F1C40F}Banco: {FFFFFF}Criar conta", "Escolha uma senha para a sua nova conta bancária:", "Criar", "Voltar");
	        }

	        if(listitem == 1) Bank_ListAccounts(playerid);
	        if(listitem == 2) ShowPlayerDialog(playerid, DIALOG_BANK_LOGIN_ID, DIALOG_STYLE_INPUT, "{F1C40F}Banco: {FFFFFF}Entrar", "Conta ID:", "Continuar", "Cancelar");
	        return 1;
	    }
     	/* ---------------------------------------------------------------------- */
     	case DIALOG_BANK_MENU:
		{
		    if(!response) return 1;
		    if(listitem == 0)
	        {
	            if(GetPVarInt(playerid, "usingATM"))
				{
				    SendErrorMessage(playerid, "Você não pode fazer isso em um ATM, procure um banco.");
					return Bank_ShowMenu(playerid);
				}

	            if(ACCOUNT_PRICE > GetPlayerMoney(playerid))
	            {
	                SendErrorMessage(playerid, "Você não possui dinheiro o suficiente para criar uma conta bancária.");
	                return Bank_ShowMenu(playerid);
	            }

				#if defined ACCOUNT_CLIMIT
				if(Bank_AccountCount(playerid) >= ACCOUNT_CLIMIT)
	            {
	                SendErrorMessage(playerid, "Você não pode criar mais contas no banco.");
	                return Bank_ShowMenu(playerid);
	            }
				#endif

				ShowPlayerDialog(playerid, DIALOG_BANK_CREATE_ACCOUNT, DIALOG_STYLE_INPUT, "{F1C40F}Banco: {FFFFFF}Criar conta", "Escolha uma senha para a sua nova conta bancária:", "Criar", "Voltar");
	        }

	        if(listitem == 1) Bank_ListAccounts(playerid);
	        if(listitem == 2) ShowPlayerDialog(playerid, DIALOG_BANK_DEPOSIT, DIALOG_STYLE_INPUT, "{F1C40F}Banco: {FFFFFF}Depositar", "Quanto você deseja depositar?", "Depositar", "Voltar");
            if(listitem == 3) ShowPlayerDialog(playerid, DIALOG_BANK_WITHDRAW, DIALOG_STYLE_INPUT, "{F1C40F}Banco: {FFFFFF}Sacar", "Quanto você deseja sacar?", "Sacar", "Voltar");
			if(listitem == 4) ShowPlayerDialog(playerid, DIALOG_BANK_TRANSFER_1, DIALOG_STYLE_INPUT, "{F1C40F}Banco: {FFFFFF}Transferir", "Especifique o ID da conta:", "Continuar", "Voltar");
            if(listitem == 5)
			{
			    if(GetPVarInt(playerid, "usingATM"))
				{
				    SendErrorMessage(playerid, "Você não pode fazer isso em um ATM, procure um banco.");
					return Bank_ShowMenu(playerid);
				}

				Bank_ShowLogMenu(playerid);
			}

			if(listitem == 6)
			{
			    if(GetPVarInt(playerid, "usingATM"))
				{
				    SendErrorMessage(playerid, "Você não pode fazer isso em um ATM, procure um banco.");
					return Bank_ShowMenu(playerid);
				}

				if(strcmp(Bank_GetOwner(CurrentAccountID[playerid]), Player_GetName(playerid)))
				{
				    SendErrorMessage(playerid, "Apenas o dono da conta pode fazer isso.");
				    return Bank_ShowMenu(playerid);
				}

				ShowPlayerDialog(playerid, DIALOG_BANK_PASSWORD, DIALOG_STYLE_INPUT, "{F1C40F}Banco: {FFFFFF}Mudar senha", "Digite uma nova senha:", "Mudar", "Voltar");
			}

			if(listitem == 7)
			{
			    if(GetPVarInt(playerid, "usingATM"))
				{
				    SendErrorMessage(playerid, "Você não pode fazer isso em um ATM, procure um banco.");
					return Bank_ShowMenu(playerid);
				}

			    if(strcmp(Bank_GetOwner(CurrentAccountID[playerid]), Player_GetName(playerid)))
				{
				    SendErrorMessage(playerid, "Apenas o dono da conta pode fazer isso.");
				    return Bank_ShowMenu(playerid);
				}

				ShowPlayerDialog(playerid, DIALOG_BANK_REMOVE, DIALOG_STYLE_MSGBOX, "{F1C40F}Banco: {FFFFFF}Deletar conta", "Você possui certeza? Essa conta será deletada {E74C3C}permanentemente.", "Sim", "Voltar");
			}

			if(listitem == 8)
			{
			    SendClientMessage(playerid, 0x3498DBFF, "BANCO: {FFFFFF}Deslogado com sucesso.");

			    CurrentAccountID[playerid] = -1;
			    Bank_ShowMenu(playerid);
			}
		}
        /* ---------------------------------------------------------------------- */
	    case DIALOG_BANK_CREATE_ACCOUNT:
	    {
	        if(!response) return Bank_ShowMenu(playerid);
	        if(isnull(inputtext)) return ShowPlayerDialog(playerid, DIALOG_BANK_CREATE_ACCOUNT, DIALOG_STYLE_INPUT, "{F1C40F}Banco: {FFFFFF}Criar conta", "{E74C3C}Você não pode deixar a senha da conta vazia.\n\n{FFFFFF}Escolha uma senha para a sua nova conta bancária:", "Criar", "Voltar");
			if(strlen(inputtext) > 16) return ShowPlayerDialog(playerid, DIALOG_BANK_CREATE_ACCOUNT, DIALOG_STYLE_INPUT, "{F1C40F}Banco: {FFFFFF}Criar conta", "{E74C3C}A senha não pode ter mais que 16 caracteres.\n\n{FFFFFF}Escolha uma senha para a sua nova conta bancária:", "Criar", "Voltar");
			if(ACCOUNT_PRICE > GetPlayerMoney(playerid))
            {
                SendErrorMessage(playerid, "Você não possui dinheiro o suficiente para criar uma conta bancária.");
                return Bank_ShowMenu(playerid);
            }

			#if defined ACCOUNT_CLIMIT
			if(Bank_AccountCount(playerid) >= ACCOUNT_CLIMIT)
            {
                SendErrorMessage(playerid, "Você não pode criar mais contas no banco.");
                return Bank_ShowMenu(playerid);
            }
			#endif

			new query[144];
			mysql_format(Database, query, sizeof(query), "INSERT INTO bank_accounts SET Owner='%e', Password=md5('%e'), CreatedOn=UNIX_TIMESTAMP()", Player_GetName(playerid), inputtext);
			mysql_tquery(Database, query, "OnBankAccountCreated", "is", playerid, inputtext);
	        return 1;
	    }
	    /* ---------------------------------------------------------------------- */
	    case DIALOG_BANK_ACCOUNTS:
	    {
            if(!response) return Bank_ShowMenu(playerid);

            SetPVarInt(playerid, "bankLoginAccount", strval(inputtext));
			ShowPlayerDialog(playerid, DIALOG_BANK_LOGIN_PASS, DIALOG_STYLE_PASSWORD, "{F1C40F}Banco: {FFFFFF}Entrar", "Senha da conta:", "Logar", "Cancelar");
	        return 1;
	    }
	    /* ---------------------------------------------------------------------- */
	    case DIALOG_BANK_LOGIN_ID:
	    {
	        if(!response) return Bank_ShowMenu(playerid);
	        if(isnull(inputtext)) return ShowPlayerDialog(playerid, DIALOG_BANK_LOGIN_ID, DIALOG_STYLE_INPUT, "{F1C40F}Banco: {FFFFFF}Entrar", "{E74C3C}Você não pode deixar o ID vazio.\n\n{FFFFFF}Conta ID:", "Continuar", "Cancelar");

			SetPVarInt(playerid, "bankLoginAccount", strval(inputtext));
			ShowPlayerDialog(playerid, DIALOG_BANK_LOGIN_PASS, DIALOG_STYLE_PASSWORD, "{F1C40F}Banco: {FFFFFF}Entrar", "Senha da conta:", "Logar", "Cancelar");
			return 1;
	    }
	    /* ---------------------------------------------------------------------- */
	    case DIALOG_BANK_LOGIN_PASS:
	    {
	        if(!response) return Bank_ShowMenu(playerid);
	        if(isnull(inputtext)) return ShowPlayerDialog(playerid, DIALOG_BANK_LOGIN_PASS, DIALOG_STYLE_PASSWORD, "{F1C40F}Banco: {FFFFFF}Entrar", "{E74C3C}Você não pode deixar a senha vazia.\n\n{FFFFFF}Senha da conta:", "Logar", "Cancelar");

			new query[200], id = GetPVarInt(playerid, "bankLoginAccount");
			mysql_format(Database, query, sizeof(query), "SELECT Owner, LastAccess, FROM_UNIXTIME(LastAccess, '%%d/%%m/%%Y %%H:%%i:%%s') AS Last FROM bank_accounts WHERE ID=%d && Password=md5('%e') && Disabled=0 LIMIT 1", id, inputtext);
			mysql_tquery(Database, query, "OnBankAccountLogin", "ii", playerid, id);
			return 1;
	    }
	    /* ---------------------------------------------------------------------- */
	    case DIALOG_BANK_DEPOSIT:
	    {
			if(!response) return Bank_ShowMenu(playerid);
			if(CurrentAccountID[playerid] == -1) return 1;
     		if(isnull(inputtext)) return ShowPlayerDialog(playerid, DIALOG_BANK_DEPOSIT, DIALOG_STYLE_INPUT, "{F1C40F}Banco: {FFFFFF}Depositar", "{E74C3C}Você não pode deixar esse campo vazio.\n\n{FFFFFF}Quanto você deseja depositar?", "Depositar", "Voltar");
			new amount = strval(inputtext);
			if(!(1 <= amount <= (GetPVarInt(playerid, "usingATM") ? 5000000 : 250000000))) return ShowPlayerDialog(playerid, DIALOG_BANK_DEPOSIT, DIALOG_STYLE_INPUT, "{F1C40F}Banco: {FFFFFF}Depositar", "{E74C3C}Você não pode depositar menos que $1 ou mais que $250.000.000 por vez. ($5.000.000 nos ATMs)\n\n{FFFFFF}Quanto você deseja depositar?", "Depositar", "Voltar");
			if(amount > GetPlayerMoney(playerid)) return ShowPlayerDialog(playerid, DIALOG_BANK_DEPOSIT, DIALOG_STYLE_INPUT, "{F1C40F}Banco: {FFFFFF}Depositar", "{E74C3C}Você não possui todo esse dinheiro.\n\n{FFFFFF}Quanto você deseja depositar?", "Depositar", "Voltar");
			if((amount + Bank_GetBalance(CurrentAccountID[playerid])) > ACCOUNT_LIMIT)
			{
   				SendErrorMessage(playerid, "Você não pode depositar mais dinheiro nessa conta.");
			    return Bank_ShowMenu(playerid);
			}

			new query[96];
			mysql_format(Database, query, sizeof(query), "UPDATE bank_accounts SET Balance=Balance+%d WHERE ID=%d && Disabled=0", amount, CurrentAccountID[playerid]);
			mysql_tquery(Database, query, "OnBankAccountDeposit", "ii", playerid, amount);
			return 1;
		}
        /* ---------------------------------------------------------------------- */
        case DIALOG_BANK_WITHDRAW:
	    {
			if(!response) return Bank_ShowMenu(playerid);
			if(CurrentAccountID[playerid] == -1) return 1;
     		if(isnull(inputtext)) return ShowPlayerDialog(playerid, DIALOG_BANK_WITHDRAW, DIALOG_STYLE_INPUT, "{F1C40F}Banco: {FFFFFF}Sacar", "{E74C3C}Você não pode deixar esse campo vazio.\n\n{FFFFFF}Quanto você deseja sacar?", "Sacar", "Voltar");
			new amount = strval(inputtext);
			if(!(1 <= amount <= (GetPVarInt(playerid, "usingATM") ? 5000000 : 250000000))) return ShowPlayerDialog(playerid, DIALOG_BANK_WITHDRAW, DIALOG_STYLE_INPUT, "{F1C40F}Banco: {FFFFFF}Sacar", "{E74C3C}Você não pode sacar menos que $1 ou mais que $250.000.000 por vez. ($5.000.000 nos ATMs)\n\n{FFFFFF}Quanto você deseja sacar?", "Sacar", "Voltar");
			if(amount > Bank_GetBalance(CurrentAccountID[playerid])) return ShowPlayerDialog(playerid, DIALOG_BANK_WITHDRAW, DIALOG_STYLE_INPUT, "{F1C40F}Banco: {FFFFFF}Sacar", "{E74C3C}A conta não possui todo esse dinheiro.\n\n{FFFFFF}Quanto você deseja sacar?", "Sacar", "Voltar");

			new query[96];
			mysql_format(Database, query, sizeof(query), "UPDATE bank_accounts SET Balance=Balance-%d WHERE ID=%d && Disabled=0", amount, CurrentAccountID[playerid]);
			mysql_tquery(Database, query, "OnBankAccountWithdraw", "ii", playerid, amount);
			return 1;
		}
        /* ---------------------------------------------------------------------- */
        case DIALOG_BANK_TRANSFER_1:
	    {
			if(!response) return Bank_ShowMenu(playerid);
			if(CurrentAccountID[playerid] == -1) return 1;
     		if(isnull(inputtext)) return ShowPlayerDialog(playerid, DIALOG_BANK_TRANSFER_1, DIALOG_STYLE_INPUT, "{F1C40F}Banco: {FFFFFF}Transferir", "{E74C3C}Você não pode deixar esse campo vazio.\n\n{FFFFFF}Especifique o ID da conta:", "Continuar", "Voltar");
            if(strval(inputtext) == CurrentAccountID[playerid]) return ShowPlayerDialog(playerid, DIALOG_BANK_TRANSFER_1, DIALOG_STYLE_INPUT, "{F1C40F}Banco: {FFFFFF}Transferir", "{E74C3C}Você não pode transferir dinheiro para essa conta.\n\n{FFFFFF}Especifique o ID da conta:", "Continuar", "Voltar");
            SetPVarInt(playerid, "bankTransferAccount", strval(inputtext));
            ShowPlayerDialog(playerid, DIALOG_BANK_TRANSFER_2, DIALOG_STYLE_INPUT, "{F1C40F}Banco: {FFFFFF}Transferir", "Especifique a quantidade:", "Transferir", "Voltar");
            return 1;
		}
        /* ---------------------------------------------------------------------- */
        case DIALOG_BANK_TRANSFER_2:
        {
            if(!response) return ShowPlayerDialog(playerid, DIALOG_BANK_TRANSFER_1, DIALOG_STYLE_INPUT, "{F1C40F}Banco: {FFFFFF}Transferir", "Especifique o ID da conta:", "Continuar", "Voltar");
            if(CurrentAccountID[playerid] == -1) return 1;
			if(isnull(inputtext)) return ShowPlayerDialog(playerid, DIALOG_BANK_TRANSFER_2, DIALOG_STYLE_INPUT, "{F1C40F}Banco: {FFFFFF}Transferir", "{E74C3C}Você não pode deixar esse campo vazio.\n\n{FFFFFF}Especifique a quantidade:", "Transferir", "Voltar");
            new amount = strval(inputtext);
			if(!(1 <= amount <= (GetPVarInt(playerid, "usingATM") ? 5000000 : 250000000))) return ShowPlayerDialog(playerid, DIALOG_BANK_TRANSFER_2, DIALOG_STYLE_INPUT, "{F1C40F}Banco: {FFFFFF}Transferir", "{E74C3C}Você não pode transferir menos que $1 ou mais que $250.000.000 por vez. ($5.000.000 nos ATMs)\n\n{FFFFFF}Especifique a quantidade:", "Transferir", "Voltar");
            if(amount > Bank_GetBalance(CurrentAccountID[playerid])) return ShowPlayerDialog(playerid, DIALOG_BANK_TRANSFER_2, DIALOG_STYLE_INPUT, "{F1C40F}Banco: {FFFFFF}Transferir", "{E74C3C}A conta não possui todo esse dinheiro.\n\n{FFFFFF}Especifique a quantidade:", "Transferir", "Voltar");
			new id = GetPVarInt(playerid, "bankTransferAccount");
			if((amount + Bank_GetBalance(id)) > ACCOUNT_LIMIT)
			{
				SendErrorMessage(playerid, "Você não pode transferir nenhum dinheiro para a conta selecionada.");
				return Bank_ShowMenu(playerid);
			}

			new query[96];
			mysql_format(Database, query, sizeof(query), "UPDATE bank_accounts SET Balance=Balance+%d WHERE ID=%d && Disabled=0", amount, id);
			mysql_tquery(Database, query, "OnBankAccountTransfer", "iii", playerid, id, amount);
            return 1;
        }
        /* ---------------------------------------------------------------------- */
        case DIALOG_BANK_PASSWORD:
        {
        	if(!response) return Bank_ShowMenu(playerid);
        	if(CurrentAccountID[playerid] == -1) return 1;
	        if(isnull(inputtext)) return ShowPlayerDialog(playerid, DIALOG_BANK_PASSWORD, DIALOG_STYLE_INPUT, "{F1C40F}Banco: {FFFFFF}Mudar senha", "{E74C3C}Você não pode deixar esse campo vazio.\n\n{FFFFFF}Digite uma nova senha:", "Mudar", "Voltar");
			if(strlen(inputtext) > 16) return ShowPlayerDialog(playerid, DIALOG_BANK_PASSWORD, DIALOG_STYLE_INPUT, "{F1C40F}Banco: {FFFFFF}Mudar senha", "{E74C3C}A nova senha não pode ser maior que 16 caracteres.\n\n{FFFFFF}Digite uma nova senha:", "Mudar", "Voltar");

			new query[128];
			mysql_format(Database, query, sizeof(query), "UPDATE bank_accounts SET Password=md5('%e') WHERE ID=%d && Disabled=0", inputtext, CurrentAccountID[playerid]);
			mysql_tquery(Database, query, "OnBankAccountPassChange", "is", playerid, inputtext);
	        return 1;
	    }
        /* ---------------------------------------------------------------------- */
        case DIALOG_BANK_REMOVE:
        {
            if(!response) return Bank_ShowMenu(playerid);
            if(CurrentAccountID[playerid] == -1) return 1;

            new query[96], amount = Bank_GetBalance(CurrentAccountID[playerid]);
			mysql_format(Database, query, sizeof(query), "UPDATE bank_accounts SET Disabled=1 WHERE ID=%d", CurrentAccountID[playerid]);
			mysql_tquery(Database, query, "OnBankAccountDeleted", "iii", playerid, CurrentAccountID[playerid], amount);
            return 1;
        }
        /* ---------------------------------------------------------------------- */
        case DIALOG_BANK_LOGS:
        {
            if(!response) return Bank_ShowMenu(playerid);
            if(CurrentAccountID[playerid] == -1) return 1;

            new typelist[6] = {TYPE_NONE, TYPE_DEPOSIT, TYPE_WITHDRAW, TYPE_TRANSFER, TYPE_LOGIN, TYPE_PASSCHANGE};
            LogListType[playerid] = typelist[listitem + 1];
            LogListPage[playerid] = 0;
            Bank_ShowLogs(playerid);
            return 1;
   		}
        /* ---------------------------------------------------------------------- */
        case DIALOG_BANK_LOG_PAGE:
		{
		    if(CurrentAccountID[playerid] == -1 || LogListType[playerid] == TYPE_NONE) return 1;
			if(!response) {
			    LogListPage[playerid]--;
			    if(LogListPage[playerid] < 0) return Bank_ShowLogMenu(playerid);
			}else{
			    LogListPage[playerid]++;
			}

			Bank_ShowLogs(playerid);
		    return 1;
		}
        /* ---------------------------------------------------------------------- */
	}

	return 0;
}

stock bank_OnPlayerEditDynamicObject(playerid, STREAMER_TAG_OBJECT objectid, response, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz)
{
	if(Iter_Contains(ATMs, EditingATMID[playerid]))
	{
	    if(response == EDIT_RESPONSE_FINAL)
	    {
	        new id = EditingATMID[playerid];
	        ATMData[id][atmX] = x;
	        ATMData[id][atmY] = y;
	        ATMData[id][atmZ] = z;
	        ATMData[id][atmRX] = rx;
	        ATMData[id][atmRY] = ry;
	        ATMData[id][atmRZ] = rz;

	        SetDynamicObjectPos(objectid, ATMData[id][atmX], ATMData[id][atmY], ATMData[id][atmZ]);
	        SetDynamicObjectRot(objectid, ATMData[id][atmRX], ATMData[id][atmRY], ATMData[id][atmRZ]);

			Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, ATMData[id][atmLabel], E_STREAMER_X, ATMData[id][atmX]);
			Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, ATMData[id][atmLabel], E_STREAMER_Y, ATMData[id][atmY]);
			Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, ATMData[id][atmLabel], E_STREAMER_Z, ATMData[id][atmZ] + 0.85);

			new query[144];
			mysql_format(Database, query, sizeof(query), "UPDATE bank_atms SET PosX='%f', PosY='%f', PosZ='%f', RotX='%f', RotY='%f', RotZ='%f' WHERE ID=%d", x, y, z, rx, ry, rz, id);
			mysql_tquery(Database, query);

	        EditingATMID[playerid] = -1;
	    }

	    if(response == EDIT_RESPONSE_CANCEL)
	    {
	        new id = EditingATMID[playerid];
	        SetDynamicObjectPos(objectid, ATMData[id][atmX], ATMData[id][atmY], ATMData[id][atmZ]);
	        SetDynamicObjectRot(objectid, ATMData[id][atmRX], ATMData[id][atmRY], ATMData[id][atmRZ]);
	        EditingATMID[playerid] = -1;
	    }
	}

	return 1;
}

forward LoadBankers();
public LoadBankers()
{
	new rows = cache_num_rows();
	if(rows)
	{
	    new id, label_string[64];
	    for(new i; i < rows; i++)
		{
		    cache_get_value_name_int(i, "ID", id);
		    cache_get_value_name_int(i, "Skin", BankerData[id][Skin]);
		    cache_get_value_name_float(i, "PosX", BankerData[id][bankerX]);
		    cache_get_value_name_float(i, "PosY", BankerData[id][bankerY]);
		    cache_get_value_name_float(i, "PosZ", BankerData[id][bankerZ]);
		    cache_get_value_name_float(i, "PosA", BankerData[id][bankerA]);
			cache_get_value_name_int(i, "VW", BankerData[id][bankerVW]);
			cache_get_value_name_int(i, "Interior", BankerData[id][bankerI]);

		    BankerData[id][bankerActorID] = CreateActor(BankerData[id][Skin], BankerData[id][bankerX], BankerData[id][bankerY], BankerData[id][bankerZ], BankerData[id][bankerA]);
		   	SetActorVirtualWorld(BankerData[id][bankerActorID], BankerData[id][bankerVW]);
		    if(!IsValidActor(BankerData[id][bankerActorID])) {
				printf("BANK SYSTEM: Não foi possível criar o banco ID %d.", id);
			}else{
			    SetActorInvulnerable(BankerData[id][bankerActorID], true);
			}

			format(label_string, sizeof(label_string), "Banco (%d)\n\n{FFFFFF}/banco", id);
			BankerData[id][bankerLabel] = CreateDynamic3DTextLabel(label_string, -1, BankerData[id][bankerX], BankerData[id][bankerY], BankerData[id][bankerZ] + 0.25, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, BankerData[id][bankerVW], BankerData[id][bankerI], -1, 100.0);
			Iter_Add(Bankers, id);
		}
	}

	printf("BANK SYSTEM: %d banqueiros foram carregados.", Iter_Count(Bankers));
	return 1;
}

forward LoadATMs();
public LoadATMs()
{
	new rows = cache_num_rows();
	if(rows)
	{
	    new id, label_string[64];
	    
	    for(new i; i < rows; i++)
		{
		    cache_get_value_name_int(i, "ID", id);
	     	cache_get_value_name_float(i, "PosX", ATMData[id][atmX]);
	     	cache_get_value_name_float(i, "PosY", ATMData[id][atmY]);
	     	cache_get_value_name_float(i, "PosZ", ATMData[id][atmZ]);
	     	cache_get_value_name_float(i, "RotX", ATMData[id][atmRX]);
	     	cache_get_value_name_float(i, "RotY", ATMData[id][atmRY]);
	     	cache_get_value_name_float(i, "RotZ", ATMData[id][atmRZ]);

		    ATMData[id][atmObjID] = CreateDynamicObject(19324, ATMData[id][atmX], ATMData[id][atmY], ATMData[id][atmZ], ATMData[id][atmRX], ATMData[id][atmRY], ATMData[id][atmRZ]);
			
			format(label_string, sizeof(label_string), "ATM (%d)\n\n{FFFFFF}/atm", id);
			ATMData[id][atmLabel] = CreateDynamic3DTextLabel(label_string, -1, ATMData[id][atmX], ATMData[id][atmY], ATMData[id][atmZ] + 0.85, 5.0, .testlos = 1);

			Iter_Add(ATMs, id);
		}
	}

    printf("BANK SYSTEM: %d ATMs foram carregados.", Iter_Count(ATMs));
	return 1;
}

forward OnBankAccountCreated(playerid, pass[]);
public OnBankAccountCreated(playerid, pass[])
{
	GiveMoney(playerid, -ACCOUNT_PRICE);

	new id = cache_insert_id(), string[64];
	SendClientMessage(playerid, 0x3498DBFF, "BANCO: {FFFFFF}Você criou uma nova conta com sucesso!");

	format(string, sizeof(string), "BANCO: {FFFFFF}ID da conta: {F1C40F}%d", id);
	SendClientMessage(playerid, 0x3498DBFF, string);

	format(string, sizeof(string), "BANCO: {FFFFFF}Senha da conta: {F1C40F}%s", pass);
	SendClientMessage(playerid, 0x3498DBFF, string);
	return 1;
}

forward OnBankAccountLogin(playerid, id);
public OnBankAccountLogin(playerid, id)
{
	if(cache_num_rows() > 0) {
	    new string[128], owner[MAX_PLAYER_NAME], last_access, ldate[24];
	    cache_get_value_name(0, "Owner", owner);
	    cache_get_value_name_int(0, "LastAccess", last_access);
	    cache_get_value_name(0, "Last", ldate);

	    format(string, sizeof(string), "BANCO: {FFFFFF}Esta conta pertence a: {F1C40F}%s.", owner);
	    SendClientMessage(playerid, 0x3498DBFF, string);
	    format(string, sizeof(string), "BANCO: {FFFFFF}Último acesso em: {F1C40F}%s", (last_access == 0) ? ("Nunca") : ldate);
	    SendClientMessage(playerid, 0x3498DBFF, string);

	    CurrentAccountID[playerid] = id;
	    Bank_ShowMenu(playerid);

	    new query[96];
	    mysql_format(Database, query, sizeof(query), "UPDATE bank_accounts SET LastAccess=UNIX_TIMESTAMP() WHERE ID=%d && Disabled=0", id);
	    mysql_tquery(Database, query);

	    Bank_SaveLog(playerid, TYPE_LOGIN, id, -1, 0);
	}else{
	    SendErrorMessage(playerid, "Credenciais inválidas.");
	    Bank_ShowMenu(playerid);
	}

	return 1;
}

forward OnBankAccountDeposit(playerid, amount);
public OnBankAccountDeposit(playerid, amount)
{
	if(cache_affected_rows() > 0) {
	    new string[64];
	    format(string, sizeof(string), "BANCO: {FFFFFF}Deposito realizado com sucesso! Valor: {2ECC71}%s.", formatInt(amount));
		SendClientMessage(playerid, 0x3498DBFF, string);

	    GiveMoney(playerid, -amount);
	    Bank_SaveLog(playerid, TYPE_DEPOSIT, CurrentAccountID[playerid], -1, amount);
	}else{
	    SendErrorMessage(playerid, "Ocorreu um erro durante a transação.");
	}

	Bank_ShowMenu(playerid);
	return 1;
}

forward OnBankAccountWithdraw(playerid, amount);
public OnBankAccountWithdraw(playerid, amount)
{
	if(cache_affected_rows() > 0) {
	    new string[64];
	    format(string, sizeof(string), "BANCO: {FFFFFF}Saque realizado com sucesso! Valor: {2ECC71}%s.", formatInt(amount));
		SendClientMessage(playerid, 0x3498DBFF, string);

	    GiveMoney(playerid, amount);
	    Bank_SaveLog(playerid, TYPE_WITHDRAW, CurrentAccountID[playerid], -1, amount);
	}else{
	    SendErrorMessage(playerid, "Ocorreu um erro durante a transação.");
	}

    Bank_ShowMenu(playerid);
	return 1;
}

forward OnBankAccountTransfer(playerid, id, amount);
public OnBankAccountTransfer(playerid, id, amount)
{
	if(cache_affected_rows() > 0) {
		new query[144];
		mysql_format(Database, query, sizeof(query), "UPDATE bank_accounts SET Balance=Balance-%d WHERE ID=%d && Disabled=0", amount, CurrentAccountID[playerid]);
		mysql_tquery(Database, query, "OnBankAccountTransferDone", "iii", playerid, id, amount);
	}else{
	    SendErrorMessage(playerid, "Ocorreu um erro durante a transação.");
	    Bank_ShowMenu(playerid);
	}

	return 1;
}

forward OnBankAccountTransferDone(playerid, id, amount);
public OnBankAccountTransferDone(playerid, id, amount)
{
	if(cache_affected_rows() > 0) {
	    new string[128];
	    format(string, sizeof(string), "BANCO: {FFFFFF}Transferência realizada com sucesso! Valor: {2ECC71}%s {FFFFFF}para a conta ID {F1C40F}%d.", formatInt(amount), id);
		SendClientMessage(playerid, 0x3498DBFF, string);

		Bank_SaveLog(playerid, TYPE_TRANSFER, CurrentAccountID[playerid], id, amount);
	}else{
	    SendErrorMessage(playerid, "Ocorreu um erro durante a transação.");

	}

    Bank_ShowMenu(playerid);
	return 1;
}

forward OnBankAccountPassChange(playerid, newpass[]);
public OnBankAccountPassChange(playerid, newpass[])
{
	if(cache_affected_rows() > 0) {
	    new string[128];
	    format(string, sizeof(string), "BANCO: {FFFFFF}Senha da conta alterada para {F1C40F}%s.", newpass);
		SendClientMessage(playerid, 0x3498DBFF, string);

        Bank_SaveLog(playerid, TYPE_PASSCHANGE, CurrentAccountID[playerid], -1, 0);
	}else{
	    SendErrorMessage(playerid, "A troca de senha falhou.");
	}

    Bank_ShowMenu(playerid);
	return 1;
}

forward OnBankAccountDeleted(playerid, id, amount);
public OnBankAccountDeleted(playerid, id, amount)
{
    if(cache_affected_rows() > 0) {
        GiveMoney(playerid, amount);

        foreach(new i : Player)
        {
            if(i == playerid) continue;
            if(CurrentAccountID[i] == id) CurrentAccountID[i] = -1;
        }

	    new string[128];
	    format(string, sizeof(string), "BANCO: {FFFFFF}Conta removida com sucesso, você retirou {2ECC71}%s {FFFFFF}da conta.", formatInt(amount));
		SendClientMessage(playerid, 0x3498DBFF, string);
	}else{
	    SendErrorMessage(playerid, "Ocorreu um erro ao remover a conta.");
	}

	CurrentAccountID[playerid] = -1;
    Bank_ShowMenu(playerid);
	return 1;
}

forward OnBankAccountAdminEdit(playerid);
public OnBankAccountAdminEdit(playerid)
{
    if(cache_affected_rows() > 0) {
        SendClientMessage(playerid, 0x3498DBFF, "BANCO: {FFFFFF}Conta editada.");
	}else{
	    SendErrorMessage(playerid, "A edição de conta falhou.");
	}

	return 1;
}

CMD:pegarpaycheck(playerid, params[])
{
	if(!IsPlayerNearBanker(playerid)) return SendErrorMessage(playerid, "Você não esta perto de um banco.");
	if(PlayerInfo[playerid][pPaycheck] < 1)
	{ 
		SendErrorMessage(playerid, "Você não possui nenhum pagamento para receber.");
	}
	else
	{
		GiveMoney(playerid, PlayerInfo[playerid][pPaycheck]);
		SendClientMessageEx(playerid, -1, "BANCO: Você sacou %s de seu pagamento.", formatInt(PlayerInfo[playerid][pPaycheck]));
		PlayerInfo[playerid][pPaycheck] = 0;
	}
	return 1;
}

CMD:banco(playerid, params[])
{
	if(!IsPlayerNearBanker(playerid)) return SendErrorMessage(playerid, "Você não esta perto de um banco.");
	SetPVarInt(playerid, "usingATM", 0);
	Bank_ShowMenu(playerid);
	return 1;
}

CMD:atm(playerid, params[])
{
	new id = GetClosestATM(playerid);
    if(id == -1) return SendErrorMessage(playerid, "Você não está perto de um ATM.");
    SetPVarInt(playerid, "usingATM", 1);
	Bank_ShowMenu(playerid);
	return 1;
}

// Admin Commands
CMD:bancomudardono(playerid, params[])
{
    if (PlayerInfo[playerid][pPropertyMod] < 1)
		return SendErrorMessage(playerid, "Você não possui autorização para utilizar esse comando.");
    if(PlayerInfo[playerid][user_admin] < 4) 
        return SendErrorMessage(playerid, "Você não possui autorização para utilizar esse comando.");
    new id, owner[MAX_PLAYER_NAME];
    if(sscanf(params, "is[24]", id, owner)) return SendSyntaxMessage(playerid, "/bancomudardono [id da conta] [novo dono]");
    new query[128];
    mysql_format(Database, query, sizeof(query), "UPDATE bank_accounts SET Owner='%e' WHERE ID=%d", owner, id);
    mysql_tquery(Database, query, "OnBankAccountAdminEdit", "i", playerid);
	return 1;
}

CMD:bancomudarsenha(playerid, params[])
{
    if (PlayerInfo[playerid][pPropertyMod] < 1)
		return SendErrorMessage(playerid, "Você não possui autorização para utilizar esse comando.");
    if(PlayerInfo[playerid][user_admin] < 4) 
        return SendErrorMessage(playerid, "Você não possui autorização para utilizar esse comando.");
    new id, password[16];
    if(sscanf(params, "is[16]", id, password)) return SendSyntaxMessage(playerid, "/bancomudarsenha [id da conta] [nova senha]");
    new query[128];
    mysql_format(Database, query, sizeof(query), "UPDATE bank_accounts SET Password=md5('%e') WHERE ID=%d", password, id);
    mysql_tquery(Database, query, "OnBankAccountAdminEdit", "i", playerid);
	return 1;
}

CMD:bancosetarsaldo(playerid, params[])
{
    if (PlayerInfo[playerid][pPropertyMod] < 1)
		return SendErrorMessage(playerid, "Você não possui autorização para utilizar esse comando.");
    if(PlayerInfo[playerid][user_admin] < 4) 
        return SendErrorMessage(playerid, "Você não possui autorização para utilizar esse comando.");
    new id, balance;
    if(sscanf(params, "ii", id, balance)) return SendSyntaxMessage(playerid, "/bancosetarsaldo [id da conta] [saldo]");
    if(balance > ACCOUNT_LIMIT) return SendErrorMessage(playerid, "O saldo específicado passa do valor limite da conta.");
    new query[128];
    mysql_format(Database, query, sizeof(query), "UPDATE bank_accounts SET Balance=%d WHERE ID=%d", balance, id);
    mysql_tquery(Database, query, "OnBankAccountAdminEdit", "i", playerid);
	return 1;
}

CMD:bancolimparlogs(playerid, params[])
{
    if (PlayerInfo[playerid][pPropertyMod] < 1)
		return SendErrorMessage(playerid, "Você não possui autorização para utilizar esse comando.");
    if(PlayerInfo[playerid][user_admin] < 4) 
        return SendErrorMessage(playerid, "Você não possui autorização para utilizar esse comando.");
    new id, type;
    if(sscanf(params, "iI(0)", id, type))
	{
	    SendSyntaxMessage(playerid, "/bancolimparlogs [id da conta] [syntax (opcional)]");
	    SendClientMessage(playerid, -1, "SYNTAXES: 0- Todos | 1- Logins | 2- Depósitos | 3- Saques | 4- Transferências | 5- Troca de senhas");
		return 1;
	}

	new query[128];
	if(type > 0) {
	    mysql_format(Database, query, sizeof(query), "DELETE FROM bank_logs WHERE AccountID=%d && Type=%d", id, type);
	}else{
	    mysql_format(Database, query, sizeof(query), "DELETE FROM bank_logs WHERE AccountID=%d", id);
	}

    mysql_tquery(Database, query, "OnBankAccountAdminEdit", "i", playerid);
	return 1;
}

CMD:bancoremoverconta(playerid, params[])
{
    if (PlayerInfo[playerid][pPropertyMod] < 1)
		return SendErrorMessage(playerid, "Você não possui autorização para utilizar esse comando.");
    if(PlayerInfo[playerid][user_admin] < 4) 
        return SendErrorMessage(playerid, "Você não possui autorização para utilizar esse comando.");
    new id;
    if(sscanf(params, "i", id)) return SendSyntaxMessage(playerid, "/bancoremoverconta [id da conta]");
    foreach(new i : Player)
    {
        if(CurrentAccountID[i] == id) CurrentAccountID[i] = -1;
    }

    new query[128];
    mysql_format(Database, query, sizeof(query), "UPDATE bank_accounts SET Disabled=1 WHERE ID=%d", id);
    mysql_tquery(Database, query, "OnBankAccountAdminEdit", "i", playerid);
	return 1;
}

CMD:bancoreativarconta(playerid, params[])
{
    if (PlayerInfo[playerid][pPropertyMod] < 1)
		return SendErrorMessage(playerid, "Você não possui autorização para utilizar esse comando.");
    if(PlayerInfo[playerid][user_admin] < 4) 
        return SendErrorMessage(playerid, "Você não possui autorização para utilizar esse comando.");
    new id;
    if(sscanf(params, "i", id)) return SendSyntaxMessage(playerid, "/bancoreativarconta [id da conta]");
    new query[128];
    mysql_format(Database, query, sizeof(query), "UPDATE bank_accounts SET Disabled=0 WHERE ID=%d", id);
    mysql_tquery(Database, query, "OnBankAccountAdminEdit", "i", playerid);
	return 1;
}

// Admin Commands for Bankers
CMD:criarbanco(playerid, params[])
{
	if (PlayerInfo[playerid][pPropertyMod] < 1)
		return SendErrorMessage(playerid, "Você não possui autorização para utilizar esse comando.");
    if(PlayerInfo[playerid][user_admin] < 3) 
        return SendErrorMessage(playerid, "Você não possui autorização para utilizar esse comando.");
	new id = Iter_Free(Bankers);
	if(id == -1) return SendErrorMessage(playerid, "Não é possível criar mais bancos");
	new skin;
	if(sscanf(params, "i", skin)) return SendSyntaxMessage(playerid, "/criarbanco [id da skin]");
	BankerData[id][Skin] = skin;
	GetPlayerPos(playerid, BankerData[id][bankerX], BankerData[id][bankerY], BankerData[id][bankerZ]);
	GetPlayerFacingAngle(playerid, BankerData[id][bankerA]);
	BankerData[id][bankerVW] = GetPlayerVirtualWorld(playerid);
	BankerData[id][bankerI] = GetPlayerInterior(playerid);
	SetPlayerPos(playerid, BankerData[id][bankerX] + (1.0 * floatsin(-BankerData[id][bankerA], degrees)), BankerData[id][bankerY] + (1.0 * floatcos(-BankerData[id][bankerA], degrees)), BankerData[id][bankerZ]);

	BankerData[id][bankerActorID] = CreateActor(skin, BankerData[id][bankerX], BankerData[id][bankerY], BankerData[id][bankerZ], BankerData[id][bankerA]);
	SetActorVirtualWorld(BankerData[id][bankerActorID], BankerData[id][bankerVW]);
	if(IsValidActor(BankerData[id][bankerActorID])) SetActorInvulnerable(BankerData[id][bankerActorID], true);

	new label_string[64];
	format(label_string, sizeof(label_string), "Banco (%d)\n\n/banco", id);
	BankerData[id][bankerLabel] = CreateDynamic3DTextLabel(label_string, -1, BankerData[id][bankerX], BankerData[id][bankerY], BankerData[id][bankerZ] + 0.25, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, BankerData[id][bankerVW], BankerData[id][bankerI], -1, 100.0);

	new query[144];
	mysql_format(Database, query, sizeof(query), "INSERT INTO bankers SET ID=%d, Skin=%d, PosX='%f', PosY='%f', PosZ='%f', PosA='%f', VW='%d', Interior= '%d'", id, skin, BankerData[id][bankerX], BankerData[id][bankerY], BankerData[id][bankerZ], BankerData[id][bankerA], BankerData[id][bankerVW], BankerData[id][bankerI]);
	mysql_tquery(Database, query);

	Iter_Add(Bankers, id);
	return 1;
}

CMD:setarbancopos(playerid, params[])
{
    if (PlayerInfo[playerid][pPropertyMod] < 1)
		return SendErrorMessage(playerid, "Você não possui autorização para utilizar esse comando.");
    if(PlayerInfo[playerid][user_admin] < 3) 
        return SendErrorMessage(playerid, "Você não possui autorização para utilizar esse comando.");
	new id;
	if(sscanf(params, "i", id)) return SendSyntaxMessage(playerid, "/setarbancopos [id do banco]");
	if(!Iter_Contains(Bankers, id)) return SendErrorMessage(playerid, "Você digitou um ID inválido.");
	GetPlayerPos(playerid, BankerData[id][bankerX], BankerData[id][bankerY], BankerData[id][bankerZ]);
	GetPlayerFacingAngle(playerid, BankerData[id][bankerA]);
	BankerData[id][bankerVW] = GetPlayerVirtualWorld(playerid);
	BankerData[id][bankerI] = GetPlayerInterior(playerid);

	DestroyActor(BankerData[id][bankerActorID]);
	BankerData[id][bankerActorID] = CreateActor(BankerData[id][Skin], BankerData[id][bankerX], BankerData[id][bankerY], BankerData[id][bankerZ], BankerData[id][bankerA]);
	SetActorVirtualWorld(BankerData[id][bankerActorID], BankerData[id][bankerVW]);
	if(IsValidActor(BankerData[id][bankerActorID])) SetActorInvulnerable(BankerData[id][bankerActorID], true);

	Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, BankerData[id][bankerLabel], E_STREAMER_X, BankerData[id][bankerX]);
	Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, BankerData[id][bankerLabel], E_STREAMER_Y, BankerData[id][bankerY]);
	Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, BankerData[id][bankerLabel], E_STREAMER_Z, BankerData[id][bankerZ]);

	SetPlayerPos(playerid, BankerData[id][bankerX] + (1.0 * floatsin(-BankerData[id][bankerA], degrees)), BankerData[id][bankerY] + (1.0 * floatcos(-BankerData[id][bankerA], degrees)), BankerData[id][bankerZ]);

	new query[144];
	mysql_format(Database, query, sizeof(query), "UPDATE bankers SET PosX='%f', PosY='%f', PosZ='%f', PosA='%f', VW='%d', Interior='%d' WHERE ID=%d", BankerData[id][bankerX], BankerData[id][bankerY], BankerData[id][bankerZ], BankerData[id][bankerA], BankerData[id][bankerVW], BankerData[id][bankerI], id);
	mysql_tquery(Database, query);
	return 1;
}

CMD:setarbancoskin(playerid, params[])
{
    if (PlayerInfo[playerid][pPropertyMod] < 1)
		return SendErrorMessage(playerid, "Você não possui autorização para utilizar esse comando.");
    if(PlayerInfo[playerid][user_admin] < 4) 
        return SendErrorMessage(playerid, "Você não possui autorização para utilizar esse comando.");
	new id, skin;
	if(sscanf(params, "ii", id, skin)) return SendSyntaxMessage(playerid, "/setbankerskin [banker id] [skin id]");
	if(!Iter_Contains(Bankers, id)) return SendErrorMessage(playerid, "Você digitou um ID inválido.");

	BankerData[id][Skin] = skin;

	if(IsValidActor(BankerData[id][bankerActorID])) DestroyActor(BankerData[id][bankerActorID]);
	BankerData[id][bankerActorID] = CreateActor(BankerData[id][Skin], BankerData[id][bankerX], BankerData[id][bankerY], BankerData[id][bankerZ], BankerData[id][bankerA]);
	SetActorVirtualWorld(BankerData[id][bankerActorID], BankerData[id][bankerVW]);
	if(IsValidActor(BankerData[id][bankerActorID])) SetActorInvulnerable(BankerData[id][bankerActorID], true);

	new query[48];
	mysql_format(Database, query, sizeof(query), "UPDATE bankers SET Skin=%d WHERE ID=%d", BankerData[id][Skin], id);
	mysql_tquery(Database, query);
	return 1;
}

CMD:destruirbanco(playerid, params[])
{
    if (PlayerInfo[playerid][pPropertyMod] < 1)
		return SendErrorMessage(playerid, "Você não possui autorização para utilizar esse comando.");
    if(PlayerInfo[playerid][user_admin] < 4) 
        return SendErrorMessage(playerid, "Você não possui autorização para utilizar esse comando.");
	new id;
	if(sscanf(params, "i", id)) return SendSyntaxMessage(playerid, "/destruirbanco [id do banco]");
	if(!Iter_Contains(Bankers, id)) return SendErrorMessage(playerid, "Você digitou um ID inválido.");
	if(IsValidActor(BankerData[id][bankerActorID])) DestroyActor(BankerData[id][bankerActorID]);
	BankerData[id][bankerActorID] = -1;

    if(IsValidDynamic3DTextLabel(BankerData[id][bankerLabel])) DestroyDynamic3DTextLabel(BankerData[id][bankerLabel]);
    BankerData[id][bankerLabel] = Text3D: -1;

	Iter_Remove(Bankers, id);

	new query[48];
	mysql_format(Database, query, sizeof(query), "DELETE FROM bankers WHERE ID=%d", id);
	mysql_tquery(Database, query);
	return 1;
}

// Admin Commands for ATMs
CMD:criaratm(playerid, params[])
{
    if (PlayerInfo[playerid][pPropertyMod] < 1)
		return SendErrorMessage(playerid, "Você não possui autorização para utilizar esse comando.");
    if(PlayerInfo[playerid][user_admin] < 3) 
        return SendErrorMessage(playerid, "Você não possui autorização para utilizar esse comando.");
	new id = Iter_Free(ATMs);
	if(id == -1) return SendErrorMessage(playerid, "O servidor chegou ao limite de ATMs.");
	ATMData[id][atmRX] = ATMData[id][atmRY] = 0.0;

	GetPlayerPos(playerid, ATMData[id][atmX], ATMData[id][atmY], ATMData[id][atmZ]);
	GetPlayerFacingAngle(playerid, ATMData[id][atmRZ]);

	ATMData[id][atmX] += (2.0 * floatsin(-ATMData[id][atmRZ], degrees));
    ATMData[id][atmY] += (2.0 * floatcos(-ATMData[id][atmRZ], degrees));
    ATMData[id][atmZ] -= 0.3;

	ATMData[id][atmObjID] = CreateDynamicObject(19324, ATMData[id][atmX], ATMData[id][atmY], ATMData[id][atmZ], ATMData[id][atmRX], ATMData[id][atmRY], ATMData[id][atmRZ]);
    if(IsValidDynamicObject(ATMData[id][atmObjID]))
    {		
        EditingATMID[playerid] = id;
        EditDynamicObject(playerid, ATMData[id][atmObjID]);
    }

	new label_string[64];
	format(label_string, sizeof(label_string), "ATM (%d)\n\n/atm", id);
	ATMData[id][atmLabel] = CreateDynamic3DTextLabel(label_string, -1, ATMData[id][atmX], ATMData[id][atmY], ATMData[id][atmZ] + 0.85, 5.0, .testlos = 1);

	new query[144];
	mysql_format(Database, query, sizeof(query), "INSERT INTO bank_atms SET ID=%d, PosX='%f', PosY='%f', PosZ='%f', RotX='%f', RotY='%f', RotZ='%f'", id, ATMData[id][atmX], ATMData[id][atmY], ATMData[id][atmZ], ATMData[id][atmRX], ATMData[id][atmRY], ATMData[id][atmRZ]);
	mysql_tquery(Database, query);

	Iter_Add(ATMs, id);
	return 1;
}

CMD:editaratm(playerid, params[])
{
    if (PlayerInfo[playerid][pPropertyMod] < 1)
		return SendErrorMessage(playerid, "Você não possui autorização para utilizar esse comando.");
    if(PlayerInfo[playerid][user_admin] < 3) 
        return SendErrorMessage(playerid, "Você não possui autorização para utilizar esse comando.");
	new id;
	if(sscanf(params, "i", id)) return SendSyntaxMessage(playerid, "/editaratm [id do atm]");
	if(!Iter_Contains(ATMs, id)) return SendErrorMessage(playerid, "Você digitou um ID inválido.");
	if(!IsPlayerInRangeOfPoint(playerid, 30.0, ATMData[id][atmX], ATMData[id][atmY], ATMData[id][atmZ])) return SendErrorMessage(playerid, "Você não esta perto do ATM que deseja editar.");
	if(EditingATMID[playerid] != -1) return SendErrorMessage(playerid, "Você já está editando um ATM.");
	EditingATMID[playerid] = id;
	EditDynamicObject(playerid, ATMData[id][atmObjID]);
	return 1;
}

CMD:destruiratm(playerid, params[])
{
    if (PlayerInfo[playerid][pPropertyMod] < 1)
		return SendErrorMessage(playerid, "Você não possui autorização para utilizar esse comando.");
    if(PlayerInfo[playerid][user_admin] < 3) 
        return SendErrorMessage(playerid, "Você não possui autorização para utilizar esse comando.");
	new id;
	if(sscanf(params, "i", id)) return SendSyntaxMessage(playerid, "/destruiratm [id do atm]");
	if(!Iter_Contains(ATMs, id)) return SendErrorMessage(playerid, "Você digitou um ID inválido.");
	if(IsValidDynamicObject(ATMData[id][atmObjID])) DestroyDynamicObject(ATMData[id][atmObjID]);
	ATMData[id][atmObjID] = -1;

    if(IsValidDynamic3DTextLabel(ATMData[id][atmLabel])) DestroyDynamic3DTextLabel(ATMData[id][atmLabel]);
    ATMData[id][atmLabel] = Text3D: -1;
	
	Iter_Remove(ATMs, id);
	
	new query[48];
	mysql_format(Database, query, sizeof(query), "DELETE FROM bank_atms WHERE ID=%d", id);
	mysql_tquery(Database, query);
	return 1;
}