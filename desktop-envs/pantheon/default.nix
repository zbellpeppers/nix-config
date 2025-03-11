{pkgs, ...}: {
  # Visit: https://wiki.nixos.org/wiki/Pantheon for information

  # Enables Pantheon desktop environment and the LightDM display manager
  services.xserver.enable = true;
  services.xserver.desktopManager.pantheon.enable = true;

  # The following options are enabled by default by the above:
  # services.xserver.displayManager.lightdm.greeters.pantheon.enable = true;
  # services.xserver.displayManager.lightdm.enable = true;

  # You can remove the Pantheon default apps by uncommenting:
  # services.pantheon.apps.enable = false;

  # Pantheon has plugins but they're installed differently than with Gnome. Example:
  # opt-services.xserver.desktopManager.pantheon.extraWingpanelIndicators
  # This would install / enable the 'extraWingpanelIndicators' plugin

  # opt-services.xserver.desktopManager.pantheon.extraSwitchboardPlugs
  # This would install / enable the 'extraSwitchboardPlugs' plugin

  # These plugins could then be added onto / modified via:
  #   wingpanel-with-indicators.override {
  #     indicators = [
  #       pkgs.some-special-indicator
  #     ];
  #   };

  # switchboard-with-plugs.override {
  #   plugs = [
  #     pkgs.some-special-plug
  #   ];
  # };
}
