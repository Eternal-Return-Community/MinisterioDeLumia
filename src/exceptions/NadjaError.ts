export default class NadjaError extends Error {
    constructor(public readonly message: string) {
        super(message);
    }
}