import { PrismaClient } from "@prisma/client";
import type { iLeveling, iUser } from "../interfaces/iUser";
const client = new PrismaClient();

export class UserRepository {
    public static async add(user: iUser): Promise<iUser> {
        return client.user.create({
            data: {
                userNum: user.userNum,
                nickname: user.nickname,
                level: user.level,
                userCode: user.userCode
            }
        })
    }

    public static async players(level: iLeveling): Promise<Array<Omit<iUser, 'sent' | 'userNum'>>> {
        return client.user.findMany({
            where: {
                level: {
                    gte: level.min,
                    lte: level.max
                },
                //sent: false
            },
            take: 100,
            skip: level.skip * 100,
            orderBy: { level: 'asc' }
        })
    }

    public static async update(userCode: string): Promise<iUser> {
        return client.user.update({
            where: {
                userCode
            },
            data: {
                sent: true
            }
        })
    }

}