const express = require("express");
const prisma = require("./db/prisma");
const dotenv = require("dotenv");

dotenv.config();

const app = express();
const port = 3000;

app.get("/", (req, res) => {
  res.send("Hello World!");
});

app.get("/users", async (req, res) => {
  const users = await prisma.user.findMany();
  res.json(users);
});

app.post("/users", async (req, res) => {
  const user = await prisma.user.create({
    data: {
      name: "Alice",
    },
  });
  res.json(user);
});

app.listen(port, () => {
  console.log(`Example app listening on port ${port}`);
});
