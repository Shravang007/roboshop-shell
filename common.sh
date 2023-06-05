color="\e[36m"
nocolor="\e[0m"
log_file="/tmp/roboshop.log"
app_path="/app"

app_presetup() {

  echo -e "${color}Add application user${nocolor}"
  useradd roboshop &>>$log_file

  echo -e "${color}Create Application Directory${nocolor}"
  rm -rf ${app_path} &>>$log_file
  mkdir ${app_path}

  echo -e "${color}Download application content${nocolor}"
  curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip  &>>$log_file
  cd ${app_path}

  echo -e "${color}Extracting Application content${nocolor}"
  cd ${app_path}
  unzip /tmp/${component}.zip &>>$log_file

}

nodejs(){
  echo -e "${color}Configuring NodeJs Repos${nocolor}"
  curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>$log_file

  echo -e "${color}Installing NodeJs${nocolor}"
  yum install nodejs -y &>>$log_file

  app_presetup

  echo -e "${color}Install NodeJs Dependencies${nocolor}"
  npm install &>>$log_file

  systemd_setup

}

systemd_setup() {
  echo -e "${color}Setup System Service${nocolor}"
  cp /root/roboshop-shell/${component}.service /etc/systemd/system/${component}.service &>>$log_file

  echo -e "${color} Start ${{component}} Service${nocolor}"
    systemctl daemon-reload &>>${log_file}
    systemctl enable ${component} &>>${log_file}
    systemctl restart ${component} &>>${log_file}

}

mongo_schema_setup() {

  echo -e "${color}Copy Mongodb Repo File${nocolor}"
  cp /root/roboshop-shell/mongodb.repo /etc/yum.repos.d/mongodb.repo &>>${log_file}

  echo -e "${color}Install Mongodb Service${nocolor}"
  yum install mongodb-org-shell -y &>>${log_file}

  echo -e "${color}Load Schema${nocolor}"
  mongo --host mongodb-dev.devopspractice73.online <${app_path}/schema/${component}.js &>>${log_file}


}

maven() {
  echo -e "${color} Install Maven Server${nocolor}"
  yum install maven -y &>>${log_file}

 app_presetup


  echo -e "${color} Download Maven Dependencies${nocolor}"
  mvn clean package &>>${log_file}
  mv target/${component}-1.0.jar ${component}.jar &>>${log_file}

  mysql_mongo_schema_setup

  systemd_setup

}


mysql_schema_setup() {
  echo -e "${color} Install Mysql Client${nocolor}"
  yum install mysql -y &>>${log_file}

  echo -e "${color} Loading Schema${nocolor}"
  mysql -h mysql-dev.devopspractice73.online -uroot -pRoboShop@1 <${app_path}/schema/${component}.sql &>>${log_file}

  }

  python() {
    echo -e "${color} Install Python ${nocolor}"
    yum install python36 gcc python3-devel -y &>>/tmp/roboshop.log

    app_presetup

    echo -e "${color} Install Application Dependencies ${nocolor}"
    cd /app
    pip3.6 install -r requirements.txt &>>/tmp/roboshop.log

    systemd_setup
  }
