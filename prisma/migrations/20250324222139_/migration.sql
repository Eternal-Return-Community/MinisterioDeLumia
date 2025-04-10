-- CreateTable
CREATE TABLE "User" (
    "userNum" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "userCode" TEXT NOT NULL,
    "nickname" TEXT NOT NULL,
    "authProvider" TEXT NOT NULL,
    "lv" INTEGER NOT NULL,
    "battleUserId" INTEGER NOT NULL,
    CONSTRAINT "User_battleUserId_fkey" FOREIGN KEY ("battleUserId") REFERENCES "MatchingMode" ("userNum") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "MatchingMode" (
    "userNum" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    CONSTRAINT "MatchingMode_userNum_fkey" FOREIGN KEY ("userNum") REFERENCES "Solo" ("userNum") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "MatchingMode_userNum_fkey" FOREIGN KEY ("userNum") REFERENCES "Duo" ("userNum") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "MatchingMode_userNum_fkey" FOREIGN KEY ("userNum") REFERENCES "Squad" ("userNum") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Solo" (
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
    "createDtm" DATETIME NOT NULL,
    "updateDtm" DATETIME NOT NULL
);

-- CreateTable
CREATE TABLE "Duo" (
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
    "createDtm" DATETIME NOT NULL,
    "updateDtm" DATETIME NOT NULL
);

-- CreateTable
CREATE TABLE "Squad" (
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
    "createDtm" DATETIME NOT NULL,
    "updateDtm" DATETIME NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "User_userNum_key" ON "User"("userNum");

-- CreateIndex
CREATE UNIQUE INDEX "User_userCode_key" ON "User"("userCode");

-- CreateIndex
CREATE UNIQUE INDEX "User_nickname_key" ON "User"("nickname");

-- CreateIndex
CREATE UNIQUE INDEX "Solo_userNum_key" ON "Solo"("userNum");

-- CreateIndex
CREATE UNIQUE INDEX "Duo_userNum_key" ON "Duo"("userNum");

-- CreateIndex
CREATE UNIQUE INDEX "Squad_userNum_key" ON "Squad"("userNum");
