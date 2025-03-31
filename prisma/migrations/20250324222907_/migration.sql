/*
  Warnings:

  - You are about to drop the column `duoUserNum` on the `MatchingMode` table. All the data in the column will be lost.
  - You are about to drop the column `soloUserNum` on the `MatchingMode` table. All the data in the column will be lost.
  - You are about to drop the column `squadUserNum` on the `MatchingMode` table. All the data in the column will be lost.

*/
-- RedefineTables
PRAGMA defer_foreign_keys=ON;
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_MatchingMode" (
    "userNum" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    CONSTRAINT "MatchingMode_userNum_fkey" FOREIGN KEY ("userNum") REFERENCES "Solo" ("userNum") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "MatchingMode_userNum_fkey" FOREIGN KEY ("userNum") REFERENCES "Duo" ("userNum") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "MatchingMode_userNum_fkey" FOREIGN KEY ("userNum") REFERENCES "Squad" ("userNum") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_MatchingMode" ("userNum") SELECT "userNum" FROM "MatchingMode";
DROP TABLE "MatchingMode";
ALTER TABLE "new_MatchingMode" RENAME TO "MatchingMode";
PRAGMA foreign_keys=ON;
PRAGMA defer_foreign_keys=OFF;
