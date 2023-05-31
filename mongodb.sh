
echo -e "\e[32mMongodb repo file\e[0m"
cp mongodb.repo /etc/yum.repos.d/mongo.repo &>>/tmp/roboshop.log

echo -e "\e[32mInstalling mongodb\e[0m"
yum install mongodb-org -y &>>/tmp/roboshop.log

set -i -e 's/127.0.0.0/0.0.0.0/' /etc/mongodb.conf

echo -e "\e[32mstarting mongodb service\e[0m"
systemctl enable mongod &>>/tmp/roboshop.log
systemctl restart mongod &>>/tmp/roboshop.log