# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{
  lib,
  config,
  pkgs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ./containers
    ./services
    ./secrets.nix
    ./disko.nix
    ./packages.nix
  ];

  programs.zsh.enable = true;

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
  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];
  boot.loader.efi.canTouchEfiVariables = true;

  networking = {
    hostName = "erebos";
    networkmanager.enable = true;
    firewall.enable = false;
    enableIPv6 = false;
    nameservers = [
      "9.9.9.9"
      "149.112.112.112"
    ];
    interfaces = {
      enp7s0.wakeOnLan.enable = true;
    };
  };

  time.timeZone = "Europe/Paris";

  users.users.hades = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "libvirtd"
    ];
    shell = pkgs.zsh;
  };
  # users.users.blogbuilder.group = "blogbuilder";
  # users.groups.blogbuilder = {};

  system.activationScripts.setPerms = {
    text = ''
      			echo Setting up /data/Movies permissions
      			chown -R hades:${config.services.radarr.user} /data/Movies
      			chmod -R 0775 /data/Movies
      			find /data/Movies -type f -exec chmod 664 {} \;

      			echo Setting up /data/Animes permissions
      			chown -R hades:${config.services.sonarr.user} /data/Animes
      			chmod -R 0775 /data/Animes
      			find /data/Animes -type f -exec chmod 664 {} \;

      			echo Setting up /data/Series permissions
      			chown -R hades:${config.services.sonarr.user} /data/Series
      			chmod -R 0775 /data/Series
      			find /data/Series -type f -exec chmod 664 {} \;
      		'';
  };

  virtualisation.oci-containers.backend = "podman";
  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
      runAsRoot = true;
      swtpm.enable = true;
    };
  };

  environment.sessionVariables = rec {
    TERM = "xterm-256color";
    EDITOR = "vim";
  };

  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = true;
  system.stateVersion = "24.11";
}
