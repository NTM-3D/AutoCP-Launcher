#Requires AutoHotkey v2.0
#SingleInstance Force

; ============================================================
; Config: Add program and titles here, separated by |
; ============================================================
Programs	:= "chrome.exe|vlc.exe|mpc-3d64.exe"	
Titles		:= "3D SBS Image Viewer|3D.HSBS|mpc-3d"						  


; ============================================================
; Make sure only one ConversionPlayer is started
; ============================================================
RunFresh(programPath, parameters := "")
{
    exeName := StrSplit(programPath, "\")[-1]

    if ProcessExist(exeName)
        ProcessClose(exeName)

    Run programPath " " parameters
}

; ============================================================
; Hotkeys
; ============================================================

; ALT+1 (v1.0.9 SBS -> 3D)
!1::
{
    hwnd := WinGetID("A")
    programPath := "D:\3D\Conversion_1.0.9\ConversionPlayer.exe"
    parameters := hwnd " true"
    RunFresh(programPath, parameters)
}

; ALT+2 (v1.1.7 SBS -> 3D)
!2::
{
    hwnd := WinGetID("A")
    programPath := "D:\3D\Conversion_1.1.7\ConversionPlayer.exe"
    parameters := hwnd " true"
    RunFresh(programPath, parameters)
}

; ALT+3 (Lastest version SBS -> 3D)
!3::
{
    hwnd := WinGetID("A")
    pid  := WinGetPID("A")
    programPath := "C:\Program Files\Odyssey 3D Hub\Conversion\ConversionPlayer.exe"
    parameters := hwnd " true " pid
    RunFresh(programPath, parameters)
}

; ALT+8 (v1.0.9 2D -> 3D)
!8::
{
    hwnd := WinGetID("A")
    programPath := "D:\3D\Conversion_1.0.9\ConversionPlayer.exe"
    parameters := hwnd " false"
    RunFresh(programPath, parameters)
}

; ALT+9 (v1.1.7 2D -> 3D)
!9::
{
    hwnd := WinGetID("A")
    programPath := "D:\3D\Conversion_1.1.7\ConversionPlayer.exe"
    parameters := hwnd " false"
    RunFresh(programPath, parameters)
}

; ALT+0 (Lastest version 2D -> 3D)
!0::
{
    hwnd := WinGetID("A")
    pid  := WinGetPID("A")
    programPath := "C:\Program Files\Odyssey 3D Hub\Conversion\ConversionPlayer.exe"
    parameters := hwnd " false " pid
    RunFresh(programPath, parameters)
}


; ============================================================
; Fullscreen detection logic
; ============================================================

IsFullscreen(hwnd)
{
    try {
        WinGetPos(&x, &y, &w, &h, hwnd)
        ;style   := WinGetStyle(hwnd)
        ;exStyle := WinGetExStyle(hwnd)
    } catch {
        return false
    }

    return (
        x = 0
        && y = 0
        && w = 3840
        && h = 2160
        ;&& style   = 386596864
        ;&& exStyle = 2097152
    )
}

IsMatch()
{
    global Programs, Titles

    try
    {
        ; Get active window info once
        activeExe := WinGetProcessName("A")
        title := WinGetTitle("A")

        for _, exe in StrSplit(Programs, "|")
        {
            ; Check EXE first
            if (activeExe != exe)
                continue

            ; EXE matched → now check titles
            for _, t in StrSplit(Titles, "|")
            {
                if (InStr(title, t))
                {
                    ; EXE + TITLE matched → now check fullscreen
                    hwnd := WinGetID("A")

                    if IsFullscreen(hwnd)
                    {
                        Run "ConversionLauncher.ahk"
                        ExitApp
                    }

                    return
                }
            }
        }
    }
    catch
    {
        return
    }
}

SetTimer IsMatch, 200
