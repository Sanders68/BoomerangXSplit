state("Boomerang X") {}

startup
{
	vars.Log = (Action<object>)(output => print("[Boomerang X] " + output));
	vars.Unity = Assembly.Load(File.ReadAllBytes(@"Components\UnityASL.bin")).CreateInstance("UnityASL.Unity");

	vars.BossPhase = 0;

	settings.Add("ilMode", false, "Use IL mode (hover for information)");
	settings.SetToolTip("ilMode", "- Starts the timer when a wave begins\n- Wave splits must still be chosen below\n- Syncs to level timer\n- Prevents starting after loading into level");

	// Formats
	// - checkpoint splits: level-checkpoint-cp (to be triggered when the checkpoint is entered; rising edge)
	// - arena splits: level-checkpoint-wave (to be triggered when the wave is beaten; falling edge)
	// - level splits: level-finish (to be triggered when the level is beaten; falling edge)
	// Any other settings can be named whatever.
	dynamic[,] sett =
	{
		{ null, "lvl0", "The Entaccan Coast", true },
			{ "lvl0", "0-a1", "Arena", false },
				{ "0-a1", "0-2-start", "Start of first wave", false },
				{ "0-a1", "0-2-0", "Beat Wave 1 (2)", true },
				{ "0-a1", "0-2-1", "Beat Wave 2 (1)", true },
				{ "0-a1", "0-2-2", "Beat Wave 3 (2)", true },
				{ "0-a1", "0-2-3", "Beat Wave 4 (2)", true },
				{ "0-a1", "0-2-4", "Beat Wave 5 (3)", true },
			{ "lvl0", "0-3", "The Composer's Garden", false },
				{ "0-3", "0-a2", "Arena", false },
					{ "0-a2", "0-3-start", "Start of first wave", false },
					{ "0-a2", "0-3-0", "Beat Wave 1 (1)", true },
					{ "0-a2", "0-3-1", "Beat Wave 2 (2)", true },
					{ "0-a2", "0-3-2", "Beat Wave 3 (4)", true },
					{ "0-a2", "0-3-3", "Beat Wave 4 (5)", true },
					{ "0-a2", "0-3-4", "Beat Wave 5 (6)", true },
					{ "0-a2", "0-3-5", "Beat Wave 6 (6)", true },
				{ "0-3", "0-finish", "Exit Arena", false },
			{ "lvl0", "1-finish", "Finish the Level", true },
		{ null, "lvl2", "Kenak, the Exiled Tyrant", true },
			{ "lvl2", "2-a", "Arena", false },
				{ "2-a", "2-5-start", "Start of first wave", false },
				{ "2-a", "2-5-0", "Beat Wave 1 (4)", true },
				{ "2-a", "2-5-1", "Beat Wave 2 (4)", true },
				{ "2-a", "2-5-2", "Beat Wave 3 (5)", true },
				{ "2-a", "2-5-3", "Beat Wave 4 (6)", true },
				{ "2-a", "2-5-4", "Beat Wave 5 (4)", true },
				{ "2-a", "2-5-5", "Beat Wave 6 (5)", true },
				{ "2-a", "2-6-cp", "Beat Wave 7 (6)", true },
			{ "lvl2", "2-finish", "Exit Arena", false },
			{ "lvl2", "3-finish", "Finish the Level", true },
		{ null, "lvl4", "The Grudge Pit", true },
			{ "lvl4", "4-a", "Arena", false },
				{ "4-a", "4-8-start", "Start of first wave", false },
				{ "4-a", "4-8-0", "Beat Wave 1 (4)", true },
				{ "4-a", "4-8-1", "Beat Wave 2 (4)", true },
				{ "4-a", "4-8-2", "Beat Wave 3 (4)", true },
				{ "4-a", "4-8-3", "Beat Wave 4 (5)", true },
				{ "4-a", "4-8-4", "Beat Wave 5 (7)", true },
				{ "4-a", "4-8-5", "Beat Wave 6 (5)", true },
				{ "4-a", "4-8-6", "Beat Wave 7 (7)", true },
				{ "4-a", "4-9-cp", "Beat Wave 8 (8)", true },
			{ "lvl4", "4-finish", "Exit Arena (The Shrine of Kaspidae)", false },
			{ "lvl4", "5-finish", "Finish the Level", true },
		{ null, "lvl6", "The Valley of the First Nymphs", true },
			{ "lvl6", "6-a", "Arena", false },
				{ "6-a", "6-11-start", "Start of first wave", false },
				{ "6-a", "6-11-0", "Beat Wave 1 (10)", true },
				{ "6-a", "6-11-1", "Beat Wave 2 (7)", true },
				{ "6-a", "6-11-2", "Beat Wave 3 (6)", true },
				{ "6-a", "6-11-3", "Beat Wave 4 (8)", true },
				{ "6-a", "6-11-4", "Beat Wave 5 (10)", true },
				{ "6-a", "6-11-5", "Beat Wave 6 (8)", true },
				{ "6-a", "6-12-cp", "Beat Wave 7 (10)", true },
			{ "lvl6", "6-finish", "Finish the Level", true },
		{ null, "lvl7", "Yoranwood", true },
			{ "lvl7", "7-a", "Arena", false },
				{ "7-a", "7-13-start", "Start of first wave", false },
				{ "7-a", "7-13-0", "Beat Wave 1 (7)", true },
				{ "7-a", "7-13-1", "Beat Wave 2 (12)", true },
				{ "7-a", "7-13-2", "Beat Wave 3 (4)", true },
				{ "7-a", "7-13-3", "Beat Wave 4 (8)", true },
				{ "7-a", "7-14-cp", "Beat Wave 5 (7)", true },
			{ "lvl7", "7-finish", "Exit Arena (Crypt of the Cursed Blood)", false },
			{ "lvl7", "8-finish", "Finish the Level", true },
		{ null, "lvl9", "The Poisoned Well", true },
			{ "lvl9", "9-a", "Arena", false },
				{ "9-a", "9-16-start", "Start of first wave", false },
				{ "9-a", "9-16-0", "Beat Wave 1 (1)", true },
				{ "9-a", "9-16-1", "Beat Wave 2 (4)", true },
				{ "9-a", "9-16-2", "Beat Wave 3 (3)", true },
				{ "9-a", "9-16-3", "Beat Wave 4 (6)", true },
				{ "9-a", "9-16-4", "Beat Wave 5 (5)", true },
				{ "9-a", "9-16-5", "Beat Wave 6 (5)", true },
				{ "9-a", "9-17-cp", "Beat Wave 7 (6)", true },
			{ "lvl9", "9-finish", "Exit Arena", false },
			{ "lvl9", "10-finish", "Finish the Level", true },
		{ null, "lvl11", "The Old Vein", true },
			{ "lvl11", "11-a", "Arena", false },
				{ "11-a", "11-19-start", "Start of first wave", false },
				{ "11-a", "11-19-0", "Beat Wave 1 (3)", true },
				{ "11-a", "11-19-1", "Beat Wave 2 (5)", true },
				{ "11-a", "11-19-2", "Beat Wave 3 (9)", true },
				{ "11-a", "11-19-3", "Beat Wave 4 (9)", true },
				{ "11-a", "11-19-4", "Beat Wave 5 (11)", true },
				{ "11-a", "11-20-cp", "Beat Wave 6 (14)", true },
			{ "lvl11", "11-finish", "Exit Arena (Forum of the Starved Hive)", false },
			{ "lvl11", "12-finish", "Finish the Level", true },
		{ null, "lvl13", "Incursion of the Great Worm", true },
			{ "lvl13", "13-a", "Arena", false },
				{ "13-a", "13-22-start", "Start of first wave", false },
				{ "13-a", "13-22-0", "Beat Wave 1 (2)", true },
				{ "13-a", "13-22-1", "Beat Wave 2 (6)", true },
				{ "13-a", "13-22-2", "Beat Wave 3 (6)", true },
				{ "13-a", "13-22-3", "Beat Wave 4 (8)", true },
				{ "13-a", "13-22-4", "Beat Wave 5 (7)", true },
				{ "13-a", "13-23-cp", "Beat Wave 6 (9)", true },
			{ "lvl13", "13-finish", "Finish the Level", true },
		{ null, "lvl14", "Atsil's Quarry", true },
			{ "lvl14", "14-a", "Arena", false },
				{ "14-a", "14-24-start", "Start of first wave", false },
				{ "14-a", "14-24-0", "Beat Wave 1 (1)", true },
				{ "14-a", "14-24-1", "Beat Wave 2 (3)", true },
				{ "14-a", "14-24-2", "Beat Wave 3 (7)", true },
				{ "14-a", "14-24-3", "Beat Wave 4 (9)", true },
				{ "14-a", "14-24-4", "Beat Wave 5 (4)", true },
				{ "14-a", "14-24-5", "Beat Wave 6 (6)", true },
				{ "14-a", "14-25-cp", "Beat Wave 7 (8)", true },
			{ "lvl14", "14-finish", "Exit Arena (The Hermit's Bath)", false },
			{ "lvl14", "15-finish", "Finish the Level", true },
		{ null, "lvl16", "Hall of the Ersatz Feast", true },
			{ "lvl16", "16-a", "Arena", false },
				{ "16-a", "16-27-start", "Start of first wave", false },
				{ "16-a", "16-27-0", "Beat Wave 1 (10)", true },
				{ "16-a", "16-27-1", "Beat Wave 2 (12)", true },
				{ "16-a", "16-27-2", "Beat Wave 3 (10)", true },
				{ "16-a", "16-27-3", "Beat Wave 4 (6)", true },
				{ "16-a", "16-27-4", "Beat Wave 5 (12)", true },
				{ "16-a", "16-27-5", "Beat Wave 6 (6)", true },
				{ "16-a", "16-27-6", "Beat Wave 7 (8)", true },
				{ "16-a", "16-28-cp", "Beat Wave 8 (11)", true },
			{ "lvl16", "16-finish", "Finish the Level", true },
		{ null, "lvl17", "The Grave of the Yoran Legion", true },
			{ "lvl17", "17-a", "Arena", false },
				{ "17-a", "17-29-start", "Start of first wave", false },
				{ "17-a", "17-29-0", "Beat Wave 1 (4)", true },
				{ "17-a", "17-29-1", "Beat Wave 2 (2)", true },
				{ "17-a", "17-29-2", "Beat Wave 3 (5)", true },
				{ "17-a", "17-29-3", "Beat Wave 4 (3)", true },
				{ "17-a", "17-29-4", "Beat Wave 5 (3)", true },
				{ "17-a", "17-29-5", "Beat Wave 6 (5)", true },
				{ "17-a", "17-30-cp", "Beat Wave 7 (7)", true },
			{ "lvl17", "17-finish", "Exit Arena (The Deepest Folly)", false },
			{ "lvl17", "18-finish", "Finish the Level", true },
		{ null, "lvl19", "Hall of the Ersatz Feast", true },
			{ "lvl19", "19-a", "Arena", false },
				{ "19-a", "19-32-start", "Start of first wave", false },
				{ "19-a", "19-32-0", "Beat Wave 1 (12)", true },
				{ "19-a", "19-32-1", "Beat Wave 2 (7)", true },
				{ "19-a", "19-32-2", "Beat Wave 3 (6)", true },
				{ "19-a", "19-32-3", "Beat Wave 4 (7)", true },
				{ "19-a", "19-32-4", "Beat Wave 5 (6)", true },
				{ "19-a", "19-32-5", "Beat Wave 6 (4)", true },
				{ "19-a", "19-33-cp", "Beat Wave 7 (6)", true },
			{ "lvl19", "19-finish", "Finish the Level", true },
		{ null, "lvl20", "Vashkatar", true },
			{ "lvl20", "20-a", "Arena", false },
				{ "20-a", "20-34-start", "Start of first wave", false },
				{ "20-a", "boss1", "Beat Phase 1", true },
				{ "20-a", "boss2", "Beat Phase 2", true },
				{ "20-a", "20-35-cp", "Beat Phase 3", true },
			{ "lvl20", "end", "Beat the Game", true }
	};

	for (int i = 0; i < sett.GetLength(0); ++i)
		settings.Add(sett[i, 1], sett[i, 3], sett[i, 2], sett[i, 0]);
}

