:: right click to run as admin
:: ensure curl is installed


:: netools v1.31.02
@echo off
set DOWNLOAD_URL=https://nettools.net/download/NetTools_v1.32.01.zip
set INSTALL_DIR=C:\Program Files\NetTools
echo Downloading nettools (zip) and installing ...
curl -o "%TEMP%\nettools.zip" "%DOWNLOAD_URL%"
powershell -Command "Expand-Archive -Path '%TEMP%\nettools.zip' -DestinationPath '%INSTALL_DIR%'"
echo NetTools successfully installed.


:: 7-zip
@echo off
set DOWNLOAD_URL=https://www.7-zip.org/a/7z2403-x64.exe
set INSTALL_DIR=C:\Program Files\7-Zip
echo downloading and installing 7-zip
curl -o "%TEMP%\7z_installer.exe" "%DOWNLOAD_URL%"
"%TEMP%\7z_installer.exe" /S /D="%INSTALL_DIR%"
echo 7-zip successfully installed


:: 1. npcap
@echo off
setlocal enabledelayedexpansion
set NPCAP_URL=https://npcap.com/npcap/npcap-1.7.exe
set NPCAP_TEMP_FILE=%TEMP%\npcap_download_page.html
curl -o "%NPCAP_TEMP_FILE%" "%NPCAP_URL%"
for /f "tokens=2 delims='" %%i in ('powershell -command "(Get-Content \"%NPCAP_TEMP_FILE%\") -match 'href=\"(.*?)\"' | Out-Null; $matches[1]"') do (
    set NPCAP_DOWNLOAD_LINK=%%i
)

echo downloading and installing npcap
curl -o "%TEMP%\npcap_installer.exe" "%NPCAP_DOWNLOAD_LINK%"
start "" /wait "%TEMP%\npcap_installer.exe" /S
del "%NPCAP_TEMP_FILE%"
del "%TEMP%\npcap_installer.exe"
echo npcap installation succesffully installed


:: 2. nmap
@echo off
set DOWNLOAD_URL=https://nmap.org/dist/nmap-7.94-setup.exe
set INSTALL_DIR=C:\Program Files\Nmap
echo downloading and installing nmap
curl -o "%TEMP%\nmap-setup.exe" "%DOWNLOAD_URL%"
"%TEMP%\nmap-setup.exe" /S /D="%INSTALL_DIR%"
echo nmap successfully installed


:: firefox
@echo off
setlocal
set "firefox_url=https://download.mozilla.org/?product=firefox-latest&os=win&lang=en-US"
set "install_install_dir=%ProgramFiles%\Mozilla Firefox"
powershell -Command "(New-Object System.Net.WebClient).DownloadFile('%firefox_url%', '%temp_dir%\firefox_installer.exe')"
"%temp_dir%\firefox_installer.exe" -ms
IF NOT %ERRORLEVEL%==0 (
    echo Error: Failed to install Firefox.
    exit /b 1
)
rmdir /q /s "%temp_dir%"


:: google chrome
@echo off
set DOWNLOAD_URL=https://dl.google.com/chrome/install/latest/chrome_installer.exe
set INSTALL_DIR=C:\Program Files\Google\Chrome
echo downloading and installing chrome .. 
curl -o "%TEMP%\chrome_installer.exe" "%DOWNLOAD_URL%"
echo Installing Google Chrome...
"%TEMP%\chrome_installer.exe" --system-level --install
echo google chrome successfully installed


:: adds sysinterals to /system32 folder
@echo off
setlocal enabledelayedexpansion
set SYSINTERNALS_URL=https://download.sysinternals.com/files/
set TEMP_DIR=%TEMP%\SysinternalsTemp
mkdir "%TEMP_DIR%"
curl -o "%TEMP_DIR%\index.html" "%SYSINTERNALS_URL%"
echo downloading and installing sysinternals
for /f "tokens=2 delims=^"" %%i in ('findstr "href=\"SysinternalsSuite\"" "%TEMP_DIR%\index.html"') do (
    set TOOL_NAME=%%i
    set TOOL_NAME=!TOOL_NAME:/=!
    set TOOL_NAME=!TOOL_NAME:-=!
    set TOOL_NAME=!TOOL_NAME:~0,-1!
    
    curl -o "%TEMP_DIR%\!TOOL_NAME!" "%SYSINTERNALS_URL%!TOOL_NAME!"
    move /Y "%TEMP_DIR%\!TOOL_NAME!" "%SystemRoot%\System32\"
)
rmdir /Q /S "%TEMP_DIR%"


