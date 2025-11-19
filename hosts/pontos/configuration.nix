# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ pkgs, ... }:

{
	imports =
	[
		./hardware-configuration.nix
		./stylix.nix
		./packages.nix
		./disko.nix
		./services
		./programs
		./../../modules/tailscale.nix
	];

	hardware.enableAllFirmware = true;

	hardware.bluetooth = {
		enable = true;
		powerOnBoot = true;
		package = pkgs.bluez;
		settings = {
			Policy.AutoEnable = "true";
		};
	};
	hardware.graphics = {
		enable = true;
		enable32Bit = true;
	};

	nix = {
		gc = {
			automatic = true;
			dates = "daily";
		};
		settings = {
			experimental-features = [
				"nix-command"
				"flakes"
			];
			extra-platforms = [ "aarch64-linux" ];
			download-buffer-size = 500000000; # 500 MB
		};
	};

	boot.loader.systemd-boot.enable = true;
	boot.loader.systemd-boot.configurationLimit = 10;
	boot.kernelParams = [ "amdgpu.sg_display=0" "usbcore.autosuspend=-1" ];
	boot.loader.efi.canTouchEfiVariables = true;
	boot.kernelPackages = pkgs.linuxPackages_latest;
	boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

	networking.hostName = "pontos";
	networking.networkmanager.enable = true;
	networking.networkmanager.wifi.powersave = true;

	time.timeZone = "Europe/Paris";

	users.users.poseidon = {
		isNormalUser = true;
		extraGroups = [ "wheel" "libvirtd" "docker" "networkmanager" ];
		shell = pkgs.zsh;
	};

	virtualisation.oci-containers.backend = "docker";
	virtualisation.docker.enable = true;
	virtualisation.libvirtd.enable = true;

	environment = {
		sessionVariables = {
			TERM="xterm-256color";
			EDITOR="vim";
			NIXOS_OZONE_WL = "1";
		};
	};

	services.flatpak.enable = true;
	services.openssh.enable = true;


	system.autoUpgrade.enable = true;
	system.autoUpgrade.allowReboot = true;
	system.stateVersion = "25.05";
}
