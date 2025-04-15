{ inputs, ... }: {
  imports = [ inputs.plasma-manager.homeManagerModules.plasma-manager ];
  programs.plasma = {
    enable = true;
    shortcuts = {
      "ActivityManager"."switch-to-activity-ba536fc0-033d-4650-aad9-190e4892e3e4" = "none";
      "KDE Keyboard Layout Switcher"."Switch keyboard layout to English (US)" = "none";
      "KDE Keyboard Layout Switcher"."Switch keyboard layout to English (Workman)" = "none";
      "KDE Keyboard Layout Switcher"."Switch to Last-Used Keyboard Layout" = "Meta+Alt+L";
      "KDE Keyboard Layout Switcher"."Switch to Next Keyboard Layout" = "\\\\, Meta+Alt+K\\\\, \\,Meta+Alt+K";
      "kaccess"."Toggle Screen Reader On and Off" = "Meta+Alt+S";
      "kcm_touchpad"."Disable Touchpad" = "Touchpad Off";
      "kcm_touchpad"."Enable Touchpad" = "Touchpad On";
      "kcm_touchpad"."Toggle Touchpad" = [ "Touchpad Toggle" "Meta+Ctrl+Touchpad Toggle" "" "" "" "Meta+Ctrl+Zenkaku Hankaku\\,Touchpad Toggle" "Touchpad Toggle" "Meta+Ctrl+Touchpad Toggle" "Meta+Ctrl+Zenkaku Hankaku" ];
      "kmix"."decrease_microphone_volume" = "Microphone Volume Down";
      "kmix"."decrease_volume" = "Volume Down";
      "kmix"."decrease_volume_small" = "Shift+Volume Down";
      "kmix"."increase_microphone_volume" = "Microphone Volume Up";
      "kmix"."increase_volume" = "Volume Up";
      "kmix"."increase_volume_small" = "Shift+Volume Up";
      "kmix"."mic_mute" = [ "Microphone Mute" "" "Meta+Volume Mute\\\\, \\,Microphone Mute" "Meta+Volume Mute\\,Mute Microphone" ];
      "kmix"."mute" = "Volume Mute";
      "ksmserver"."Halt Without Confirmation" = "none";
      "ksmserver"."Lock Session" = [ "Meta+L" "" "Screensaver\\\\, \\,Meta+L" "Screensaver\\,Lock Session" ];
      "ksmserver"."Log Out" = "Ctrl+Alt+Del";
      "ksmserver"."Log Out Without Confirmation" = "none";
      "ksmserver"."LogOut" = "none";
      "ksmserver"."Reboot" = "none";
      "ksmserver"."Reboot Without Confirmation" = "none";
      "ksmserver"."Shut Down" = "none";
      "kwin"."Activate Window Demanding Attention" = "Meta+Ctrl+A";
      "kwin"."Cycle Overview" = "none";
      "kwin"."Cycle Overview Opposite" = "none";
      "kwin"."Decrease Opacity" = "none";
      "kwin"."Edit Tiles" = "Meta+T";
      "kwin"."Expose" = "Ctrl+F9";
      "kwin"."ExposeAll" = [ "Ctrl+F10" "" "Launch (C)\\\\, \\,Ctrl+F10" "Launch (C)\\,Toggle Present Windows (All desktops)" ];
      "kwin"."ExposeClass" = "Ctrl+F7";
      "kwin"."ExposeClassCurrentDesktop" = "none";
      "kwin"."Grid View" = "Meta+G";
      "kwin"."Increase Opacity" = "none";
      "kwin"."Kill Window" = "Meta+Ctrl+Esc";
      "kwin"."Move Tablet to Next Output" = "none";
      "kwin"."MoveMouseToCenter" = "Meta+F6";
      "kwin"."MoveMouseToFocus" = "Meta+F5";
      "kwin"."MoveZoomDown" = "none";
      "kwin"."MoveZoomLeft" = "none";
      "kwin"."MoveZoomRight" = "none";
      "kwin"."MoveZoomUp" = "none";
      "kwin"."Overview" = "Meta+W";
      "kwin"."Setup Window Shortcut" = "none";
      "kwin"."Show Desktop" = "Meta+D";
      "kwin"."Switch One Desktop Down" = "Meta+Ctrl+Down";
      "kwin"."Switch One Desktop Up" = "Meta+Ctrl+Up";
      "kwin"."Switch One Desktop to the Left" = "Meta+Ctrl+Left";
      "kwin"."Switch One Desktop to the Right" = "Meta+Ctrl+Right";
      "kwin"."Switch Window Down" = "Meta+Alt+Down";
      "kwin"."Switch Window Left" = "Meta+Alt+Left";
      "kwin"."Switch Window Right" = "Meta+Alt+Right";
      "kwin"."Switch Window Up" = "Meta+Alt+Up";
      "kwin"."Switch to Desktop 1" = "Ctrl+F1";
      "kwin"."Switch to Desktop 10" = "none";
      "kwin"."Switch to Desktop 11" = "none";
      "kwin"."Switch to Desktop 12" = "none";
      "kwin"."Switch to Desktop 13" = "none";
      "kwin"."Switch to Desktop 14" = "none";
      "kwin"."Switch to Desktop 15" = "none";
      "kwin"."Switch to Desktop 16" = "none";
      "kwin"."Switch to Desktop 17" = "none";
      "kwin"."Switch to Desktop 18" = "none";
      "kwin"."Switch to Desktop 19" = "none";
      "kwin"."Switch to Desktop 2" = "Ctrl+F2";
      "kwin"."Switch to Desktop 20" = "none";
      "kwin"."Switch to Desktop 3" = "Ctrl+F3";
      "kwin"."Switch to Desktop 4" = "Ctrl+F4";
      "kwin"."Switch to Desktop 5" = "none";
      "kwin"."Switch to Desktop 6" = "none";
      "kwin"."Switch to Desktop 7" = "none";
      "kwin"."Switch to Desktop 8" = "none";
      "kwin"."Switch to Desktop 9" = "none";
      "kwin"."Switch to Next Desktop" = "none";
      "kwin"."Switch to Next Screen" = "none";
      "kwin"."Switch to Previous Desktop" = "none";
      "kwin"."Switch to Previous Screen" = "none";
      "kwin"."Switch to Screen 0" = "none";
      "kwin"."Switch to Screen 1" = "none";
      "kwin"."Switch to Screen 2" = "none";
      "kwin"."Switch to Screen 3" = "none";
      "kwin"."Switch to Screen 4" = "none";
      "kwin"."Switch to Screen 5" = "none";
      "kwin"."Switch to Screen 6" = "none";
      "kwin"."Switch to Screen 7" = "none";
      "kwin"."Switch to Screen Above" = "none";
      "kwin"."Switch to Screen Below" = "none";
      "kwin"."Switch to Screen to the Left" = "none";
      "kwin"."Switch to Screen to the Right" = "none";
      "kwin"."Toggle Night Color" = "none";
      "kwin"."Toggle Window Raise/Lower" = "none";
      "kwin"."Walk Through Windows" = "Alt+Tab";
      "kwin"."Walk Through Windows (Reverse)" = "Alt+Shift+Tab";
      "kwin"."Walk Through Windows Alternative" = "none";
      "kwin"."Walk Through Windows Alternative (Reverse)" = "none";
      "kwin"."Walk Through Windows of Current Application" = "Alt+`";
      "kwin"."Walk Through Windows of Current Application (Reverse)" = "Alt+~";
      "kwin"."Walk Through Windows of Current Application Alternative" = "none";
      "kwin"."Walk Through Windows of Current Application Alternative (Reverse)" = "none";
      "kwin"."Window Above Other Windows" = "none";
      "kwin"."Window Below Other Windows" = "none";
      "kwin"."Window Close" = "Alt+F4";
      "kwin"."Window Custom Quick Tile Bottom" = "none";
      "kwin"."Window Custom Quick Tile Left" = "none";
      "kwin"."Window Custom Quick Tile Right" = "none";
      "kwin"."Window Custom Quick Tile Top" = "none";
      "kwin"."Window Fullscreen" = "none";
      "kwin"."Window Grow Horizontal" = "none";
      "kwin"."Window Grow Vertical" = "none";
      "kwin"."Window Lower" = "none";
      "kwin"."Window Maximize" = "Meta+PgUp";
      "kwin"."Window Maximize Horizontal" = "none";
      "kwin"."Window Maximize Vertical" = "none";
      "kwin"."Window Minimize" = "Meta+PgDown";
      "kwin"."Window Move" = "none";
      "kwin"."Window Move Center" = "none";
      "kwin"."Window No Border" = "none";
      "kwin"."Window On All Desktops" = "none";
      "kwin"."Window One Desktop Down" = "Meta+Ctrl+Shift+Down";
      "kwin"."Window One Desktop Up" = "Meta+Ctrl+Shift+Up";
      "kwin"."Window One Desktop to the Left" = "Meta+Ctrl+Shift+Left";
      "kwin"."Window One Desktop to the Right" = "Meta+Ctrl+Shift+Right";
      "kwin"."Window One Screen Down" = "none";
      "kwin"."Window One Screen Up" = "none";
      "kwin"."Window One Screen to the Left" = "none";
      "kwin"."Window One Screen to the Right" = "none";
      "kwin"."Window Operations Menu" = "Alt+F3";
      "kwin"."Window Pack Down" = "none";
      "kwin"."Window Pack Left" = "none";
      "kwin"."Window Pack Right" = "none";
      "kwin"."Window Pack Up" = "none";
      "kwin"."Window Quick Tile Bottom" = "Meta+Down";
      "kwin"."Window Quick Tile Bottom Left" = "none";
      "kwin"."Window Quick Tile Bottom Right" = "none";
      "kwin"."Window Quick Tile Left" = "Meta+Left";
      "kwin"."Window Quick Tile Right" = "Meta+Right";
      "kwin"."Window Quick Tile Top" = "Meta+Up";
      "kwin"."Window Quick Tile Top Left" = "none";
      "kwin"."Window Quick Tile Top Right" = "none";
      "kwin"."Window Raise" = "none";
      "kwin"."Window Resize" = "none";
      "kwin"."Window Shade" = "none";
      "kwin"."Window Shrink Horizontal" = "none";
      "kwin"."Window Shrink Vertical" = "none";
      "kwin"."Window to Desktop 1" = "none";
      "kwin"."Window to Desktop 10" = "none";
      "kwin"."Window to Desktop 11" = "none";
      "kwin"."Window to Desktop 12" = "none";
      "kwin"."Window to Desktop 13" = "none";
      "kwin"."Window to Desktop 14" = "none";
      "kwin"."Window to Desktop 15" = "none";
      "kwin"."Window to Desktop 16" = "none";
      "kwin"."Window to Desktop 17" = "none";
      "kwin"."Window to Desktop 18" = "none";
      "kwin"."Window to Desktop 19" = "none";
      "kwin"."Window to Desktop 2" = "none";
      "kwin"."Window to Desktop 20" = "none";
      "kwin"."Window to Desktop 3" = "none";
      "kwin"."Window to Desktop 4" = "none";
      "kwin"."Window to Desktop 5" = "none";
      "kwin"."Window to Desktop 6" = "none";
      "kwin"."Window to Desktop 7" = "none";
      "kwin"."Window to Desktop 8" = "none";
      "kwin"."Window to Desktop 9" = "none";
      "kwin"."Window to Next Desktop" = "none";
      "kwin"."Window to Next Screen" = "Meta+Shift+Right";
      "kwin"."Window to Previous Desktop" = "none";
      "kwin"."Window to Previous Screen" = "Meta+Shift+Left";
      "kwin"."Window to Screen 0" = "none";
      "kwin"."Window to Screen 1" = "none";
      "kwin"."Window to Screen 2" = "none";
      "kwin"."Window to Screen 3" = "none";
      "kwin"."Window to Screen 4" = "none";
      "kwin"."Window to Screen 5" = "none";
      "kwin"."Window to Screen 6" = "none";
      "kwin"."Window to Screen 7" = "none";
      "kwin"."disableInputCapture" = "Meta+Shift+Esc";
      "kwin"."view_actual_size" = "Meta+0";
      "kwin"."view_zoom_in" = [ "Meta++" "Meta+\x3d\\,Meta++" "Meta+\x3d\\,Zoom In" ];
      "kwin"."view_zoom_out" = "Meta+-";
      "mediacontrol"."mediavolumedown" = "\\\\, \\,\\,Media volume down";
      "mediacontrol"."mediavolumeup" = "none";
      "mediacontrol"."nextmedia" = "Media Next";
      "mediacontrol"."pausemedia" = "Media Pause";
      "mediacontrol"."playmedia" = "none";
      "mediacontrol"."playpausemedia" = "Media Play";
      "mediacontrol"."previousmedia" = "Media Previous";
      "mediacontrol"."stopmedia" = "Media Stop";
      "org_kde_powerdevil"."Decrease Keyboard Brightness" = "Keyboard Brightness Down";
      "org_kde_powerdevil"."Decrease Screen Brightness" = "Monitor Brightness Down";
      "org_kde_powerdevil"."Decrease Screen Brightness Small" = "Shift+Monitor Brightness Down";
      "org_kde_powerdevil"."Hibernate" = "Hibernate";
      "org_kde_powerdevil"."Increase Keyboard Brightness" = "Keyboard Brightness Up";
      "org_kde_powerdevil"."Increase Screen Brightness" = "Monitor Brightness Up";
      "org_kde_powerdevil"."Increase Screen Brightness Small" = "Shift+Monitor Brightness Up";
      "org_kde_powerdevil"."PowerDown" = "Power Down";
      "org_kde_powerdevil"."PowerOff" = "Power Off";
      "org_kde_powerdevil"."Sleep" = "Sleep";
      "org_kde_powerdevil"."Toggle Keyboard Backlight" = "Keyboard Light On/Off";
      "org_kde_powerdevil"."Turn Off Screen" = "none";
      "org_kde_powerdevil"."powerProfile" = [ "Battery" "Meta+B\\,Battery" "Meta+B\\,Switch Power Profile" ];
      "plasmashell"."activate application launcher" = [ "Meta" "" "Alt+F1\\\\, \\,Meta" "Alt+F1\\,Activate Application Launcher" ];
      "plasmashell"."activate task manager entry 1" = "Meta+1";
      "plasmashell"."activate task manager entry 10" = "none";
      "plasmashell"."activate task manager entry 2" = "Meta+2";
      "plasmashell"."activate task manager entry 3" = "Meta+3";
      "plasmashell"."activate task manager entry 4" = "Meta+4";
      "plasmashell"."activate task manager entry 5" = "Meta+5";
      "plasmashell"."activate task manager entry 6" = "Meta+6";
      "plasmashell"."activate task manager entry 7" = "Meta+7";
      "plasmashell"."activate task manager entry 8" = "Meta+8";
      "plasmashell"."activate task manager entry 9" = "Meta+9";
      "plasmashell"."clear-history" = "none";
      "plasmashell"."clipboard_action" = "Meta+Ctrl+X";
      "plasmashell"."cycle-panels" = "Meta+Alt+P";
      "plasmashell"."cycleNextAction" = "none";
      "plasmashell"."cyclePrevAction" = "none";
      "plasmashell"."manage activities" = "Meta+Q";
      "plasmashell"."next activity" = "\\,none\\,Walk through activities";
      "plasmashell"."previous activity" = "\\,none\\,Walk through activities (Reverse)";
      "plasmashell"."repeat_action" = "none";
      "plasmashell"."show dashboard" = "Ctrl+F12";
      "plasmashell"."show-barcode" = "none";
      "plasmashell"."show-on-mouse-pos" = "Meta+V";
      "plasmashell"."stop current activity" = "Meta+S";
      "plasmashell"."switch to next activity" = "none";
      "plasmashell"."switch to previous activity" = "none";
      "plasmashell"."toggle do not disturb" = "none";
      "yakuake"."toggle-window-state" = "Ctrl+Space\\,F12\\,Open/Retract Yakuake";
    };
    configFile = {
      "baloofilerc"."General"."dbVersion" = 2;
      "baloofilerc"."General"."exclude filters" = "*~,*.part,*.o,*.la,*.lo,*.loT,*.moc,moc_*.cpp,qrc_*.cpp,ui_*.h,cmake_install.cmake,CMakeCache.txt,CTestTestfile.cmake,libtool,config.status,confdefs.h,autom4te,conftest,confstat,Makefile.am,*.gcode,.ninja_deps,.ninja_log,build.ninja,*.csproj,*.m4,*.rej,*.gmo,*.pc,*.omf,*.aux,*.tmp,*.po,*.vm*,*.nvram,*.rcore,*.swp,*.swap,lzo,litmain.sh,*.orig,.histfile.*,.xsession-errors*,*.map,*.so,*.a,*.db,*.qrc,*.ini,*.init,*.img,*.vdi,*.vbox*,vbox.log,*.qcow2,*.vmdk,*.vhd,*.vhdx,*.sql,*.sql.gz,*.ytdl,*.tfstate*,*.class,*.pyc,*.pyo,*.elc,*.qmlc,*.jsc,*.fastq,*.fq,*.gb,*.fasta,*.fna,*.gbff,*.faa,po,CVS,.svn,.git,_darcs,.bzr,.hg,CMakeFiles,CMakeTmp,CMakeTmpQmake,.moc,.obj,.pch,.uic,.npm,.yarn,.yarn-cache,__pycache__,node_modules,node_packages,nbproject,.terraform,.venv,venv,core-dumps,lost+found";
      "baloofilerc"."General"."exclude filters version" = 9;
      "dolphinrc"."General"."FilterBar" = true;
      "dolphinrc"."General"."ViewPropsTimestamp" = "2025,4,4,8,12,59.201";
      "dolphinrc"."KFileDialog Settings"."Places Icons Auto-resize" = false;
      "dolphinrc"."KFileDialog Settings"."Places Icons Static Size" = 22;
      "dolphinrc"."PreviewSettings"."Plugins" = "appimagethumbnail,audiothumbnail,comicbookthumbnail,cursorthumbnail,directorythumbnail,djvuthumbnail,ebookthumbnail,exrthumbnail,imagethumbnail,jpegthumbnail,kraorathumbnail,opendocumentthumbnail,svgthumbnail,windowsexethumbnail,windowsimagethumbnail,fontthumbnail,blenderthumbnail,ffmpegthumbs,gsthumbnail,mobithumbnail,rawthumbnail";
      "kactivitymanagerdrc"."activities"."ba536fc0-033d-4650-aad9-190e4892e3e4" = "Default";
      "kactivitymanagerdrc"."main"."currentActivity" = "ba536fc0-033d-4650-aad9-190e4892e3e4";
      "katerc"."General"."Days Meta Infos" = 30;
      "katerc"."General"."Save Meta Infos" = true;
      "katerc"."General"."Show Full Path in Title" = false;
      "katerc"."General"."Show Menu Bar" = true;
      "katerc"."General"."Show Status Bar" = true;
      "katerc"."General"."Show Tab Bar" = true;
      "katerc"."General"."Show Url Nav Bar" = true;
      "katerc"."filetree"."editShade" = "31,81,106";
      "katerc"."filetree"."listMode" = false;
      "katerc"."filetree"."middleClickToClose" = false;
      "katerc"."filetree"."shadingEnabled" = true;
      "katerc"."filetree"."showCloseButton" = false;
      "katerc"."filetree"."showFullPathOnRoots" = false;
      "katerc"."filetree"."showToolbar" = true;
      "katerc"."filetree"."sortRole" = 0;
      "katerc"."filetree"."viewShade" = "81,49,95";
      "kcminputrc"."Keyboard"."RepeatDelay" = 300;
      "kcminputrc"."Keyboard"."RepeatRate" = 35;
      "kcminputrc"."Libinput/5426/185/Razer Razer Basilisk V3 X HyperSpeed"."PointerAccelerationProfile" = 1;
      "kcminputrc"."Mouse"."cursorTheme" = "Breeze_Light";
      "kded5rc"."Module-device_automounter"."autoload" = false;
      "kdeglobals"."DirSelect Dialog"."DirSelectDialog Size" = "817,584";
      "kdeglobals"."DirSelect Dialog"."Splitter State" = "x00x00x00xffx00x00x00x01x00x00x00x02x00x00x00x89x00x00x02xa8x00xffxffxffxffx01x00x00x00x01x00";
      "kdeglobals"."General"."XftHintStyle" = "hintslight";
      "kdeglobals"."General"."XftSubPixel" = "none";
      "kdeglobals"."General"."fixed" = "Roboto Mono,10,-1,5,400,0,0,0,0,0,0,0,0,0,0,1";
      "kdeglobals"."General"."font" = "Roboto,10,-1,5,400,0,0,0,0,0,0,0,0,0,0,1";
      "kdeglobals"."General"."menuFont" = "Roboto,10,-1,5,400,0,0,0,0,0,0,0,0,0,0,1";
      "kdeglobals"."General"."smallestReadableFont" = "Roboto,8,-1,5,400,0,0,0,0,0,0,0,0,0,0,1";
      "kdeglobals"."General"."toolBarFont" = "Roboto,10,-1,5,400,0,0,0,0,0,0,0,0,0,0,1";
      "kdeglobals"."Icons"."Theme" = "Papirus-Dark";
      "kdeglobals"."KDE"."AnimationDurationFactor" = 0.25;
      "kdeglobals"."PreviewSettings"."EnableRemoteFolderThumbnail" = false;
      "kdeglobals"."PreviewSettings"."MaximumRemoteSize" = 0;
      "kdeglobals"."WM"."activeBackground" = "20,26,33,216";
      "kdeglobals"."WM"."activeBlend" = "20,26,33";
      "kdeglobals"."WM"."activeFont" = "Roboto,10,-1,5,400,0,0,0,0,0,0,0,0,0,0,1";
      "kdeglobals"."WM"."activeForeground" = "211,218,227";
      "kdeglobals"."WM"."inactiveBackground" = "47,52,63";
      "kdeglobals"."WM"."inactiveBlend" = "47,52,63";
      "kdeglobals"."WM"."inactiveForeground" = "102,106,115,216";
      "kiorc"."Confirmations"."ConfirmDelete" = true;
      "kiorc"."Confirmations"."ConfirmEmptyTrash" = true;
      "kiorc"."Confirmations"."ConfirmTrash" = false;
      "kiorc"."Executable scripts"."behaviourOnLaunch" = "alwaysAsk";
      "kscreenlockerrc"."Daemon"."LockGrace" = 30;
      "kscreenlockerrc"."Daemon"."Timeout" = 15;
      "kscreenlockerrc"."Greeter/Wallpaper/org.kde.image/General"."Image" = "/nix/store/djr05621pkh0qykdiiwvg0ydzqkhxm1j-plasma-workspace-wallpapers-6.3.4/share/wallpapers/Path/";
      "kscreenlockerrc"."Greeter/Wallpaper/org.kde.image/General"."PreviewImage" = "/nix/store/djr05621pkh0qykdiiwvg0ydzqkhxm1j-plasma-workspace-wallpapers-6.3.4/share/wallpapers/Path/";
      "ksplashrc"."KSplash"."Theme" = "a2n.kuro";
      "ktrashrc"."\\/home\\/zachary\\/.local\\/share\\/Trash"."Days" = 7;
      "ktrashrc"."\\/home\\/zachary\\/.local\\/share\\/Trash"."LimitReachedAction" = 0;
      "ktrashrc"."\\/home\\/zachary\\/.local\\/share\\/Trash"."Percent" = 5;
      "ktrashrc"."\\/home\\/zachary\\/.local\\/share\\/Trash"."UseSizeLimit" = true;
      "ktrashrc"."\\/home\\/zachary\\/.local\\/share\\/Trash"."UseTimeLimit" = true;
      "kwalletrc"."Wallet"."First Use" = false;
      "kwinrc"."Desktops"."Id_1" = "d25b7117-cea6-4134-a15b-6d32f80ee72b";
      "kwinrc"."Desktops"."Number" = 1;
      "kwinrc"."Desktops"."Rows" = 1;
      "kwinrc"."NightColor"."Active" = true;
      "kwinrc"."NightColor"."Mode" = "Constant";
      "kwinrc"."NightColor"."NightTemperature" = 2300;
      "kwinrc"."Tiling"."padding" = 4;
      "kwinrc"."Tiling/6658d5bc-2de5-5706-a3dc-884add4e97b7"."tiles" = "{\"layoutDirection\":\"horizontal\",\"tiles\":\x5b{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}\x5d}";
      "kwinrc"."Tiling/7418b520-0e3e-5a43-8c74-67b2ea22689f"."tiles" = "{\"layoutDirection\":\"horizontal\",\"tiles\":\x5b{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}\x5d}";
      "kwinrc"."Xwayland"."Scale" = 1;
      "kwinrc"."org.kde.kdecoration2"."theme" = "__aurorae__svg__MoeDark";
      "kxkbrc"."Layout"."DisplayNames" = ",";
      "kxkbrc"."Layout"."LayoutList" = "us,us";
      "kxkbrc"."Layout"."Model" = "pc86";
      "kxkbrc"."Layout"."Options" = "caps:capslock";
      "kxkbrc"."Layout"."ResetOldOptions" = true;
      "kxkbrc"."Layout"."Use" = true;
      "kxkbrc"."Layout"."VariantList" = "workman,";
      "plasma-localerc"."Formats"."LANG" = "en_US.UTF-8";
      "plasmanotifyrc"."Applications/org.qbittorrent.qBittorrent"."Seen" = true;
      "plasmanotifyrc"."Applications/vesktop"."Seen" = true;
      "plasmanotifyrc"."Applications/vivaldi-stable"."Seen" = true;
      "plasmaparc"."General"."AudioFeedback" = false;
      "plasmaparc"."General"."RaiseMaximumVolume" = true;
      "plasmaparc"."General"."VolumeStep" = 2;
      "plasmarc"."Theme"."name" = "Gently";
      "plasmarc"."Wallpapers"."usersWallpapers" = "";
      "spectaclerc"."General"."autoSaveImage" = true;
      "spectaclerc"."General"."clipboardGroup" = "PostScreenshotCopyImage";
      "spectaclerc"."General"."launchAction" = "UseLastUsedCapturemode";
      "spectaclerc"."General"."rememberSelectionRect" = "Never";
      "spectaclerc"."General"."useReleaseToCapture" = true;
      "spectaclerc"."GuiConfig"."captureMode" = 0;
      "spectaclerc"."ImageSave"."imageFilenameTemplate" = "<yyyy>-<MM>-<dd>_<HH>:<mm>:<ss><Ap>";
      "spectaclerc"."ImageSave"."lastImageSaveLocation" = "file:///home/zachary/Pictures/Screenshots/2025-04-15_10:49:38AM.png";
      "spectaclerc"."ImageSave"."translatedScreenshotsFolder" = "Screenshots";
      "spectaclerc"."VideoSave"."translatedScreencastsFolder" = "Screencasts";
      "spectaclerc"."VideoSave"."videoFilenameTemplate" = "<yyyy>-<MM>-<dd>_<HH>:<mm>:<ss><Ap>";
    };
    dataFile = {
      "kate/anonymous.katesession"."Document 0"."URL" = "file:///etc/nixos/home-manager/king/git/default.nix";
      "kate/anonymous.katesession"."Document 1"."URL" = "file:///etc/nixos/home-manager/king/default.nix";
      "kate/anonymous.katesession"."Kate Plugins"."cmaketoolsplugin" = false;
      "kate/anonymous.katesession"."Kate Plugins"."compilerexplorer" = false;
      "kate/anonymous.katesession"."Kate Plugins"."eslintplugin" = false;
      "kate/anonymous.katesession"."Kate Plugins"."externaltoolsplugin" = true;
      "kate/anonymous.katesession"."Kate Plugins"."formatplugin" = false;
      "kate/anonymous.katesession"."Kate Plugins"."katebacktracebrowserplugin" = false;
      "kate/anonymous.katesession"."Kate Plugins"."katebuildplugin" = false;
      "kate/anonymous.katesession"."Kate Plugins"."katecloseexceptplugin" = false;
      "kate/anonymous.katesession"."Kate Plugins"."katecolorpickerplugin" = false;
      "kate/anonymous.katesession"."Kate Plugins"."katectagsplugin" = false;
      "kate/anonymous.katesession"."Kate Plugins"."katefilebrowserplugin" = false;
      "kate/anonymous.katesession"."Kate Plugins"."katefiletreeplugin" = true;
      "kate/anonymous.katesession"."Kate Plugins"."kategdbplugin" = false;
      "kate/anonymous.katesession"."Kate Plugins"."kategitblameplugin" = false;
      "kate/anonymous.katesession"."Kate Plugins"."katekonsoleplugin" = true;
      "kate/anonymous.katesession"."Kate Plugins"."kateprojectplugin" = true;
      "kate/anonymous.katesession"."Kate Plugins"."katereplicodeplugin" = false;
      "kate/anonymous.katesession"."Kate Plugins"."katesearchplugin" = true;
      "kate/anonymous.katesession"."Kate Plugins"."katesnippetsplugin" = false;
      "kate/anonymous.katesession"."Kate Plugins"."katesqlplugin" = false;
      "kate/anonymous.katesession"."Kate Plugins"."katesymbolviewerplugin" = false;
      "kate/anonymous.katesession"."Kate Plugins"."katexmlcheckplugin" = false;
      "kate/anonymous.katesession"."Kate Plugins"."katexmltoolsplugin" = false;
      "kate/anonymous.katesession"."Kate Plugins"."keyboardmacrosplugin" = false;
      "kate/anonymous.katesession"."Kate Plugins"."ktexteditorpreviewplugin" = false;
      "kate/anonymous.katesession"."Kate Plugins"."latexcompletionplugin" = false;
      "kate/anonymous.katesession"."Kate Plugins"."lspclientplugin" = true;
      "kate/anonymous.katesession"."Kate Plugins"."openlinkplugin" = false;
      "kate/anonymous.katesession"."Kate Plugins"."rainbowparens" = false;
      "kate/anonymous.katesession"."Kate Plugins"."rbqlplugin" = false;
      "kate/anonymous.katesession"."Kate Plugins"."tabswitcherplugin" = true;
      "kate/anonymous.katesession"."Kate Plugins"."textfilterplugin" = true;
      "kate/anonymous.katesession"."MainWindow0"."Active ViewSpace" = 0;
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-H-Splitter" = "200,1674,0";
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-Sidebar-0-Bar-0-TvList" = "kate_private_plugin_katefiletreeplugin,kateproject,kateprojectgit,lspclient_symbol_outline";
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-Sidebar-0-LastSize" = 200;
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-Sidebar-0-SectSizes" = 0;
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-Sidebar-0-Splitter" = 907;
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-Sidebar-1-Bar-0-TvList" = "";
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-Sidebar-1-LastSize" = 200;
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-Sidebar-1-SectSizes" = 0;
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-Sidebar-1-Splitter" = 905;
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-Sidebar-2-Bar-0-TvList" = "";
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-Sidebar-2-LastSize" = 200;
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-Sidebar-2-SectSizes" = 0;
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-Sidebar-2-Splitter" = 1674;
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-Sidebar-3-Bar-0-TvList" = "output,diagnostics,kate_plugin_katesearch,kateprojectinfo,kate_private_plugin_katekonsoleplugin";
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-Sidebar-3-LastSize" = 200;
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-Sidebar-3-SectSizes" = 0;
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-Sidebar-3-Splitter" = 1572;
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-Sidebar-Style" = 2;
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-Sidebar-Visible" = true;
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-diagnostics-Position" = 3;
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-diagnostics-Show-Button-In-Sidebar" = true;
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-diagnostics-Visible" = false;
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-kate_plugin_katesearch-Position" = 3;
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-kate_plugin_katesearch-Show-Button-In-Sidebar" = true;
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-kate_plugin_katesearch-Visible" = false;
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-kate_private_plugin_katefiletreeplugin-Position" = 0;
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-kate_private_plugin_katefiletreeplugin-Show-Button-In-Sidebar" = true;
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-kate_private_plugin_katefiletreeplugin-Visible" = false;
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-kate_private_plugin_katekonsoleplugin-Position" = 3;
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-kate_private_plugin_katekonsoleplugin-Show-Button-In-Sidebar" = true;
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-kate_private_plugin_katekonsoleplugin-Visible" = false;
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-kateproject-Position" = 0;
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-kateproject-Show-Button-In-Sidebar" = true;
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-kateproject-Visible" = true;
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-kateprojectgit-Position" = 0;
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-kateprojectgit-Show-Button-In-Sidebar" = true;
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-kateprojectgit-Visible" = false;
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-kateprojectinfo-Position" = 3;
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-kateprojectinfo-Show-Button-In-Sidebar" = true;
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-kateprojectinfo-Visible" = false;
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-lspclient_symbol_outline-Position" = 0;
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-lspclient_symbol_outline-Show-Button-In-Sidebar" = true;
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-lspclient_symbol_outline-Visible" = false;
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-output-Position" = 3;
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-output-Show-Button-In-Sidebar" = true;
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-output-Visible" = false;
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-V-Splitter" = "0,907,0";
      "kate/anonymous.katesession"."MainWindow0 Settings"."WindowState" = 10;
      "kate/anonymous.katesession"."MainWindow0-Splitter 0"."Children" = "MainWindow0-ViewSpace 0";
      "kate/anonymous.katesession"."MainWindow0-Splitter 0"."Orientation" = 1;
      "kate/anonymous.katesession"."MainWindow0-Splitter 0"."Sizes" = 1674;
      "kate/anonymous.katesession"."MainWindow0-ViewSpace 0"."Active View" = 1;
      "kate/anonymous.katesession"."MainWindow0-ViewSpace 0"."Count" = 2;
      "kate/anonymous.katesession"."MainWindow0-ViewSpace 0"."Documents" = "0,1";
      "kate/anonymous.katesession"."MainWindow0-ViewSpace 0"."View 0" = 0;
      "kate/anonymous.katesession"."MainWindow0-ViewSpace 0"."View 1" = 1;
      "kate/anonymous.katesession"."MainWindow0-ViewSpace 0 0"."CursorColumn" = 23;
      "kate/anonymous.katesession"."MainWindow0-ViewSpace 0 0"."CursorLine" = 24;
      "kate/anonymous.katesession"."MainWindow0-ViewSpace 0 1"."CursorColumn" = 4;
      "kate/anonymous.katesession"."MainWindow0-ViewSpace 0 1"."CursorLine" = 7;
      "kate/anonymous.katesession"."Open Documents"."Count" = 2;
      "kate/anonymous.katesession"."Open MainWindows"."Count" = 1;
      "kate/anonymous.katesession"."Plugin:kateprojectplugin:"."projects" = "";
      "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0"."BinaryFiles" = false;
      "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0"."CurrentExcludeFilter" = "-1";
      "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0"."CurrentFilter" = "-1";
      "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0"."ExcludeFilters" = "";
      "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0"."ExpandSearchResults" = false;
      "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0"."Filters" = "";
      "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0"."FollowSymLink" = false;
      "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0"."HiddenFiles" = false;
      "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0"."MatchCase" = false;
      "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0"."Place" = 1;
      "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0"."Recursive" = true;
      "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0"."Replaces" = "";
      "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0"."Search" = "";
      "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0"."SearchAsYouTypeAllProjects" = true;
      "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0"."SearchAsYouTypeCurrentFile" = true;
      "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0"."SearchAsYouTypeFolder" = true;
      "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0"."SearchAsYouTypeOpenFiles" = true;
      "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0"."SearchAsYouTypeProject" = true;
      "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0"."SearchDiskFiles" = "";
      "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0"."SearchDiskFiless" = "";
      "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0"."SizeLimit" = 128;
      "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0"."UseRegExp" = false;
    };
  };

}
