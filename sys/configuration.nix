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

  services.xserver = {
    enable = true;
    videoDrivers = lib.mkDefault [ "nvidia" ];
    windowManager.openbox.enable = true;
  };

  services.displayManager.autoLogin = {
    enable = true;
    user = "hades";
  };

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

  users.groups.media = {
    gid = 982;
  };
  users.users.hades = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "libvirtd"
      "video"
      "input"
      "uinput"
      "render"
      "audio"
      "media"
    ];
    shell = pkgs.zsh;
  };

  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    defaultNetwork.settings.dns_enabled = true;
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

  systemd.tmpfiles.rules = [
    "d /data/downloads	0775	${config.services.transmission.user}	${config.services.transmission.group} -"
    "d /data/Series     0775	${config.services.sonarr.user}		    ${config.services.sonarr.group}       -"
    "d /data/Animes     0775 	${config.services.sonarr.user} 		    ${config.services.sonarr.group}       -"
    "d /data/Movies     0775 	${config.services.radarr.user} 		    ${config.services.radarr.group}       -"
  ];

  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = true;
  system.stateVersion = "24.11";
}
