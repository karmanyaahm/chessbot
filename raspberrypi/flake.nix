# https://artemis.sh/2023/06/06/cross-compile-nixos-for-great-good.html
{
  description = "raspberry-pi-nix example";
  nixConfig = {
    extra-substituters = [ "https://raspberry-pi-nix.cachix.org" ];
    extra-trusted-public-keys = [
      "raspberry-pi-nix.cachix.org-1:WmV2rdSangxW0rZjY/tBvBDSaNFQ3DyEQsVw8EvHn9o="
    ];
  };
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/8bf65f17d8070a0a490daf5f1c784b87ee73982c";
    raspberry-pi-nix.url = "github:tstat/raspberry-pi-nix";
    deploy-rs.url = "github:serokell/deploy-rs";

  };

  outputs = { self, nixpkgs, raspberry-pi-nix, deploy-rs }:
    let
      inherit (nixpkgs.lib) nixosSystem;
      basic-config = import ./configuration.nix;
  nixosConfigurations.rpi-example = nixosSystem {
          system = "aarch64-linux";
          modules = [ 

({ ... }: {
config.system.autoUpgrade.channel = "https://github.com/NixOS/nixpkgs/archive/8bf65f17d8070a0a490daf5f1c784b87ee73982c.tar.gz";
          config = {
#environment.etc."nixos/configuration.nix" = import ./
          };
        })

 raspberry-pi-nix.nixosModules.raspberry-pi

 basic-config ];
      };
    in
    {
   
      # nix shell #.sd; zstdcat result/sd-image/nixos*-linux.img.zst | sudo dd of=/dev/SDABGSCNISNTIN status=progress bs=4M
      sd = nixosConfigurations.rpi-example.config.system.build.sdImage;
# to deploy change ip address below and type `nix run github:serokell/deploy-rs`
    deploy.nodes.vulpix = {
      profiles.system = { 
        user = "root";
        path = deploy-rs.lib.aarch64-linux.activate.nixos nixosConfigurations.rpi-example;
      };

      # this is how it ssh's into the target system to send packages/configs over.
      sshUser = "chessbot";
      user = "root";
      sshOpts = [ "-o" "PreferredAuthentications=password" ];

      hostname = "10.159.66.197";
    };
  };
}
