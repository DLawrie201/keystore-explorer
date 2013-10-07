;========================================================================
;
; Copyright 2004 - 2013 Wayne Grant
;           2013 Kai Kramer
; 
; This file is part of KeyStore Explorer.
; 
; KeyStore Explorer is free software: you can redistribute it and/or modify
; it under the terms of the GNU General Public License as published by
; the Free Software Foundation, either version 3 of the License, or
; (at your option) any later version.
; 
; KeyStore Explorer is distributed in the hope that it will be useful,
; but WITHOUT ANY WARRANTY; without even the implied warranty of
; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
; GNU General Public License for more details.
; 
; You should have received a copy of the GNU General Public License
; along with KeyStore Explorer. If not, see <http://www.gnu.org/licenses/>.
;
;========================================================================

;=================================;
;                                 ;
;  Install for Key Store Explorer ;
;                                 ;
;=================================;

;--------------------------------
; Includes
;--------------------------------

; Modern interface
!include "MUI.nsh"

;--------------------------------
; Globals
;--------------------------------

 BrandingText "Copyright 2004 - 2013 Wayne Grant, 2013 Kai Kramer"

; Product name
!define PRODUCT "KeyStore Explorer"

; Product version
!define VERSION "5.0"

; Product key (name and version)
!define PRODUCT_KEY "${PRODUCT} ${VERSION}"

