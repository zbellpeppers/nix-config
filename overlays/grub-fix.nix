final: prev: {
  grub2 = prev.grub2.overrideAttrs (oldAttrs: {
    postPatch =
      (oldAttrs.postPatch or "")
      + ''
        install_grub_pl=$(find . -name install-grub.pl)
        if [ -n "$install_grub_pl" ]; then
          sed -i '6s/use File::Path qw(make_path);/use File::Path qw(make_path rmtree);/' "$install_grub_pl"
        else
          echo "Warning: install-grub.pl not found"
        fi
      '';
  });
}