:: adobe reader free (without the mcafee bloat)
@echo off
setlocal enabledelayedexpansion
set URL=https://get.adobe.com/reader/download?os=Windows+10^&name=Reader+2024.001.20615+English+Windows^(64Bit^)^&lang=en^&nativeOs=Windows+10^&accepted=^&declined=mss^&preInstalled=^&site=otherversions
set TEMP_FILE=%TEMP%\adobe_reader_download_page.html
curl -o "%TEMP_FILE%" "%URL%"
for /f "tokens=2 delims='" %%i in ('powershell -command "(Get-Content \"%TEMP_FILE%\") -match 'window.location.href = \'(.*?)\'' | Out-Null; $matches[1]"') do (
    set DOWNLOAD_LINK=%%i
)
echo downloading and installing adobe reader free
curl -o "%TEMP%\Reader_en_install.exe" "%DOWNLOAD_LINK%"
start "" /wait "%TEMP%\Reader_en_install.exe" /sAll /rs
del "%TEMP_FILE%"
del "%TEMP%\Reader_en_install.exe"
echo adobe reader free successfully installed

@echo off
setlocal
rem Set the Sysinternals URL
set SYSINTERNALS_URL=https://live.sysinternals.com/
rem Create a folder named "Sysinternals" on the desktop
set DESKTOP_FOLDER=%USERPROFILE%\Desktop\Sysinternals
mkdir "%DESKTOP_FOLDER%" 2>nul
cd /d "%DESKTOP_FOLDER%"
rem Download each file listed
echo Downloading Sysinternals files...
curl -O "%SYSINTERNALS_URL%accesschk.exe"
curl -O "%SYSINTERNALS_URL%accesschk64.exe"
curl -O "%SYSINTERNALS_URL%AccessEnum.exe"
curl -O "%SYSINTERNALS_URL%AdExplorer.chm"
curl -O "%SYSINTERNALS_URL%ADExplorer.exe"
curl -O "%SYSINTERNALS_URL%ADExplorer64.exe"
curl -O "%SYSINTERNALS_URL%ADInsight.chm"
curl -O "%SYSINTERNALS_URL%ADInsight.exe"
curl -O "%SYSINTERNALS_URL%ADInsight64.exe"
curl -O "%SYSINTERNALS_URL%adrestore.exe"
curl -O "%SYSINTERNALS_URL%adrestore64.exe"
curl -O "%SYSINTERNALS_URL%ARM64/"
curl -O "%SYSINTERNALS_URL%Autologon.exe"
curl -O "%SYSINTERNALS_URL%Autologon64.exe"
curl -O "%SYSINTERNALS_URL%autoruns.chm"
curl -O "%SYSINTERNALS_URL%Autoruns.exe"
curl -O "%SYSINTERNALS_URL%Autoruns64.exe"
curl -O "%SYSINTERNALS_URL%autorunsc.exe"
curl -O "%SYSINTERNALS_URL%autorunsc64.exe"
curl -O "%SYSINTERNALS_URL%Bginfo.exe"
curl -O "%SYSINTERNALS_URL%Bginfo64.exe"
curl -O "%SYSINTERNALS_URL%Cacheset.exe"
curl -O "%SYSINTERNALS_URL%Cacheset64.exe"
curl -O "%SYSINTERNALS_URL%Clockres.exe"
curl -O "%SYSINTERNALS_URL%Clockres64.exe"
curl -O "%SYSINTERNALS_URL%Contig.exe"
curl -O "%SYSINTERNALS_URL%Contig64.exe"
curl -O "%SYSINTERNALS_URL%Coreinfo.exe"
curl -O "%SYSINTERNALS_URL%Coreinfo64.exe"
curl -O "%SYSINTERNALS_URL%CPUSTRES.EXE"
curl -O "%SYSINTERNALS_URL%CPUSTRES64.EXE"
curl -O "%SYSINTERNALS_URL%ctrl2cap.amd.sys"
curl -O "%SYSINTERNALS_URL%ctrl2cap.exe"
curl -O "%SYSINTERNALS_URL%Dbgview.chm"
curl -O "%SYSINTERNALS_URL%Dbgview.exe"
curl -O "%SYSINTERNALS_URL%dbgview64.exe"
curl -O "%SYSINTERNALS_URL%Desktops.exe"
curl -O "%SYSINTERNALS_URL%Desktops64.exe"
curl -O "%SYSINTERNALS_URL%Disk2vhd.chm"
curl -O "%SYSINTERNALS_URL%disk2vhd.exe"
curl -O "%SYSINTERNALS_URL%disk2vhd64.exe"
curl -O "%SYSINTERNALS_URL%diskext.exe"
curl -O "%SYSINTERNALS_URL%diskext64.exe"
curl -O "%SYSINTERNALS_URL%Diskmon.exe"
curl -O "%SYSINTERNALS_URL%Diskmon64.exe"
curl -O "%SYSINTERNALS_URL%DiskView.exe"
curl -O "%SYSINTERNALS_URL%DiskView64.exe"
curl -O "%SYSINTERNALS_URL%du.exe"
curl -O "%SYSINTERNALS_URL%du64.exe"
curl -O "%SYSINTERNALS_URL%efsdump.exe"
curl -O "%SYSINTERNALS_URL%Eula.txt"
curl -O "%SYSINTERNALS_URL%files/"
curl -O "%SYSINTERNALS_URL%FindLinks.exe"
curl -O "%SYSINTERNALS_URL%FindLinks64.exe"
curl -O "%SYSINTERNALS_URL%handle.exe"
curl -O "%SYSINTERNALS_URL%handle64.exe"
curl -O "%SYSINTERNALS_URL%healthmonitoring.html"
curl -O "%SYSINTERNALS_URL%hex2dec.exe"
curl -O "%SYSINTERNALS_URL%hex2dec64.exe"
curl -O "%SYSINTERNALS_URL%junction.exe"
curl -O "%SYSINTERNALS_URL%junction64.exe"
curl -O "%SYSINTERNALS_URL%ldmdump.exe"
curl -O "%SYSINTERNALS_URL%Listdlls.exe"
curl -O "%SYSINTERNALS_URL%Listdlls64.exe"
curl -O "%SYSINTERNALS_URL%livekd.exe"
curl -O "%SYSINTERNALS_URL%livekd64.exe"
curl -O "%SYSINTERNALS_URL%LoadOrd.exe"
curl -O "%SYSINTERNALS_URL%LoadOrd64.exe"
curl -O "%SYSINTERNALS_URL%LoadOrdC.exe"
curl -O "%SYSINTERNALS_URL%LoadOrdC64.exe"
curl -O "%SYSINTERNALS_URL%logonsessions.exe"
curl -O "%SYSINTERNALS_URL%logonsessions64.exe"
curl -O "%SYSINTERNALS_URL%movefile.exe"
curl -O "%SYSINTERNALS_URL%movefile64.exe"
curl -O "%SYSINTERNALS_URL%notmyfault.exe"
curl -O "%SYSINTERNALS_URL%notmyfault64.exe"
curl -O "%SYSINTERNALS_URL%notmyfaultc.exe"
curl -O "%SYSINTERNALS_URL%notmyfaultc64.exe"
curl -O "%SYSINTERNALS_URL%ntfsinfo.exe"
curl -O "%SYSINTERNALS_URL%ntfsinfo64.exe"
curl -O "%SYSINTERNALS_URL%pendmoves.exe"
curl -O "%SYSINTERNALS_URL%pendmoves64.exe"
curl -O "%SYSINTERNALS_URL%pipelist.exe"
curl -O "%SYSINTERNALS_URL%pipelist64.exe"
curl -O "%SYSINTERNALS_URL%portmon.exe"
curl -O "%SYSINTERNALS_URL%procdump.exe"
curl -O "%SYSINTERNALS_URL%procdump64.exe"
curl -O "%SYSINTERNALS_URL%procexp.chm"
curl -O "%SYSINTERNALS_URL%procexp.exe"
curl -O "%SYSINTERNALS_URL%procexp64.exe"
curl -O "%SYSINTERNALS_URL%procmon.chm"
curl -O "%SYSINTERNALS_URL%Procmon.exe"
curl -O "%SYSINTERNALS_URL%Procmon64.exe"
curl -O "%SYSINTERNALS_URL%PsExec.exe"
curl -O "%SYSINTERNALS_URL%PsExec64.exe"
curl -O "%SYSINTERNALS_URL%psfile.exe"
curl -O "%SYSINTERNALS_URL%psfile64.exe"
curl -O "%SYSINTERNALS_URL%PsGetsid.exe"
curl -O "%SYSINTERNALS_URL%PsGetsid64.exe"
curl -O "%SYSINTERNALS_URL%PsInfo.exe"
curl -O "%SYSINTERNALS_URL%PsInfo64.exe"
curl -O "%SYSINTERNALS_URL%pskill.exe"
curl -O "%SYSINTERNALS_URL%pskill64.exe"
curl -O "%SYSINTERNALS_URL%pslist.exe"
curl -O "%SYSINTERNALS_URL%pslist64.exe"
curl -O "%SYSINTERNALS_URL%PsLoggedon.exe"
curl -O "%SYSINTERNALS_URL%PsLoggedon64.exe"
curl -O "%SYSINTERNALS_URL%psloglist.exe"
curl -O "%SYSINTERNALS_URL%psloglist64.exe"
curl -O "%SYSINTERNALS_URL%pspasswd.exe"
curl -O "%SYSINTERNALS_URL%pspasswd64.exe"
curl -O "%SYSINTERNALS_URL%psping.exe"
curl -O "%SYSINTERNALS_URL%psping64.exe"
curl -O "%SYSINTERNALS_URL%PsService.exe"
curl -O "%SYSINTERNALS_URL%PsService64.exe"
curl -O "%SYSINTERNALS_URL%psshutdown.exe"
curl -O "%SYSINTERNALS_URL%psshutdown64.exe"
curl -O "%SYSINTERNALS_URL%pssuspend.exe"
curl -O "%SYSINTERNALS_URL%pssuspend64.exe"
curl -O "%SYSINTERNALS_URL%Pstools.chm"
curl -O "%SYSINTERNALS_URL%psversion.txt"
curl -O "%SYSINTERNALS_URL%RAMMap.exe"
curl -O "%SYSINTERNALS_URL%RAMMap64.exe"
curl -O "%SYSINTERNALS_URL%RDCMan.exe"
curl -O "%SYSINTERNALS_URL%readme.txt"
curl -O "%SYSINTERNALS_URL%RegDelNull.exe"
curl -O "%SYSINTERNALS_URL%RegDelNull64.exe"
curl -O "%SYSINTERNALS_URL%Reghide.exe"
curl -O "%SYSINTERNALS_URL%regjump.exe"
curl -O "%SYSINTERNALS_URL%RootkitRevealer.chm"
curl -O "%SYSINTERNALS_URL%RootkitRevealer.exe"
curl -O "%SYSINTERNALS_URL%ru.exe"
curl -O "%SYSINTERNALS_URL%ru64.exe"
curl -O "%SYSINTERNALS_URL%sdelete.exe"
curl -O "%SYSINTERNALS_URL%sdelete64.exe"
curl -O "%SYSINTERNALS_URL%ShareEnum.exe"
curl -O "%SYSINTERNALS_URL%ShareEnum64.exe"
curl -O "%SYSINTERNALS_URL%ShellRunas.exe"
curl -O "%SYSINTERNALS_URL%sigcheck.exe"
curl -O "%SYSINTERNALS_URL%sigcheck64.exe"
curl -O "%SYSINTERNALS_URL%streams.exe"
curl -O "%SYSINTERNALS_URL%streams64.exe"
curl -O "%SYSINTERNALS_URL%strings.exe"
curl -O "%SYSINTERNALS_URL%strings64.exe"
curl -O "%SYSINTERNALS_URL%sync.exe"
curl -O "%SYSINTERNALS_URL%sync64.exe"
curl -O "%SYSINTERNALS_URL%Sysmon.exe"
curl -O "%SYSINTERNALS_URL%Sysmon64.exe"
curl -O "%SYSINTERNALS_URL%tcpvcon.exe"
curl -O "%SYSINTERNALS_URL%tcpvcon64.exe"
curl -O "%SYSINTERNALS_URL%tcpview.chm"
curl -O "%SYSINTERNALS_URL%tcpview.exe"
curl -O "%SYSINTERNALS_URL%tcpview64.exe"
curl -O "%SYSINTERNALS_URL%Testlimit.exe"
curl -O "%SYSINTERNALS_URL%Testlimit64.exe"
curl -O "%SYSINTERNALS_URL%tools/"
curl -O "%SYSINTERNALS_URL%Vmmap.chm"
curl -O "%SYSINTERNALS_URL%vmmap.exe"
curl -O "%SYSINTERNALS_URL%vmmap64.exe"
curl -O "%SYSINTERNALS_URL%Volumeid.exe"
curl -O "%SYSINTERNALS_URL%Volumeid64.exe"
curl -O "%SYSINTERNALS_URL%whois.exe"
curl -O "%SYSINTERNALS_URL%whois64.exe"
curl -O "%SYSINTERNALS_URL%Winobj.exe"
curl -O "%SYSINTERNALS_URL%Winobj64.exe"
curl -O "%SYSINTERNALS_URL%ZoomIt.exe"
curl -O "%SYSINTERNALS_URL%ZoomIt64.exe"

:: check path

echo %PATH% | findstr /i /c:"%SYSINTERNALS_FOLDER%" > nul
if %ERRORLEVEL% equ 0 (
    echo Sysinternals folder is already in the PATH.
    exit /b 0
)

setx PATH "%PATH%;%SYSINTERNALS_FOLDER%" /m
echo successfully installed windows sysinterals in "desktop\%DESKTOP_FOLDER%" and added to $PATH