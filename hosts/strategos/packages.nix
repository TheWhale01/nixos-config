{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    vim
    libraspberrypi
    wget
    git
    btop
  ];
}
