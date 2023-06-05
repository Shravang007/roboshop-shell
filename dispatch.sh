source common.sh

component=dispatch

echo -e "${color} Install Golang${nocolor}"
yum install golang -y &>>${log_file}

 app_presetup

 golang

 systemd_setup