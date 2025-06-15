{ pkgs, ... }:
{
  services = {
    displayManager.cosmic-greeter.enable = true;
    desktopManager = {
      cosmic.enable = true;
      cosmic.xwayland.enable = true;
    };
  };
  environment.systemPackages = with pkgs; [
    cosmic-applets
    cosmic-applibrary
    cosmic-bg
    cosmic-comp
    cosmic-edit
    cosmic-ext-calculator
    cosmic-ext-ctl
    cosmic-ext-tweaks
    cosmic-files
    cosmic-greeter
    cosmic-icons
    cosmic-idle
    cosmic-launcher
    cosmic-notifications
    cosmic-osd
    cosmic-panel
    cosmic-player
    cosmic-protocols
    cosmic-randr
    cosmic-screenshot
    cosmic-session
    cosmic-settings
    cosmic-store
    cosmic-tasks
    cosmic-term
    cosmic-wallpapers
    cosmic-workspaces-epoch
  ];
}
