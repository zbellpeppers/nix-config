{...}: {
  services.actual = {
    enable = true;
    openFirewall = true;
    settings = {
      "ACTUAL_DATA_DIR" = "/home/zachary/Desktop/All/Documents/Accounting/actual-budget";
      port = 5006;
    };
  };
}
