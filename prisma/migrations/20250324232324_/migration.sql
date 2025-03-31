/*
  Warnings:

  - You are about to drop the column `SquadId` on the `MatchingMode` table. All the data in the column will be lost.

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
    "createDtm" INTEGER NOT NULL DEFAULT 0,
    "updateDtm" INTEGER NOT NULL DEFAULT 0
);
INSERT INTO "new_Duo" ("createDtm", "mmr", "modTotalGames", "playAsia2Count", "playFrankFurtCount", "playOhioCount", "playSaoPauloCount", "playSeoulCount", "rankBindRegion", "totalGames", "updateDtm", "userNum") SELECT "createDtm", "mmr", "modTotalGames", "playAsia2Count", "playFrankFurtCount", "playOhioCount", "playSaoPauloCount", "playSeoulCount", "rankBindRegion", "totalGames", "updateDtm", "userNum" FROM "Duo";
DROP TABLE "Duo";
ALTER TABLE "new_Duo" RENAME TO "Duo";
CREATE UNIQUE INDEX "Duo_userNum_key" ON "Duo"("userNum");
CREATE TABLE "new_MatchingMode" (
    "userNum" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "soloId" INTEGER,
    "duoId" INTEGER,
    "squadId" INTEGER,
    CONSTRAINT "MatchingMode_soloId_fkey" FOREIGN KEY ("soloId") REFERENCES "Solo" ("userNum") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "MatchingMode_duoId_fkey" FOREIGN KEY ("duoId") REFERENCES "Duo" ("userNum") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "MatchingMode_squadId_fkey" FOREIGN KEY ("squadId") REFERENCES "Squad" ("userNum") ON DELETE SET NULL ON UPDATE CASCADE
);
INSERT INTO "new_MatchingMode" ("duoId", "soloId", "userNum") SELECT "duoId", "soloId", "userNum" FROM "MatchingMode";
DROP TABLE "MatchingMode";
ALTER TABLE "new_MatchingMode" RENAME TO "MatchingMode";
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
    "createDtm" INTEGER NOT NULL DEFAULT 0,
    "updateDtm" INTEGER NOT NULL DEFAULT 0
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
    "createDtm" INTEGER NOT NULL DEFAULT 0,
    "updateDtm" INTEGER NOT NULL DEFAULT 0
);
INSERT INTO "new_Squad" ("createDtm", "mmr", "modTotalGames", "playAsia2Count", "playFrankFurtCount", "playOhioCount", "playSaoPauloCount", "playSeoulCount", "rankBindRegion", "totalGames", "updateDtm", "userNum") SELECT "createDtm", "mmr", "modTotalGames", "playAsia2Count", "playFrankFurtCount", "playOhioCount", "playSaoPauloCount", "playSeoulCount", "rankBindRegion", "totalGames", "updateDtm", "userNum" FROM "Squad";
DROP TABLE "Squad";
ALTER TABLE "new_Squad" RENAME TO "Squad";
CREATE UNIQUE INDEX "Squad_userNum_key" ON "Squad"("userNum");
PRAGMA foreign_keys=ON;
PRAGMA defer_foreign_keys=OFF;
