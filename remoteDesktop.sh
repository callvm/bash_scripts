# Used to turn a remote Ubuntu virtual machine (only accessible via terminal), into a VM that you can visually manage with Remote Desktop on Windows

sudo apt-get update
sudo apt-get install -y xrdp
sudo apt-get install -y xfce4
sudo service xrdp restart
sudo -s

# Then connect via remote desktop using the IP, enter username and pass as normal when prompted.
