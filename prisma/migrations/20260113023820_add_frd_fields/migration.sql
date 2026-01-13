/*
  Warnings:

  - You are about to drop the column `content` on the `CommonPrompt` table. All the data in the column will be lost.
  - You are about to drop the column `moduleId` on the `CommonPrompt` table. All the data in the column will be lost.
  - You are about to drop the column `description` on the `MicroserviceModule` table. All the data in the column will be lost.
  - You are about to drop the column `description` on the `Project` table. All the data in the column will be lost.
  - Added the required column `contentMd` to the `CommonPrompt` table without a default value. This is not possible if the table is not empty.

*/
-- RedefineTables
PRAGMA defer_foreign_keys=ON;
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_CommonPrompt" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "title" TEXT NOT NULL,
    "type" TEXT,
    "tags" TEXT,
    "contentMd" TEXT NOT NULL,
    "isDeleted" BOOLEAN NOT NULL DEFAULT false,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL
);
INSERT INTO "new_CommonPrompt" ("createdAt", "id", "tags", "title", "updatedAt") SELECT "createdAt", "id", "tags", "title", "updatedAt" FROM "CommonPrompt";
DROP TABLE "CommonPrompt";
ALTER TABLE "new_CommonPrompt" RENAME TO "CommonPrompt";
CREATE TABLE "new_MicroserviceModule" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "projectId" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "category" TEXT,
    "architectureJson" TEXT,
    "architectureMd" TEXT,
    "forbiddenMistakes" TEXT,
    "modules" TEXT,
    "descriptionMd" TEXT,
    "status" TEXT NOT NULL DEFAULT 'active',
    "isDeleted" BOOLEAN NOT NULL DEFAULT false,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    CONSTRAINT "MicroserviceModule_projectId_fkey" FOREIGN KEY ("projectId") REFERENCES "Project" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);
INSERT INTO "new_MicroserviceModule" ("createdAt", "id", "name", "projectId", "updatedAt") SELECT "createdAt", "id", "name", "projectId", "updatedAt" FROM "MicroserviceModule";
DROP TABLE "MicroserviceModule";
ALTER TABLE "new_MicroserviceModule" RENAME TO "MicroserviceModule";
CREATE INDEX "MicroserviceModule_projectId_idx" ON "MicroserviceModule"("projectId");
CREATE TABLE "new_Project" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "name" TEXT NOT NULL,
    "category" TEXT,
    "architectureJson" TEXT,
    "architectureMd" TEXT,
    "forbiddenMistakes" TEXT,
    "modules" TEXT,
    "descriptionMd" TEXT,
    "status" TEXT NOT NULL DEFAULT 'active',
    "isDeleted" BOOLEAN NOT NULL DEFAULT false,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL
);
INSERT INTO "new_Project" ("createdAt", "id", "name", "updatedAt") SELECT "createdAt", "id", "name", "updatedAt" FROM "Project";
DROP TABLE "Project";
ALTER TABLE "new_Project" RENAME TO "Project";
PRAGMA foreign_keys=ON;
PRAGMA defer_foreign_keys=OFF;
