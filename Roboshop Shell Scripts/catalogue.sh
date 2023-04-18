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

