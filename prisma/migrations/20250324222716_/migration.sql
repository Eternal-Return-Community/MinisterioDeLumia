/*
  Warnings:

  - Added the required column `matchingModeUserNum` to the `User` table without a default value. This is not possible if the table is not empty.

*/
-- RedefineTables
PRAGMA defer_foreign_keys=ON;
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_MatchingMode" (
    "userNum" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "soloUserNum" INTEGER,
    "duoUserNum" INTEGER,
    "squadUserNum" INTEGER,
    CONSTRAINT "MatchingMode_soloUserNum_fkey" FOREIGN KEY ("soloUserNum") REFERENCES "Solo" ("userNum") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "MatchingMode_duoUserNum_fkey" FOREIGN KEY ("duoUserNum") REFERENCES "Duo" ("userNum") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "MatchingMode_squadUserNum_fkey" FOREIGN KEY ("squadUserNum") REFERENCES "Squad" ("userNum") ON DELETE SET NULL ON UPDATE CASCADE
);
INSERT INTO "new_MatchingMode" ("userNum") SELECT "userNum" FROM "MatchingMode";
DROP TABLE "MatchingMode";
ALTER TABLE "new_MatchingMode" RENAME TO "MatchingMode";
CREATE TABLE "new_User" (
    "userNum" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "userCode" TEXT NOT NULL,
    "nickname" TEXT NOT NULL,
    "authProvider" TEXT NOT NULL,
    "lv" INTEGER NOT NULL,
    "battleUserId" INTEGER NOT NULL,
    "matchingModeUserNum" INTEGER NOT NULL,
    CONSTRAINT "User_matchingModeUserNum_fkey" FOREIGN KEY ("matchingModeUserNum") REFERENCES "MatchingMode" ("userNum") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_User" ("authProvider", "battleUserId", "lv", "nickname", "userCode", "userNum") SELECT "authProvider", "battleUserId", "lv", "nickname", "userCode", "userNum" FROM "User";
DROP TABLE "User";
ALTER TABLE "new_User" RENAME TO "User";
CREATE UNIQUE INDEX "User_userNum_key" ON "User"("userNum");
CREATE UNIQUE INDEX "User_userCode_key" ON "User"("userCode");
CREATE UNIQUE INDEX "User_nickname_key" ON "User"("nickname");
PRAGMA foreign_keys=ON;
PRAGMA defer_foreign_keys=OFF;
