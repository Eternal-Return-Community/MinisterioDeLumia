import { PrismaClient } from "@prisma/client";
const client = new PrismaClient();

export async function add(user: { userNum: number, nickname: string, userCode: string, level: number }): Promise<{
    userNum: number,
    nickname: string | null,
    level: number,
    userCode: string
}> {
    return client.user.create({
        data: {
            userNum: user.userNum,
            nickname: user.nickname,
            level: user.level,
            userCode: user.userCode
        }
    })
}

export async function all(): Promise<Array<{ userNum: number }>> {
    return client.user.findMany({
        select: {
            userNum: true
        }
    })
}