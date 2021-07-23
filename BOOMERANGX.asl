/*for Boomerang X version 1.01
Autosplitter version 1.0 written by Sandou*/

state("BOOMERANG X")
{
    int LevelIndex : "UnityPlayer.dll",0x019591C0, 0x2E8, 0x60, 0x90, 0x28, 0x84;
    int EndGem  : "mono-2.0-bdwgc.dll", 0x00497DA8, 0x190, 0x7D0, 0x237;
    int IsIntroPlaying : "UnityPlayer.dll", 0x019122E8, 0x38, 0x50, 0x8, 0x118, 0x335;
    int InMenu : "UnityPlayer.dll",0x019591C0, 0x2E8, 0x60, 0x30, 0x28, 0x6A8;
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

