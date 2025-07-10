#!/bin/bash
./maintain.sh
sudo cp /opt/audit/summary.txt .

UPTIME=$(uptime) 
USERS_ONLINE=$(who | wc -l)

{
  echo "Uptime: $UPTIME"
  echo "Users Online: $USERS_ONLINE"
} >> "summary.txt"


./htmlConvert.sh

if ! docker ps --format '{{.Names}}' | grep -q "^report-server$"; then
  echo "Starting Nginx Docker container..."
  sudo docker run -d \
    -p 80:80 \
    -v /Users/chirag.belani/assessment/DevOps_assessment01:/usr/share/nginx/html:ro \
    --name report-server \
    nginx
else
  echo "Docker container 'report-server' is already running."
fi

