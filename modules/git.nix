{ ... }:

{
	programs.git = {
		enable = true;
		settings = {
			init.defaultBranch = "main";
			pull.rebase = false;
			user = {
				name = "TheWhale01";
				email = "ard.rasp01@gmail.com";
			};
		};
	};
}
