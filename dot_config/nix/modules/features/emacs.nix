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
    ];

    conf.packages.brews = lib.optionals isDarwin [
      "d12frosted/emacs-plus/emacs-plus@30"
      "dbus"
      "librsvg"
      "jansson"
      "gnutls"
      "tree-sitter"
      "imagemagick"
      "jpeg"
      "enchant"
      "pkgconf"
      "texinfo"
    ];

    conf.packages.nix = lib.optionals (!isDarwin) (with pkgs; [
      emacs
      pinentry-gnome3
      isync
      msmtp
      cacert
    ]);
  };
}
