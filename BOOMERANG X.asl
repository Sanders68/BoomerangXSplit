/**/

state("BOOMERANG X")
{
    int levelindex : "UnityPlayer.dll", 0x013A7FE0, 0x84, 0x4, 0xDC, 0x0, 0x44;
    int endgem  : "mono-2.0-bdwgc.dll", 0x003A0574, 0xB3C, 0x20, 0x17;
    int introisplaying : "mono-2.0-bdwgc.dll", 0x003A0574, 0xB3C, 0x20, 0x1F5;
    int inmenu : "mono-2.0-bdwgc.dll", 0x003A0574, 0xB44, 0x35C;
}

isLoading
{
  return current.inmenu == 0;
}

start
{
    return (current.introisplaying == 0 && old.introisplaying == 1);
    
}

split
{
    return (current.levelindex != (old.levelindex) && current.levelindex == 2 | 4 | 6 | 7 | 9 | 11 | 13 | 14 | 16 | 17 | 19 | 20);
} 
