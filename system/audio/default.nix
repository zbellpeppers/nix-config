{pkgs, ...}: {
  # Needed for sound configuration
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    wireplumber = {
      enable = true;
      extraConfig."10-bluez" = {
        "monitor.bluez.properties" = {
          "bluez.enable-sbc-xq" = true;
          "bluez.enable-msbc" = true;
          "bluez.enable-hw-volume" = true;
          "bluez.codecs" = ["sbc" "sbc_xq" "aac" "ldac" "aptx" "aptx_hd"];
        };
      };
    };
  };
}
