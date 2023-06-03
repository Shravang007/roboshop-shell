

echo -e "\e[33m Install Python\e[0m"
yum install python36 gcc python3-devel -y &>>/tmp/roboshop.log

echo -e "\e[33m Add Application User\e[0m"
useradd roboshop &>>/tmp/roboshop.log


echo -e "\e[33m Creat Application Directory\e[0m"
rm -rf /app &>>/tmp/roboshop.log
mkdir /app &>>/tmp/roboshop.log

echo -e "\e[33m Download Application Content \e[0m"
curl -L -o /tmp/payment.zip https://roboshop-artifacts.s3.amazonaws.com/payment.zip &>>/tmp/roboshop.log
cd /app &>>/tmp/roboshop.log

echo -e "\e[33m Extract Application Content\e[0m"
unzip /tmp/payment.zip &>>/tmp/roboshop.log


echo -e "\e[33m Install Application Dependencies\e[0m"
cd /app &>>/tmp/roboshop.log
pip3.6 install -r requirements.txt &>>/tmp/roboshop.log

echo -e "\e[33m Setup SystemD Payment Service\e[0m"
cp /root/roboshop-shell/payment.service /etc/systemd/system/payment.service &>>/tmp/roboshop.log

echo -e "\e[33m Start Payment\e[0m"
systemctl daemon-reload &>>/tmp/roboshop.log
systemctl enable payment &>>/tmp/roboshop.log
systemctl restart payment &>>/tmp/roboshop.log