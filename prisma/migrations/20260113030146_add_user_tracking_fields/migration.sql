-- AlterTable
ALTER TABLE "CommonPrompt" ADD COLUMN "createdBy" TEXT;
ALTER TABLE "CommonPrompt" ADD COLUMN "updatedBy" TEXT;

-- AlterTable
ALTER TABLE "MicroserviceModule" ADD COLUMN "createdBy" TEXT;
ALTER TABLE "MicroserviceModule" ADD COLUMN "updatedBy" TEXT;

-- AlterTable
ALTER TABLE "Project" ADD COLUMN "createdBy" TEXT;
ALTER TABLE "Project" ADD COLUMN "updatedBy" TEXT;
