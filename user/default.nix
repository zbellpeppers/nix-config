{lib, ...}: {
  imports =
    if builtins.pathExists ./king
    then [./king]
    else if builtins.pathExists ./queen
    then [./queen]
    else throw "Neither king nor queen configuration found";
}
