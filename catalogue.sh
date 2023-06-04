component=catalogue
color="\e[33m"
nocolor="\e[0m"


echo -e "${color}Configuring NodeJs Repos${nocolor}"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>/tmp/roboshop.log

echo -e "${color}Installing NodeJs${nocolor}"
yum install nodejs -y &>>/tmp/roboshop.log

echo -e "${color}Add application user${nocolor}"
useradd roboshop &>>/tmp/roboshop.log

echo -e "${color}Create Application Directory${nocolor}"
rm -rf /app &>>/tmp/roboshop.log
mkdir /app

echo -e "${color}Download application content${nocolor}"
curl -o /tmp/$component.zip https://roboshop-artifacts.s3.amazonaws.com/$component.zip  &>>/tmp/roboshop.log
cd /app

echo -e "${color}Extracting Application content${nocolor}"
unzip /tmp/$component.zip &>>/tmp/roboshop.log
cd /app

echo -e "${color}Install NodeJs Dependencies${nocolor}"
npm install &>>/tmp/roboshop.log

echo -e "${color}Setup System Service${nocolor}"
cp /root/roboshop-shell/$component.service /etc/systemd/system/$component.service &>>/tmp/roboshop.log

echo -e "${color}Start $component Service${nocolor}"
systemctl daemon-reload
systemctl enable $component
systemctl restart $component

echo -e "${color}Copy Mongodb Repo File${nocolor}"
cp /root/roboshop-shell/mongodb.repo /etc/yum.repos.d/mongodb.repo &>>/tmp/roboshop.log

echo -e "${color}Install Mongodb client${nocolor}"
yum install mongodb-org-shell -y &>>/tmp/roboshop.log

echo -e "${color}Load Schema${nocolor}"
mongo --host mongodb-dev.devopspractice73.online </app/schema/$component.js &>>/tmp/roboshop.log
