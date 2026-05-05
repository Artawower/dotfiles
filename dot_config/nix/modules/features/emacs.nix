{ config, lib, pkgs, ... }:

let
  cfg      = config.conf.features.emacs;
  isDarwin = pkgs.stdenv.isDarwin;
in

{
  config = lib.mkIf cfg.enable {
    conf.packages.nix = with pkgs; [
      sqlite
      imagemagick
      tree-sitter
      ripgrep
      fd
    ] ++ lib.optionals (!isDarwin) [
      emacs
      isync
      msmtp
      cacert
    ];
  };
}
