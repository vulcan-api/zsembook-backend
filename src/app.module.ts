import {
  MiddlewareConsumer,
  Module,
  NestModule,
  RequestMethod,
} from '@nestjs/common';
import { AuthModule } from './auth/auth.module';
import { ConfigModule } from '@nestjs/config';
import { DbModule } from './db/db.module';
import { SpottedModule } from './spotted/spotted.module';
import { MailerModule } from '@nestjs-modules/mailer';
import * as process from 'process';
import { UserModule } from './user/user.module';
import { OlympicsModule } from './olympics/olympics.module';
import { FaqModule } from './faq/faq.module';
import { SchoolEventModule } from './school-event/school-event.module';
import { CachingMiddleware } from './middleware/caching.middleware';

@Module({
  imports: [
    AuthModule,
    DbModule,
    ConfigModule.forRoot({
      isGlobal: true,
    }),
    SpottedModule,
    MailerModule.forRootAsync({
      useFactory: () => ({
        transport: {
          host: process.env.SMTP_HOST,
          secure: false,
          auth: {
            user: process.env.SMTP_USER,
            pass: process.env.SMTP_PASS,
          },
        },
        defaults: {
          from: `"No-Reply" <${process.env.SMTP_USER}>`,
        },
      }),
    }),
    UserModule,
    OlympicsModule,
    FaqModule,
    SchoolEventModule,
  ],
})
export class AppModule implements NestModule {
  configure(consumer: MiddlewareConsumer): any {
    consumer
      .apply(CachingMiddleware)
      .forRoutes({ path: '*', method: RequestMethod.GET });
  }
}
