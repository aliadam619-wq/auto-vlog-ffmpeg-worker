import express from "express";
import { exec } from "child_process";

const app = express();
app.use(express.json());

// ✅ Health check (REQUIRED)
app.get("/health", (req, res) => {
  res.json({ status: "ok" });
});

// ✅ FFmpeg check
app.get("/ffmpeg-check", (req, res) => {
  exec("ffmpeg -version", (err, stdout) => {
    if (err) {
      return res.status(500).json({ error: "FFmpeg not installed" });
    }
    res.send(stdout.split("\n")[0]);
  });
});

// 🚧 Render endpoint (placeholder for now)
app.post("/render", async (req, res) => {
  res.json({
    jobId: "demo-job-id",
    status: "queued"
  });
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`FFmpeg worker running on port ${PORT}`);
});
