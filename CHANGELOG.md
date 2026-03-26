# Changelog

## Version 2.7
- Added Microsoft Flight Simulator 2024 support for both Xbox/MS Store and Steam path options.
- Refactored launch/path logic so both sim versions use the same code path.
- Minor UI refinements.
- Added app icon + new executable.

## Version 2.6.2
- Added code that I thought would stop the "Cancel" dialog box from appearing, but that didn't go too well.
- Yes - there is a "Cancel" dialog that appears when you click "Cancel" or "X" out of the program. I don't know why, and I'm having trouble figuring that out lol.
- But we have an executable now. You're welcome :)

## Version 2.6.1
- Removed duplicate array.
- Cleaned up response/feedback logic.

## Version 2.6
- Resolved an issue when launching the script via Desktop shortcut by adding various instances of *[System.Windows.Forms.MessageBox]*.
- Code updated (slightly) for executable beta ;) TIL about ps2exe!

## Version 2.5
- Improved logic and error handling a LOT. Script now prints debugging info to terminal (when run in PS, PS ISE, or VS Code).
- Now using `gamelaunchhelper.exe` for the launch instead of `FlightSimulator.exe`.
- Resolved issue where the sim would launch when the auto-start checkbox was not checked.

## Version 2.4.2
- Added logic for a custom icon for the form that is currently disabled, but "ready". Mostly.

## Version 2.4.1
- Minor UI tweaks/improvements.

## Version 2.4
- Introduction of v2 of the UI - much nicer to look at, although extremely basic.
- Window size, button placement and text alignment(s) adjusted.

## Version 2.3
- Functional enhancements.
- Minor UI corrections.

## Version 2.2
- Fixed window sizing.
- Button alignment and radio button label clipping to be fixed in a future build.

## Version 2.1
- Returned the missing assemblies (`System.Windows.Forms`, `System.Drawing`).
- Prompt now appears without incident at the center of the screen, but realizing that the sizing is still incorrect. Will fix in next release.

## Version 2.0
- Made it... work.
- Updated `$storePath`, still need to verify `$steamPath` (I only have the MS version)!
- Please submit a Pull request with this value if you don't mind :)
- Adjusted the form configuration so that it opens at the center of the screen and fits all of the text.
- Increased form `MinimumSize` to `400x250`.
- Added size properties to buttons to avoid more cut-off text.
- Blah blah blah...

## Version 1.0
- Initial release.