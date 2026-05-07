{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.conf.features.terminal;
in

{
  config = lib.mkIf cfg.enable {
    conf.packages.nix = with pkgs; [
      (import ../../pkgs/xonsh.nix { inherit pkgs; })

      helix
      marksman
      nil
      bash-language-server
      yaml-language-server

      zellij
      yazi
      tmux

      starship
      zoxide
      eza
      fastfetch
      direnv
    ];
  };
}
