#!/bin/bash

# Update packages
sudo apt update
sudo apt upgrade -y

# Install Apache
sudo apt install apache2 -y

# Start and enable Apache
sudo systemctl start apache2
sudo systemctl enable apache2

# Install PHP and required modules
sudo apt install php libapache2-mod-php php-mysql -y

# Restart Apache
sudo systemctl restart apache2

# Install MySQL
sudo apt install mysql-server -y

# Set root password
sudo mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY 'Password.1';"

# Secure MySQL installation
sudo mysql_secure_installation <<EOF

Y
Password.1
Password.1
Y
Y
Y
Y
EOF

# Restart MySQL
sudo systemctl restart mysql

# Install phpMyAdmin (optional)
sudo apt install phpmyadmin -y

# Enable PHP mcrypt module (required for phpMyAdmin)
sudo phpenmod mcrypt
sudo systemctl restart apache2

# Configure Apache for phpMyAdmin
echo 'Include /etc/phpmyadmin/apache.conf' | sudo tee -a /etc/apache2/apache2.conf

# Restart Apache
sudo systemctl restart apache2

# Output success message
echo "LAMP stack installation complete. Open your browser and visit http://$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4)"




