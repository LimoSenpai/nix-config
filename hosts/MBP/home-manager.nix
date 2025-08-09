{ inputs, lib, pkgs, stylix,... }: {

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users.tinus = {
      imports = [ 
        ./home.nix
        inputs.self.outputs.homeManagerModules.default
        inputs.self.homeManagerModules.niri
      ];
    };
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
  };
}