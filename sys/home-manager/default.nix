{ inputs, ... }:

{
	imports = [
		inputs.modules.nixosModules.homeManager
	];

	programs.home-manager.enable = true;
}
