[CmdletBinding()]
Param (
  [Parameter(Mandatory=$True,Position=0)]
  [string]$searchFor
)
$paths = Get-ChildItem Registry::HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall;
foreach($path in $paths) {
    if ($path.PSChildName.startsWith("{")) {
        $displayName = (Get-ItemProperty -Path Registry::$path -Name DisplayName).DisplayName;
        if ($displayName.toLower().contains($searchFor)) {
            $uninstallString = (Get-ItemProperty -Path Registry::$path -Name UninstallString).UninstallString;
            $uninstallString = $uninstallString.replace("MsiExec.exe /I", "");
            msiexec.exe /X $uninstallString /quiet /norestart;
        }
    }
}
