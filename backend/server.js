const express = require("express");
const bodyParser = require("body-parser");
const cors = require("cors");

const app = express();
const PORT = 3001; // choose your port for this project

app.use(bodyParser.json());
app.use(cors());

let tasks = {
  "YT Life": [],
  "Upcoming Articles": [],
  "SQL": [],
  "GATE 2026": [],
  "DSA": []
};

// Add a task
app.post("/add-task", (req, res) => {
  const { category, text } = req.body;
  if (!category || !text) return res.status(400).json({ error: "Missing data" });
  tasks[category].push({ text, done: false });
  res.json({ success: true });
});

// Get tasks for category
app.get("/tasks/:category", (req, res) => {
  const category = req.params.category;
  res.json(tasks[category] || []);
});

// Update task done status
app.post("/update-task", (req, res) => {
  const { category, index, done } = req.body;
  if (tasks[category] && tasks[category][index]) {
    tasks[category][index].done = done;
  }
  res.json({ success: true });
});

app.listen(PORT, () => {
  console.log(`Backend running at http://localhost:${PORT}`);
});
