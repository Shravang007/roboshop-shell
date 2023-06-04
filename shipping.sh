source common.sh
component=shipping

echo -e "${color} Install Maven Server${nocolor}"
yum install maven -y &>>${log_file}

echo -e "${color} Add Application User${nocolor}"
useradd roboshop &>>${log_file}

echo -e "${color} Create Application Directory ${nocolor}"
rm -rf ${app_path} &>>${log_file}
mkdir ${app_path} &>>${log_file}

echo -e "${color} Download Application content${nocolor}"
curl -L -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip &>>${log_file}

echo -e "${color} Extract Application content${nocolor}"
cd ${app_path} &>>${log_file}
unzip /tmp/${component}.zip &>>${log_file}


echo -e "${color} Download Maven Dependencies${nocolor}"
mvn clean package &>>${log_file}
mv target/${component}-1.0.jar ${component}.jar &>>${log_file}

echo -e "${color} Setup SystemD ${component} Service${nocolor}"
cp /root/roboshop-shell/${component}.service  /etc/systemd/system/${component}.service &>>${log_file}

echo -e "${color} Install Mysql Client${nocolor}"
yum install mysql -y &>>${log_file}

echo -e "${color} Loading Schema${nocolor}"
mysql -h <MYSQL-SERVER-IPADDRESS> -uroot -pRoboShop@1 <${app_path}/schema/${component}.sql &>>${log_file}

echo -e "${color} Start ${component} Service${nocolor}"
systemctl daemon-reload &>>${log_file}
systemctl enable ${component} &>>${log_file}
systemctl restart ${component} &>>${log_file}