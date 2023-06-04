source common.sh

component=catalogue

nodejs


echo -e "${color}Copy Mongodb Repo File${nocolor}"
cp /root/roboshop-shell/mongodb.repo /etc/yum.repos.d/mongodb.repo &>>$log_file

echo -e "${color}Install Mongodb client${nocolor}"
yum install mongodb-org-shell -y &>>$log_file

echo -e "${color}Load Schema${nocolor}"
mongo --host mongodb-dev.devopspractice73.online <${app_path}/schema/$component.js &>>$log_file