; AppUserModelId (see http://stackoverflow.com/questions/5438651/launch4j-nsis-and-duplicate-pinned-windows-7-taskbar-icons)
!define MyApp_AppUserModelId "SourceForge.KeyStoreExplorer"

; Product home page address
!define HOME_PAGE_ADDRESS "http://keystore-explorer.sf.net"

; Records if file associations are required for ks/jks/jceks/keystore files
!define KSJKS_FILE_ASSOC $1

; Records if file associations are required for p12/pfx (PKCS #12) files
!define PKCS12_FILE_ASSOC $2

; Records if file associations are required for BC bks/uber files
!define KSBC_FILE_ASSOC $3

; File Associations custom dialog
!define FILE_ASSOC_TITLE "File Associations"
!define FILE_ASSOC_SUBTITLE "Select the file types to associate with ${PRODUCT}."
!define FILE_ASSOCIATIONS_DIALOG fileAssociations.ini
ReserveFile ${FILE_ASSOCIATIONS_DIALOG}

; License text
!define LICENSE_FILE "../res/licenses/license-kse.txt"

; Files to install
!define KSE_EXE "kse.exe"
!define KSE_JAR "kse.jar"
!define BCPKIX_JAR "bcpkix.jar"
!define BCPROV_JAR "bcprov.jar"
!define JH_JAR "jhall.jar"
!define JGOODIES_LOOKS_JAR "jgoodies-looks.jar"
!define JGOODIES_COMMON_JAR "jgoodies-common.jar"
!define MIG_LAYOUT_CORE_JAR "miglayout-core.jar"
!define MIG_LAYOUT_SWING_JAR "miglayout-swing.jar"
!define JNA_JAR "jna.jar"
!define KSE_ICO "kse.ico"
!define KEYSTORE_ICO "keystore.ico"
!define WWW_ICO "www.ico"
!define LICENSES_ICO "licenses.ico"
;!define INSTALL_ICO "install.ico"
;!define UNINSTALL_ICO "uninstall.ico"
!define LICENSE_DIR "licenses"
!define UNINSTALL_EXE "uninstall.exe"

; Used by RefreshShellIcons function
!define SHCNE_ASSOCCHANGED 0x08000000
!define SHCNF_IDLIST 0

; Install icon
;!define MUI_ICON "..\res\icons\${INSTALL_ICO}"

; Uninstall icon
;!define MUI_UNICON "..\res\icons\${UNINSTALL_ICO}"

; Required for menu shortcuts to be removed on uninstall
RequestExecutionLevel admin

;--------------------------------
; Customize install L&F
;--------------------------------

; The name of the installer
Name "${PRODUCT} ${VERSION}"

; Install file to create
OutFile "..\dist\kse-50-setup.exe"

; Only one component therefore no customization is required
InstType /NOCUSTOM

; Include XP stuff
XPStyle on

; The text to prompt the user to enter a directory
DirText "Choose a directory to install to:"

; The default installation directory
InstallDir "$PROGRAMFILES\${PRODUCT_KEY}"

; Show details of install
ShowInstDetails Show

; Install details background co lour
InstallColors ffffff 123456

; Registry key to check for directory (so if you install again, it will overwrite the old one automatically)
InstallDirRegKey HKLM "SOFTWARE\${PRODUCT_KEY}" "Install_Dir"

; Text to show before uninstall
UninstallText "This will uninstall ${PRODUCT_KEY}. Hit Uninstall to continue."

; Show details of uninstall
ShowUninstDetails Show

; Side panel image for install/uninstall
!define MUI_WELCOMEFINISHPAGE_BITMAP "side.bmp"
!define MUI_UNWELCOMEFINISHPAGE_BITMAP "side.bmp"

; Header image for install/uninstall
!define MUI_HEADERIMAGE
!define MUI_HEADERIMAGE_BITMAP "header.bmp"

;--------------------------------
; Page order
;--------------------------------

; Install

!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_LICENSE ${LICENSE_FILE}
Page custom fileAssociationsPage "" ": File Associations"
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH

; Uninstall

!insertmacro MUI_UNPAGE_WELCOME
!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES
!insertmacro MUI_UNPAGE_FINISH

;--------------------------------
; Languages
;--------------------------------

!insertmacro MUI_LANGUAGE "English"

;--------------------------------
; Install Sections (only one)
;--------------------------------
Section "${PRODUCT}"

    ; Set output path to the installation directory.
    SetOutPath "$INSTDIR"

    ; Files to install
    File "..\dist\${KSE_EXE}"
    File "..\dist\${KSE_JAR}"
    File "..\dist\${BCPKIX_JAR}"
    File "..\dist\${BCPROV_JAR}"
    File "..\dist\${JH_JAR}"
    File "..\dist\${JGOODIES_LOOKS_JAR}"
    File "..\dist\${JGOODIES_COMMON_JAR}"
    File "..\dist\${MIG_LAYOUT_CORE_JAR}"
    File "..\dist\${MIG_LAYOUT_SWING_JAR}"
    File "..\dist\${JNA_JAR}"
    File "..\res\icons\${KSE_ICO}"
    File "..\res\icons\${KEYSTORE_ICO}"
    File "..\res\icons\${WWW_ICO}"
    File "..\res\icons\${LICENSES_ICO}"
    CreateDirectory $INSTDIR\${LICENSE_DIR}
    File /oname=${LICENSE_DIR}\bouncycastle.txt "..\res\licenses\license-bouncycastle.txt"
    File /oname=${LICENSE_DIR}\javahelp.txt "..\res\licenses\license-javahelp.txt"
    File /oname=${LICENSE_DIR}\jgoodies.txt "..\res\licenses\license-jgoodies.txt"
    File /oname=${LICENSE_DIR}\kse.txt "..\res\licenses\license-kse.txt"
    File /oname=${LICENSE_DIR}\miglayout.txt "..\res\licenses\license-miglayout.txt"
    File /oname=${LICENSE_DIR}\jna.txt "..\res\licenses\license-jna.txt"

    ; Write the installation path into the registry
    WriteRegStr HKLM "SOFTWARE\${PRODUCT_KEY}" "Install_Dir" "$INSTDIR"

    ; Write the uninstall keys for Windows
    WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_KEY}" "DisplayName" "${PRODUCT_KEY}"
    WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_KEY}" "UninstallString" "$INSTDIR\${UNINSTALL_EXE}"

    ; Create uninstall
    WriteUninstaller "${UNINSTALL_EXE}"

    ; Create program shortcuts to KeyStore Explorer, KeyStore Explorer home page and the uninstall
    CreateDirectory "$SMPROGRAMS\${PRODUCT_KEY}"
    CreateShortCut "$SMPROGRAMS\${PRODUCT_KEY}\Uninstall.lnk" "$INSTDIR\${UNINSTALL_EXE}" "" "$INSTDIR\${UNINSTALL_EXE}" 0
    CreateShortCut "$SMPROGRAMS\${PRODUCT_KEY}\Visit Website.lnk" "${HOME_PAGE_ADDRESS}" "" "$INSTDIR\${WWW_ICO}" 0
    CreateShortCut "$SMPROGRAMS\${PRODUCT_KEY}\Licenses.lnk" "$INSTDIR\licenses" "" "$INSTDIR\${LICENSES_ICO}" 0
    CreateShortCut "$SMPROGRAMS\${PRODUCT_KEY}\${PRODUCT_KEY}.lnk" "$INSTDIR\${KSE_EXE}" "" "$INSTDIR\${KSE_EXE}" 0
    
    ; Add AppModelUserID to app shortcut (so KSE can be pinned to taskbar under Windows Vista, 7 and 8)
    WinShell::SetLnkAUMI "$SMPROGRAMS\${PRODUCT_KEY}\${PRODUCT_KEY}.lnk" "${MyApp_AppUserModelId}"

    ; Create file associations in registry if required
    StrCmp "${KSJKS_FILE_ASSOC}" "1" ksjksfileassoc noksjksfileassoc
    ksjksfileassoc:
        WriteRegStr HKCR ".ks" "" "Java KeyStore"
        WriteRegStr HKCR ".jks" "" "Java KeyStore"
        WriteRegStr HKCR ".jceks" "" "Java KeyStore"
        WriteRegStr HKCR ".keystore" "" "Java KeyStore"
        WriteRegStr HKCR "Java KeyStore\DefaultIcon" "" "$INSTDIR\${KEYSTORE_ICO}"
        WriteRegStr HKCR "Java KeyStore\shell\open\command" "" '"$INSTDIR\${KSE_EXE}" "%1"'
        Call RefreshShellIcons
    noksjksfileassoc:

    StrCmp "${PKCS12_FILE_ASSOC}" "1" pkcs12fileassoc nopkcs12fileassoc
    pkcs12fileassoc:
        WriteRegStr HKCR "PFXFile\shell\open\command" "" '"$INSTDIR\${KSE_EXE}" "%1"'
    nopkcs12fileassoc:

    ; Create file associations in registry if required
    StrCmp "${KSBC_FILE_ASSOC}" "1" ksbcfileassoc noksbcfileassoc
    ksbcfileassoc:
        WriteRegStr HKCR ".bks" "" "Java BC KeyStore"
        WriteRegStr HKCR ".uber" "" "Java BC KeyStore"
        WriteRegStr HKCR "Java BC KeyStore\DefaultIcon" "" "$INSTDIR\${KEYSTORE_ICO}"
        WriteRegStr HKCR "Java BC KeyStore\shell\open\command" "" '"$INSTDIR\${KSE_EXE}" "%1"'
        Call RefreshShellIcons
    noksbcfileassoc:

    ; Ask if a shortcut is required on the desktop
    MessageBox MB_YESNO "Do you want a shortcut to KeyStore Explorer to be placed on the desktop?" IDNO NoShortcut
        CreateShortCut "$DESKTOP\${PRODUCT_KEY}.lnk" "$INSTDIR\${KSE_EXE}" "" "$INSTDIR\${KSE_EXE}" 0
    NoShortcut:

