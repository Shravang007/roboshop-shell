source common.sh
component=shipping

maven


echo -e "${color} Install Mysql Client${nocolor}"
yum install mysql -y &>>${log_file}

echo -e "${color} Loading Schema${nocolor}"
mysql -h mysql-dev.devopspractice73.online -uroot -pRoboShop@1 <${app_path}/schema/${component}.sql &>>${log_file}