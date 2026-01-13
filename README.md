# CodeHelp Admin (AdminJS + Express + Prisma + SQLite)

This repo boots an Admin panel using **AdminJS** on top of **Express** and **Prisma** with a **SQLite** database.

## Models

### Project
Project model represents a software project with its architecture and metadata.

**Fields:**
- `id` (String, cuid) - Unique identifier
- `name` (String) - Project name
- `category` (String, optional) - Project category/type
- `architectureJson` (String, optional) - Structured technical architecture (JSON stored as string)
- `architectureMd` (String, optional) - Technical architecture in Markdown format
- `forbiddenMistakes` (String, optional) - List of mistakes to avoid in this project (JSON stored as string)
- `modules` (String, optional) - Module inventory list (JSON stored as string)
- `descriptionMd` (String, optional) - Project description in Markdown
- `status` (String, default="active") - Project status
- `isDeleted` (Boolean, default=false) - Soft delete flag
- `createdAt`, `updatedAt` - Timestamps
- **Relation:** One-to-many with MicroserviceModule

### MicroserviceModule
MicroserviceModule represents a module or microservice within a project.

**Fields:**
- `id` (String, cuid) - Unique identifier
- `projectId` (String) - Foreign key to Project
- `name` (String) - Module name
- `category` (String, optional) - Module category/type
- `architectureJson` (String, optional) - Structured technical architecture (JSON stored as string)
- `architectureMd` (String, optional) - Technical architecture in Markdown format
- `forbiddenMistakes` (String, optional) - List of mistakes to avoid (JSON stored as string)
- `modules` (String, optional) - Sub-module inventory (JSON stored as string)
- `descriptionMd` (String, optional) - Module description in Markdown
- `status` (String, default="active") - Module status
- `isDeleted` (Boolean, default=false) - Soft delete flag
- `createdAt`, `updatedAt` - Timestamps
- **Relation:** Belongs to Project

### CommonPrompt
CommonPrompt represents reusable prompt templates that can be used across projects and modules. **Note:** CommonPrompt is now an independent resource and is NOT tied to any specific MicroserviceModule.

**Fields:**
- `id` (String, cuid) - Unique identifier
- `title` (String) - Prompt title
- `type` (String, optional) - Type of prompt (template/snippet/checklist/constraint)
- `tags` (String, optional) - Tags for categorization (JSON array stored as string)
- `contentMd` (String) - Prompt content in Markdown format
- `isDeleted` (Boolean, default=false) - Soft delete flag
- `createdAt`, `updatedAt` - Timestamps

## JSON Fields

Since SQLite doesn't support native JSON types, all JSON fields are stored as String. When editing these fields in AdminJS:
- Enter valid JSON strings (e.g., `["tag1", "tag2"]` or `{"key": "value"}`)
- The application layer should handle JSON parsing and serialization

## Soft Delete

The `isDeleted` field is present on all models to support soft deletion. Records with `isDeleted=true` should be filtered out in queries. **Note:** The current AdminJS configuration does not automatically hide soft-deleted records in the UI. This filtering can be added as a future enhancement.

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
- CommonPrompt is now a standalone resource for cross-project reusability. Future enhancements may include ProjectPrompt/ModulePrompt junction tables for explicit associations.
