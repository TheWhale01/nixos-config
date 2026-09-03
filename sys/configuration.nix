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
	];

	hardware.enableAllFirmware = true;
	hardware.enableRedistributableFirmware = true;

	hardware.bluetooth = {
		enable = true;
		powerOnBoot = true;
		package = pkgs.bluez;
		settings = {
		  General = {
				Experimental = true;
				FastConnectable = true;
			};
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
	networking.firewall.enable = true;
	networking.firewall.checkReversePath = "loose";
	networking.enableIPv6 = true;

	time.timeZone = "Europe/Paris";

	users.users.poseidon = {
		isNormalUser = true;
		extraGroups = [ "wheel" "libvirtd" "podman" "network" "video" "render" "dialout" "networkmanager" ];
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
		};
	};

	services.udev.extraRules = ''
  		ACTION=="add", SUBSYSTEM=="usb", ATTR{idVendor}=="0e8d", ATTR{idProduct}=="0717", RUN+="${pkgs.runtimeShell} -c 'echo 0e8d 0717 > /sys/bus/usb/drivers/btusb/new_id'"
	'';

	security.polkit.enable = true;
	security.rtkit.enable = true;

	system.autoUpgrade.enable = true;
	system.autoUpgrade.allowReboot = true;
	system.stateVersion = "26.05";
}
