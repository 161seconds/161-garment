#!/bin/sh
set -e

PORT="${PORT:-8080}"
echo "Configuring Tomcat to listen on port ${PORT}..."

# Disable Tomcat shutdown socket (port 8005 -> -1) so Render health checks do not trigger "Invalid shutdown command"
sed -i 's/<Server port="8005"/<Server port="-1"/g' /usr/local/tomcat/conf/server.xml

# Replace default port 8080 with dynamic $PORT in server.xml
sed -i "s/8080/${PORT}/g" /usr/local/tomcat/conf/server.xml

echo "Starting Apache Tomcat on port ${PORT}..."
exec catalina.sh run
