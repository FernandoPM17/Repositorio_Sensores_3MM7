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

max(Inc_izq_roll);
min(Inc_izq_roll);
max(Inc_der_roll);
min(Inc_der_roll);
