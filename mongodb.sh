
echo -e "\e[33mCopy Mongodb Repo file\e[0m"
cp mongodb.repo /etc/yum.repos.d/mongo.repo &>>/tmp/roboshop.log

echo -e "\e[33mInstalling mongodb\e[0m"
yum install mongodb-org -y &>>/tmp/roboshop.log

echo -e "\e[33mUpdating Mongodb Listen address\e[0m"
sed -i 's/127.0.0.0/0.0.0.0/' /etc/mongod.conf

echo -e "\e[33mstarting mongodb service\e[0m"
systemctl enable mongod &>>/tmp/roboshop.log
systemctl restart mongod &>>/tmp/roboshop.log
