import Cache from "../Cache";
import type { iFriends } from "../interfaces/iFriend";
import NadjaError from "../exceptions/NadjaError";
import ChatBuilder from "../helpers/ChatBuilder";
import Auth from "./Auth";
import type { iUserPresences } from "../interfaces/iUserPresences";

export default class Nadja {

    private static readonly BASE_URL: string = 'https://bser-rest-release.bser.io/api';

    public static async client(method: string, endpoint: string, body?: string): Promise<any> {

        const response = await fetch(this.BASE_URL.concat(endpoint), {
            method,
            headers: {
                'User-Agent': 'BestHTTP/2 v2.4.0',
                'Content-Type': 'application/json',
                'Host': 'bser-rest-release.bser.io',
                'X-BSER-AuthProvider': 'STEAM',
                'X-BSER-SessionKey': Cache.token,
                'X-BSER-Version': Cache.patch
            },
            body
        })

        const data: any = await response.json();


        if (data?.cod == 1006 || data?.msg === 'maintenance') throw new NadjaError('**ERBS** entrou em manutenção.');

        if (data?.cod == 1007) {
            await Auth.ERBS.getPatch()
            throw new NadjaError('Servidor voltou da manutenção agora. A versão do Patch demora 30 minutos para atualizar. Utilize o comando novamente em 30 minutos.')
        }

        if (data?.cod > 1000 && data?.cod <= 1110) {
            await Auth.STEAM.refreshTicket()
            await this.client(method, endpoint, body)
            return;
        }

        return this.data(data.cod, data)
    }

    private static data(cod: number, x: any): any {
        return cod > 1000 ? x : x.rst
    }

    public static async send(nickName: string, userCode: string, text: string): Promise<unknown> {
        return this.client('POST', '/chat/send', new ChatBuilder(nickName, userCode, text).toString())
    }

    public static async add(userCode: string): Promise<any> {
        return this.client('POST', `/friends/${userCode}/request`)
    }

    public static async delete(userCode: string): Promise<void> {
        await this.client('POST', `/friends/${userCode}/delete`)
    }

    public static async list(): Promise<iFriends> {
        return this.client('GET', '/friends')
    }

    public static async search(userName: string): Promise<Omit<iFriends, 'receiveFriends'>> {
        return this.client('POST', `/friends/search`, userName);
    }

    public static async findPresence(userCode: string | Array<string>): Promise<Array<iUserPresences>> {
        const response = await this.client('POST', '/users/findPresences/', JSON.stringify({
            "userCode": Cache.userCode,
            "userCodes": typeof userCode === 'string' ? [userCode] : userCode
        }));

        return response.userPresences;
    }

    public static async login(): Promise<void> {
        const response = await this.client('GET', '/lobby/enterRepeat/?supportLanguage=2&searchTime=0')
        Cache.userCode = response.user.uc
        Cache.userNum = response.user.un
        console.log(Cache)
    }
}
