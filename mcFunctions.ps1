Function Test-AppInstalled {
    # Get-AppInstalled $appName for exact match or for a wildcard or "Like" use Get-AppInstalled -Like $appName
    Param(
    [cmdletbinding()]
    [parameter(Mandatory=$true)]
    [String[]]$appName,
    [Switch]$Like)

    if($Like){
        $installed = (Get-ChildItem -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall, HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall | Get-ItemProperty | Where-Object { $_.DisplayName -Like "*$appName*" } ) 
    } else {
        $installed = (Get-ChildItem -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall, HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall | Get-ItemProperty | Where-Object { $_.DisplayName -eq "$appName" } ) 
    }
    if($installed) {
        return $true
    } else {
        return $false
    }
}

Function Install-MSI ($appInstaller, $arguments, $appName, $appVer) {
  #example argument format to pass $appArgs = @('/S','/INI="firefox_quiet_install.ini"')
    
    # Install
    $someText = "->{0,-11} {1,-24} `t" -f " Installing", "$appName $appVer"
    Write-host -NoNewline $someText -ForegroundColor Cyan

    $arglist= "/i " + "$installerName " + "$arguments"
    Start-Process -filepath msiexec.exe -ArgumentList $arglist -ErrorAction SilentlyContinue -Wait -NoNewWindow -PassThru -WindowStyle Hidden | out-null
    

    # Check status of install
    $installed = Test-AppInstalled "$appName" -Like
    $installStatus = $null
    $statusColor = $null
    if($installed -eq $true){
        $installStatus = 'Successful'
        $statusColor = 'Yellow'
    } else {
        $installStatus = 'Failed'
        $statusColor = 'Red'
    }

    Write-Host $installStatus -ForegroundColor $statusColor

} # end of function

Function Install-Exe ($appInstaller, $arguments, $appName, $appVer) {
  #example argument format to pass $appArgs = @('/S','/INI="firefox_quiet_install.ini"')
    
    # Install
    $someText = "->{0,-11} {1,-24} `t" -f " Installing", "$appName $appVer"
    Write-host -NoNewline $someText -ForegroundColor Cyan
    Start-Process $appInstaller -argumentList $arguments -ErrorAction SilentlyContinue -Wait -NoNewWindow -PassThru -WindowStyle Hidden | out-null

    # Check status of install
    $installed = Test-AppInstalled "$appName" -Like
    $installStatus = $null
    $statusColor = $null
    if($installed -eq $true){
        $installStatus = 'Successful'
        $statusColor = 'Yellow'
    } else {
        $installStatus = 'Failed'
        $statusColor = 'Red'
    }

    Write-Host $installStatus -ForegroundColor $statusColor

} # end of function
