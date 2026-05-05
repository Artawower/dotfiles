{ config, lib, pkgs, ... }:

let cfg = config.conf.features.terminal; in

{
  config = lib.mkIf cfg.enable {
    conf.packages.nix = with pkgs; [
      helix
      marksman
      nil
      bash-language-server
      yaml-language-server

      zellij
      neovim
      yazi
      ranger
      tmux
      xxh

      starship
      zoxide
      eza
      bat
      fastfetch
      direnv
    ];
  };
}
