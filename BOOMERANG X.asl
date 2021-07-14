/**/

state("BOOMERANG X")
{
    int LevelIndex : "UnityPlayer.dll", 0x013A7FE0, 0x84, 0x4, 0xDC, 0x0, 0x44;
    int EndGem  : "mono-2.0-bdwgc.dll", 0x003A0574, 0xB3C, 0x20, 0x157;
    int IsIntroPlaying : "mono-2.0-bdwgc.dll", 0x003A0574, 0xB3C, 0x20, 0x1F5;
    int InMenu : "mono-2.0-bdwgc.dll", 0x003A0574, 0xB44, 0x35C;
}

isLoading
{
  return current.InMenu == 0 && current.EndGem != 1;
}

start
{
    return current.IsIntroPlaying == 0 && old.IsIntroPlaying == 1;
}

split
{
    return current.EndGem == 1 && current.EndGem != old.EndGem || current.LevelIndex != old.LevelIndex && 
    (
        current.LevelIndex == 2 || 
        current.LevelIndex == 4 ||
        current.LevelIndex == 6 ||
        current.LevelIndex == 7 ||
        current.LevelIndex == 9 ||
        current.LevelIndex == 11 ||
        current.LevelIndex == 13 ||
        current.LevelIndex == 14 ||
        current.LevelIndex == 16 ||
        current.LevelIndex == 17 ||
        current.LevelIndex == 19 ||
        current.LevelIndex == 20 );
} 