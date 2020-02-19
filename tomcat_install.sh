# Installation script for Tomcat 9 on Ubuntu

sudo apt update
sudo apt install default-jdk ufw
sudo useradd -r -m -U -d /opt/tomcat -s /bin/false tomcat
wget https://downloads.apache.org/tomcat/tomcat-9/v9.0.31/bin/apache-tomcat-9.0.31.tar.gz -P /tmp
sudo tar xf /tmp/apache-tomcat-9*.tar.gz -C /opt/tomcat
sudo ln -s /opt/tomcat/apache-tomcat-9.0.31 /opt/tomcat/latest
sudo chown -RH tomcat: /opt/tomcat/latest
sudo sh -c 'chmod +x /opt/tomcat/latest/bin/*.sh'

cat > /etc/systemd/system/tomcat.service << EOL
[Unit]
Description=Tomcat 9 servlet container
After=network.target

[Service]
Type=forking

User=tomcat
Group=tomcat

Environment="JAVA_HOME=/usr/lib/jvm/default-java"
Environment="JAVA_OPTS=-Djava.security.egd=file:///dev/urandom -Djava.awt.headless=true"

Environment="CATALINA_BASE=/opt/tomcat/latest"
Environment="CATALINA_HOME=/opt/tomcat/latest"
Environment="CATALINA_PID=/opt/tomcat/latest/temp/tomcat.pid"
Environment="CATALINA_OPTS=-Xms512M -Xmx1024M -server -XX:+UseParallelGC"

ExecStart=/opt/tomcat/latest/bin/startup.sh
ExecStop=/opt/tomcat/latest/bin/shutdown.sh

[Install]
WantedBy=multi-user.target
EOL

sudo systemctl daemon-reload
sudo systemctl start tomcat
sudo systemctl enable tomcat
sudo ufw allow 8080/tcp

echo "Edit the Tomcat users file at /opt/tomcat/latest/conf/tomcat-users.xml"
echo "Edit the Manager app context file at /opt/tomcat/latest/webapps/manager/META-INF/context.xml"
echo "Edit the Host Manager app context file at /opt/tomcat/latest/webapps/host-manager/META-INF/context.xml"
echo "Once this is done, restart Tomcat with sudo systemctl restart tomcat"
