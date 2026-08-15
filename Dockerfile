# ====================================================
# STAGE 1: BUILD JAVA SOURCE CODE
# ====================================================
FROM tomcat:9.0-jdk11-temurin AS builder

WORKDIR /app

# Copy Java source and web assets
COPY src/java /app/src/java
COPY web /app/web

# Create classes directory
RUN mkdir -p /app/web/WEB-INF/classes

# Compile all Java sources
RUN javac -encoding UTF-8 -cp "/usr/local/tomcat/lib/*:/app/web/WEB-INF/lib/*" \
    -d /app/web/WEB-INF/classes \
    $(find /app/src/java -name "*.java")

# ====================================================
# STAGE 2: PRODUCTION TOMCAT RUNTIME
# ====================================================
FROM tomcat:9.0-jre11-temurin

# Clean default webapps
RUN rm -rf /usr/local/tomcat/webapps/*

# Deploy to ROOT (/) and /PRJ301-Assignment
COPY --from=builder /app/web /usr/local/tomcat/webapps/ROOT
COPY --from=builder /app/web /usr/local/tomcat/webapps/PRJ301-Assignment

# Copy and setup entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 8080
ENTRYPOINT ["/entrypoint.sh"]
