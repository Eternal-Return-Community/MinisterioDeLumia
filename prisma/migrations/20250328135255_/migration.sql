-- RedefineTables
PRAGMA defer_foreign_keys=ON;
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_users" (
    "userNum" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "userCode" TEXT NOT NULL,
    "nickname" TEXT,
    "level" INTEGER NOT NULL DEFAULT 1
);
INSERT INTO "new_users" ("nickname", "userCode", "userNum") SELECT "nickname", "userCode", "userNum" FROM "users";
DROP TABLE "users";
ALTER TABLE "new_users" RENAME TO "users";
CREATE UNIQUE INDEX "users_userNum_key" ON "users"("userNum");
CREATE UNIQUE INDEX "users_userCode_key" ON "users"("userCode");
CREATE UNIQUE INDEX "users_nickname_key" ON "users"("nickname");
PRAGMA foreign_keys=ON;
PRAGMA defer_foreign_keys=OFF;
