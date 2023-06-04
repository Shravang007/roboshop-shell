source common.sh

echo -e " ${color} Copy MongoDB Repo file  ${nocolor} "
cp /root/roboshop-shell/mongodb.repo /etc/yum.repos.d/mongodb.repo   &>>/tmp/roboshop.log


echo -e " ${color} Installing MongoDB Server ${nocolor} "
yum install mongodb-org -y  &>>/tmp/roboshop.log


echo -e " ${color} Update MongoDB Listen Address ${nocolor} "
sed -i 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf


echo -e " ${color} Start MongoDB Service ${nocolor} "
systemctl enable mongod  &>>/tmp/roboshop.log
systemctl restart mongod  &>>/tmp/roboshop.log
