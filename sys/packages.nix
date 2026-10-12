{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    vim
    libraspberrypi
    wget
    git
    btop
    wakeonlan
    fastfetch
    usbutils
    gnumake
  ];
}
