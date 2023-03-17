import { Test, TestingModule } from '@nestjs/testing';
import { SchoolEventController } from './school-event.controller';

describe('SchoolEventController', () => {
  let controller: SchoolEventController;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [SchoolEventController],
    }).compile();

    controller = module.get<SchoolEventController>(SchoolEventController);
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });
});
