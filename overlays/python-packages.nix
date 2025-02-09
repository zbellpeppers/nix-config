final: prev: {
  python312 = prev.python312.override {
    packageOverrides = pfinal: pprev: {
      primp = pprev.primp.overrideAttrs (oldAttrs: {
        pname = "primp";
        version = "0.12.0";
        pyproject = true;
        src = prev.fetchFromGitHub {
          owner = "deedy5";
          repo = "primp";
          rev = "v${oldAttrs.version}";
          hash = "sha256-I8+ZoVQkzhdLA1/6ZA2ExG7YUryXVYqM3URjgjXoINU=";
        };
      });
    };
  };
}
