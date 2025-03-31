/*
  Warnings:

  - You are about to drop the `Duo` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `MatchingMode` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Solo` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Squad` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the column `battleUserId` on the `User` table. All the data in the column will be lost.

*/
-- DropIndex
DROP INDEX "Duo_userNum_key";

-- DropIndex
DROP INDEX "Solo_userNum_key";

-- DropIndex
DROP INDEX "Squad_userNum_key";

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

-- RedefineTables
PRAGMA defer_foreign_keys=ON;
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_User" (
    "userNum" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "userCode" TEXT NOT NULL,
    "nickname" TEXT NOT NULL,
    "authProvider" TEXT NOT NULL,
    "lv" INTEGER NOT NULL
);
INSERT INTO "new_User" ("authProvider", "lv", "nickname", "userCode", "userNum") SELECT "authProvider", "lv", "nickname", "userCode", "userNum" FROM "User";
DROP TABLE "User";
ALTER TABLE "new_User" RENAME TO "User";
CREATE UNIQUE INDEX "User_userNum_key" ON "User"("userNum");
CREATE UNIQUE INDEX "User_userCode_key" ON "User"("userCode");
CREATE UNIQUE INDEX "User_nickname_key" ON "User"("nickname");
PRAGMA foreign_keys=ON;
PRAGMA defer_foreign_keys=OFF;
