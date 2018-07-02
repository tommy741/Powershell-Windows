Set oFSO = CreateObject("Scripting.FileSystemObject")
Set oShell = WScript.CreateObject("WScript.Shell")

If
oFSO.FileExists(oShell.ExpandEnviromentStrings("%APPDATA%\.......\test.gng")) Then
    WScript.StdOut.Write "The application is installed"
    WScript.Quite(0)
Else
    WScript.Quite(0)
    End If
