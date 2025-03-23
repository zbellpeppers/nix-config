{pkgs, ...}: {
  # Git configuration
  programs.git = {
    enable = true;

    # Credentials
    userName = "zbellpeppers";
    userEmail = "codeberg@bell-peppers.com";

    # Signing Configuration
    signing = {
      key = "9EFE29683CB660DD0C67B6AB780996F7F20545BD";
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
        "git@codeberg.org:" = {
          insteadOf = "https://codeberg.org/";
        };
      };
    };
  };
}
