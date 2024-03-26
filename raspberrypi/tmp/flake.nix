{
  description = "Build image";
  # update to whatever version
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";

  outputs = { self, nixpkgs }: rec {
    nixosConfigurations.vulpix =
      nixpkgs.legacyPackages.x86_64-linux.pkgsCross.armv7l-hf-multiplatform.nixos {

        imports = [
          "${nixpkgs}/nixos/modules/installer/sd-card/sd-image-armv7l-multiplatform.nix"
          nixosModules.vulpix
        ];
      };
    images.vulpix = nixosConfigurations.vulpix.config.system.build.sdImage;

    nixosModules.vulpix = ({ lib, config, pkgs, ... }: {
      environment.systemPackages = with pkgs; [
        neofetch
      ];

      services.openssh.enable = true;

      users.users.root.openssh.authorizedKeys.keys = [
        "ssh-ed255119 AAAAAAAAAAAAAAAAAAsdfgjgkly idk i dont speak bottom"
      ];

      networking.hostName = "vulpix";
    });
  };
}

