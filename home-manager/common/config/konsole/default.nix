{...}: {
  xdg.configFile."konsolerc".text = ''
    [Desktop Entry]
    DefaultProfile=Zsh.profile

    [General]
    ConfigVersion=1

    [KonsoleWindow]
    AllowMenuAccelerators=true
    RememberWindowSize=false

    [UiSettings]
    ColorScheme=
  '';
  xdg.dataFile."konsole/Zsh.profile".text = ''
    [Appearance]
    Font=FiraCode Nerd Font,11,-1,5,400,0,0,0,0,0,0,0,0,0,0,1

    [Cursor Options]
    CursorShape=1

    [General]
    Command=/etc/profiles/per-user/zachary/bin/zsh
    Name=Zsh
    Parent=FALLBACK/
    TerminalColumns=120
    TerminalRows=29

    [Interaction Options]
    TrimLeadingSpacesInSelectedText=true
    TrimTrailingSpacesInSelectedText=true

    [Scrolling]
    HistorySize=15000

    [Terminal Features]
    BlinkingCursorEnabled=true
  '';
}
