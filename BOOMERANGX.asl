/*for Boomerang X version 1.02
Autosplitter version 1.1 written by Sandou*/

state("BOOMERANG X")
{
    int LevelIndex : "UnityPlayer.dll", 0x018ED0A0, 0xD0,0x8, 0x240, 0x10, 0x84;
    int EndGem  : "UnityPlayer.dll", 0x018ED0F8, 0xD0, 0x20, 0x240, 0x10, 0x40, 0x237;
    int IsIntroPlaying : "UnityPlayer.dll", 0x019122E8, 0x38, 0x50, 0x8, 0x118, 0x335;
    int InMenu : "UnityPlayer.dll", 0x01915AA0, 0x30, 0x158, 0x8, 0x18, 0x28, 0x28, 0x6A8;
}

startup
{
    settings.Add("IntroDisabled", true, "Intro is disabled (Set an offset timer of -0.25s)");
}

isLoading
{
    return current.InMenu == 0 && current.EndGem != 1; 
}

start
{
    if(settings["IntroDisabled"])
    {
        return current.InMenu == 1 && old.InMenu == 0;
    }
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

