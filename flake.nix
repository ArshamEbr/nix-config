{
  description = "NixOS Flake Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    catppuccin.url = "github:catppuccin/nix";

        stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
  let
  user = {
    name = "arsham";
    host = "Arsham-NixOS";
    system = "x86_64-linux";
    misc = "~/nix-config/misc";
  };
  in
  {
    
    nixosConfigurations.${user.host} = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs user;};
      modules = [ ./config.nix ];
    };
  };
}
