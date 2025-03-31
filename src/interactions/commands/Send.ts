import { ApplicationCommandOptionType, type CommandInteraction } from "discord.js";
import { Discord, Guard, Slash, SlashOption } from "discordx";
import { PermissionGuard } from "@discordx/utilities";
import Nadja from "../../services/Nadja";
import logger from "../../utils/logger";

@Discord()
export abstract class Send {

    @Slash({ name: "send", description: "envie mensangem para um usuário especifico." })
    @Guard(PermissionGuard(['Administrator'], {
        content: 'Você não tem permissão para executar esse comando',
        ephemeral: true
    }))
    async execute(
        @SlashOption({
            name: 'name',
            description: 'nome do usuario que vai receber a mensagem',
            required: true,
            type: ApplicationCommandOptionType.String,
            minLength: 3,
            maxLength: 18
        }) name: string,
        @SlashOption({
            name: 'bot',
            description: 'nome do bot',
            required: true,
            type: ApplicationCommandOptionType.String,
            minLength: 1
        }) botName: string,
        @SlashOption({
            name: 'text',
            description: 'mensagem que vai ser enviada',
            required: true,
            type: ApplicationCommandOptionType.String,
            minLength: 1,
            maxLength: 4000
        }) text: string,
        interaction: CommandInteraction): Promise<void> {

        await interaction.deferReply({ flags: 'Ephemeral' });

        const search = await Nadja.search(name)

        if (!search.friends.length) {
            await interaction.editReply({ content: `O jogador **${name}** não existe.` })
            return
        }

        await Nadja.send(botName, search.friends[0]?.friendUserCode!, text);
        await interaction.editReply({ content: 'Mensagem enviada com sucesso!' })

        logger('MESSAGE', `${interaction.user.globalName} enviou uma mensagem. Nome: ${botName}, Para: ${name}. Mensagem: ${text}`)
    }

}