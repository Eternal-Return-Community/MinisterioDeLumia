/*
  Warnings:

  - You are about to drop the column `SquadId` on the `MatchingMode` table. All the data in the column will be lost.
  - You are about to drop the column `duoId` on the `MatchingMode` table. All the data in the column will be lost.
  - You are about to drop the column `soloId` on the `MatchingMode` table. All the data in the column will be lost.
  - Added the required column `duoUserNum` to the `MatchingMode` table without a default value. This is not possible if the table is not empty.
  - Added the required column `soloUserNum` to the `MatchingMode` table without a default value. This is not possible if the table is not empty.
  - Added the required column `squadUserNum` to the `MatchingMode` table without a default value. This is not possible if the table is not empty.

*/
-- RedefineTables
PRAGMA defer_foreign_keys=ON;
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_MatchingMode" (
    "userNum" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "soloUserNum" INTEGER NOT NULL,
    "duoUserNum" INTEGER NOT NULL,
    "squadUserNum" INTEGER NOT NULL,
    CONSTRAINT "MatchingMode_soloUserNum_fkey" FOREIGN KEY ("soloUserNum") REFERENCES "Solo" ("userNum") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "MatchingMode_duoUserNum_fkey" FOREIGN KEY ("duoUserNum") REFERENCES "Duo" ("userNum") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "MatchingMode_squadUserNum_fkey" FOREIGN KEY ("squadUserNum") REFERENCES "Squad" ("userNum") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_MatchingMode" ("userNum") SELECT "userNum" FROM "MatchingMode";
DROP TABLE "MatchingMode";
ALTER TABLE "new_MatchingMode" RENAME TO "MatchingMode";
PRAGMA foreign_keys=ON;
PRAGMA defer_foreign_keys=OFF;
