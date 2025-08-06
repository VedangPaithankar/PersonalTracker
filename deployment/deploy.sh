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

# Kill old backend safely
pkill -f "node server.js" 2>/dev/null || true

# Start backend
nohup node server.js > $BASE_DIR/backend/server.log 2>&1 &

# --- Frontend ---
cd $BASE_DIR/frontend || exit 1

# Kill old frontend safely
pkill -f "serve_frontend.py" 2>/dev/null || true
pkill -f "http.server $FRONTEND_PORT" 2>/dev/null || true

# Start frontend
nohup python3 serve_frontend.py > $BASE_DIR/frontend/frontend.log 2>&1 &

echo "$PROJECT_NAME deployed successfully!"
echo "Frontend: http://192.168.1.51:$FRONTEND_PORT/"
echo "Backend: http://192.168.1.51:$BACKEND_PORT/"

