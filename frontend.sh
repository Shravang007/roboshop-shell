
echo -e "/e[33mInstalling nginx server/e[0m"
yum install nginx -y

echo -e "/e[33mDeleting Previoud data/e[0m"
rm -rf /usr/share/nginx/html/*

echo -e "/e[33mDownloading Content/e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip

echo -e "/e[33mOpening a Directory/e[0m"
cd /usr/share/nginx/html
unzip /tmp/frontend.zip

#we need to add configuration file

echo -e "/e[33mStarting nginx server/e[0m"
systemctl enable nginx
systemctl restart nginx
