/*
  Warnings:

  - You are about to drop the column `certificate` on the `User` table. All the data in the column will be lost.
  - You are about to drop the column `class_name` on the `User` table. All the data in the column will be lost.
  - You are about to drop the column `darkTheme` on the `User` table. All the data in the column will be lost.
  - You are about to drop the column `fingerprint` on the `User` table. All the data in the column will be lost.
  - You are about to drop the column `firebaseToken` on the `User` table. All the data in the column will be lost.
  - You are about to drop the column `loginID` on the `User` table. All the data in the column will be lost.
  - You are about to drop the column `privateKey` on the `User` table. All the data in the column will be lost.
  - You are about to drop the column `restURLId` on the `User` table. All the data in the column will be lost.
  - You are about to drop the `RestURL` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "User" DROP CONSTRAINT "User_restURLId_fkey";

-- AlterTable
ALTER TABLE "User" DROP COLUMN "certificate",
DROP COLUMN "class_name",
DROP COLUMN "darkTheme",
DROP COLUMN "fingerprint",
DROP COLUMN "firebaseToken",
DROP COLUMN "loginID",
DROP COLUMN "privateKey",
DROP COLUMN "restURLId";

-- DropTable
DROP TABLE "RestURL";
