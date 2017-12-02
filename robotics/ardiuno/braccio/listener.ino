#include <Braccio.h>
#include <Servo.h>

Servo base;
Servo shoulder;
Servo elbow;
Servo wrist_rot;
Servo wrist_ver;
Servo gripper;

const int NUMBER_OF_FIELDS = 7; // how many comma separated fields we expect
int fieldIndex = 0;            // the current field being received
int values[NUMBER_OF_FIELDS];   // array holding values for all the fields



void setup()
{
  Serial.begin(9600); // Initialize serial port to send and receive at 9600 baud
  Braccio.begin();
}

void loop()
{
  if(Serial.available())
  {
    char ch = Serial.read();
    if(ch >= '0' && ch <= '9') // is this an ascii digit between 0 and 9?
    {
      // yes, accumulate the value
      values[fieldIndex] = (values[fieldIndex] * 10) + (ch - '0'); 
    }
    else if (ch == ',')  // comma is our separator, so move on to the next field
    {
      if(fieldIndex < NUMBER_OF_FIELDS-1)
        fieldIndex++;   // increment field index
    }
    else
    {
      // any character not a digit or comma ends the acquisition of fields
      // in this example it's the newline character sent by the Serial Monitor
      Serial.print(fieldIndex +1);
      Serial.println(" fields received:");

      if(fieldIndex == 6){
            Serial.println("received all 7 servo positions");
            Braccio.ServoMovement(values[0], values[1], values[2], values[3], values[4], values[5], values[6]);
      }
      
      for(int i=0; i <= fieldIndex; i++)
      {
        //        Serial.println(values[i]);
        //
        //        // trigger some action
        //        if(sizeof(values)/sizeof(values[0]) == 7){
        //            Serial.println("received all servo positions");
        //        }
        values[i] = 0; // set the values to zero, ready for the next message
      }

      fieldIndex = 0;  // ready to start over
    }
  }
}