SectionEnd

;--------------------------------
; Uninstall section
;--------------------------------
Section "Uninstall"

	; Remove AppUserModelId
	WinShell::UninstAppUserModelId "${MyApp_AppUserModelId}"
	WinShell::UninstShortcut "$SMPROGRAMS\${PRODUCT_KEY}\${PRODUCT_KEY}.lnk"

    ; Remove registry keys
    DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_KEY}"
    DeleteRegKey HKLM "Software\${PRODUCT_KEY}"

    ; Remove installed files
    Delete "$INSTDIR\${KSE_EXE}"
    Delete "$INSTDIR\${KSE_JAR}"
    Delete "$INSTDIR\${BCPKIX_JAR}"
    Delete "$INSTDIR\${BCPROV_JAR}"
    Delete "$INSTDIR\${JH_JAR}"
    Delete "$INSTDIR\${JGOODIES_LOOKS_JAR}"
    Delete "$INSTDIR\${JGOODIES_COMMON_JAR}"
    Delete "$INSTDIR\${MIG_LAYOUT_CORE_JAR}"
    Delete "$INSTDIR\${MIG_LAYOUT_SWING_JAR}"
    Delete "$INSTDIR\${JNA_JAR}"
    Delete "$INSTDIR\${KSE_ICO}"
    Delete "$INSTDIR\${KEYSTORE_ICO}"
    Delete "$INSTDIR\${WWW_ICO}"
    Delete "$INSTDIR\${LICENSES_ICO}"
    RmDir /r "$INSTDIR\${LICENSE_DIR}"
    Delete "$INSTDIR\${UNINSTALL_EXE}"

    ; Remove install directory (not /r - will only be removed if user did not modify it's contents)
    RmDir "$INSTDIR"

    ; Remove shortcuts
    Rmdir /r "$SMPROGRAMS\${PRODUCT_KEY}"

    ; Desktop shortcut may not exist
    IfFileExists "$DESKTOP\${PRODUCT_KEY}.lnk" deleteshortcut nodeleteshortcut
    deleteshortcut:
        Delete "$DESKTOP\${PRODUCT_KEY}.lnk"
    nodeleteshortcut:

    ; Remove file associations from registry (doesn't matter if they're not there)
    DeleteRegKey HKCR ".ks"
    DeleteRegKey HKCR ".jks"
    DeleteRegKey HKCR ".jceks"
    DeleteRegKey HKCR ".keystore"
    DeleteRegKey HKCR ".bks"
    DeleteRegKey HKCR ".uber"
    DeleteRegKey HKCR "Java KeyStore"
    DeleteRegKey HKCR "Java BC KeyStore"
    DeleteregKey HKCR "PFXFile\shell\open"

SectionEnd

;--------------------------------
; Functions
;--------------------------------

;
; Display splash screen and initialise file associations to be true
;
Function .onInit

    advsplash::show 2000 350 187 -1 splash
    Pop $3 ; Ignore return value

    StrCpy ${KSJKS_FILE_ASSOC} 1
    StrCpy ${PKCS12_FILE_ASSOC} 1
    StrCpy ${KSBC_FILE_ASSOC} 1

FunctionEnd

;
; Displays custom dialog to get file associations
;
Function fileAssociationsPage

    !insertmacro MUI_HEADER_TEXT "${FILE_ASSOC_TITLE}" "${FILE_ASSOC_SUBTITLE}"

    ; Get dialog ini file
    GetTempFileName $R0
    File /oname=$R0 ${FILE_ASSOCIATIONS_DIALOG}

    ; Populate dialog with any previously entered values (will initially be selected)
    WriteINIStr "$R0" "Field 2" "State" "${KSJKS_FILE_ASSOC}"
    WriteINIStr "$R0" "Field 3" "State" "${PKCS12_FILE_ASSOC}"
    WriteINIStr "$R0" "Field 4" "State" "${KSBC_FILE_ASSOC}"

    ; Display dialog
    InstallOptions::dialog $R0
    Pop $R1

    ReadINIStr "${KSJKS_FILE_ASSOC}" "$R0" "Field 2" "State"
    ReadINIStr "${PKCS12_FILE_ASSOC}" "$R0" "Field 3" "State"
    ReadINIStr "${KSBC_FILE_ASSOC}" "$R0" "Field 4" "State"

    Delete $R0 ; Clean up

FunctionEnd

;
; Refresh icons (after file association creation)
;
Function RefreshShellIcons

  System::Call 'shell32.dll::SHChangeNotify(l, l, i, i) v \
  (${SHCNE_ASSOCCHANGED}, ${SHCNF_IDLIST}, 0, 0)'

FunctionEnd