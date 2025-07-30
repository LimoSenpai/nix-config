{ inputs, lib, pkgs, ... } : {

  home-manager.tinus = {
    extraSpecialArgs = { inherit inputs pkgs; };
    users = {
      modules = [ 
       hosts/desktop-pc/home.nix
       inputs.self.outputs.homeManagerModules.default
      ];
    };
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
    nixosModules.home-manager
  };
}