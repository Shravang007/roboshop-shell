source common.sh

component=mysql

echo -e "${color}Disable  ${component} Default Version${nocolor}"
yum module disable ${component} -y &>>${log_file}
stat_check $?


echo -e "${color}Setup the ${component} repo file${nocolor}"
cp /root/roboshop-shell/${component}.repo /etc/yum.repos.d/${component}.repo &>>${log_file}
stat_check $?

echo -e "${color}Install ${component} Community Server${nocolor}"
yum install ${component}-community-server -y &>>${log_file}
stat_check $?

echo -e "${color}Start ${component} Service${nocolor}"
systemctl enable ${component}d &>>${log_file}
systemctl start ${component}d &>>${log_file}
stat_check $?

echo -e "${color}Setup ${component} Password${nocolor}"
${component}_secure_installation --set-root-pass $1 &>>${log_file}
stat_check $?



