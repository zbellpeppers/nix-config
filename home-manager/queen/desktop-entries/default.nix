{...}: {
  xdg.desktopEntries = {
    "vesktop" = {
      name = "Discord";
      exec = "vesktop";
      icon = "discord";
    };
    "org.speedcrunch.SpeedCrunch" = {
      name = "Calculator";
      exec = "speedcrunch";
      icon = "org.gnome.Calculator";
    };
    "codium" = {
      name = "Code";
      exec = "codium";
      icon = "code-oss";
      terminal = false;
      type = "Application";
      categories = ["Utility" "TextEditor" "Development" "IDE"];
    };
    "codium-url-handler" = {
      name = "VSCodium - URL Handler";
      exec = "codium --open-url %U";
      icon = "vscodium";
      terminal = false;
      type = "Application";
      categories = ["Utility" "TextEditor" "Development" "IDE"];
      mimeType = ["x-scheme-handler/vscodium"];
      noDisplay = true;
    };
  };
}
