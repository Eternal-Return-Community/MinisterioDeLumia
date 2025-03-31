import type { ArgsOf, Client } from "discordx";
import { ActivityType } from "discord.js";
import { Discord, Once } from "discordx";
import Auth from '../services/Auth';

@Discord()
export abstract class Ready {
    @Once({ event: "ready" })
    public async onceReady([]: ArgsOf<"ready">, client: Client) {

        if (client.user) client.user.setActivity({ name: 'Jogue Eternal Return', type: ActivityType.Custom })
        console.log('Ministério de Lumia tá no ar.');
        await Auth.STEAM.login()
        await client.initApplicationCommands();
    }
}