{ lib, pkgs }:
let
  definitionFiles = [
    ./polkit-agent.nix
    ./smartcard.nix
    ./power-profiles-daemon.nix
    ./storage-daemons.nix
    ./gnome-keyring.nix
    ./bluetooth-manager.nix
    ./printing.nix
    ./xserver.nix
    ./openssh.nix
    ./sudo-poweroff.nix
    ./ollama.nix
  ];

  mergeDefinitions = file: (import file { inherit lib pkgs; });
  emptyRegistry = {};
  registries = map mergeDefinitions definitionFiles;
  registry = lib.foldl' lib.recursiveUpdate emptyRegistry registries;
in
  registry
