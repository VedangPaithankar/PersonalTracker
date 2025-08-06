const express = require("express");
const bodyParser = require("body-parser");
const cors = require("cors");
const path = require("path");

const app = express();
const PORT = 3001;

app.use(bodyParser.json());
app.use(cors());

// Serve frontend static files
app.use(express.static(path.join(__dirname, "../frontend")));

// Example tasks structure
let tasks = {
  "YT Life": [],
  "Upcoming Articles": [],
  "SQL": [],
  "GATE 2026": [],
  "DSA": []
};

// API endpoints
app.post("/add-task", (req, res) => {
  const { category, text } = req.body;
  if (!category || !text) return res.status(400).json({ error: "Missing data" });
  tasks[category].push({ text, done: false });
  res.json({ success: true });
});

app.get("/tasks/:category", (req, res) => {
  const category = req.params.category;
  res.json(tasks[category] || []);
});

app.post("/update-task", (req, res) => {
  const { category, index, done } = req.body;
  if (tasks[category] && tasks[category][index]) {
    tasks[category][index].done = done;
  }
  res.json({ success: true });
});

// Serve index by default
app.get("/", (req, res) => {
  res.sendFile(path.join(__dirname, "../frontend/dashboard.html"));
});

app.listen(PORT, () => {
  console.log(`Server running at http://localhost:${PORT}`);
});
