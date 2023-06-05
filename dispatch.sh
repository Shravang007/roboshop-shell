source common.sh

component=dispatch

echo -e "${color} Install Golang${nocolor}"
yum install golang -y &>>${log_file}

echo -e "${color} Add Application User${nocolor}"
useradd roboshop &>>${log_file}

echo -e "${color} Create Application Directory${nocolor}"
rm -rf ${app_path} &>>${log_file}
mkdir ${app_path} &>>${log_file}

echo -e "${color} Download ${component} Content${nocolor}"
curl -L -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip &>>${log_file}

echo -e "${color} Extract ${component} Content${nocolor}"
cd ${app_path} &>>${log_file}
unzip /tmp/${component}.zip &>>${log_file}

echo -e "${color} Start Golang${nocolor}"
cd ${app_path} &>>${log_file}
go mod init ${component} &>>${log_file}
go get &>>${log_file}
go build &>>${log_file}

echo -e "${color} Setup SystemD ${component} Service${nocolor}"
cp /root/roboshop-shell/${component}.service /etc/systemd/system/${component}.service &>>${log_file}

echo -e "${color} Start ${component} Service${nocolor}"
systemctl daemon-reload &>>${log_file}
systemctl enable ${component} &>>${log_file}
systemctl start ${component} &>>${log_file}