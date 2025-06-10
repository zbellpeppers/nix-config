{ ... }:
{
  xdg.configFile."konsolerc".text = ''
    [Desktop Entry]
    DefaultProfile=Fish.profile

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
    Command=/run/current-system/sw/bin/zsh
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
  xdg.dataFile."konsole/Fish.profile".text = ''
    [Appearance]
    Font=FiraCode Nerd Font,11,-1,5,400,0,0,0,0,0,0,0,0,0,0,1

    [Cursor Options]
    CursorShape=1

    [General]
    Command=/run/current-system/sw/bin/fish
    Name=Fish
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
