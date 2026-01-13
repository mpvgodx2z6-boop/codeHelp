# CodeHelp Admin (AdminJS + Express + Prisma + SQLite)

This repo boots an Admin panel using **AdminJS** on top of **Express** and **Prisma** with a **SQLite** database.

## Models

- **Project**
- **MicroserviceModule** (belongs to Project)
- **CommonPrompt** (belongs to MicroserviceModule)

## Prerequisites

- Node.js 18+ (recommended)

## Setup

```bash
npm install
cp .env.example .env
```

## Create DB + migrate

```bash
npm run prisma:migrate -- --name init
```

This will create `prisma/dev.db` and apply migrations.

## Run (dev)

```bash
npm run dev
```

Open:

- Admin UI: http://localhost:3000/admin
- Health check: http://localhost:3000/health

## Build + run (prod)

```bash
npm run build
npm start
```

## Notes

- Admin authentication is not enabled by default. If you need auth, use `@adminjs/express` authentication helpers or add a session store.
- The Prisma schema lives in `prisma/schema.prisma`.
