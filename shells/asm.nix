{ pkgs, ... }:

pkgs.mkShell
{
	nativeBuildInputs = with pkgs; [
		nasm
		gnumake
		valgrind
		gcc
		clang
		bear
	];
	shellHook = ''
		echo 'ASM shell'
	'';
}
