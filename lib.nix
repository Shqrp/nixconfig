{
  inputs,
  home-manager,
  noctalia-greeter,
}:

let
  system = "x86_64-linux";
in
{
  mkHost =
    {
      hostname,
      displays,
      displayConfig,
    }:
    inputs.nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        ./configuration.nix
        ./hosts/${hostname}.nix

        home-manager.nixosModules.home-manager
        noctalia-greeter.nixosModules.default
        {
          nixpkgs = {
            inherit system;
            config = {
              allowUnfree = true;
              nvidia.acceptLicense = true;
            };
          };
        }
      ];
      specialArgs =
        let
          getDisplay = index: builtins.elemAt displays index;
        in
        {
          inherit inputs;
          inherit hostname;
          inherit system;
          inherit displays;
          inherit displayConfig;
          inherit getDisplay;
          pkgs-unstable = import inputs.nixpkgs-unstable {
            inherit system;
            config.allowUnfree = true;
          };
        };
    };
}
