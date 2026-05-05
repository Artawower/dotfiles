{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.conf.features.terminal;
  isDarwin = pkgs.stdenv.isDarwin;
in

{
  config = lib.mkIf cfg.enable {
    conf.packages.nix = with pkgs; [
      helix
      marksman
      nil
      bash-language-server
      yaml-language-server

      zellij
      yazi

      starship
      zoxide
      eza
      bat
      fastfetch
      direnv
    ];

    conf.packages.casks = lib.optionals isDarwin [
      "ghostty"
      "cmux"
    ];
  };
}
