import { add } from "./database.js";

let GAMES: Array<number> = []
const FOUND: Array<number> = []
const USERS: Array<number> = [5231832]

async function userGames(userNum: number) {

    const response = await fetch(`https://open-api.bser.io/v1/user/games/${userNum}`, {
        headers: {
            'Content-Type': 'application/json',
            "x-api-key": process.env.TOKEN!
        },
    });

    const data: any = await response.json();
    if (data.code != 200) return

    for (const user of data.userGames) {
        if (GAMES.includes(user.gameId) || FOUND.includes(user.gameId)) continue;
        if (user.serverName !== 'SouthAmerica' || user.matchingMode != 2) continue;
        GAMES.push(user.gameId)
    }

    if (data?.next != null) {
        userGames(data.next)
        return;
    }
}

async function games(gameId: number) {

    if (FOUND.includes(gameId)) return;

    const response = await fetch(`https://open-api.bser.io/v1/games/${gameId}`, {
        headers: {
            'Content-Type': 'application/json',
            "x-api-key": process.env.TOKEN!

        },
    });

    const data: any = await response.json();
    if (data.code != 200) return

    for (const user of data.userGames) {
        if (user.serverName !== 'SouthAmerica' || user.matchingMode != 2) break;
        if (USERS.includes(user.userNum)) continue;

        const userCode = await findPresence(user.userNum)

        try {
            USERS.push(user.userNum)
            await add({
                nickname: user.nickname,
                userNum: user.userNum,
                level: user.accountLevel,
                userCode
            })
        } catch (e) { continue }

        console.log(`Novo jogador adicionado: ${user.nickname}`)
    }

    FOUND.push(gameId)
}

async function findPresence(userNum: number): Promise<string> {
    const response = await fetch(`https://bser-rest-release.bser.io/api/users/findPresencesByUserNums`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
            'X-BSER-AuthProvider': 'STEAM',
            'X-BSER-Version': process.env.VERSION!,
            'X-BSER-SessionKey': process.env.BTOKEN!
        },
        body: JSON.stringify({
            "userNum": 1,
            "userNums": [userNum]
        })
    })

    const data: any = await response.json();
    return data.rst.userPresences[0].userCode
}

function renewalSession() {
    fetch(`https://bser-rest-release.bser.io/api/external/renewalSession`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
            'X-BSER-AuthProvider': 'STEAM',
            'X-BSER-Version': process.env.VERSION!,
            'X-BSER-SessionKey': process.env.BTOKEN!
        }
    }).catch(e => console.log(e?.message))
}

setInterval(renewalSession, 3 * 10000)

while (true) {
    for (const userNum of USERS) await userGames(userNum)

    console.log(`QUANTIDADE DE JOGOS A SER ANALIZADO ${GAMES.length}`)

    for (const id of GAMES) await games(id)

    GAMES = []
    console.clear()
    console.log('O PROCESSO VAI RECOMEÇAR')
}