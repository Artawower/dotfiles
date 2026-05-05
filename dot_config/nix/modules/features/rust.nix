{ config, lib, pkgs, ... }:

let
  cfg      = config.conf.features.rust;
  isDarwin = pkgs.stdenv.isDarwin;
in

{
  config = lib.mkIf cfg.enable {
    conf.packages.nix = lib.optionals (!isDarwin) (with pkgs; [
      rustup
      gcc
      cmake
      pkg-config
    ]);

    conf.packages.brews = lib.optionals isDarwin [
      "rustup"
      "gcc"
      "cmake"
      "llvm"
    ];
  };
}
