-- CreateEnum
CREATE TYPE "Role" AS ENUM ('USER', 'MODERATOR', 'FAQ');

-- AlterTable
ALTER TABLE "User" ADD COLUMN     "role" "Role" NOT NULL DEFAULT 'USER';
