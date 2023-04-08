#include <Wire.h>
#include <Adafruit_MPL3115A2.h>
Adafruit_MPL3115A2 mpl = Adafruit_MPL3115A2();

float maxTemp = -1000.0;  // Inicializar la variable máxima a un valor muy bajo
float minTemp = 1000.0;   // Inicializar la variable mínima a un valor muy alto
float Tb = 10;            // Temperatura umbral para la planta del frijol
float UC;                 // Variable para la Unidad Calor

void setup() {
  Serial.begin(9600);
  while (!Serial) {}
  
  Serial.println("Iniciando...");
  
  if (!mpl.begin()) {
    Serial.println("No se pudo encontrar el módulo MPL3115A2, compruebe la conexión.");
    while (1);
  }
  
  Serial.println("Módulo MPL3115A2 iniciado correctamente.");
}

void loop() {
  // Leer el valor de la temperatura
  float temp = mpl.readTemperature();

  // Actualizar los valores máximo y mínimo
  if (temp > maxTemp) {
    maxTemp = temp;
  }
  if (temp < minTemp) {
    minTemp = temp;
  }
  
  // Mostrar la temperatura actual en el monitor serial
  Serial.print("Temperatura: ");
  Serial.print(temp);
  Serial.println(" C");

  // Esperar un segundo antes de volver a leer la temperatura
  delay(1000);
  
  // Verificar si ha pasado un día
  static unsigned long startTime = millis();
  if (millis() - startTime >= 86400000) {
    // Mostrar los valores máximos y mínimos
    Serial.print("Valor máximo de temperatura: ");
    Serial.print(maxTemp);
    Serial.println(" C");
    Serial.print("Valor mínimo de temperatura: ");
    Serial.print(minTemp);
    Serial.println(" C");

    UC= (maxTemp+minTemp)/2-Tb;
    if (UC >= 12.89 && UC < 64.41){
      Serial.print("Fenomeno de Emergencia");
    }
    if (UC >= 64.41 && UC < 91.33){
      Serial.print("Fenomeno de Formación de guías");
    }
    if (UC >= 91.33 && UC < 99.31){
      Serial.print("Fenomeno de Floración");
    }
    if (UC >= 99.31 && UC < 112.77){
      Serial.print("Fenomeno de Formación de vainas");
    }
    if (UC >= 112.77 && UC < 153.24){
      Serial.print("Fenomeno de LLenado de vainas");
    }
    if (UC >= 153.24){
      Serial.print("Fenomeno de Maduración");
    }

    // Reiniciar los valores máximos y mínimos
    maxTemp = -1000.0;  // Inicializar la variable máxima a un valor muy bajo
    minTemp = 1000.0;   // Inicializar la variable mínima a un valor muy alto
    startTime = millis();  // Reiniciar el tiempo de inicio
  }
}