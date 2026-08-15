#!/bin/sh
set -e

PORT="${PORT:-8080}"
echo "Configuring Tomcat to listen on port ${PORT}..."

# Replace default port 8080 with dynamic $PORT in server.xml
sed -i "s/8080/${PORT}/g" /usr/local/tomcat/conf/server.xml

echo "Starting Apache Tomcat on port ${PORT}..."
exec catalina.sh run
