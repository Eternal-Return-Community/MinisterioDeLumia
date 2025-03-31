import { ModalSubmitInteraction } from "discord.js";
import { Discord, ModalComponent } from "discordx";
import send from "../../helpers/send";
import { name, text } from "../../utils/settings.json"
import Cache from "../../Cache";

type IsNumber = string | undefined | number;

@Discord()
export abstract class Chat {

    private readonly ids: readonly string[] = ['bot-name', 'bot-text', 'min-lvl', 'max-lvl', 'threads'];

    @ModalComponent()
    async panel(interaction: ModalSubmitInteraction): Promise<void> {

        if (!Cache.isAvailable) {
            interaction.reply({ content: 'Algum administrador acabou de enviar um spam de mensagem.', flags: 'Ephemeral' });
            return
        }

        const [botName, botText, min, max, threads] = this.values(interaction);
        await interaction.reply({ content: `# Mensagens estão sendo enviadas com a seguintes informação \n\`NOME\`: ${this.name(botName)} \n\`TEXTO\`: ${this.text(botText).replaceAll('{{name}}', 'Nome do usuário')} \n\`MIN\` ${this.min(min)} \`|\` \`MAX\` ${this.max(max)} \n\`THREADS\`: ${this.threads(threads)}`, flags: 'Ephemeral' });

        await send({ name: this.name(botName), text: this.text(botText), min: this.min(min), max: this.max(max), count: this.threads(threads) })
    }

    private values(interaction: ModalSubmitInteraction): readonly string[] {
        return this.ids.map((id) => interaction.fields.getTextInputValue(id))
    }

    private name = (n: string | undefined): string => n ?? name
    private text = (t: string | undefined): string => t ?? text

    private min = (min: IsNumber): number => this.isNumber(min, 1)
    private max = (max: IsNumber): number => this.isNumber(max, 30)

    private threads(thread: IsNumber): number {
        const thrds = this.isNumber(thread, 5)
        return thrds == 999 ? Infinity : thrds
    }

    private isNumber(text: IsNumber, level: number): number {
        if (isNaN(Number(text))) return level;
        return Math.abs(Math.round(Number(text)));
    }
}