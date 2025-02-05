{
  config,
  pkgs,
  ...
}: {
  # Git configuration
  programs.git = {
    enable = true;

    # Credentials
    userName = "tkmockingbird";
    userEmail = "zbellpeppers@pm.me";

    package = pkgs.git;

    # SSH key configuration
    signing = {
      key = "7DFAE613BBACACB80DBFFB31D8E0D05600EE3146";
      signByDefault = true;
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
        defaultBranch = "main";
      };
      url = {
        "git@gitlab.com:" = {
          insteadOf = "https://gitlab.com/";
        };
      };
    };
  };
}
