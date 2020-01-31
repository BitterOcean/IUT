/* 
 * Breifly in this Project we will measure
 * the the amount of lpg , CO and smoke 
 * exists in the air.
 * 
 * "A Smoke Meter Using :
 *  1- a MQ2 sensor
 *  2- ESP8266 NODEMCU BOARD
 *  
 * EXPLANATION : 
 * you can add some parts to control a LED
 * or a buzzer e.g. when the amount of smoke
 * overpassed a special amount , the buzzer
 * rang or the LED started to blink...
 * but this is simply read an show the amount of
 * smoke , CO and LPG on a web page.
 */
#include <ESP8266WiFi.h>
#include <MQ2.h>

int pin = A0;//change this with the pin that you use
int lpg, co, smoke;

/* ****WiFi**** */
const char* ssid = "IUT-City";
const char* password = "";
WiFiServer server(80);
/* ****WiFi**** */

MQ2 mq2(pin);//an object of class MQ2

//This function runs only one time
void setup(){
  Serial.begin(115200);
  delay(100);
  mq2.begin();
  
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

void loop(){
  
  /* ****WiFi******************************** */
  WiFiClient client = server.available();
  if (!client) {
    return;
  }
  
  // Wait until the client sends some data
  Serial.println("new client");
  while (!client.available()) {
    delay(1);
  }
  
  // Read the first line of the request
  String req = client.readStringUntil('\r');
  Serial.println(req);
  client.flush();
  
  // Return the response
  client.println("HTTP/1.1 200 OK");
  client.println("Content-Type: text/html");
  client.println(""); //  do not forget this one
  client.println("<!DOCTYPE HTML>");
  client.println("<html>");
  /***********HTML************/
  /*read the values from the sensor, it returns
  *an array which contains 3 values.
  * 1 = LPG in ppm
  * 2 = CO in ppm
  * 3 = SMOKE in ppm
  */
  float* values= mq2.read(true); //set it false if you don't want to print the values in the Serial
  
  //lpg = values[0];
  lpg = mq2.readLPG();
  //co = values[1];
  co = mq2.readCO();
  //smoke = values[2];
  smoke = mq2.readSmoke();
  
  client.print("The amount of lpg is : ");
  client.println(lpg);
  client.println();
  client.print("The amount of CO is : ");
  client.println(co);
  client.println();
  client.print("The amount of smoke is : ");
  client.println(smoke);
  client.println();
  
  client.println("</html>");
  /***********HTML************/
  
  delay(1);
  Serial.println("Client disonnected");
  Serial.println("");
  
  /* ***************WiFi END****************** */
  delay(1000);
}
