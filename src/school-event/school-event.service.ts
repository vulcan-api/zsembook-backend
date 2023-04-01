import { Injectable } from '@nestjs/common';
import { DbService } from '../db/db.service';

@Injectable()
export class SchoolEventService {
  constructor(private readonly prisma: DbService) {}

  async getAllEvents(skip: number, take: number): Promise<any> {
    return await this.prisma.schoolEvent.findMany({
      skip,
      take,
      orderBy: { date: 'desc' },
    });
  }

  async getEventById(eventId: number): Promise<object> {
    return await this.prisma.schoolEvent.findUniqueOrThrow({
      where: { id: eventId },
    });
  }
}
