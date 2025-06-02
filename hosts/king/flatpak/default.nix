{
  lib,
  inputs,
  ...
}: {
  # Flatpak management
  services.flatpak = {
    enable = true;
    remotes = lib.mkOptionDefault [
      {
        name = "flathub-beta";
        location = "https://flathub.org/beta-repo/flathub-beta.flatpakrepo";
      }
    ];
    update.auto = {
      enable = true;
      onCalendar = "daily";
    };
    packages = [
      "com.stremio.Stremio"
      "org.onlyoffice.desktopeditors"
      "com.protonvpn.www"
      "com.vivaldi.Vivaldi"
      "org.freecad.FreeCAD"
    ];
  };
}
