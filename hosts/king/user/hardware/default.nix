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
  ];

  boot.initrd.availableKernelModules = ["nvme" "xhci_pci" "ahci" "thunderbolt" "usbhid" "uas" "sd_mod"];
  boot.initrd.kernelModules = ["amdgpu"];
  boot.kernelModules = ["kvm-amd"];
  boot.extraModulePackages = [];

  fileSystems."/" = {
    device = "/dev/disk/by-label/nix-root";
    fsType = "btrfs";
    options = [
      "subvol=@"
      "compress=lzo"
      "noatime"
      "space_cache=v2"
      "discard=async"
    ];
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-label/nix-root";
    fsType = "btrfs";
    options = [
      "subvol=@home"
      "compress=lzo"
      "noatime"
      "space_cache=v2"
      "discard=async"
    ];
  };

  fileSystems."/nix" = {
    device = "/dev/disk/by-label/nix-root";
    fsType = "btrfs";
    options = [
      "subvol=@nix"
      "compress=lzo"
      "noatime"
      "space_cache=v2"
      "discard=async"
    ];
  };

  fileSystems."/var" = {
    device = "/dev/disk/by-label/nix-root";
    fsType = "btrfs";
    options = [
      "subvol=@var"
      "compress=lzo"
      "noatime"
      "space_cache=v2"
      "discard=async"
    ];
  };

  fileSystems."/var/log" = {
    device = "/dev/disk/by-label/nix-root";
    fsType = "btrfs";
    options = [
      "subvol=@log"
      "compress=lzo"
      "noatime"
      "space_cache=v2"
      "discard=async"
    ];
  };

  fileSystems."/tmp" = {
    device = "/dev/disk/by-label/nix-root";
    fsType = "btrfs";
    options = [
      "subvol=@tmp"
      "compress=lzo"
      "noatime"
      "space_cache=v2"
      "discard=async"
    ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-label/nix-boot";
    fsType = "vfat";
  };

  swapDevices = [];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp12s0u5.useDHCP = lib.mkDefault true;

  hardware = {
    cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    amdgpu = {
      opencl.enable = true;
      amdvlk = {
        enable = true;
        support32Bit.enable = true;
      };
    };
    graphics = {
      enable = true;
      enable32Bit = true;
    };
    # Monitor Brightness Control
    i2c.enable = true;
    # Enable bluetooth - Activate on boot
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
    xone.enable = true; # support for the xbox controller USB dongle
  };
}
