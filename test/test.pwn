/**
* Example Test.
*/
#include "a_samp"
#include "string"

#pragma tabsize 4

main() {
  print "Hello, World"

  for (new i = 0; i >= 0; i++) { // infinity loop.
      printf "%d", i;
  }
}

stock getPlayerName(playerid) {
  new _name[MAX_PLAYER_NAME+1];
    GetPlayerName(playerid, _name, sizeof(_name));
  return 1;
}

stock sendClientMessage(playerid, color, const str[], {Float,_}:...)
{
    static args, start, end, string[144]
    #emit LOAD.S.pri 8
    #emit STOR.pri args

    if (args > 12)
    {
        #emit ADDR.pri str
        #emit STOR.pri start

        for (end = start + (args - 12); end > start; end -= 4)
        {
            #emit LREF.pri end
            #emit PUSH.pri
        }
        #emit PUSH.S str
        #emit PUSH.C 144
        #emit PUSH.C string
        #emit PUSH.C args
        #emit SYSREQ.C format

        SendClientMessage(playerid, color, string)

        #emit LCTRL 5
        #emit SCTRL 4
        #emit RETN
    }
    return SendClientMessage(playerid, color, str);
}

public OnPlayerSpawn(playerid) {
  sendClientMessage playerid, -1, "Hello, %s[%d]", getPlayerName(playerid), playerid;
  return 1;
}

