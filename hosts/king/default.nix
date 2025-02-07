{
  config,
  lib,
  pkgs,
  modulesPath,
  inputs,
  flake,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    ../../system
    ../../desktop-environments/plasma
    ../../user/king
    ./boot
    inputs.home-manager.nixosModules.home-manager
    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.users.zachary = import ../../home-manager/king;
      home-manager.backupFileExtension = "0004";
    }
    inputs.chaotic.nixosModules.default
    inputs.nix-flatpak.nixosModules.nix-flatpak
  ];

  boot.initrd.availableKernelModules = ["nvme" "xhci_pci" "ahci" "thunderbolt" "usbhid" "uas" "sd_mod"];
  boot.initrd.kernelModules = [""];
  boot.kernelModules = ["kvm-amd" "amdgpu"];
  boot.extraModulePackages = [];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/fd84cbcd-2af0-4344-8c20-b6009814e609";
    fsType = "btrfs";
    options = ["subvol=@"];
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/fd84cbcd-2af0-4344-8c20-b6009814e609";
    fsType = "btrfs";
    options = ["subvol=@home"];
  };

  fileSystems."/nix" = {
    device = "/dev/disk/by-uuid/fd84cbcd-2af0-4344-8c20-b6009814e609";
    fsType = "btrfs";
    options = ["subvol=@nix"];
  };

  fileSystems."/var" = {
    device = "/dev/disk/by-uuid/fd84cbcd-2af0-4344-8c20-b6009814e609";
    fsType = "btrfs";
    options = ["subvol=@var"];
  };

  fileSystems."/tmp" = {
    device = "/dev/disk/by-uuid/fd84cbcd-2af0-4344-8c20-b6009814e609";
    fsType = "btrfs";
    options = ["subvol=@tmp"];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/DEDC-2567";
    fsType = "vfat";
    options = ["fmask=0077" "dmask=0077"];
  };

  swapDevices = [
    {device = "/dev/disk/by-uuid/9c3863d8-3f5a-4fc7-b3fa-8bbefe94d655";}
  ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp12s0u5.useDHCP = lib.mkDefault true;

  hardware = {
    cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    amdgpu.opencl.enable = true;
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        amdvlk
        rocmPackages.clr
      ];
    };
    # Monitor Brightness Control
    i2c.enable = true;
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
  };
}
