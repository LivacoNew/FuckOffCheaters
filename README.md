# Fuck Off Cheaters
Fuck Off Cheaters is a very primative """anti-cheat""" for PAYDAY 2, aiming to make it easier for people who are fed up of joining/hosting lobbies that contain cheaters that don't get marked by the game.

If you join a lobby and FOC determines that lobby contains a cheater, it will send an alert to the chat about it along with what they have been flagged with.

![The mod successfully flagging me as having CarryStacker installed.](https://i.imgur.com/nrVzuEK.png)
![A public lobby, with the mod finding someone with RNG Modifier and Cook Faster installed.](https://i.imgur.com/2v1w3qQ.png)

The mod can also log detection data to a json file, and mark the cheater visually in-game if you choose to enable it in the mod options.

## How to install?
Download the repo, and chuck the folder into your Game Files, `mods` directory.

This mod requires [SuperBLT](https://superblt.znix.xyz/).

## What does this flag?
The mod will currently alert you to any player that;
- Is flagged as a cheater in-game.
- Has a username that contains [P3DHack], indicating usage of the same-named hack mod.
- Has more than 120 skill points allocated.
- Has a mod installed that matches any mod in a list, customisable in the mod's options.

## What is defined as a "cheat"?
For the purposes of this mod, a "cheat" is defined as anything that;
- Gives that player an unfair advantage in terms of actual gameplay.
- Alters the gameplay in a way that removes challenge.
- Anything that artificially boosts rewards or performance of a player.

Unfortunately due to the diverse nature of PAYDAY 2's modding scene, it's impossible to provide a definitive accurate definition beyond this that covers every case.

Some examples of mods that are marked as cheats;
- Blatant cheats like Infinite Ammo, Infinite Skills, God mode, and RNG modifiers.
- Mods like Silent Assassin or Carry Stacker, that drastically alter the gameplay and balance.
- DLC Unlockers, as while not specifically cheating does provide a basis to dis-trust that player.
- Bezerker Lives Matter and Freecam, as while they have perfectly legitimate uses can also be used to simply cheat depending on the player's settings.

Some examples of mods that are not counted as cheats by this mod;
- Any HUD mods that provide extra information to the player such as VanillaHUD or WolfHUD.
- Performance or visual mods, e.g Less Inaccurate Weapon Laser or Advanced Crosshairs.
- Mods that change the gameplay in extremely minor or insignificant ways, such as Civilian Marking in Stealth or XP Banks.

## How accurate is this?
Accurate enough for *most* cheaters who simply install the mods and play. If a cheater is smarter than that however, they can easily bypass these checks right now.

For example; you'll see most detections are done as a result of the mod checks. **However**, it's not hard to report a false mod name/id to BLT and have it disguised as another, legitimate mod. This is just something that is a limitation of BLT, and not something very easily fixed.
