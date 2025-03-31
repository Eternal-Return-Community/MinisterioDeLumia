/*
  Warnings:

  - You are about to drop the column `battleUserInfoId` on the `User` table. All the data in the column will be lost.
  - Added the required column `battleUserId` to the `User` table without a default value. This is not possible if the table is not empty.

*/
-- RedefineTables
PRAGMA defer_foreign_keys=ON;
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_User" (
    "userNum" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "userCode" TEXT NOT NULL,
    "nickname" TEXT,
    "authProvider" TEXT NOT NULL,
    "lv" INTEGER NOT NULL,
    "battleUserId" INTEGER NOT NULL,
    CONSTRAINT "User_battleUserId_fkey" FOREIGN KEY ("battleUserId") REFERENCES "MatchingMode" ("userNum") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_User" ("authProvider", "lv", "nickname", "userCode", "userNum") SELECT "authProvider", "lv", "nickname", "userCode", "userNum" FROM "User";
DROP TABLE "User";
ALTER TABLE "new_User" RENAME TO "User";
CREATE UNIQUE INDEX "User_userNum_key" ON "User"("userNum");
CREATE UNIQUE INDEX "User_userCode_key" ON "User"("userCode");
CREATE UNIQUE INDEX "User_nickname_key" ON "User"("nickname");
PRAGMA foreign_keys=ON;
PRAGMA defer_foreign_keys=OFF;
