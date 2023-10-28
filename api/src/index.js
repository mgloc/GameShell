const express = require("express");
const prisma = require("./db/prisma");
const dotenv = require("dotenv");

dotenv.config();

const app = express();
const port = 3000;

app.get("/", (req, res) => {
  res.send("Hello World!");
});

app.listen(port, () => {
  console.log(`Example app listening on port ${port}`);
});
