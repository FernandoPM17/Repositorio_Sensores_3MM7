#include <Adafruit_AHTX0.h>
#include <Wire.h>
#include <Adafruit_MPL3115A2.h>
Adafruit_MPL3115A2 baro;
Adafruit_AHTX0 aht;
float tempLM35;
float tempOtro; 
int pinLM35=0;

void setup() {
  // put your setup code here, to run once:
  Serial.begin(115200);
  aht.begin();
  baro.begin();
}

void loop() {
  // put your main code here, to run repeatedly:
  tempLM35 = analogRead(pinLM35);
  tempLM35=(5.0*tempLM35*100.0)/1024;
  Serial.println(tempLM35);

  float temperature_mpl = baro.getTemperature();
  Serial.println(temperature_mpl);

  sensors_event_t humidity, temp;
  aht.getEvent(&humidity, &temp);// populate temp and humidity objects with fresh data
  Serial.println(temp.temperature);
  Serial.println(humidity.relative_humidity); Serial.print("\n");

  delay(100);
}
