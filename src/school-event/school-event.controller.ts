import { Controller, Get, Param, ParseIntPipe, Query } from '@nestjs/common';
import { GetAllEventsDto } from './dto/get-all-events.dto';
import { SchoolEventService } from './school-event.service';
@Controller('event')
export class SchoolEventController {
  constructor(private readonly schoolEventService: SchoolEventService) {}
  @Get()
  async getAllEvents(@Query() query: GetAllEventsDto): Promise<object> {
    return this.schoolEventService.getAllEvents(
      query.skip ?? 0,
      query.take ?? 10,
    );
  }

  @Get('/:id')
  getEvent(
    @Param('id', ParseIntPipe) eventId: number
  ): object {
    return this.schoolEventService.getEventById(eventId);
  }
}
