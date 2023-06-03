

echo -e "\e[33mDisable  MYSQL Default Version\e[0m"
yum module disable mysql -y &>>/tmp/roboshop.log

set -e

echo -e "\e[33mSetup the MySQL repo file\e[0m"
cp /root/roboshop-shell/mysql.repo /etc/yum.repos.d/mysql.repo &>>/tmp/roboshop.log

echo -e "\e[33mInstall MySql Community Server\e[0m"
yum install mysql-community-server -y &>>/tmp/roboshop.log

echo -e "\e[33mStart Mysql Sever\e[0m"
systemctl enable mysqld &>>/tmp/roboshop.log
systemctl start mysqld &>>/tmp/roboshop.log

echo -e "\e[33mSetup Mysql Password\e[0m"
mysql_secure_installation --set-root-pass RoboShop@1 &>>/tmp/roboshop.log

echo -e "\e[33mCheck MYSQL Password Working\e[0m"
mysql -uroot -pRoboShop@ &>>/tmp/roboshop.log


