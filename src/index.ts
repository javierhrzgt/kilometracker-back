import express from "express";
import type { Express } from "express";
import helmet from "helmet";
import cors from "cors";
import compression from "compression";
import dotenv from "dotenv";
import { prisma } from "@/lib/prisma";

dotenv.config();

const app:Express = express();
const PORT = process.env.PORT || 3000;

app.use(helmet());
app.use(cors());
app.use(compression());
app.use(express.json({ limit: "10mb" }));

app.get("/health", (req, res) => {
  res.json({
    status: "ok",
    timestamp: new Date().toISOString(),
  });
});

app.listen(PORT, () => {
  console.log(`🚀 Server: http://localhost:${PORT}`);
  console.log(`📊 Env: ${process.env.NODE_ENV || 'development'}`)
});

prisma
  .$connect()
  .then(() => console.log("✅ Database connected"))
  .catch((e) => console.error("❌ Database connected failed", e));
