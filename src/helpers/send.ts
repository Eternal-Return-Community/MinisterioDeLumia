import Cache from "../Cache";
import repositories from "../database/repositories";
import Nadja from "../services/Nadja"
import logger from "../utils/logger";

type Settings = {
    name: string;
    text: string;
    min: number;
    max: number;
    count: number
}

export default async function send({ name, text, min, max, count }: Settings): Promise<void> {

    Cache.isAvailable = false;

    if (Cache.count >= count) {
        Cache.isAvailable = true
        Cache.count = 0;
        return
    }

    try {

        for (let i = 0; i < Infinity; i++) {

            const players = await repositories.user.players({ min, max, skip: i });
            if (players.length == 0) break;

            const userCodes = players.map(i => i.userCode);
            const userPresences = await Nadja.findPresence(userCodes);

            for (const { gamestatus, nn, userCode } of userPresences) {

                if (gamestatus === 'Offline') continue;
                const response = await Nadja.add(userCode);

                if (response?.cod >= 7000) continue;

                logger('ADD', `solicitação de amizade enviada para ${nn} com sucesso!`)
            }
        }

        const friendList = await Nadja.list();
        
        if (friendList == undefined) {
            ++Cache.count
            await send({ name, text, min, max, count })
            return
        };

        for (const { friendUserCode, friendNickname } of friendList?.friends) {

            const presence = await Nadja.findPresence(friendUserCode);
            console.log(`[PLAYER] -> ${presence[0]?.nn} (${presence[0]?.gamestatus})`)

            if (presence[0]?.gamestatus === 'Offline') {
                await Nadja.delete(friendUserCode)
                continue
            };

            await Nadja.send(name, friendUserCode, text?.replaceAll('{{name}}', friendNickname))
            await Promise.all([repositories.user.update(friendUserCode), Nadja.delete(friendUserCode)])

            logger('MESSAGE', `Mensagem enviada para: ${friendNickname}`)
        }

        ++Cache.count

        if (count != Infinity) logger('INFO', `Atual ${Cache.count} | Total ${count} | Faltam ${(count - Cache.count) ? `Falta ${count - Cache.count}` : 'Todas as mensagens foram enviadas com sucesso! :partying_face:'}`)

    } catch (e: any) {
        console.log(`Ocorreu um seguinte erro: ${e?.message ?? e}`)
    }

    await send({ name, text, min, max, count })

}