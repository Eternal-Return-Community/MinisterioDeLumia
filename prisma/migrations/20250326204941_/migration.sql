/*
  Warnings:

  - You are about to drop the `duos` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `matchingmodes` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `solos` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `squads` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `users` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropTable
PRAGMA foreign_keys=off;
DROP TABLE "duos";
PRAGMA foreign_keys=on;

-- DropTable
PRAGMA foreign_keys=off;
DROP TABLE "matchingmodes";
PRAGMA foreign_keys=on;

-- DropTable
PRAGMA foreign_keys=off;
DROP TABLE "solos";
PRAGMA foreign_keys=on;

-- DropTable
PRAGMA foreign_keys=off;
DROP TABLE "squads";
PRAGMA foreign_keys=on;

-- DropTable
PRAGMA foreign_keys=off;
DROP TABLE "users";
PRAGMA foreign_keys=on;

-- CreateTable
CREATE TABLE "User" (
    "userNum" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "userCode" TEXT NOT NULL,
    "nickname" TEXT,
    "authProvider" TEXT NOT NULL,
    "lv" INTEGER NOT NULL,
    "battleUserInfoId" INTEGER NOT NULL,
    CONSTRAINT "User_battleUserInfoId_fkey" FOREIGN KEY ("battleUserInfoId") REFERENCES "MatchingMode" ("userNum") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "MatchingMode" (
    "userNum" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "userId" INTEGER NOT NULL,
    "soloId" INTEGER,
    "duoId" INTEGER,
    "squadId" INTEGER,
    CONSTRAINT "MatchingMode_soloId_fkey" FOREIGN KEY ("soloId") REFERENCES "Solo" ("userNum") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "MatchingMode_duoId_fkey" FOREIGN KEY ("duoId") REFERENCES "Duo" ("userNum") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "MatchingMode_squadId_fkey" FOREIGN KEY ("squadId") REFERENCES "Squad" ("userNum") ON DELETE SET NULL ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Solo" (
    "userNum" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "totalGames" INTEGER NOT NULL DEFAULT 0,
    "modTotalGames" INTEGER NOT NULL DEFAULT 0,
    "mmr" INTEGER NOT NULL DEFAULT 0,
    "playSeoulCount" INTEGER NOT NULL DEFAULT 0,
    "playOhioCount" INTEGER NOT NULL DEFAULT 0,
    "playFrankFurtCount" INTEGER NOT NULL DEFAULT 0,
    "playSaoPauloCount" INTEGER NOT NULL DEFAULT 0,
    "playAsia2Count" INTEGER NOT NULL DEFAULT 0,
    "rankBindRegion" INTEGER NOT NULL DEFAULT 0,
    "createDtm" BIGINT NOT NULL DEFAULT 0,
    "updateDtm" BIGINT NOT NULL DEFAULT 0
);

-- CreateTable
CREATE TABLE "Duo" (
    "userNum" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "totalGames" INTEGER NOT NULL DEFAULT 0,
    "modTotalGames" INTEGER NOT NULL DEFAULT 0,
    "mmr" INTEGER NOT NULL DEFAULT 0,
    "playSeoulCount" INTEGER NOT NULL DEFAULT 0,
    "playOhioCount" INTEGER NOT NULL DEFAULT 0,
    "playFrankFurtCount" INTEGER NOT NULL DEFAULT 0,
    "playSaoPauloCount" INTEGER NOT NULL DEFAULT 0,
    "playAsia2Count" INTEGER NOT NULL DEFAULT 0,
    "rankBindRegion" INTEGER NOT NULL DEFAULT 0,
    "createDtm" BIGINT NOT NULL DEFAULT 0,
    "updateDtm" BIGINT NOT NULL DEFAULT 0
);

-- CreateTable
CREATE TABLE "Squad" (
    "userNum" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "totalGames" INTEGER NOT NULL DEFAULT 0,
    "modTotalGames" INTEGER NOT NULL DEFAULT 0,
    "mmr" INTEGER NOT NULL DEFAULT 0,
    "playSeoulCount" INTEGER NOT NULL DEFAULT 0,
    "playOhioCount" INTEGER NOT NULL DEFAULT 0,
    "playFrankFurtCount" INTEGER NOT NULL DEFAULT 0,
    "playSaoPauloCount" INTEGER NOT NULL DEFAULT 0,
    "playAsia2Count" INTEGER NOT NULL DEFAULT 0,
    "rankBindRegion" INTEGER NOT NULL DEFAULT 0,
    "createDtm" BIGINT NOT NULL DEFAULT 0,
    "updateDtm" BIGINT NOT NULL DEFAULT 0
);

-- CreateIndex
CREATE UNIQUE INDEX "User_userNum_key" ON "User"("userNum");

-- CreateIndex
CREATE UNIQUE INDEX "User_userCode_key" ON "User"("userCode");

-- CreateIndex
CREATE UNIQUE INDEX "User_nickname_key" ON "User"("nickname");

-- CreateIndex
CREATE UNIQUE INDEX "Solo_userNum_key" ON "Solo"("userNum");

-- CreateIndex
CREATE UNIQUE INDEX "Duo_userNum_key" ON "Duo"("userNum");

-- CreateIndex
CREATE UNIQUE INDEX "Squad_userNum_key" ON "Squad"("userNum");
