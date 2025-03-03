{
  config,
  pkgs,
  ...
}: {
  # Bash Configuration
  programs.bash = {
    enable = true;
    enableCompletion = true;
  };
}
