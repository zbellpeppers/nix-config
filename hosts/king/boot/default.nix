{
  pkgs,
  config,
  ...
}: {
  boot = {
    # Specifices the Linux Kernel
    kernelPackages = pkgs.linuxPackages_cachyos;

    # Enables r8125 Realtek Ethernet Driver
    extraModulePackages = with config.boot.kernelPackages; [r8125];
    kernelModules = ["r8125"];

    # Bootloader Configuration
    loader = {
      efi.canTouchEfiVariables = true;
      timeout = 8;
      grub = {
        enable = true;
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
