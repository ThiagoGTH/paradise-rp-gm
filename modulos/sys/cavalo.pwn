#include <YSI\y_hooks>

hook OnPlayerUpdate(playerid)
{
    if(inahorse[playerid] == 1)
    {
        new keys, ud, lr;
        GetPlayerKeys(playerid, keys, ud, lr);
        if((keys & (KEY_WALK)) == (KEY_WALK))
        {
            new Float:x, Float:y, Float:z, Float:angle;
            //TogglePlayerControllable(playerid, false);
            GetPlayerPos(playerid, x, y, z);
            GetPlayerFacingAngle(playerid, angle);
            x += (0.1 * floatsin(-angle, degrees));
            y += (0.1 * floatcos(-angle, degrees));
            SetPlayerPos(playerid, x, y, z);
            ApplyAnimation(playerid, "BIKED", "BIKED_RIDE", 4.1, 1, 1, 1, 1, 0, 1);
        }
        if((keys & (KEY_SPRINT)) == (KEY_SPRINT) || (keys & (KEY_JUMP)) == (KEY_JUMP))
        {
            new Float:angle;
            GetPlayerFacingAngle(playerid, angle);
            if(keys == KEY_WALK) SetPlayerFacingAngle(playerid, angle-0.1);
            else SetPlayerFacingAngle(playerid, angle+0.1); 
            ApplyAnimation(playerid, "BIKED", "BIKED_RIDE", 4.1, 1, 1, 1, 1, 0, 1);
        }
    }
    return 1;
}
 
CMD:cavalo(playerid, params[])
{
    if(PlayerInfo[playerid][user_logged] == 0)
	{
		SendClientMessage(playerid, COLOR_GRAD1, "Você não está logado.");
		return true;
	}
	switch(inahorse[playerid])
	{
		case 0:
		{
   			inahorse[playerid] = 1;
            SendClientMessage(playerid, COLOR_GREY, "Você montou no cavalo.");
      	    SetPlayerAttachedObject(playerid, 5, 11733, 5, -0.627999, 1.480000, -0.126000, 93.399879, 1.999998, 77.299987, 1.103000, 1.112997, 1.014999);
            ApplyAnimation(playerid, "BIKED", "BIKED_RIDE", 4.1, 1, 1, 1, 1, 0, 1);
            SetPlayerArmedWeapon(playerid,0);
        }
		case 1:
		{
            inahorse[playerid] = 0;
            SendClientMessage(playerid, COLOR_GREY, "Você desmontou do cavalo.");
		    ClearAnimations(playerid, 1);
            RemovePlayerAttachedObject(playerid, 5);
            
		}
	}
	return true;
}