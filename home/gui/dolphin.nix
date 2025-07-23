{ config, pkgs, ... }: 

{
 home.packages = [
   pkgs.kdePackages.dolphin
  ];
}
