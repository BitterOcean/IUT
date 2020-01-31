/////////////////////////////////
// Generated with a lot of love//
// with TUNIOT FOR ESP8266     //
// Website: Easycoding.tn      //
/////////////////////////////////
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
 * 
 * Also I want to mention that to write this 
 * code I've used this website "Website: Easycoding.tn"
 * that is Great !!!!
 */
#include <ESP8266WiFi.h>

WiFiClient client;

String MakerIFTTT_Key ;
;String MakerIFTTT_Event;
char *append_str(char *here, String s) {  int i=0; while (*here++ = s[i]){i++;};return here-1;}
char *append_ul(char *here, unsigned long u) { char buf[20]; return append_str(here, ultoa(u, buf, 10));}
char post_rqst[256];char *p;char *content_length_here;char *json_start;int compi;

int Gas_pin = 2;

void setup()
{
  Serial.begin(115200);
  WiFi.disconnect();
  delay(3000);
  Serial.println("Start.....");
   WiFi.begin("IUT-City","");
  while ((!(WiFi.status() == WL_CONNECTED))){
    delay(300);

  }
  pinMode(Gas_pin,INPUT);
  Serial.println("..................");
  Serial.println("Connected");
  

}


void loop()
{
  int Gas_state =digitalRead(Gas_pin);

   if(Gas_state == LOW)
   {
    if (client.connect("maker.ifttt.com",80)) {
    MakerIFTTT_Key ="k-D50JDWQB5Ez8gM7XaleGIGeGpESIk-rm9EqXF3e1g";
    MakerIFTTT_Event ="email";
    p = post_rqst;
    p = append_str(p, "POST /trigger/");
    p = append_str(p, MakerIFTTT_Event);
    p = append_str(p, "/with/key/");
    p = append_str(p, MakerIFTTT_Key);
    p = append_str(p, " HTTP/1.1\r\n");
    p = append_str(p, "Host: maker.ifttt.com\r\n");
    p = append_str(p, "Content-Type: application/json\r\n");
    p = append_str(p, "Content-Length: ");
    content_length_here = p;
    p = append_str(p, "NN\r\n");
    p = append_str(p, "\r\n");
    json_start = p;
    p = append_str(p, "{\"value1\":\"");
    p = append_str(p, "Nodemcu");
    p = append_str(p, "\",\"value2\":\"");
    p = append_str(p, "Hi guys ......!!!");
    p = append_str(p, "\",\"value3\":\"");
    p = append_str(p, "How are you..??");
    p = append_str(p, "\"}");

    compi= strlen(json_start);
    content_length_here[0] = '0' + (compi/10);
    content_length_here[1] = '0' + (compi%10);
    client.print(post_rqst);

  }
  Serial.println("Your email has been sent...");
  Serial.println("Gas leakage is detected");
  delay(5000);
 }
 else
 {
  Serial.println("No Gas");
 }

}
