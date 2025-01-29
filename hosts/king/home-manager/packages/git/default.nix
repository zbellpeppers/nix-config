{
  config,
  pkgs,
  ...
}: {
  # basic configuration of git, please change to your own
  programs.git = {
    enable = true;
    userName = "tkmockingbird";
    userEmail = "zbellpeppers@pm.me";
    extraConfig = {
      url = {
        "git@github.com:" = {
          insteadOf = "https://github.com/";
        };
      };
    };
  };
}
