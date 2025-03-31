import { Client, Discord, On, type ArgsOf } from "discordx";
import env from "../../env";
import NadjaError from "../exceptions/NadjaError";
import Cache from "../Cache";

@Discord()
export abstract class InteractionCreate {
    @On({ event: 'interactionCreate' })
    public async onInteraction([interaction]: ArgsOf<"interactionCreate">, client: Client): Promise<void> {
        if (interaction.guild?.id !== env.guild) return;

        if (interaction.isModalSubmit()) {
            await client.executeInteraction(interaction)
            return
        }

        if (interaction.isCommand()) {
            try {
                await client.executeInteraction(interaction)
            } catch (e: any) {
                if (e instanceof NadjaError) {
                    interaction.reply({ content: e.message, flags: 'Ephemeral' })
                    return
                }

                interaction.reply({ content: 'Ocorreu um erro estranho.', flags: 'Ephemeral' })
            }
        }

    }
}