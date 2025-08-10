# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, pkgs, ... }:

{
	imports =
	[
		./hardware-configuration.nix
		./stylix.nix
		./packages.nix
	];

	hardware.bluetooth.enable = true;
	hardware.bluetooth.powerOnBoot = true;
	hardware.bluetooth.package = pkgs.bluez5;

	# Only for nvidia GPU
	hardware.graphics = {
		enable = true;
		extraPackages = with pkgs; [
			intel-media-driver
		];
	};
	hardware.nvidia = {
		modesetting.enable = true;
		powerManagement.enable = false;
		powerManagement.finegrained = false;
		open = false;
		nvidiaSettings = true;
		package = config.boot.kernelPackages.nvidiaPackages.production;
		prime = {
			intelBusId = "PCI:0:0:2";
			nvidiaBusId = "PCI:0:1:0";
			sync.enable = true;
		};
	};
	services.xserver.videoDrivers = [ "nvidia" ];

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
		};
	};

	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;

	networking.hostName = "pontos";
	networking.networkmanager.enable = true;
	networking.nameservers = [ "1.1.1.1" "1.0.0.1" ];

	time.timeZone = "Europe/Paris";

	users.users.poseidon = {
		isNormalUser = true;
		extraGroups = [ "wheel" "libvirtd" ];
		shell = pkgs.zsh;
	};

	virtualisation.oci-containers.backend = "podman";

	programs.hyprland.enable = true;
	programs.zsh.enable = true;
	programs.waybar.enable = true;

	environment = {
		sessionVariables = rec {
			TERM="xterm-256color";
			EDITOR="vim";
			NIXOS_OZONE_WL = "1";
		};
	};

	services.displayManager.sddm = {
		enable = true;
		wayland.enable = true;
		theme = "catppuccin-mocha";
	};
	services.power-profiles-daemon.enable = true;
	services.pipewire.enable = true;
	services.tailscale.enable = true;

	system.autoUpgrade.enable = true;
	system.autoUpgrade.allowReboot = true;
	system.stateVersion = "25.05";
}
