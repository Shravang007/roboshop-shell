source common.sh

component=dispatch

echo -e "${color} Install Golang${nocolor}"
yum install golang -y &>>${log_file}

 app_presetup

echo -e "${color} Start Golang${nocolor}"
cd ${app_path} &>>${log_file}
go mod init ${component} &>>${log_file}
go get &>>${log_file}
go build &>>${log_file}

 systemd_setup