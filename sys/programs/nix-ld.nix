{ pkgs, ... }:

{
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    dotnet-sdk_9
    omnisharp-roslyn
  ];
}
