#include <SPI.h>

#include <Adb.h>
#define MAX_RESET 8



// Adb connection.
Connection * connection;

// Elapsed time for ADC sampling
long lastTime;
boolean shoot = false;
// Event handler for the shell connection. 
void adbEventHandler(Connection * connection, adb_eventType event, uint16_t length, uint8_t * data)
{
  int i;

  // Data packets contain two bytes, one for each servo, in the range of [0..180]
  if (event == ADB_CONNECTION_RECEIVE)
  {

    shoot = true;


  }


}

void setup()
{

  pinMode(13, OUTPUT);
  // Initialise serial port
  Serial.begin(57600);

  // Note start time
  lastTime = millis();


  // Initialise the ADB subsystem.  
  ADB::init();

  // Open an ADB stream to the phone's shell. Auto-reconnect
  connection = ADB::addConnection("tcp:4567", true, adbEventHandler);  

  // read the analog and convert it into time


}
int value = 0;
void loop()
{
  if(shoot) {
    fire();
    shoot=false;
  }

  // Poll the ADB subsystem.
  ADB::poll();
}

void fire(){
  // read the analog and convert it into time
  int firedelayAnalog = analogRead(0);
  int firedurationAnalog = analogRead(1);

  // wait for delay
  delay(firedelayAnalog);
  // open gas valve
  digitalWrite(13,HIGH);
  // wait for duration
  delay(firedurationAnalog);
  // close gas valve
  digitalWrite(13,LOW);
  Serial.print("Duration: "); 
  Serial.print(firedurationAnalog); 
  Serial.print(" Delay: "); 
  Serial.print(firedelayAnalog);
  Serial.println();

}





