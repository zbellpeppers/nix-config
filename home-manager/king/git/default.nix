{pkgs, ...}: {
  # Git configuration
  programs.git = {
    enable = true;

    # Credentials
    userName = "zbellpeppers";
    userEmail = "codeberg@bell-peppers.com";

    # Signing Configuration
    signing = {
      key = "/home/zachary/.ssh/id_ed25519.pub";
      signByDefault = true;
      format = "ssh";
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
