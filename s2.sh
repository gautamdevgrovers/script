cd ~/Downloads
sudo apt install wget -y
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -O chrome.deb
wget https://daffo.s3.ap-south-1.amazonaws.com/linux/code.deb -O code.deb
wget https://daffo.s3.ap-south-1.amazonaws.com/linux/installer.tar -O installer.tar
sudo dpkg -i *.deb
sudo apt install -f -y
wget https://daffo.s3.ap-south-1.amazonaws.com/linux/anydesk.deb -O anydesk.deb
sudo dpkg -i anydesk.deb
sudo apt install -f -y
serial_number=$(sudo dmidecode -t system | grep "Serial Number" | awk '{print $3}')

if [ -z "$serial_number" ]; then
    echo "Failed to retrieve the serial number."
    exit 1
fi

# Set the hostname to the serial number
new_hostname="$serial_number"
# Update the hostname in the /etc/hostname file
echo "$new_hostname" | sudo tee /etc/hostname
# Update the hostname in the current session
sudo hostnamectl set-hostname "$new_hostname"
# Update the /etc/hosts file with the new hostname
sudo sed -i "s/127.0.1.1.*/127.0.1.1\t$new_hostname/g" /etc/hosts
echo "Hostname has been changed to $new_hostname"
echo "web5.manaze.io"
echo "172.18.1.1:8090"
echo "https://sites.google.com/a/daffodilsw.com/hr-policies/home"
google-chrome https://web5.manaze.io https://172.18.1.1:8090 https://sites.google.com/a/daffodilsw.com/hr-policies/home


