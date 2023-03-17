import { Test, TestingModule } from '@nestjs/testing';
import { SchoolEventService } from './school-event.service';

describe('SchoolEventService', () => {
  let service: SchoolEventService;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [SchoolEventService],
    }).compile();

    service = module.get<SchoolEventService>(SchoolEventService);
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });
});
