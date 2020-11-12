import { ScheduledEvent } from "aws-lambda";

export const handler = async (event: ScheduledEvent): Promise<void> => {
  console.log(event.time)
}
