#!/bin/sh

forever /home/user/.c9/server.js -w /workspace/${PROJECT_NAME} --auth user:password --listen 0.0.0.0