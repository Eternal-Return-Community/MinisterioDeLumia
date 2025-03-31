import type { PrismaClientKnownRequestError } from "@prisma/client/runtime/library";
import type { Message } from "discord.js";

export default class DecayPrismaError {
    constructor(private readonly message: Message, private readonly errors: PrismaClientKnownRequestError) {

        if(errors.code === 'P2025') {
            this.message.reply('**[ERROR] ->** Esse comando não existe. Tente outro comando.')
            return 
        }

        if(errors.code === 'P2002') {
            const description = this.errors.meta?.modelName === 'CustomCommands' ? 
            'Comando com nome duplicado. Digite outro nome para esse comando' : 
            'Algum dos campos enviados já existe no banco de dados..'
            this.message.reply('**[ERROR] ->** '.concat(description))
            return
        }

        console.log(this.errors)
        this.message.reply('**[ERROR] ->** Ocorreu um erro interno (1)')
    }
}