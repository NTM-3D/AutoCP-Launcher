# AutoCP-Launcher

An AutoHotkey v2 utility for launching ConversionPlayer (SBS/2D → 3D conversion) via hotkeys, with automatic fullscreen detection that triggers the converter when a defined app and title combo goes fullscreen.

---

## Scripts

### `FullscreenDetector.ahk` — Main script (run this one)

- Polls the active window every 200 ms.
- When the active window matches both a watched process name and title keyword, and is in fullscreen, it automatically launches `ConversionLauncher.ahk` and exits itself.
- Registers all manual hotkeys (see table below).

### `ConversionLauncher.ahk` — Auto-launch helper

- Launched by `FullscreenDetector` when a fullscreen match is detected.
- Starts ConversionPlayer in SBS → 3D mode, passing the active window handle.
- Monitors for ConversionPlayer exit and restarts `FullscreenDetector` when it closes.

---

## Hotkeys

| Hotkey | Action |
|--------|--------|
| `Alt+1` | Launch ConversionPlayer v1.0.9 — SBS → 3D |
| `Alt+2` | Launch ConversionPlayer v1.1.7 — SBS → 3D |
| `Alt+3` | Launch ConversionPlayer latest — SBS → 3D |
| `Alt+8` | Launch ConversionPlayer v1.0.9 — 2D → 3D |
| `Alt+9` | Launch ConversionPlayer v1.1.7 — 2D → 3D |
| `Alt+0` | Launch ConversionPlayer latest — 2D → 3D |

All hotkeys target the currently active window and kill any existing ConversionPlayer instance before launching a fresh one.

---

## Auto-detection

In `FullscreenDetector` I have included a few example applicatons and titles:

Processes: `chrome.exe`, `vlc.exe`, `mpc-3d64.exe` (https://github.com/johnbeere/MPC-3D)

Title must contain one of: `3D SBS Image Viewer`, `3D.HSBS`, `mpc-3d`

Fullscreen is defined as the window covering the full `3840×2160`.

To add more apps or title keywords, edit the config lines near the top of `FullscreenDetector.ahk`:

```ahk
Programs := "chrome.exe|vlc.exe|mpc-3d64.exe"
Titles   := "3D SBS Image Viewer|3D.HSBS|mpc-3d"
```

---

## Showing the filename in VLC's title bar

For the title-based detection to work in VLC, VLC must display the filename in its window title. By default it shows metadata instead. To fix this:

1. Open VLC and go to Tools → Preferences.
2. In the bottom-left corner, set Show settings to All.
3. Navigate to Input / Codecs.
4. Scroll to the very bottom and find "Change title according to current media".
5. Set the value to `$u` (filename without path).
6. Click Save and restart VLC.

The window title will now contain the filename, allowing the title keyword match to work correctly.

---

## Getting older versions of Odyssey 3D Hub

Older versions of the Samsung Odyssey 3D Hub installer are archived on the Internet Archive:  
https://archive.org/search?query=subject%3A%22g90xf%22

To preserve a specific version of ConversionPlayer alongside the latest:

1. Uninstall the latest version.
2. Download and install the version you want to keep.
3. Copy the folder `C:\Program Files\Odyssey 3D Hub\Conversion` to a safe location.
4. Uninstall that version and install the another you want to keep and repeat.
5. Install the latest version again.

You can then point the `programPath` in the scripts to whichever copy you want to use for each hotkey.

v1.0.9 is recommended for SBS → 3D conversion as it starts noticeably faster than later versions.

---

## Setup

1. Install [AutoHotkey v2.0](https://www.autohotkey.com/)
2. Update the `programPath` variables in `FullscreenDetector.ahk` to match your ConversionPlayer backup/install locations
3. In `ConversionLauncher.ahk`, update the `programPath` to point to whichever version of ConversionPlayer you want the auto-detection to launch
4. Run `FullscreenDetector.ahk` — optionally add it to startup

> Tip: To run on Windows startup, place a shortcut to `FullscreenDetector.ahk` in `shell:startup`.
