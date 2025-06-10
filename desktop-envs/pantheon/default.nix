{ pkgs, ... }:
{
  # Visit: https://wiki.nixos.org/wiki/Pantheon for information

  # Enables Pantheon desktop environment and the LightDM display manager
  services.xserver.enable = true;
  services.xserver.desktopManager.pantheon.enable = true;

  # Disable specific pantheon default apps:
  # environment.pantheon.excludePackages = with pkgs; [
  #   # Communication
  #   pantheon.elementary-mail
  #   pantheon.elementary-feedback

  #   # # Media
  #   # pantheon.elementary-music
  #   # pantheon.elementary-photos
  #   # pantheon.elementary-videos

  #   # # Utilities
  #   pantheon.elementary-calculator
  #   pantheon.elementary-calendar
  #   pantheon.elementary-code
  #   # pantheon.elementary-screenshot
  #   pantheon.elementary-tasks
  #   pantheon.elementary-terminal

  #   # # System
  #   # pantheon.elementary-print # If you don't need printing
  # ];

  environment.systemPackages = with pkgs; [
    pantheon.elementary-iconbrowser
    pantheon.elementary-print-shim
    pantheon.elementary-screenshot
    pantheon.elementary-photos
    pantheon.contractor
  ];

  # Removes all default Pantheon apps
  services.pantheon.apps.enable = false;

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
