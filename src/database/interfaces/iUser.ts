export interface iUser {
    userNum: number;
    nickname: string;
    userCode: string;
    level: number
    sent: boolean
}

export interface iLeveling {
    min: number;
    max: number;
    skip: number;
}