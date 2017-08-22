#!/bin/sh

echo ${PATH} &&
/usr/local/bin/forever /home/user/.c9/server.js -w /workspace/${PROJECT_NAME} --listen 127.0.0.1
    
