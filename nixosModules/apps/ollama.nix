{  inputs, config, lib, pkgs, ... }:
{
  options.ollama.enable = lib.mkEnableOption "Power Profiles Daemon";

  config = lib.mkIf config.ollama.enable {
    ollama = {
      services.ollama = {
        enable = true;
        acceleration = "cuda";
        host = "0.0.0.0";
        environmentVariables.OLLAMA_LOW_VRAM = "false";
      };
    };
  };
}
