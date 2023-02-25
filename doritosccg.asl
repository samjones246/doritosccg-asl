state("Crash Course Go!")
{
    int levelTime: 0x0047EED4, 0x170;
}

startup
{
    vars.Log = (Action<object>)((output) => print("[Doritos CCG ASL] " + output));
}

init
{
    vars.totalTime = 0;
}

update
{
    if (current.levelTime == Int32.MaxValue) {
        current.levelTime = 0;
    }
    if (current.levelTime > old.levelTime) {
        vars.gameTime = vars.totalTime + current.levelTime;
    }
}

start
{
    if (current.levelTime != 0 && old.levelTime == 0){
        vars.totalTime = 0;
        return true;
    }
}

split
{
    if (current.levelTime == 0 && old.levelTime != 0) {
        vars.totalTime += old.levelTime;
        return true;
    }
}

gameTime
{
    return TimeSpan.FromMilliseconds(vars.gameTime);
}

isLoading
{
    return current.levelTime == old.levelTime;
}