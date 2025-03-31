import SteamUser from 'steam-user';
import Cache from '../Cache';
import Nadja from './Nadja';

class Steam extends SteamUser {

    private readonly accountName: string = process.env.LOGIN!;
    private readonly password: string = process.env.PASSWORD!;
    private readonly gameID: number = 1049590;

    constructor() {
        super({ autoRelogin: true })

        this.on('error', (err) => {
            console.log('[SteamUser - Error] -> ', err)
            this._relog()
        })

        this.on('disconnected', (err) => {
            console.log('[SteamUser - Disconnected] -> ', err)
            this._relog()
        })
    }

    public async login(): Promise<void> {
        this.logOn({ accountName: this.accountName, password: this.password })
        this.on('loggedOn', async () => {
            try {
                console.log(`[Steam - Ticket] -> Gerando Ticket.`)
                await this.generateSessionTicket()
            } catch (e: any) {
                console.log(`[Steam - getToken] -> ${e?.message}`)
            }
        })
    }

    public async refreshTicket(): Promise<void> {
        try {
            await this.cancelAuthSessionTickets(this.gameID, null)
            await this.generateSessionTicket()
            console.log(`[Steam - refreshToken] -> Atualizandoo Ticket.`)
        } catch (e: any) {
            console.log(`[Steam - refreshToken] -> ${e}`)
            await this.generateSessionTicket()
        }
    }

    private async generateSessionTicket(): Promise<void> {
        const { sessionTicket } = await this.createAuthSessionTicket(this.gameID);
        if (!sessionTicket) throw new Error('You need to log into the game at least once on your Steam/ERBS account.');

        console.log(`[Steam - Ticket] -> Ticket Gerado!`)
        ERBS.auth(this.getSessionTicket(sessionTicket))
    }

    private getSessionTicket(sessionTicket: Buffer): string {
        return sessionTicket.toString('hex').toUpperCase()
    }

    private _relog(): void {
        console.log(`[Steam - Relog] -> Relogando...`)
        if (!this.steamID) setTimeout(this.login, 10 * 1000)
    }
}

class ERBS {
    public static async auth(authorizationCode: string): Promise<void> {
        await this.getPatch();
        const response = await Nadja.client('POST', '/users/authenticate', JSON.stringify({
            "dlc": "pt",
            "glc": "ko",
            "alc": "en",
            "la": 2,
            "ap": 'STEAM',
            "idt": authorizationCode,
            "prm": { authorizationCode },
            "ver": Cache.patch
        }))

        Cache.token = response?.sessionKey
        await Nadja.login()
        this.renewalSession();
    }

    private static renewalSession = (): void => {
        if (Cache.renewalSession) return;
        Cache.renewalSession = true;
        setInterval(() => Nadja.client('POST', '/external/renewalSession'), 1 * 30000)
    }

    public static async getPatch(): Promise<void> {
        try {
            const response = await fetch('https://er.dakgg.io/api/v1/character-stats')
            const data: any = await response.json();

            const patchNumber = String(data.meta.patch);

            const major = patchNumber.substring(0, 1);
            const minor = patchNumber.substring(1, 3);
            const patch = patchNumber.substring(3, patchNumber.length);

            console.log(`[ERBS - Patch] -> ${major}.${minor}.${patch}`)
            Cache.patch = `${major}.${minor}.${patch}`;
        } catch (e: any) {
            console.log('Ocorreu um erro ao pegar a versão do Patch')
            console.log(e?.message ?? e)
        }
    }
}

export default { STEAM: new Steam(), ERBS };