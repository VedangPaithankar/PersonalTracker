#!/data/data/com.termux/files/usr/bin/bash
# Deployment script for Termux (Frontend + Backend)

PROJECT_NAME="PersonalTracker"
FRONTEND_PORT=3000
BACKEND_PORT=3001
BASE_DIR=~/storage/shared/Server/Projects/$PROJECT_NAME

echo "Deploying $PROJECT_NAME..."

# --- Backend ---
cd $BASE_DIR/backend || exit 1
if [ -f "package.json" ] && [ ! -d "node_modules" ]; then
    echo "Installing backend dependencies..."
    npm install
fi

npm install express body-parser cors

pkill -f "node server.js"
nohup node server.js > server.log 2>&1 &

# --- Frontend ---
cd $BASE_DIR/frontend || exit 1
pkill -f "serve_frontend.py"
nohup python3 serve_frontend.py &

echo "$PROJECT_NAME deployed successfully!"
echo "Frontend: http://localhost:$FRONTEND_PORT/"
echo "Backend: http://localhost:$BACKEND_PORT/"
