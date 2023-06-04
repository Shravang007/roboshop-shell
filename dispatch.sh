source dispatch.sh

component=dispatch

echo -e "${color} Install Golang${nocolor}"
yum install golang -y &>>${log_file}

echo -e "${color} Add Application User${nocolor}"
useradd roboshop &>>${log_file}

echo -e "${color} Create Application Directory${nocolor}"
rm -rf ${app_path} &>>${log_file}
mkdir ${app_path} &>>${log_file}

echo -e "${color} Download Dispatch Content${nocolor}"
curl -L -o /tmp/dispatch.zip https://roboshop-artifacts.s3.amazonaws.com/dispatch.zip &>>${log_file}

echo -e "${color} Extract Dispatch Content${nocolor}"
cd ${app_path} &>>${log_file}
unzip /tmp/dispatch.zip &>>${log_file}

echo -e "${color} Start Golang${nocolor}"
cd ${app_path} &>>${log_file}
go mod init dispatch &>>${log_file}
go get &>>${log_file}
go build &>>${log_file}

echo -e "${color} Setup SystemD Dispatch Service${nocolor}"
cp /root/roboshop-shell/dispatch.service /etc/systemd/system/dispatch.service &>>${log_file}

echo -e "${color} Start Dispatch Service${nocolor}"
systemctl daemon-reload &>>${log_file}
systemctl enable dispatch &>>${log_file}
systemctl start dispatch &>>${log_file}