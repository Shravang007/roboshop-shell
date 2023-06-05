

color="\e[35m"
nocolor="\e[0m"
log_file="/tmp/roboshop.log"
app_path="/app"


nodejs(){
  echo -e "${color}Configuring NodeJs Repos${nocolor}"
  curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>$log_file

  echo -e "${color}Installing NodeJs${nocolor}"
  yum install nodejs -y &>>$log_file

  echo -e "${color}Add application user${nocolor}"
  useradd roboshop &>>$log_file

  echo -e "${color}Create Application Directory${nocolor}"
  rm -rf ${app_path} &>>$log_file
  mkdir ${app_path}

  echo -e "${color}Download application content${nocolor}"
  curl -o /tmp/$component.zip https://roboshop-artifacts.s3.amazonaws.com/$component.zip  &>>$log_file
  cd ${app_path}

  echo -e "${color}Extracting Application content${nocolor}"
  unzip /tmp/$component.zip &>>$log_file
  cd ${app_path}

  echo -e "${color}Install NodeJs Dependencies${nocolor}"
  npm install &>>$log_file

  echo -e "${color}Setup System Service${nocolor}"
  cp /root/roboshop-shell/$component.service /etc/systemd/system/{$component}.service &>>$log_file

  echo -e "${color}Start $component Service${nocolor}"
  systemctl daemon-reload
  systemctl enable $component
  systemctl restart $component

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

  echo -e "${color} Add Application User${nocolor}"
  useradd roboshop &>>${log_file}

  echo -e "${color} Create Application Directory ${nocolor}"
  rm -rf ${app_path} &>>${log_file}
  mkdir ${app_path} &>>${log_file}

  echo -e "${color} Download Application content${nocolor}"
  curl -L -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip &>>${log_file}

  echo -e "${color} Extract Application content${nocolor}"
  cd ${app_path} &>>${log_file}
  unzip /tmp/${component}.zip &>>${log_file}


  echo -e "${color} Download Maven Dependencies${nocolor}"
  mvn clean package &>>${log_file}
  mv target/${component}-1.0.jar ${component}.jar &>>${log_file}

  echo -e "${color} Setup SystemD ${component} Service${nocolor}"
  cp /root/roboshop-shell/${component}.service  /etc/systemd/system/${component}.service &>>${log_file}

  echo -e "${color} Start ${component} Service${nocolor}"
  systemctl daemon-reload &>>${log_file}
  systemctl enable ${component} &>>${log_file}
  systemctl restart ${component} &>>${log_file}

}
