{ lib, pkgs }:
{
  openssh = {
    services.openssh = {
      enable = true;
      openFirewall = lib.mkDefault true;
      settings = {
        PubkeyAuthentication = lib.mkDefault true;
        PasswordAuthentication = lib.mkDefault true;
        PermitRootLogin = lib.mkDefault "yes";
      };
    };
  };
}
