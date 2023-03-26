import * as leoProfanity from 'leo-profanity';
// eslint-disable-next-line @typescript-eslint/ban-ts-comment
// @ts-ignore
import * as pl from './dictionaries/pl_PL.json';
import * as en from './dictionaries/en_EN.json';
leoProfanity.add(pl);
leoProfanity.add(en);

export function filterProfanity(text: string): string {
  return leoProfanity.clean(text);
}

export function checkProfanity(text: string): boolean {
  return leoProfanity.check(text);
}
