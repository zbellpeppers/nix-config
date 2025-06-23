{
  pkgs,
  config,
  lib,
  ...
}:
{
  nixpkgs.overlays = [
    (final: prev: {
      linux_xanmod_latest = prev.linux_xanmod_latest.overrideAttrs (old: {
        NIX_CFLAGS_COMPILE = (old.NIX_CFLAGS_COMPILE or "") + " -march=znver5 -O3";
      });
    })
  ];
  boot = {
    # Enable ntfs support
    supportedFilesystems = [ "ntfs" ];

    # Specifices the Linux Kernel
    kernelPackages = pkgs.linuxKernel.packages.linux_xanmod_latest;

    # Enables r8125 Realtek Ethernet Driver
    extraModulePackages = with config.boot.kernelPackages; [ r8125 ];
    kernelModules = [ "r8125" ];

    # Bootloader Configuration
    loader = {
      efi.canTouchEfiVariables = true;
      timeout = 5;
      grub = {
        enable = lib.mkDefault true;
        efiSupport = true;
        device = "nodev";
        theme = "${pkgs.minimal-grub-theme}";
        extraEntries = ''
          menuentry "Windows 11" {
            insmod search_fs_uuid
            insmod chain
            search --fs-uuid --set=root 0FF3-0D14
            chainloader /EFI/Microsoft/Boot/bootmgfw.efi
          }
          menuentry "Reboot to BIOS" {
            fwsetup
          }
          menuentry "Shutdown" {
            halt
          }
        '';
      };
    };
  };
}
