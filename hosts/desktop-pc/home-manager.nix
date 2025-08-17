{ inputs, lib, pkgs, ... }: {
  home-manager = {
    extraSpecialArgs = { inherit inputs; };

    users.tinus = { pkgs, lib, inputs, ... }: {
      # HM needs these so .mozilla/... is *inside* $HOME
      home.username = "tinus";
      home.homeDirectory = "/home/tinus";
      home.stateVersion = "25.05";

      imports = [
        ./home.nix
        inputs.self.homeManagerModules.default
        inputs.self.homeManagerModules.niri
      ];


      # silence Stylix warning + theme the right profile
      stylix.targets.firefox.profileNames = [ "zen" ];
    };

    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
  };
}
