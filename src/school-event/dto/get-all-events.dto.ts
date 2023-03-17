import { IsInt, IsOptional, IsPositive } from 'class-validator';

export class GetAllEventsDto {
  @IsOptional()
  @IsPositive()
  @IsInt()
  skip?: number;

  @IsOptional()
  @IsPositive()
  @IsInt()
  take?: number;
}
