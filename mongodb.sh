
echo -e "\e[31mCopy Mongodb Repo file\e[0m"
cp mongodb.repo /etc/yum.repos.d/mongo.repo &>>/tmp/roboshop.log

echo -e "\e[31mInstalling mongodb\e[0m"
yum install mongodb-org -y &>>/tmp/roboshop.log

echo -e "\e[31mUpdating Mongodb listing address\e[0m"
sed -i -e 's/127.0.0.0/0.0.0.0/' /etc/mongodb.conf

echo -e "\e[31mstarting mongodb service\e[0m"
systemctl enable mongod &>>/tmp/roboshop.log
systemctl restart mongod &>>/tmp/roboshop.log
