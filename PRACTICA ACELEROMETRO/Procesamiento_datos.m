clc
clear all
close all
%% CARGA DE DATOS
Inc_izq=load("DATOS_INCLINADO_IZQUIERDA.mat");
Inc_izq_pitch=Inc_izq.muestras(1:100,1);Inc_izq_pitch=Inc_izq_pitch';
Inc_izq_roll=Inc_izq.muestras(1:100,2); Inc_izq_roll=Inc_izq_roll';

Inc_der=load("DATOS_INCLINADO_DERECHA.mat");
Inc_der_pitch=Inc_der.muestras(1:100,1);Inc_der_pitch=Inc_der_pitch';
Inc_der_roll=Inc_der.muestras(1:100,2); Inc_der_roll=Inc_der_roll';

Estaticos=load("DATOS_ESTATICOS.mat");
Estaticos_pitch=Estaticos.muestras(1:100,1);Estaticos_pitch=Estaticos_pitch';
Estaticos_roll=Estaticos.muestras(1:100,2); Estaticos_roll=Estaticos_roll';
%% Normalizacion de datos
Maximo=1023;
Minimo=0;
% Estaticos
Estaticos_pitchNorm=inputNorm(Estaticos_pitch,Minimo,Maximo);
Estaticos_rollNorm=inputNorm(Estaticos_roll,Minimo,Maximo);
EstaticosNorm=[Estaticos_pitchNorm ; Estaticos_rollNorm];
T1= [-1*ones(1,100);-1*ones(1,100)]; %Estaticos de -1 a -1

%Izquierda inclinado
Inc_izq_pitchNorm=inputNorm(Inc_izq_pitch,Minimo,Maximo);
Inc_izq_rollNorm=inputNorm(Inc_izq_roll,Minimo,Maximo);
Inc_izqNorm=[Inc_izq_pitchNorm; Inc_izq_rollNorm];
T2= [-1*ones(1,100);1*ones(1,100)]; %Inclinado izquierda de -1 a 1

%Derecha inclinado
Inc_der_pitchNorm=inputNorm(Inc_der_pitch,Minimo,Maximo);
Inc_der_rollNorm=inputNorm(Inc_der_roll,Minimo,Maximo);
Inc_derNorm=[Inc_der_pitchNorm; Inc_der_rollNorm];
T3= [1*ones(1,100);1*ones(1,100)]; %Inclinado derecha de 1 a 1

%% Concatenacion de vectores
DatosNorm=[EstaticosNorm Inc_izqNorm Inc_derNorm];
T=[T1 T2 T3];

% Grafica de datos normalizados y sin normalizar
subplot(2,3,1)
plot(Estaticos.muestras);
title("Datos estaticos sin normalizar")
subplot(2,3,2)
plot(Inc_izq.muestras);
title("Datos inclinados izquierda sin normalizar")
subplot(2,3,3)
plot(Inc_der.muestras)
title("Datos inclinados derecha sin normalizar")
subplot(2,3,4)
plot(EstaticosNorm)
title("Datos estaticos normalizados")
subplot(2,3,5)
plot(Inc_izqNorm)
title("Datos inclinados inzquierda normalizado")
subplot(2,3,6)
plot(Inc_derNorm)
title("Datos inclinados derecha normalizados")
%Hasta aqui va bien
%% Division de datos
[TrainInput,TrainOutput,TestInput,TestOutput]=divideData(DatosNorm,T,0.75);
%% Entrenamiento
nodeHidden=2;
outputs=2;
fhidden='tansig';
foutput='tansig';

[W1,b1,W2,b2,emedio]=neuralTrain(TrainInput,TrainOutput,nodeHidden,fhidden,foutput);
figure
plot(emedio)
