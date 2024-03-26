{ pkgs, lib, ... }: 

let a = "a";
in
{
  programs.nix-ld.enable = true;
nix.settings.trusted-users = [ "@wheel" ];
        time.timeZone = "America/New_York";
        networking = {
          hostName = "basic-example";
          useDHCP = true;
          wireless.enable = true;
	  wireless.networks."utexas-iot".psk = "15144799525540142800";
        };
security.sudo.wheelNeedsPassword = false;
      services.openssh.enable = true;
    services.getty.greetingLine = ''<<< Welcome to NixOS system.nixos.label (\m) - \l >>>
eth0: \4{eth0}
eth0: \6{eth0}


wlan0: \4{wlan0}
wlan0: \6{wlan0}
'';
nixpkgs.config.permittedInsecurePackages = [
                "python-2.7.18.7"
              ];
services.openssh.settings.PermitRootLogin = "yes";
        environment.systemPackages = with pkgs; [
 bluez bluez-tools neofetch git htop
vim
libgpiod
gccStdenv
gcc
ripgrep
linux.dev
libcxxStdenv
linuxHeaders
python3
#python2
gnumake
 ];
      #  hardware = {
      #    #bluetooth.enable = true;
      #    raspberry-pi = {
      #      config = {
      #        all = {
      #          base-dt-params = {
      #            #i2c = {
      #            #  enable = true;
      #            #  value = "on";
      #            #};
      #            # enable autoprobing of bluetooth driver
      #            # https://github.com/raspberrypi/linux/blob/c8c99191e1419062ac8b668956d19e788865912a/arch/arm/boot/dts/overlays/README#L222-L224
      #            #krnbt = {
      #            #  enable = true;
      #            #  value = "on";
      #            #};
      #          };
      #        };
      #      };
      #    };
      #    };
            users.users.chessbot = {
              isNormalUser = true;
              extraGroups = [
                "wheel" # Enable ‘sudo’ for the user.
		"dialout"
		"gpio"
              ];
              password = "chessbot";
            };
	system.stateVersion = "23.11";
}
