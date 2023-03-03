#include "Adafruit_VL53L0X.h"

Adafruit_VL53L0X lox = Adafruit_VL53L0X();
float EMA_ALPHA=0.25;
float EMA_LP=0;
float leido=0;

void setup() {
  Serial.begin(115200);


  while (! Serial) {
    delay(1);
  }
  
  Serial.println("----- VL53L0X -----");
  if (!lox.begin()) {
    Serial.println(F("error de inicializacion"));
    while(1);
  }
  
  Serial.println(F("VL53L0X ejemplo rango\n\n")); 
}


void loop() {
  VL53L0X_RangingMeasurementData_t measure;

  lox.rangingTest(&measure, false); 

  if (measure.RangeStatus != 4) {  
    leido = (float)measure.RangeMilliMeter;
    EMA_LP=EMA_ALPHA*leido+(1-EMA_ALPHA)*EMA_LP;
    Serial.println(EMA_LP);
  } else {
    Serial.println(" fuera de rango ");
  }
    
  delay(100);
}
