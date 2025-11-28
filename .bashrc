alias life='cat /sys/class/power_supply/BAT0/capacity'
alias config='sudo nano /etc/nixos/configuration.nix'
alias bashrc='nano ~/.bashrc'
alias rebuild='sudo nixos-rebuild switch'

copy () {
	if [ -f "$1" ]; then
		xclip -selection clipboard < "$1"
		echo "Copied $1 to clipboard"
	else
		echo "File not found $1"
	fi 
}

# VERSION CONTROL
update-dots () {
	cp -R ~/.config/alacritty ~/nixos-dotfiles/
	cp -R ~/.config/qtile ~/nixos-dotfiles/
	cp /etc/nixos/configuration.nix ~/nixos-dotfiles/configuration.nix 
	cp /etc/nixos/flake.nix ~/nixos-dotfiles/flake.nix 
	cp /etc/nixos/flake.lock ~/nixos-dotfiles/flake.lock 

	cp ~/.bashrc ~/nixos-dotfiles/.bashrc
	cd ~/nixos-dotfiles 
	git add .
	git commit -m "update configs $(date +%Y-%m-%d)"
	git push origin master
}

rollback-qtile () {
	cp -R ~/nixos-dotfiles/qtile ~/.config
}
br () {
	brightnessctl set ${1}%
}
