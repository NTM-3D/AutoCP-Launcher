#Requires AutoHotkey v2.0
#SingleInstance Force

; ============================================================
; Helper: Run program fresh (shared with hotkeys)
; ============================================================
RunFresh(programPath, parameters := "")
{
    exeName := StrSplit(programPath, "\")[-1]

    if ProcessExist(exeName)
        ProcessClose(exeName)

    Run programPath " " parameters
}

LaunchCP()
{
    hwnd := WinGetID("A")

    programPath := "D:\3D\Conversion_1.0.9\ConversionPlayer.exe"
    parameters  := hwnd " true"

    RunFresh(programPath, parameters)

    ; Start monitoring for exit
    SetTimer WaitForExit, 200
}

WaitForExit()
{
    if !ProcessExist("ConversionPlayer.exe")
    {
        SetTimer WaitForExit, 0

        ; Restart fullscreen detector
        Run "FullscreenDetector.ahk"
    }
}

; Launch immediately
LaunchCP()
