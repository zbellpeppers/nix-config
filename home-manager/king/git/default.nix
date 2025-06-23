{ pkgs, ... }:
{
  # Git configuration
  programs.git = {
    enable = true;

    # Credentials
    userName = "zbellpeppers";
    userEmail = "github@bell-peppers.com";

    # Signing Configuration
    signing = {
      key = "7E353EEAF145C5889BA0F69FD400D510F24B952D";
      signByDefault = true;
      signer = "${pkgs.gnupg}/bin/gpg2"; # Explicit path for NixOS
    };

    # Useful aliases
    aliases = {
      co = "checkout";
      br = "branch";
      ci = "commit";
      st = "status";
      unstage = "reset HEAD --";
      last = "log -1 HEAD";
      visual = "!gitk";
    };

    # Additional config
    extraConfig = {
      gpg = {
        format = "openpgp";
        ssh = {
          allowedSignersFile = "/etc/ssh/allowed_signers";
        };
      };
      core = {
        editor = "codium";
        autocrlf = "input";
      };
      color = {
        ui = "auto";
      };
      pull = {
        rebase = false;
      };
      push = {
        default = "simple";
      };
      init = {
        defaultBranch = "master";
      };
      url = {
        "git@github.com:" = {
          insteadOf = "https://github.com/";
        };
      };
    };
  };
}
