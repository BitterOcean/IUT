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

North
{
  wait(North);
  NorthCounter++;
  if (NorthCounter==1)
    wait(bridge);
  signal(North);

  /* Crossing the Bridge */

  if (NorthCounter>=5 && SouthCounter)
  {
    signal(bridge);
    NorthCounter = 0;
  }
}
