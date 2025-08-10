{ pkgs, ... }:

pkgs.mkShell
{
	nativeBuildInputs = with pkgs; [
		nodejs
	];
	shellHook = ''
		echo 'webdev shell'
	'';
}
