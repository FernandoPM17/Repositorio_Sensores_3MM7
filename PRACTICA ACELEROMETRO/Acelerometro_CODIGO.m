clc
clear all
close all
%% CONEXION DEL PUERTO
s=serialport("COM3",9600,"Timeout",5);
data1=read(s,11,"char");
flush(s,"output"); % Limpiamos buffer

%% RECOLECCION DE DATOS
for(i=1:1:100)   
    data1=readline(s)
    data1=char(data1);
    if(data1(1)=="<")
        component1=data1(1,[2:5]);
        component2=data1(1,[7:10]);

        %convierto el componente 1 a numerote
        n1=double(component1(1))-48;
        n2=double(component1(2))-48;
        n3=double(component1(3))-48;
        n4=double(component1(4))-48;
        Numero=(n1*1000)+(n2*100)+(n3*10)+n4;
        muestras(i,1)=Numero;

        %convierto el componente 2 a numerote
        n1=double(component2(1))-48;
        n2=double(component2(2))-48;
        n3=double(component2(3))-48;
        n4=double(component2(4))-48;
        Numero=(n1*1000)+(n2*100)+(n3*10)+n4;
        muestras(i,2)=Numero;
    end
    
end
%% LIMPIAMOS BUFFER Y CERRAMOS CONEXION
flush(s,"output");
s=[];
