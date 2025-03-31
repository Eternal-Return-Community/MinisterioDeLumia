/*
  Warnings:

  - You are about to alter the column `createDtm` on the `Duo` table. The data in that column could be lost. The data in that column will be cast from `DateTime` to `Int`.
  - You are about to alter the column `updateDtm` on the `Duo` table. The data in that column could be lost. The data in that column will be cast from `DateTime` to `Int`.
  - You are about to alter the column `createDtm` on the `Solo` table. The data in that column could be lost. The data in that column will be cast from `DateTime` to `Int`.
  - You are about to alter the column `updateDtm` on the `Solo` table. The data in that column could be lost. The data in that column will be cast from `DateTime` to `Int`.
  - You are about to alter the column `createDtm` on the `Squad` table. The data in that column could be lost. The data in that column will be cast from `DateTime` to `Int`.
  - You are about to alter the column `updateDtm` on the `Squad` table. The data in that column could be lost. The data in that column will be cast from `DateTime` to `Int`.

*/
-- RedefineTables
PRAGMA defer_foreign_keys=ON;
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Duo" (
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
    "createDtm" INTEGER NOT NULL,
    "updateDtm" INTEGER NOT NULL
);
INSERT INTO "new_Duo" ("createDtm", "mmr", "modTotalGames", "playAsia2Count", "playFrankFurtCount", "playOhioCount", "playSaoPauloCount", "playSeoulCount", "rankBindRegion", "totalGames", "updateDtm", "userNum") SELECT "createDtm", "mmr", "modTotalGames", "playAsia2Count", "playFrankFurtCount", "playOhioCount", "playSaoPauloCount", "playSeoulCount", "rankBindRegion", "totalGames", "updateDtm", "userNum" FROM "Duo";
DROP TABLE "Duo";
ALTER TABLE "new_Duo" RENAME TO "Duo";
CREATE UNIQUE INDEX "Duo_userNum_key" ON "Duo"("userNum");
CREATE TABLE "new_Solo" (
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
    "createDtm" INTEGER NOT NULL,
    "updateDtm" INTEGER NOT NULL
);
INSERT INTO "new_Solo" ("createDtm", "mmr", "modTotalGames", "playAsia2Count", "playFrankFurtCount", "playOhioCount", "playSaoPauloCount", "playSeoulCount", "rankBindRegion", "totalGames", "updateDtm", "userNum") SELECT "createDtm", "mmr", "modTotalGames", "playAsia2Count", "playFrankFurtCount", "playOhioCount", "playSaoPauloCount", "playSeoulCount", "rankBindRegion", "totalGames", "updateDtm", "userNum" FROM "Solo";
DROP TABLE "Solo";
ALTER TABLE "new_Solo" RENAME TO "Solo";
CREATE UNIQUE INDEX "Solo_userNum_key" ON "Solo"("userNum");
CREATE TABLE "new_Squad" (
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
    "createDtm" INTEGER NOT NULL,
    "updateDtm" INTEGER NOT NULL
);
INSERT INTO "new_Squad" ("createDtm", "mmr", "modTotalGames", "playAsia2Count", "playFrankFurtCount", "playOhioCount", "playSaoPauloCount", "playSeoulCount", "rankBindRegion", "totalGames", "updateDtm", "userNum") SELECT "createDtm", "mmr", "modTotalGames", "playAsia2Count", "playFrankFurtCount", "playOhioCount", "playSaoPauloCount", "playSeoulCount", "rankBindRegion", "totalGames", "updateDtm", "userNum" FROM "Squad";
DROP TABLE "Squad";
ALTER TABLE "new_Squad" RENAME TO "Squad";
CREATE UNIQUE INDEX "Squad_userNum_key" ON "Squad"("userNum");
PRAGMA foreign_keys=ON;
PRAGMA defer_foreign_keys=OFF;
