{ inputs, ... }:

{
	imports = [
		inputs.modules.nixosModules.default
	];

	programs.home-manager.enable = true;
}
