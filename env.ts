const { BOT_TOKEN, GUILD, LOGIN, PASSWORD, WEBHOOK } = process.env;

if (!BOT_TOKEN || !LOGIN || !PASSWORD || !WEBHOOK) throw new Error('O bot não pode ser inicializado pq tem informação faltando no .env');

export default {
    token: BOT_TOKEN,
    guild: GUILD,
    webhook: WEBHOOK
}