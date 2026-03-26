# msfs-safeModeSwitch
Simple PowerShell tool for forcing the option of running MSFS 2020 or MSFS 2024 in Safe Mode or Normal Mode by either adding or removing the `running.lock` file in the sim's active directory. The repo includes both the PowerShell script and a prebuilt Windows executable.

This "tool", whatever have you, assumes you are comfortable with basic navigation of Command Prompt and/or PowerShell, and that you have PowerShell installed. If you don't have PowerShell installed, install it from [here](https://learn.microsoft.com/en-us/powershell/scripting/install/installing-powershell-on-windows?view=powershell-7.4).

## YPMV! - Your Path May Vary
**Make sure you update the sim path values in the script as needed for your install.** If you are using the `.exe`, rebuild it after changing the script so the packaged version includes your updated paths.


# Context/Backstory
Like most of us, I have a ton of things in my Community folder. 442GB, in fact.
On occasion, the sim will CTD and prompt to open in Safe Mode or Normal Mode on the next launch as a result. 
Being that my PC gets relatively good frame rates in Safe Mode (or in any of the Activities in Normal Mode, specifically), I've learned to not have any inhibitions or reservations about doing flights in Safe Mode here and there. Especially if I have very little patience for my PC's tendencies to be a bit dramatic in terms of impact from the sim on that particular day.

That said, I did some research to understand how MSFS Safe Mode worked, and as it turns out, the sim will place a **running.lock** file in the game's running directory (which, for me, is **C:\XboxGames\Microsoft Flight Simulator\Content** for 2020 and **C:\XboxGames\Microsoft Flight Simulator 2024\Content** for 2024). 
On the next launch of the sim with this .lock file in place, the user will be presented with the following dialog box:
![Problem z Microsoft Flight Simulator 2020 - Microsoft Community](https://filestore.community.support.microsoft.com/api/images/a29118b5-b472-4454-b175-b0a42233d7ac?upload=true)

## [What does booting in Safe Mode do?](https://flightsimulator.zendesk.com/hc/en-us/articles/4405893759378-Safe-Mode-FAQ)
Per the documentation, *Safe Mode in Microsoft Flight Simulator disables temporarily: third-party content from the Marketplace and mods from the community folder.*
This can allow for an optimal experience with the base sim; minimal lagging or frame drops, screen tearing, and so on.

# It really isn't that bad.
Aside from missing custom/third-party scenery, aircraft, and other random add-ons (P42 simFX, RealTurb CAT, to name a few) there really is no downside to running the sim in Safe Mode, and all fellow simmers deserve an easily-accessible option for choosing how to launch the sim.
On the bright side, anyway, the following still work (for me) in Safe Mode with no *observed* limitations, whatsoever:
 - SimConnect
 	- FBW's flyPad and Remote MCDU server
	- VATSIM
	- FSLTL
   	- LittleNavMap (all features, **including real-time aircraft position tracking**)
   	- Volanta
 - Navigraph Simlink
	 - Navigraph Charts (all features except the in-game Charts panel, **with real-time aircraft position tracking**)
		 - Though unconfirmed if the JustFlight models will work as I do not have them and use only the FSLTL models.
 - *MSFS 2020 Map Enhancement*, by derekhe on [GitHub](https://github.com/derekhe/msfs2020-map-enhancement) (which works WONDERFULLY in **ALL** instances!!!)
 - FSUIPC
 - NVIDIA Freestyle/Game Filters
 - Reshade
 - Other things, probably, but this is pretty much all of *my* "necessities" for a flight.

# HOW TO SET UP
1. Download or clone the repo to a folder of your choice.
2. Decide whether you want to use the PowerShell script or the packaged executable.
3. For the **script version**, use [sourcecode/msfsSafeMode.ps1](./sourcecode/msfsSafeMode.ps1). Update the path values in the script if your MSFS install locations differ from the defaults.
4. For the **executable version**, use [distribution/msfsSafeMode.exe](./distribution/msfsSafeMode.exe). If you need different default paths, edit the script first and then rebuild the `.exe`.
5. If you want quick access, create a Desktop shortcut to whichever version you plan to use.

# HOW TO USE
1. Launch either the `.ps1` script or the `.exe`.
2. In the app window, choose your sim version: `MSFS 2020` or `MSFS 2024`.
3. Choose your platform: `Microsoft Store / Xbox` or `Steam`.
4. Click `Safe Mode` to create `running.lock`, or click `Normal Mode` to remove it.
5. If you want the sim to launch immediately after the mode change, check the auto-start box before making your selection.
6. Click `Cancel` or close the window with the `X` if you do not want to make any changes.

The app will show a confirmation message after updating the selected sim's `running.lock` state.

![uiV2.png](https://raw.githubusercontent.com/teezyyoxo/msfs2020-safeModeSwitch/refs/heads/main/UI%20images/uiV2-sample.png)

Keep calm, and keep the blue side up. Happy flying in whatever mode you choose!

# IS A LESS-COMPLICATED VERSION COMING?
There is now a packaged executable included in the repo for convenience, alongside the PowerShell script. I still like keeping the script available so it's easy to see exactly what the tool is doing and to customize the default sim paths when needed.