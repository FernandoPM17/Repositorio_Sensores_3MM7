#include <Adafruit_MPL3115A2.h>
#include <Arduino.h>
#include <math.h>

Adafruit_MPL3115A2 baro;

// configurar el pin utilizado para la medicion de voltaje del divisor resistivo del NTC
#define CONFIG_THERMISTOR_ADC_PIN A0

// configurar el valor de la resistencia que va en serie con el termistor NTC en ohms
#define CONFIG_THERMISTOR_RESISTOR 9900l

/**
 * @brief Obtiene la resistencia del termistor resolviendo el divisor resistivo.
 * 
 * @param adcval Valor medido por el convertidor analógico a digital.
 * @return int32_t Resistencia electrica del termistor.
 */
int32_t thermistor_get_resistance(uint16_t adcval)
{
  // calculamos la resistencia del NTC a partir del valor del ADC
  return (CONFIG_THERMISTOR_RESISTOR * ((1023.0 / adcval) - 1));
}

/**
 * @brief Obtiene la temperatura en grados centigrados a partir de la resistencia
 * actual del componente.
 * 
 * @param resistance Resistencia actual del termistor.
 * @return float Temperatura en grados centigrados.
 */
float thermistor_get_temperature(int32_t resistance)
{
  // variable de almacenamiento temporal, evita realizar varias veces el calculo de log
  float temp;
  // calculamos logaritmo natural, se almacena en variable para varios calculos
  temp = log(resistance);
  // resolvemos la ecuacion de STEINHART-HART
  // http://en.wikipedia.org/wiki/Steinhart–Hart_equation
  temp = 1 / (0.001129148 + (0.000234125 * temp) + (0.0000000876741 * temp * temp * temp));
  // convertir el resultado de kelvin a centigrados y retornar
  return temp - 273.15;
}

void setup() {
  // preparar serial
  Serial.begin(9600);
  while(!Serial);
  //erial.println("Adafruit_MPL3115A2 and NTC thermistor test!");

  if (!baro.begin()) {
    //Serial.println("Could not find MPL3115A2 sensor. Check wiring.");
    while(1);
  }

  // use to set sea level pressure for current location
  // this is needed for accurate altitude measurement
  // STD SLP = 1013.26 hPa
  baro.setSeaPressure(1013.26);
}

void loop() {
  float temperature_mpl = baro.getTemperature();

  // variable para almacenar la temperatura y resistencia
  float temperatura_ntc;
  uint32_t resistencia_ntc;
  // calcular la resistencia electrica del termistor usando la lectura del ADC
  resistencia_ntc = thermistor_get_resistance(analogRead(CONFIG_THERMISTOR_ADC_PIN));
  // luego calcular la temperatura segun dicha resistencia
  temperatura_ntc = thermistor_get_temperature(resistencia_ntc);
  // imprimir resistencia y temperatura al monitor serial
  temperatura_ntc=20.97+25.94+temperatura_ntc;
  Serial.print("$");
  Serial.print(temperature_mpl,2);
  Serial.print("     ");//5 espacios
  Serial.println(temperatura_ntc,2);
  delay(10);
}
