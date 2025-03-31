import env from "../../env"

export type Prefix = 'INFO' | 'ADD' | 'MESSAGE';

export default <T extends Prefix = 'INFO'>(prefix: T, message: string) => {
    fetch(env.webhook, {
        method: 'POST',
        headers: { 'content-type': 'application/json' },
        body: JSON.stringify({
            'username': 'Nadja',
            'content': `\`[${prefix}]\` -> **${message}**`
        })
    })
        .catch(e => console.log('Ocorreu um erro ao enviar o Logger ->', e?.message ?? e))
}