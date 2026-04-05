# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ lib, pkgs, ... }:

{
	imports =
	[
		./hardware-configuration.nix
		./stylix.nix
		./packages.nix
		./disko.nix
		./services
		./programs
		./jovian.nix
	];

	hardware.enableAllFirmware = true;
	hardware.enableRedistributableFirmware = true;

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
			download-buffer-size = 500000000; # 500 MB
			extra-platforms = [ "aarch64-linux" ];
		};
	};

	boot.loader.systemd-boot.enable = true;
	boot.loader.systemd-boot.configurationLimit = 10;
	boot.kernelParams = [ "amdgpu.sg_display=0" ];
	boot.loader.efi.canTouchEfiVariables = true;
	boot.binfmt.emulatedSystems = [ "aarch64-linux" ];
	boot.kernelPackages = pkgs.linuxPackages_latest;

	networking.hostName = "pontos";
	networking.networkmanager.enable = true;
	networking.firewall.enable = lib.mkDefault false;

	time.timeZone = "Europe/Paris";

	users.users.poseidon = {
		isNormalUser = true;
		extraGroups = [ "wheel" "libvirtd" "podman" "networkmanager" "video" "render" "dialout" ];
		shell = pkgs.zsh;
	};

	virtualisation.oci-containers.backend = "podman";
	virtualisation.podman.enable = true;
	virtualisation.libvirtd.enable = true;

	environment = {
		sessionVariables = {
			TERM="xterm-256color";
			EDITOR="vim";
			NIXOS_OZONE_WL = "1";
			STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
		};
	};

	system.autoUpgrade.enable = true;
	system.autoUpgrade.allowReboot = true;
	system.stateVersion = "25.05";
}
