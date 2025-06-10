{ ... }:
{
  programs.micro = {
    enable = true;
    settings = {
      autosu = true;
      clipboard = "external";
      hlsearch = true;
      hltaberrors = true;
      ignorecase = false;
      keymenu = true;
      matchbracestyle = "highlight";
      mkparents = true;
      savecursor = true;
      scrollbar = true;
      softwrap = true;
      autoclose = true;
      linter = true;
      status = true;
    };
  };
}
