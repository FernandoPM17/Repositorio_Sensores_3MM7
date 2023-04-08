clc
clear all
close all

%% CARGA DE DATOOS
load("ntc.mat","Sensor_Term")
load("SensorTemperatura.mat","Sensor_MPL")
T=0:0.01:14.99;
Y1=smoothdata(Sensor_MPL,'lowess');
Y2=smoothdata(Sensor_Term,'lowess');
%% CONEXION DEL PUERTO
% s=serialport("COM3",9600,"Timeout",5);
% data1=read(s,18,"char");
% flush(s,"output"); % Limpiamos buffer
% j=0;
%% RECOLECCION DE DATOS
% for(i=1:1:500)
%     T(i)=j;
%     data1=readline(s)
%     data1=char(data1);
%     if(data1(1)=="$")
%         MPL=data1(1,[2:6]);
%         Termistor=data1(1,[12:16]);
%         Sensor_MPL(i)=str2double(MPL);
%         Sensor_Term(i)=str2double(Termistor);
%     end
%     flush(s,"output");
%     j=j+0.01;
% end
%% LIMPIAMOS BUFFER Y CERRAMOS CONEXION
% flush(s,"output");
% s=[];

%% Graficación
a=figure
subplot(2,2,1)
plot(T,Sensor_MPL)
title("MPL")
subplot(2,2,2)
plot(T,Sensor_Term)
title("Termistor")
subplot(2,2,3)
plot(T,Y1)
title("MPL suavizado")
subplot(2,2,4)
plot(T,Y2)
title("Termistor suavizado")

b=figure
Num1=[0.1367];
Den1=[1 0.29239];
FT1=tf(Num1,Den1);
subplot(1,2,1)
stepplot(FT1,15)
title("Función de transferencia MPL")

Num2=[0.2155];
Den2=[1 0.467289];
FT2=tf(Num2,Den2);
subplot(1,2,2)
stepplot(FT2,15)
title("Función de transferencia Termistor")

