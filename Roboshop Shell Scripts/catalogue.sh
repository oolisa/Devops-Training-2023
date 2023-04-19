script_path=$(dirname $0)
source ${script_path}/common.sh

echo -e "\e[34m>>>>>>>>> Configuring NodeJS repos <<<<<<<<\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash

echo -e "\e[34m>>>>>>>>> Install NodeJS <<<<<<<<\e[0m"
yum install nodejs -y

echo -e "\e[34m>>>>>>>>> Add the App User <<<<<<<<\e[0m"
useradd ${app_user}

echo -e "\e[34m>>>>>>>>> Create New App Directory <<<<<<<<\e[0m"
rm -rf /app 
mkdir /app 

echo -e "\e[34m>>>>>>>>> Download App zip files <<<<<<<<\e[0m"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip

cd /app 

echo -e "\e[34m>>>>>>>>> Unzip App file <<<<<<<<\e[0m"
unzip /tmp/catalogue.zip

echo -e "\e[34m>>>>>>>>> Install dependencies for NodeJs <<<<<<<<\e[0m"
cd /app 
npm install 

echo -e "\e[34m>>>>>>>>> Copy catalogue service SystemD <<<<<<<<\e[0m"
cp ${script_path}/catalogue.service /etc/systemd/system/catalogue.service

echo -e "\e[34m>>>>>>>>> Start the Catalogue Service <<<<<<<<\e[0m"
systemctl daemon-reload
systemctl enable catalogue 
systemctl start catalogue

echo -e "\e[34m>>>>>>>>> Copy the Mongo repo <<<<<<<<\e[0m"
cp ${script_path}/mongo.repo /etc/yum.repos.d/mongo.repo

echo -e "\e[34m>>>>>>>>> Install the MongoDB client <<<<<<<<\e[0m"
yum install mongodb-org-shell -y

echo -e "\e[34m>>>>>>>>> Load the Schema <<<<<<<<\e[0m"
mongo --host mongodb-otdynamic.online </app/schema/catalogue.js


