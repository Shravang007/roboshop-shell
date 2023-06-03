
echo -e "\e[33mInstalling nginx server\e[0m"
yum install nginx -y  &>>/tmp/roboshop.log

echo -e "\e[33mDeleting Previous app content\e[0m"
rm -rf /usr/share/nginx/html/* &>>/tmp/roboshop.log

echo -e "\e[33mDownloading frontend Content\e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip 2>/tmp/error.log

echo -e "\e[33mExtract frontend content\e[0m"
cd /usr/share/nginx/html  &>>/tmp/roboshop.log
unzip /tmp/frontend.zip  &>>/tmp/roboshop.log

echo -e "\e[33mUpdate Frontend Configuration\e[0m"
cp /home/centos/roboshop-shell/roboshop.conf /etc/nginx/default.d/roboshop.conf &>>/tmp/roboshop.log

echo -e "\e[33mStarting nginx server\e[0m"
systemctl enable nginx  &>>/tmp/roboshop.log
systemctl restart nginx  &>>/tmp/roboshop.log

