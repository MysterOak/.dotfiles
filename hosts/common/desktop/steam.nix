{ ... }:
{
	programs = {
		gamescope = {
			enable = true;
			capSysNice = true;
	};
	steam = {
		enable = true;
		gamescopeSession.enable = true;
		};
	};
	environment = {
		loginShellInit = ''
			[[ "$(tty)" = "/dev/tty1" ]] && ./gs.sh
			'';
		};
}
