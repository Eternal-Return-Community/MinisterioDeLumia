import type { CommandInteraction } from "discord.js";
import { Discord, Guard, Slash } from "discordx";
import Cache from "../../Cache";
import { PermissionGuard } from "@discordx/utilities";

@Discord()
export abstract class Reset {

    @Slash({ name: "reset", description: "resetar o cache." })
    @Guard(PermissionGuard(['Administrator'], {
        content: 'Você não tem permissão para executar esse comando',
        ephemeral: true
    }))
    execute(interaction: CommandInteraction): void {
        Cache.isAvailable = true;
        Cache.count = 0;
        interaction.reply({ content: 'Cache resetado. O comando **/chat** tá liberado novamente.', flags: 'Ephemeral' });
    }

}