#include <NCIncs/nc_rpg>
#include <sdkhooks>


int fXPMultiple;

public Plugin myinfo = 
{
	name = "XPForDamage",
	author = ".KarmA",
	description = "Give XP for damage for NCRPG",
	version = "1.0",
	url = "https://steamcommunity.com/id/i_t_s_Karma/"
}
stock bool correctPlayer(int client){
    if(client > 0 && client <= MaxClients && IsClientInGame(client))
        return true;
    return false;
}
public void OnPluginStart(){
    HookEvent("player_hurt", OnPlayerHurt);
}
public void OnMapStart(){   
    NCRPG_Configs RPG_Configs = NCRPG_Configs(CONFIG_CORE);
    fXPMultiple = RPG_Configs.GetInt("xp", "xp_for_damage", 20);
    RPG_Configs.SaveConfigFile(CONFIG_CORE);
}
public Action OnPlayerHurt(Event event, const char[] name, bool dontBroadcast){
    int iClient = GetClientOfUserId(event.GetInt("userid"));
    int iAttacker = GetClientOfUserId(event.GetInt("attacker"));

    if(!correctPlayer(iClient) || !correctPlayer(iAttacker)) return Plugin_Continue;
    if(iClient == iAttacker) return Plugin_Continue;


    int fGive = (fXPMultiple * event.GetInt("dmg_health"));
    NCRPG_GiveExp(iAttacker, fGive);

    return Plugin_Continue;
}