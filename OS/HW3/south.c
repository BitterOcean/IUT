/* North is used to ensure mutual exclusion when NorthCounter
is updated i.e. when any nort_entered_car enters to the bridge */
/* South is used to ensure mutual exclusion when SouthCounter
is updated i.e. when any south_entered_car enters to the bridge */
/* bridge is used to ensure mutual exclusion when North or
South wants to executes */
semaphore South , North , bridge = 1;

/* Counters are helpfull variables used for preventing starvation */
int NorthCounter = 0;
int SouthCounter = 0;

South
{
  wait(South);
  SouthCounter++;
  if (SouthCounter==1)
    wait(bridge);
  signal(South);

  /* Crossing the Bridge */

  if (SouthCounter>=5 && NorthCounter)
  {
    signal(bridge);
    SouthCounter = 0;
  }
}
