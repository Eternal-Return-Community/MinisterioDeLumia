import { ActionRowBuilder, ModalBuilder, TextInputBuilder, TextInputStyle, type CommandInteraction } from "discord.js";
import { Discord, Guard, Slash } from "discordx";
import Cache from "../../Cache";
import { PermissionGuard } from "@discordx/utilities";
import { name, min, max, threads, text } from '../../utils/settings.json';

@Discord()
export abstract class Chat {

    @Slash({ name: "chat", description: "envie mensangem para os usuários." })
    @Guard(PermissionGuard(['Administrator'], {
        content: 'Você não tem permissão para executar esse comando',
        ephemeral: true
    }))
    async execute(interaction: CommandInteraction): Promise<void> {
        if (!Cache.isAvailable) {
            interaction.reply({ content: 'Bot ainda está enviando as mensagens. Aguarde alguns minutos.', flags: 'Ephemeral' });
            return
        }

        interaction.showModal(this.components);
    }

    private get panel(): ModalBuilder {
        return new ModalBuilder()
            .setTitle('PAINEL ~ Ministério de Lumia')
            .setCustomId('panel');
    }

    private get components(): ModalBuilder {
        return this.panel.addComponents(
            this.action(this.userName),
            this.action(this.minLevel),
            this.action(this.maxLevel),
            this.action(this.threads),
            this.action(this.text))
    }

    private get userName(): TextInputBuilder {
        return new TextInputBuilder()
            .setLabel('Nome do bot')
            .setStyle(TextInputStyle.Short)
            .setRequired(true)
            .setPlaceholder('para adicionar cor no nome use <color=cor>NICK DO BOT</color>')
            .setMinLength(3)
            .setMaxLength(120)
            .setValue(name)
            .setCustomId('bot-name')
    }

    private get minLevel(): TextInputBuilder {
        return new TextInputBuilder()
            .setLabel('Level minimo')
            .setStyle(TextInputStyle.Short)
            .setRequired(true)
            .setMinLength(1)
            .setMaxLength(3)
            .setValue(min)
            .setPlaceholder('level minimo da conta do usuário que vai receber a mensagem.')
            .setCustomId('min-lvl')
    }

    private get maxLevel(): TextInputBuilder {
        return new TextInputBuilder()
            .setLabel('Level máximo')
            .setStyle(TextInputStyle.Short)
            .setRequired(true)
            .setMinLength(1)
            .setMaxLength(3)
            .setValue(max)
            .setPlaceholder('level máximo da conta do usuário que vai receber a mensagem.')
            .setCustomId('max-lvl')
    }

    private get threads(): TextInputBuilder {
        return new TextInputBuilder()
            .setLabel('Rodadas')
            .setStyle(TextInputStyle.Short)
            .setRequired(true)
            .setMinLength(1)
            .setMaxLength(3)
            .setValue(threads)
            .setPlaceholder('quantas vezes o processo vai reiniciar')
            .setCustomId('threads')
    }

    private get text(): TextInputBuilder {
        return new TextInputBuilder()
            .setLabel('Texto')
            .setStyle(TextInputStyle.Paragraph)
            .setRequired(true)
            .setMinLength(1)
            .setMaxLength(4000)
            .setValue(text)
            .setPlaceholder('texto que o bot vai enviar para os usuários.')
            .setCustomId('bot-text')
    }

    private action(component: TextInputBuilder): ActionRowBuilder<TextInputBuilder> {
        return new ActionRowBuilder<TextInputBuilder>().addComponents(component);
    }
}