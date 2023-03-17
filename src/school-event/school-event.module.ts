import { Module } from '@nestjs/common';
import { SchoolEventController } from './school-event.controller';
import { SchoolEventService } from './school-event.service';

@Module({
  controllers: [SchoolEventController],
  providers: [SchoolEventService]
})
export class SchoolEventModule {}
