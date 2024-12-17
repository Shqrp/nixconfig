{ inputs, home-manager }:

let
  system = "x86_64-linux";
in
{
  mkHost =
    { hostname, displays }:
    inputs.nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        ./configuration.nix
        ./hosts/${hostname}.nix

        home-manager.nixosModules.home-manager
      ];
      specialArgs = {
        inherit inputs;
        inherit hostname;
        inherit system;
        inherit displays;
        pkgs = import inputs.nixpkgs {
          inherit system;
          config = {
            allowUnfree = true;
            nvidia.acceptLicense = true;
          };
        };
        pkgs-unstable = import inputs.nixpkgs-unstable {
          inherit system;
          config.allowUnfree = true;
        };
      };
    };
}