onStart
{
	vars.BossPhase = 0;
}

init
{
	vars.Unity.TryOnLoad = (Func<dynamic, bool>)(helper =>
	{
		var st = helper.GetClass("Assembly-CSharp", "singleton`1");

		var sw = helper.GetClass("System", "Stopwatch");
		var tm = helper.GetClass("Assembly-CSharp", "timer_manager");
		vars.Unity.Make<long>(tm.Static, tm["global_stopwatch"], sw["elapsed"]).Name = "globalElapsedTicks";
		vars.Unity.Make<bool>(tm.Static, tm["global_stopwatch"], sw["is_running"]).Name = "globalStopwatchRunning";
		vars.Unity.Make<long>(tm.Static, tm["level_stopwatch"], sw["elapsed"]).Name = "levelElapsedTicks";
		vars.Unity.Make<bool>(tm.Static, tm["level_stopwatch"], sw["is_running"]).Name = "levelStopwatchRunning";
		vars.Unity.Make<bool>(tm.Static, tm["level_stopwatch_running"]).Name = "levelTimerRunning";

		var lm = helper.GetClass("Assembly-CSharp", "loading_manager", 1);
		var lvlm = helper.GetClass("Assembly-CSharp", "level_manager");
		var aa = helper.GetClass("Assembly-CSharp", "arena_agenda");
		vars.Unity.Make<int>(lm.Static, st["_instance"], lm["current_level_index"]).Name = "level";
		vars.Unity.Make<int>(lm.Static, st["_instance"], lm["current_game_checkpoint"]).Name = "checkpoint";
		vars.Unity.Make<int>(lm.Static, st["_instance"], lm["current_level_manager"], lvlm["my_arena"], aa["current_wave"]).Name = "wave";

		var fblm = helper.GetClass("Assembly-CSharp", "final_boss_level_manager");
		var eb = helper.GetClass("Assembly-CSharp", "eel_boss");
		vars.Unity.Make<int>(lm.Static, st["_instance"], lm["current_level_manager"], fblm["eel"], eb["current_state"]).Name = "eelState";

		var gpg = helper.GetClass("Assembly-CSharp", "goo_planet_gem");
		vars.Unity.Make<int>(lm.Static, st["_instance"], lm["current_level_manager"], fblm["final_planet_gem"], gpg["times_hit"]).Name = "gemHits";

		var sfxm = helper.GetClass("Assembly-CSharp", "sfx_manager", 1);
		vars.Unity.Make<int>(sfxm.Static, st["_instance"], sfxm["active_ambience_zone"]).Name = "ambienceZone";

		return true;
	});

	vars.Unity.Load(game);
}

