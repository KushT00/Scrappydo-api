#!/bin/bash

# Install Chrome and ChromeDriver
apt-get update && apt-get install -y wget gnupg unzip curl
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list
apt-get update
apt-get install -y google-chrome-stable
apt-get clean

# Get the Chrome version and download the matching ChromeDriver
CHROME_VERSION=$(google-chrome --version | grep -oE "[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}")
CHROMEDRIVER_VERSION=$(curl -s "https://chromedriver.storage.googleapis.com/LATEST_RELEASE_$CHROME_VERSION")
wget -q "https://chromedriver.storage.googleapis.com/${CHROMEDRIVER_VERSION}/chromedriver_linux64.zip"
unzip chromedriver_linux64.zip
mv chromedriver /usr/bin/chromedriver
chmod +x /usr/bin/chromedriver
rm chromedriver_linux64.zip
