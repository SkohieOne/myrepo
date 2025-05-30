apt-get update
apt install software-properties-common -y
apt-add-repository ppa:ansible/ansible
apt-get install ansible net-tools -y
# Add vagrant user to sudoers
echo "vagrant ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/vagrant