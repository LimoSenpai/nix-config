{ inputs, lib, pkgs, ... }: {

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users.tinus = {
      imports = [ 
        ./home.nix
        inputs.self.outputs.homeManagerModules.default
      ];
    };
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
  };
}