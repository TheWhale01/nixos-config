# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ lib, config, pkgs, ... }:

{
	imports =
	[
		./hardware-configuration.nix
		./programs
		./containers
		./services
		./secrets.nix
		./disko.nix
		./packages.nix
	];

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

	services.xserver.videoDrivers = lib.mkDefault [ "nvidia" ];

	hardware.graphics.enable = true;
	hardware.nvidia = {
		modesetting.enable = true;
		powerManagement.enable = false;
		powerManagement.finegrained = false;
		open = false;
		nvidiaSettings = true;
		package = config.boot.kernelPackages.nvidiaPackages.stable;
	};


	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;

	networking = {
		hostName = "erebos";
		networkmanager.enable = true;
		firewall.enable = false;
		enableIPv6 = false;
		nameservers = [ "9.9.9.9" "1.1.1.1" ];
	};


	time.timeZone = "Europe/Paris";

	users.users.hades = {
		isNormalUser = true;
		extraGroups = [ "wheel" "libvirtd" ];
		shell = pkgs.zsh;
	};

	users.groups.arr.members = [
		config.services.radarr.user
		config.services.sonarr.user
		config.services.transmission.user
	];

	users.groups.transmission.members = [
		"transmission"
	];

	systemd.tmpfiles.rules = [
		# R/W permissions for radarr
		"d /data/Movies 0775 hades ${config.services.radarr.group} -"
		# R/W permissions for sonarr
		"d /data/Series 0775 hades ${config.services.sonarr.group} -"
		# R/W permissions for both
		"d ${config.services.transmission.settings.download-dir}/radarr 0775 hades arr -"
		"d ${config.services.transmission.settings.download-dir}/tv-sonarr 0775 hades arr -"
	];

	virtualisation.oci-containers.backend = "podman";
	virtualisation.libvirtd = {
		enable = true;
		qemu = {
			package = pkgs.qemu_kvm;
			runAsRoot = true;
			swtpm.enable = true;
			ovmf = {
				enable = true;
				packages = [(pkgs.OVMF.override {
					secureBoot = true;
					tpmSupport = true;
				}).fd];
			};
		};
	};

	environment.sessionVariables = rec {
		TERM="xterm-256color";
		EDITOR="vim";
	};

	system.autoUpgrade.enable = true;
	system.autoUpgrade.allowReboot = true;
	system.stateVersion = "24.11";
}
