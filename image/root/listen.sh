#!/bin/sh

PROJECT_NAME=$(ls -1 /workspace) &&
    forever /home/user/.c9/server.js -w /workspace/${PROJECT_NAME} --listen 127.0.0.1
    
