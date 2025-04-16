{...}: {
  xdg.configFile."persepolis_download_manager/persepolis.conf".text = ''
    [General]
    ui_direction=ltr

    [AfterDownloadWindow]
    position=@Point(1920 0)
    size=@Size(659 311)

    [MainWindow]
    column0=169
    column1=0
    column10=0
    column11=0
    column12=0
    column2=200
    column3=200
    column4=200
    column5=0
    column6=119
    column7=109
    delete-warning=no
    maximized=no
    position=@Point(199 245)
    size=@Size(1006 554)

    [PreferencesWindow]
    position=@Point(2094 86)
    size=@Size(591 649)

    [ProgressWindow]
    position=@Point(1920 0)
    size=@Size(617 304)

    [TextQueue]
    position=@Point(0 0)
    size=@Size(700 500)

    [settings]
    after-dialog=yes
    awake=yes
    browser-persepolis=yes
    check-clipboard=yes
    chunk-size=100
    color-scheme=System
    column0=yes
    column1=no
    column10=no
    column11=no
    column12=no
    column2=yes
    column3=yes
    column4=yes
    column5=no
    column6=yes
    column7=yes
    connections=64
    custom-font=yes
    dont-check-certificate=no
    dont-show-addlinkwindow=yes
    download_path=/home/zachary/Downloads
    font=Liberation Sans
    font-size=10
    hide-window=yes
    icons=Papirus
    locale=en_US
    max-tries=5
    notification=Native notification
    retry-wait=1
    settings\awake=yes
    shortcuts\add_new_download_shortcut=Ctrl+N
    shortcuts\delete_shortcut=Ctrl+D
    shortcuts\hide_window_shortcut=Ctrl+W
    shortcuts\import_text_shortcut=Ctrl+O
    shortcuts\move_down_selection_shortcut=Ctrl+Down
    shortcuts\move_up_selection_shortcut=Ctrl+Up
    shortcuts\quit_shortcut=Ctrl+Q
    shortcuts\remove_shortcut=Ctrl+R
    shortcuts\video_finder_shortcut=Ctrl+V
    show-menubar=no
    show-progress=no
    show-sidepanel=yes
    sound=no
    sound-volume=50
    startup=yes
    style=System
    subfolder=no
    timeout=5
    toolbar_icon_size=32
    tray-icon=yes
    video_finder\max_links=5
    wait-queue=0, 00

    [version]
    version=5.01
  '';
}
