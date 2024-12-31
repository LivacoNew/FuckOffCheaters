# Fuck Off Cheaters
Fuck Off Cheaters is a primative """anti-cheat""" for PAYDAY 2, aiming to make it easier for people who are fed up of joining/hosting lobbies that contain cheaters that don't get marked by the game.

If you join a lobby and FOC determines that lobby contains a cheater, it will send an alert to the chat about it along with what they have been flagged with.

![The mod successfully flagging me as having CarryStacker installed.](https://i.imgur.com/nrVzuEK.png)
![A public lobby, with the mod finding someone with RNG Modifier and Cook Faster installed.](https://i.imgur.com/2v1w3qQ.png)

## Feature Overview
- FOC will flag any player who;
	- Has been marked as a cheater by PAYDAY itself.
	- Has a username that contains the "[P3DHack]" prefix.
	- Has more than 120 skill points allocated in their build.
	- Has a mod installed that is known to be a cheat.
- Customise which detections/mods get flagged.
- Mark the player as a CHEATER *visually* on flag.
- Log any detections as a JSON file inside the `ModFolder/detections` folder, for reference or to help contribute to the filters.

## How to install?
This mod requires [SuperBLT](https://superblt.znix.xyz/).

Download the mod, and chuck the folder into your Game Files, `mods` directory.

## How accurate is this?
Accurate enough for *most* public cheaters, who simply install the mods and play. 
If a cheater is smarter than that however, **they can easily bypass these checks**.

For example; you'll see most detections are done as a result of the mod checks. **However**, it's not hard to report a false mod name/id to BLT and have it disguised as another, legitimate mod. This is just something that is a limitation of BLT, and not something very easily fixed without a lot more work than me - work I'm working on figuring out, but am still relatively new to PAYDAY modding so need some time.

## What does this mod define as a "cheat"?
Unfortunately, PAYDAY modding is really diverse and not everyone agrees on what a cheat is. Some think it's only explicit and obvious cheats, meanwhile some others think anything other than the vanilla game is cheating.

For the purposes of this mod specifically, I've defined "cheat" is defined as anything that;
- Gives that player an *large*, *unfair* advantage in terms of *actual* gameplay, or otherwise alters the gameplay in a way that removes a big portion of challenge. For example;
	- God Mode, Infinite Ammo, "trainers" or any obvious cheats.
	- Mods like Bezerker Live Matter, where it can be configured to set your health for a 100% zerk.
	- Mods like Silent Assassin or Carry Stacker, that drastically alter the gameplay/difficulty of a specific heist.
	- HUD Mods, Visual Mods, or Stealth Civilian Marking or similar **are not counted under this**, as while they may give that player an advantage, it's extremely minor and doesn't remove *actual* challenge.
- Artificially boosts the rewards or stats of a player, letting them skip progression *without putting in the work for it*. For example;
	- Any obvious XP Boosters, or mods like CC/Money generator or Crime Spree from Bags.
	- Cooking/Printing faster, letting you get more loot for less work.
	- RNGModifier, altering the luck and loot potential of a given lobby, e.g forcing Go Bank's 1% chance for the vault to be wide open.
	- XP Banks **do not count**, as you still need to put in work to actually gain that XP, not to mention it's already partially in the game anyway after Infamy 4.

If you disagree with any of this but still wish to use the mod, **you can disable individual detections or mods inside the in-game settings to match what you would like to play with.** 
