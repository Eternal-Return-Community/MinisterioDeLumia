/*
  Warnings:

  - You are about to drop the column `userId` on the `MatchingMode` table. All the data in the column will be lost.

*/
-- RedefineTables
PRAGMA defer_foreign_keys=ON;
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_MatchingMode" (
    "userNum" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "soloId" INTEGER,
    "duoId" INTEGER,
    "squadId" INTEGER,
    CONSTRAINT "MatchingMode_soloId_fkey" FOREIGN KEY ("soloId") REFERENCES "Solo" ("userNum") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "MatchingMode_duoId_fkey" FOREIGN KEY ("duoId") REFERENCES "Duo" ("userNum") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "MatchingMode_squadId_fkey" FOREIGN KEY ("squadId") REFERENCES "Squad" ("userNum") ON DELETE SET NULL ON UPDATE CASCADE
);
INSERT INTO "new_MatchingMode" ("duoId", "soloId", "squadId", "userNum") SELECT "duoId", "soloId", "squadId", "userNum" FROM "MatchingMode";
DROP TABLE "MatchingMode";
ALTER TABLE "new_MatchingMode" RENAME TO "MatchingMode";
PRAGMA foreign_keys=ON;
PRAGMA defer_foreign_keys=OFF;
