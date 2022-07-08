firstAptInstalls(){
# Apt - Mass Installers
	chrome-gnome-shell \
	gnome-tweak-tool \
	gvfs-backends \
	obs-studio \
	virtualbox \
}

spotifyInstall(){
	curl -sS https://download.spotify.com/debian/pubkey_5E3C45D7B312C643.gpg | sudo apt-key add -
	echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
	sudo apt-get update
	sudo apt-get -y install spotify-client
}

balenaEtcherInstall(){
	curl -1sLf \
		'https://dl.cloudsmith.io/public/balena/etcher/setup.deb.sh' \
		| sudo -E bash
	sudo apt-get update
	sudo apt-get -y install balena-etcher-electron
}

gimpInstall(){
	sudo add-apt-repository -y ppa:ubuntuhandbook1/gimp
	sudo apt update
	sudo apt -y install gimp
}

linssidInstall(){
	sudo add-apt-repository -y ppa:wseverin/ppa
	sudo apt update
	sudo apt -y install linssid
}

nohangInstall(){
	sudo systemctl enable --now nohang-desktop.service
}

signalInstall(){
	wget -O- https://updates.signal.org/desktop/apt/keys.asc | gpg --dearmor > signal-desktop-keyring.gpg
	cat signal-desktop-keyring.gpg | sudo tee -a /usr/share/keyrings/signal-desktop-keyring.gpg > /dev/null
	echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/signal-desktop-keyring.gpg] https://updates.signal.org/desktop/apt xenial main' | \
		sudo tee -a /etc/apt/sources.list.d/signal-xenial.list
	sudo apt update && sudo apt install signal-desktop
}

flatpakInstall(){
	sudo apt -y install gnome-software-plugin-flatpak
	flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
}

xanmodttInstall(){
	echo 'deb http://deb.xanmod.org releases main' | sudo tee /etc/apt/sources.list.d/xanmod-kernel.list
	wget -qO - https://dl.xanmod.org/gpg.key | sudo apt-key --keyring /etc/apt/trusted.gpg.d/xanmod-kernel.gpg add -
	sudo apt update && sudo apt install linux-xanmod-tt
}


#################################


conkyInstall(){
	curl -sL -o conky-x86_64.AppImage \
		$(curl -sL https://api.github.com/repos/brndnmtthws/conky/releases/latest | \
		jq --raw-output '.assets[0] | .browser_download_url')
	sudo chmod +x conky-x86_64.AppImage
	ail-cli integrate conky-x86_64.AppImage
}

beeperInstall(){
	curl -L https://download.beeper.com/linux/appImage/x64 \
		--output beeper.AppImage
	sudo chmod +x beeper.AppImage
	ail-cli integrate beeper.AppImage
}

obsidianInstall(){
	curl -L $(curl -s "https://api.github.com/repos/obsidianmd/obsidian-releases/releases/latest" | \
		jq --raw-output '.assets[2].browser_download_url' | head -n1) \
		--output obsidian.AppImage
	sudo chmod +x obsidian.AppImage
	ail-cli integrate obsidian.AppImage
}

clickupInstall(){
	curl -L https://desktop.clickup.com/linux \
		--output clickup.AppImage
	sudo chmod +x clickup.AppImage
	ail-cli integrate clickup.AppImage
}

plexampInstall(){
	curl https://plexamp.plex.tv/plexamp.plex.tv/desktop/Plexamp-4.2.1.AppImage \
		--output plexamp.AppImage
	sudo chmod +x plexamp.AppImage
	ail-cli integrate plexamp.AppImage
}


######################


cd ~/Applications/Downloads

firefoxDevInstall(){
curl --location "https://download.mozilla.org/?product=firefox-devedition-latest-ssl&os=linux64&lang=en-US" | \
	tar --extract --verbose --preserve-permissions -j
sudo cp -rp firefox /opt/firefoxdev
sudo rm -rf firefox
sudo chown -R $USER /opt/firefoxdev
sudo echo \
"[Desktop Entry]
Name=Firefox Developer
GenericName=Firefox Developer Edition
Exec=/opt/firefoxdev/firefox %u
Terminal=false
Icon=/opt/firefoxdev/browser/chrome/icons/default/default128.png
Type=Application
Categories=Application;Network;X-Developer;
Comment=Firefox Developer Edition Web Browser.
StartupWMClass=Firefox Developer Edition" > \
	~/.local/share/applications/firefox_dev.desktop
sudo chmod +x ~/.local/share/applications/firefox_dev.desktop
}

filezillaProInstall(){
curl "https://docs.travishinton.us/index.php/s/Jx4LiAQDsbfPdn2/download/FileZilla_Pro_3.59.0_x86_64-linux-gnu.tar.bz2" | \
	tar --extract --verbose --preserve-permissions -j
sudo cp -rp FileZilla3 /opt/FileZilla3
sudo rm -rf FileZilla3
sudo chown -R $USER /opt/FileZilla3
sudo echo \
"[Desktop Entry]
Name=FileZilla
GenericName=FTP client
GenericName[da]=FTP-klient
GenericName[de]=FTP-Client
GenericName[fr]=Client FTP
Comment=Download and upload files via FTP, FTPS and SFTP
Comment[da]=Download og upload filer via FTP, FTPS og SFTP
Comment[de]=Dateien über FTP, FTPS und SFTP übertragen
Comment[fr]=Transférer des fichiers via FTP, FTPS et SFTP
Exec=/opt/FileZilla3/bin/filezilla %U
Terminal=false
Icon=/opt/FileZilla3/share/filezilla/resources/480x480/filezilla_pro.png
Type=Application
Categories=Network;FileTransfer;
Version=1.0" > \
	~/.local/share/applications/filezilla.desktop
sudo chmod +x ~/.local/share/applications/filezilla.desktop
}


#################################################


mullvadInstall(){
	curl -L https://mullvad.net/download/app/deb/latest/ \
		--output mullvad.deb
	sudo apt-get -y install ./mullvad.deb
	sudo rm mullvad.deb
}

protonmailBridgeInstall(){
	curl https://protonmail.com/download/bridge/protonmail-bridge_2.1.3-1_amd64.deb \
		--output pmbridge.deb
	sudo apt-get -y install ./pmbridge.deb
	sudo rm pmbridge.deb
}

videoDownloadHelperInstall(){
	curl https://github.com/mi-g/vdhcoapp/releases/download/v1.6.3-net.downloadhelper.coapp-1.6.3-1_amd64.deb \
		--output vdh.deb
	sudo apt-get -y install ./vdh.deb
	sudo rm vdh.deb
}

nodejsInstall(){
	curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
	sudo apt-get install -y nodejs
}

devKinstaInstall(){
	curl -L https://kinsta.com/devkinsta/download/?version=linux \
		--output devkinsta.deb
	sudo apt-get -y install ./devkinsta.deb
	sudo rm devkinsta.deb
}


#################################################

# Post installation commands
postInstalls(){
	#ufw enable
	sudo tailscale up --accept-routes
	rclone config
}