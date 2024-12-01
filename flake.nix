{
  description = "NixOS Flake Configuration";

  inputs = {
    #  sriov-Module = {
    #  url = "github:cyberus-technology/nixos-sriov";
    #  flake = false;
    #};
    #sriovModule.url = "github:cyberus-technology/nixos-sriov";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    catppuccin.url = "github:catppuccin/nix";
    stylix.url = "github:danth/stylix";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
  let
  #  sriov-modules = builtins.fetchGit {
  #  url = "https://github.com/cyberus-technology/nixos-sriov";
  #  ref = "main";
  #};
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
