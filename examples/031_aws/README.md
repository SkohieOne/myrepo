# Ejemplo Inventario dinámico AWS

## 1. Instalación de los collections de AWS

````markdown
ansible-galaxy collection install amazon.cloud
ansible-galaxy collection install amazon.aws
````

## 2. Instalación del cliente AWS en máquina agente de control ansible

````markdown
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo apt install unzip
unzip awscliv2.zip
sudo ./aws/install 
aws --version
aws configure #Se necesita un usuario con acceso
````

Comprobamos que todo funciona del lado del AWS Cli

````markdown
aws sts get-caller-identity
````

## 3. Creación de llave para EC2

````markdown
aws ec2 create-key-pair --key-name mi-clave-ec2 --query "KeyMaterial" --output text > /home/vagrant/.ssh/mi-clave-ec2.pem
chmod 400 /home/vagrant/.ssh/mi-clave-ec2.pem
````