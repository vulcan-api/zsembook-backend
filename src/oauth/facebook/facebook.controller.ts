import {
  Body,
  Controller,
  Get,
  HttpStatus,
  Post,
  Res,
  UseGuards,
} from '@nestjs/common';
import { AuthGuard } from '@nestjs/passport';
import { FacebookService } from './facebook.service';
import { FacebookUser } from './facebook.strategy';
import { AuthService } from '../../auth/auth.service';
import { Response } from 'express';

@Controller('oauth/facebook')
export class FacebookController {
  constructor(
    private readonly facebookService: FacebookService,
    private readonly authService: AuthService,
  ) {}
  @UseGuards(AuthGuard('facebook'))
  @Get()
  async facebookLogin(): Promise<number> {
    return HttpStatus.OK;
  }
  @Post('callback')
  async facebookCallback(
    @Body() user: FacebookUser,
    @Res() response: Response,
  ): Promise<void> {
    const userId = await this.facebookService.registerFacebookUser(user);
    const jwt = await this.authService.generateAuthCookie({
      userId,
      roles: ['USER'],
      isBanned: false,
    });

    response.cookie(...jwt);
    response.cookie(
      'user_info',
      JSON.stringify(await this.authService.getUserPublicInfo(user.email)),
    );
    response.send({ token: jwt[1] });
  }
}
