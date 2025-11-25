life () {
	cat /sys/class/power_supply/BAT0/capacity
}

config () {
	sudo vim /etc/nixos/configuration.nix
}

bashrc () {
	vim ~/.bashrc
}

rebuild () {
	sudo nixos-rebuild switch
}

copy () {
	if [ -f "$1" ]; then
		xclip -selection clipboard < "$1"
		echo "Copied $1 to clipboard"
	else
		echo "File not found $1"
	fi 
}

update-dots () {
	cp -R ~/.config/alacritty ~/nixos-dotfiles/
	cp -R ~/.config/qtile ~/nixos-dotfiles/
	cp ~/.bashrc ~/nixos-dotfiles/.bashrc
	cd ~/nixos-dotfiles
	git add .
	git commit -m 'update configs $(date +%Y-%m-%d)'
	git push origin master
}


#testing


