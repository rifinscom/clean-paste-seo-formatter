/*
================================================================================
Project: CleanPaste & SEO Formatter
Version: 1.0.0
Author: Rifins Dev
Website: https://www.rifins.com
Description: Strips text formatting from copied content and converts 
             case for SEO-optimized writing. Drag-anywhere enabled.
================================================================================
*/
#Requires AutoHotkey v2.0
#SingleInstance Force

; Application Metadata
AppTitle := "Rifins CleanPaste"
AppWebsite := "www.rifins.com"

; Initialize GUI (NoActivate property for seamless pasting)
MyGui := Gui("+AlwaysOnTop +MinimizeBox +E0x08000000", AppTitle)

; PRO FEATURE: Drag-Anywhere functionality
OnMessage(0x0201, WM_LBUTTONDOWN)
WM_LBUTTONDOWN(wParam, lParam, msg, hwnd) {
    PostMessage(0xA1, 2, , , "ahk_id " hwnd)
}

; Application Interface
MyGui.SetFont("s10 bold")
MyGui.Add("Text", "Center w200", "SEO Text Formatter")

MyGui.SetFont("s9 norm")
MyGui.Add("Button", "w200 h40", "Paste as Plain Text").OnEvent("Click", PastePlain)
MyGui.Add("Button", "w200 h40", "Convert to Title Case").OnEvent("Click", ConvertTitleCase)

; Credit Label
MyGui.SetFont("s8 cBlue", "Inter")
MyGui.Add("Text", "Center w200", AppWebsite).OnEvent("Click", (*) => Run("https://" . AppWebsite))

; Logic: Strip formatting and paste
PastePlain(*) {
    rawText := A_Clipboard
    A_Clipboard := ""
    A_Clipboard := rawText ; Reassigning text strips the rich formatting
    ClipWait(1)
    SendInput("^v")
}

; Logic: Convert to Title Case for SEO Headings
ConvertTitleCase(*) {
    rawText := A_Clipboard
    A_Clipboard := ""
    A_Clipboard := StrTitle(rawText) ; Capitalizes the first letter of each word
    ClipWait(1)
    SendInput("^v")
}

; Handle Close
MyGui.OnEvent("Close", (*) => ExitApp())
MyGui.Show("NoActivate")
