{ pkgs, ... }:

let
  system-dashboard = (import ./system.nix { inherit pkgs; }).dashboard;
in
{
  dashboards = pkgs.symlinkJoin {
    name = "grafana-dashboards";
    paths = [
      system-dashboard
    ];
  };
}
