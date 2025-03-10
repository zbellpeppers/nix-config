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

  # Required for ZFS
  networking.hostId = "fb2d1e16";

  boot.initrd.availableKernelModules = ["nvme" "xhci_pci" "ahci" "thunderbolt" "usbhid" "uas" "sd_mod"];
  boot.initrd.kernelModules = ["amdgpu"];
  boot.kernelModules = ["kvm-amd"];
  boot.extraModulePackages = [];

  fileSystems."/" =
    { device = "zpool/root";
      fsType = "zfs";
    };

  fileSystems."/nix" =
    { device = "zpool/nix";
      fsType = "zfs";
    };

  fileSystems."/var" =
    { device = "zpool/var";
      fsType = "zfs";
    };

  fileSystems."/home" =
    { device = "zpool/home";
      fsType = "zfs";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/EEBC-B8A9";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };

  swapDevices = [ ];

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
