import { IntentsBitField, Partials } from "discord.js";
import { Client } from "discordx";
import env from "../env";

class MinisterioDeLumia extends Client {
    constructor(debug: boolean = false) {
        super({
            partials: [Partials.Channel, Partials.Message],
            intents: [
                IntentsBitField.Flags.Guilds,
                IntentsBitField.Flags.GuildMessages,
                IntentsBitField.Flags.GuildMembers,
                IntentsBitField.Flags.MessageContent
            ],
            silent: !debug,
            botGuilds: env.guild ? [env.guild] : []
        });
    }
}

export default new MinisterioDeLumia()