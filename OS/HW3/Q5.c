semaphore mutex = 1, south_permit = 1, north_permit = 1;
int north_pass = 0, north_waiting = 0;
int south_pass = 0, south_waiting = 0;

south{
  wait(mutex);
  if(north_pass == 0 && north_waiting == 0){
    south_pass ++;
    signal(south_permit);
  }else if(north_waiting > 0 && south_pass < 5 && north_pass == 0){
    south_pass++;
    signal(south_permit);
  }else south_waiting++;

  signal(mutex);
  wait(south_permit);
  //pass cs;
  wait(mutex);
  south_pass--;
  if(south_pass == 0 && north_waiting > 0){
    for( i = 0; i < 5 && north_waiting > 0){
      signal(north_permit);
      north_pass++;
      north_waiting--;
    }
  }else if(north_waiting == 0 && south_waiting > 0){
    signal(south_permit);
    north_waiting--;
    north_pass++;
  }
  signal(mutex);
}


---------------------------------------------------------------------------


north{
  wait(mutex);
  if(south_pass == 0 && south_waiting == 0){
    north_pass ++;
    signal(north_permit);
  }else if(south_waiting > 0 && north_pass < 5 && south_pass == 0){
    north_pass++;
    signal(north_permit);
  }else north_waiting++;

  signal(mutex);
  wait(north_permit);
  //pass cs;
  wait(mutex);
  north_pass--;
  if(north_pass == 0 && south_waiting > 0){
    for( i = 0; i < 5 && south_waiting > 0){
      signal(south_permit);
      south_pass++;
      south_waiting--;
    }
  }else if(south_waiting == 0 && north_waiting > 0){
    signal(north_permit);
    south_waiting--;
    south_pass++;
  }
  signal(mutex);
}
