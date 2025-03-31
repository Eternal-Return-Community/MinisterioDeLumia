/*
  Warnings:

  - You are about to drop the `Duo` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `MatchingMode` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Solo` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Squad` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `User` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropTable
PRAGMA foreign_keys=off;
DROP TABLE "Duo";
PRAGMA foreign_keys=on;

-- DropTable
PRAGMA foreign_keys=off;
DROP TABLE "MatchingMode";
PRAGMA foreign_keys=on;

-- DropTable
PRAGMA foreign_keys=off;
DROP TABLE "Solo";
PRAGMA foreign_keys=on;

-- DropTable
PRAGMA foreign_keys=off;
DROP TABLE "Squad";
PRAGMA foreign_keys=on;

-- DropTable
PRAGMA foreign_keys=off;
DROP TABLE "User";
PRAGMA foreign_keys=on;

-- CreateTable
CREATE TABLE "users" (
    "userNum" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "userCode" TEXT NOT NULL,
    "nickname" TEXT,
    "authProvider" TEXT NOT NULL,
    "lv" INTEGER NOT NULL
);

-- CreateTable
CREATE TABLE "matchingmodes" (
    "userNum" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "userId" INTEGER NOT NULL,
    "soloId" INTEGER,
    "duoId" INTEGER,
    "squadId" INTEGER,
    CONSTRAINT "matchingmodes_soloId_fkey" FOREIGN KEY ("soloId") REFERENCES "solos" ("userNum") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "matchingmodes_duoId_fkey" FOREIGN KEY ("duoId") REFERENCES "duos" ("userNum") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "matchingmodes_squadId_fkey" FOREIGN KEY ("squadId") REFERENCES "squads" ("userNum") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "matchingmodes_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users" ("userNum") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "solos" (
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
CREATE TABLE "duos" (
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
CREATE TABLE "squads" (
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
CREATE UNIQUE INDEX "users_userNum_key" ON "users"("userNum");

-- CreateIndex
CREATE UNIQUE INDEX "users_userCode_key" ON "users"("userCode");

-- CreateIndex
CREATE UNIQUE INDEX "users_nickname_key" ON "users"("nickname");

-- CreateIndex
CREATE UNIQUE INDEX "solos_userNum_key" ON "solos"("userNum");

-- CreateIndex
CREATE UNIQUE INDEX "duos_userNum_key" ON "duos"("userNum");

-- CreateIndex
CREATE UNIQUE INDEX "squads_userNum_key" ON "squads"("userNum");
