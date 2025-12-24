import express from "express";

const app = express();
const PORT = process.env.PORT || 3000;

app.get("/", (req, res) => {
  res.send("FFmpeg worker alive");
});

app.listen(PORT, () => {
  console.log(`Server listening on ${PORT}`);
});
