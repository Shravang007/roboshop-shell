source common.sh
component=rabbitmq

echo -e "${color} Configure Erlang Repos${nocolor}"
curl -s https://packagecloud.io/install/repositories/${component}/erlang/script.rpm.sh | bash &>>${log_file}


echo -e "${color} Configure ${component} Repos${nocolor}"
curl -s https://packagecloud.io/install/repositories/${component}/${component}-server/script.rpm.sh | bash &>>${log_file}

echo -e "${color} Install ${component} Server${nocolor}"
yum install ${component}-server -y &>>${log_file}

echo -e "${color} Start ${component} Service${nocolor}"
systemctl enable ${component}-server &>>${log_file}
systemctl start ${component}-server &>>${log_file}

echo -e "${color} Add ${component} Application User${nocolor}"
${component}ctl add_user roboshop roboshop123 &>>${log_file}
${component}ctl set_permissions -p / roboshop ".*" ".*" ".*" &>>${log_file}