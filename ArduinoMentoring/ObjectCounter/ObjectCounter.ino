/* 
 * Breifly in this Project we will count people 
 * traversing a certain passage or enterance.
 * 
 * "An Object Counter Using :
 *  1- an IR Sensor
 *  2- ESP8266 NODEMCU BOARD
 *  
 *  EXPLANATIONS :
 *  the distance from the object is very imporatnt
 *  and in some cases the IR sensor is not suitable
 *  for these applications.If the distanse is greateer
 *  than 20-30cm , the ultrasonic sensor can be a 
 *  better choice.
 *  
 *  We need to know when the Ir sensor changes its 
 *  state from HIGH to LOW and count how many times
 *  this transition happens : this is called "state 
 *  change detection".
 */
#include <ESP8266WiFi.h> //including the main library

//assign an initial value to some variables
#define ir1Pin D4//the pin on the esp8266 board used for receiving the IR-ray
#define ir2Pin D5//the pin on the esp8266 board used for receiving the IR-ray
  /*
   * the part below is not needed
   * this variable is used in that
   * places that we have only one
   * IR_sensor and we need to remember
   * the last state
   * but here we have two IR_sensors
   * 
   * int i = 1;
   */
  int cntr = 0;// count the number of poeple are in the room
  /* ****  WiFi  **** */
  const char* ssid = "ASUS";
  const char* password = "MOHX09030914";
  WiFiServer server(80);
  /* ****WiFi END**** */

//This function runs only one time
void setup() {
  Serial.begin(115200);
  delay(100);
  pinMode(ir1Pin, INPUT);//define pin 4 as an INPUT pin
  pinMode(ir2Pin, INPUT);//define pin 5 as an INPUT pin
  /*
   * these two statements are wrong ; 
   * because when you define a pin as 
   * an INPUT pin then you can not 
   * change or define its value , this
   * will change automatically when 
   * your IR_sensor starts to notify
   * or gives signal...
   * 
   *digitalWrite(ir1Pin, HIGH);
   *digitalWrite(ir2Pin, HIGH);
   *
   *taein pin mode o digital write ?
   */
  
/* *****************WiFi***************** */
// Connect to WiFi network
  /*parts below are used only for debuging...
   *"Serial.println" is a function used for 
   *writing something in the consol..*/
  Serial.println();
  Serial.println();
  Serial.print("Connecting to ");
  Serial.println(ssid);
  
  WiFi.begin(ssid, password);//starting WIFI antenna to connect to the ssid with the defined password
 
  while (WiFi.status() != WL_CONNECTED) {
    /*Until WIFI is not connected ,
     * it will print dots in the consol
     * every 500 mSec */
    delay(500);
    Serial.print(".");
  }
  Serial.println("");
  Serial.println("WiFi connected");
 
  // Start the server
  server.begin();
  Serial.println("Server started");
 
  // Print the IP address
  Serial.print("Use this URL to connect: ");
  Serial.print("http://");
  Serial.print(WiFi.localIP());
  Serial.println("/");
  /* ***************WiFi END****************** */
}

void loop() {
  
  //che javabi bedahad 
  int ir1 = digitalRead(ir1Pin);
  int ir2 = digitalRead(ir2Pin);
  Serial.println("right : ");
  Serial.println(ir1);
  Serial.println("left : ");
  Serial.println(ir2);
/* ****WiFi**daryaft etelaat az client***** */
/*
  WiFiClient client = server.available();
  if (!client) {
    return;
  }
  
  // Wait until the client sends some data
  Serial.println("new client");
  //while (!client.available()) {
  //  delay(1);
  //}
  
  // Read the first line of the request
  String req = client.readStringUntil('\r');
  Serial.println(req);
  client.flush();
  //payan daryaft
  
  //barname
  // Return the response
  /*
  client.println("HTTP/1.1 200 OK");
  client.println("Content-Type: text/html");
  client.println(""); //  do not forget this one
  client.println("<!DOCTYPE HTML>");
  client.println("<html>");
/***********HTML************/
 /*
  if(ir1 == LOW) i = 1;
  if(ir2 == LOW)
    {
      if(i==1)
        {
          cntr++;
          client.println("tedad afrad dakhel otagh:");
          client.println(cntr);
          i=0;
        }
      else 
        {
          cntr--;
          client.println("tedad afrad dakhel otagh:");
          client.println(cntr);
        }
    }
  */
  
  /*
   * parts below woreked in this way :
   * if at first IR_1 notify us , means that
   * a person wanted to ENTER the room
   * OTHERWISE (if at first IR_2 gives us a
   * signal) it means that a person wanted
   * to get out of the room
   * #Also we presumed that a person wanted
   * to enter the room , will certainly
   * enter the room means that after 
   * traversing across the IR_1 , she/he 
   * will travers across the IR_2 too.
   * 
   * 
   *     IR_1       IR_2
   *      ##         ##
   *       .         .
   *       .         .
   *  OUT  .         .  IN
   *       .         .
   *       -         -
   *      ir1       ir2
   *
   */
  if( ir1 == 0 )
    cntr++;
    
  delay(2000);
  
  if( ir2 == 0 )
    if(cntr)
      cntr--;

  Serial.print("tedad afrad dakhel otagh: ");
  Serial.println(cntr);
  //client.print("tedad afrad dakhel otagh: ");
  //client.println(cntr);
  delay(500);
  
  //client.println("</html>");
/***********HTML************/
  
  delay(1);
  Serial.println("Client disonnected");
  Serial.println("");
  
  /* ***************WiFi END****************** */
}
