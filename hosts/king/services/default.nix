{...}: {
  services.actual = {
    enable = true;
    port = 5006;
    openFirewall = true;
    settings = {
      "ACTUAL_DATA_DIR" = "/home/zachary/Desktop/All/Documents/Accounting/actual-budget";
    };
  };
}
