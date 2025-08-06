#!/data/data/com.termux/files/usr/bin/bash
# Deployment script for Termux

PROJECT_NAME="PersonalTracker"
PORT=3001

echo "Deploying $PROJECT_NAME on port $PORT..."

cd ~/storage/shared/Server/Projects/$PROJECT_NAME/backend || exit 1

# Install/update dependencies
npm install
npm init -y
npm install express body-parser cors

# Kill old server if running
pkill -f "node server.js"

# Start server in background
nohup node server.js > server.log 2>&1 &

echo "$PROJECT_NAME deployed successfully!"
