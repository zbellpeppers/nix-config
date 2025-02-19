final: prev: {
  grub2 = prev.grub2.overrideAttrs (oldAttrs: {
    postPatch =
      (oldAttrs.postPatch or "")
      + ''
        sed -i '6s/use File::Path qw(make_path);/use File::Path qw(make_path rmtree);/' \
          nixos/modules/system/boot/loader/grub/install-grub.pl
      '';
  });
}
