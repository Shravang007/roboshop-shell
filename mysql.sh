source common.sh

component=mysql

echo -e "${color}Disable  ${component} Default Version${nocolor}"
yum module disable ${component} -y &>>${log_file}

echo -e "${color}Setup the ${component} repo file${nocolor}"
cp /root/roboshop-shell/${component}.repo /etc/yum.repos.d/${component}.repo &>>${log_file}

echo -e "${color}Install ${component} Community Server${nocolor}"
yum install ${component}-community-server -y &>>${log_file}

echo -e "${color}Start ${component} Sever${nocolor}"
systemctl enable ${component}d &>>${log_file}
systemctl start ${component}d &>>${log_file}

echo -e "${color}Setup ${component} Password${nocolor}"
${component}_secure_installation --set-root-pass RoboShop@1 &>>${log_file}

echo -e "${color}Check ${component} Password Working${nocolor}"
${component} -uroot -pRoboShop@ &>>${log_file}