update
{
	if (!vars.Unity.Loaded) return false;

	vars.Unity.Update();

	current.Level = vars.Unity["level"].Current;
	current.Checkpoint = vars.Unity["checkpoint"].Current;
	current.Wave = vars.Unity["wave"].Current;

	current.EelState = vars.Unity["eelState"].Current;
	current.GemHits = vars.Unity["gemHits"].Current;

	current.AmbienceZone = vars.Unity["ambienceZone"].Current;

	current.ElapsedTicks = settings["ilMode"] ? vars.Unity["levelElapsedTicks"].Current : vars.Unity["globalElapsedTicks"].Current;
	current.TimerRunning = settings["ilMode"] ? vars.Unity["levelStopwatchRunning"].Current : vars.Unity["globalStopwatchRunning"].Current;

	current.LevelTimerRunning = vars.Unity["levelTimerRunning"].Current;
}

start
{
	if (current.ElapsedTicks > 0)
		return;

	return !old.TimerRunning && current.TimerRunning;
}

split
{
	if (old.Level != current.Level)
		return settings[old.Level + "-finish"];

	if (old.Checkpoint != current.Checkpoint)
		return settings[current.Level + "-" + current.Checkpoint + "-cp"];

	if (!old.LevelTimerRunning && current.LevelTimerRunning)
		return settings[current.Level + "-" + current.Checkpoint + "-start"];

	if (old.Wave < current.Wave)
		return settings[current.Level + "-" + current.Checkpoint + "-" + old.Wave];

	// If we're not in the final level, don't continue on to check final level things.
	if (current.Level != 20)
		return;

	if (old.EelState == 0 && current.EelState == 3)
		return settings["boss" + ++vars.BossPhase];

	if (old.GemHits < current.GemHits)
		return current.GemHits == 8 && settings["end"];
}

reset
{
	// active_ambience_zone is set to 0 when going to the main menu, but also when breaking the last gem.
	// To prevent a reset in the latter case, we check whether we're doing that right now.
	if (current.GemHits >= 7 && current.Level == 20)
		return;

	if (settings["ilMode"])
		return !old.LevelTimerRunning && current.LevelTimerRunning;

	return old.AmbienceZone != 0 && current.AmbienceZone == 0;
}

gameTime
{
	// System.Diagnostics.Stopwatch is optimized such that `elapsed` does not continually update.
	// What we do instead is pause (isLoading) the timer when its `is_running` variable is false.
	// This causes desyncs the more you do it (since LiveSplit can't keep up frame-perfectly).
	// To re-sync the timer, we set its game time to the elapsed ticks when the Stopwatch is paused.
	// An additional check is made, so that the time isn't set to 0 before resetting on the main menu.
	if (!current.TimerRunning && current.AmbienceZone > 0)
		return TimeSpan.FromTicks(current.ElapsedTicks);
}

isLoading
{
	return !current.TimerRunning;
}

exit
{
	vars.Unity.Reset();
}

shutdown
{
	vars.Unity.Reset();
}
