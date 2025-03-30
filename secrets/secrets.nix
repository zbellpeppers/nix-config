let
  zachary = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIID+lc8OXN8J15tOj2Q+d4R6Zl/82FiUKLN5pPMIgR/E";
  users = [zachary];

  king = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKG/aELnbQOQOxr4k1zrHNjVFiwMxWx2OGlVETsmYMJ1";
  systems = [king];
in {
  "cf-dns-token.age".publicKeys = [zachary];
}
