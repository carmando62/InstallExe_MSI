. .\mcPSFunctions.ps1

<# Examples..
$appInstaller = 'Firefox Setup 64.0.exe'
$appName=  'Firefox'
$appVer = '64.0'
$appArgs = @('/S','/INI="firefox_quiet_install.ini"')

$appInstaller = "AcroRdr20151500630033_MUI.exe"
$appName= 'Acrobat Reader'
$appVer = '2.0.1'
$appArgs = @('/sAll', '/rs', '/l', '/msi', '/qn', 'ALLUSERS=2', 'EULA_ACCEPT=YES', 'REMOVE_PREVIOUS=YES', 'DISABLE_ARM_SERVICE_INSTALL=1', 'UPDATE_MODE=0', 'SUPPRESS_APP_LAUNCH=YES')
#>


$appInstaller = 'Firefox Setup 64.0.exe'
$appName=  'Firefox'
$appVer = '64.0'
$appArgs = @('/S','/INI="firefox_quiet_install.ini"')
Install-Exe -appInstaller $appInstaller -arguments $appArgs -appName $appName -appVer $appVer
