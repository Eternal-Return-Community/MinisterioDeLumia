import MinisterioDeLumia from "./src/Bot";
import env from "./env";
import { dirname, importx } from "@discordx/importer";

await importx(`${dirname(import.meta.url)}/src/{events,interactions}/**/*.{ts,js}`);
MinisterioDeLumia.login(env.token)