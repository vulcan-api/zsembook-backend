import { Injectable } from '@nestjs/common';
import { FacebookUser } from './facebook.strategy';
import { DbService } from '../../db/db.service';
import { generateUsername } from 'unique-username-generator';

@Injectable()
export class FacebookService {
  constructor(private readonly prisma: DbService) {}
  async registerFacebookUser(user: FacebookUser): Promise<number> {
    const usr = await this.prisma.user.findUnique({
      where: { facebookId: user.id },
      select: { id: true },
    });
    if (usr) return usr.id;
    const [name, lastName] = user.name.split(' ');
    return (
      await this.prisma.user.create({
        data: {
          email: user.email,
          name,
          username: await this.getRandomUsername(),
          surname: lastName,
          passwordHash: '',
          profileDesc: '',
          facebookId: user.id,
        },
      })
    ).id;
  }

  async getRandomUsername(): Promise<string> {
    let username = '';
    let usr;
    do {
      username = generateUsername('', 4);
      usr = await this.prisma.user.findUnique({
        where: { username },
      });
    } while (usr);
    return username;
  }
}
