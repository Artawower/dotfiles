{ config, lib, pkgs, ... }:

let
  cfg      = config.conf.features.tiling;
  isDarwin = pkgs.stdenv.isDarwin;
in

{
  config = lib.mkIf cfg.enable {
    conf.packages.nix = lib.optionals (!isDarwin) (with pkgs; [
      niri
      xremap
      xwayland-satellite
      wl-clipboard
      wl-clip-persist
      waybar
      swww
      fuzzel
      swaynotificationcenter
      brightnessctl
      playerctl
      grim
      slurp
      swappy
    ]);

    conf.packages.casks = lib.optionals isDarwin [
      "nikitabobko/tap/aerospace"
    ];

    conf.packages.brews = lib.optionals isDarwin [
      "koekeishiya/formulae/skhd"
      "FelixKratz/formulae/borders"
    ];
  };
}
