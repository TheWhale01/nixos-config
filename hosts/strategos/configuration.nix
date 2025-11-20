{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./services
    ./packages.nix
    ../../modules/tailscale.nix
  ];

  boot.loader.grub.enable = false;
  boot.loader.generic-extlinux-compatible.enable = true;

  networking.hostName = "strategos";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Paris";

  hardware.enableRedistributableFirmware = true;

  swapDevices = [
    {
      device = "/var/lib/swap/swapfile";
      size = 4096;
    }
  ];

  nix.settings = {
    trusted-users = [ "athena" "root" ];
    experimental-features = [
        "nix-command"
        "flakes"
      ];
  };

  users.users.athena = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    shell = pkgs.zsh;
    packages = with pkgs; [];
  };
  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBcOee301WJTTAQCgHuELLFoQ4mOzL2o6cx6DiQkOiJF poseidon@pontos"
  ];

  programs.zsh.enable = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.05"; # Did you read the comment?
}
