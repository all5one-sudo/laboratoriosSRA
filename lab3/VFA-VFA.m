clear all; close all; clc;

s=tf('s');
k=0.1;
kpA=0;
kpB=1;
kpC=10;
kpD=2.6; % Ganador

Ao=100000/((1+s/(2*pi*10))*(1+s/(2*pi*5060000)));

T1=-k*Ao^2;

T2A=-kpA*Ao;
T2B=-kpB*Ao;
T2C=-kpC*Ao;
T2D=-kpD*Ao; % Ganador

TA=T1+T2A;
TB=T1+T2B;
TC=T1+T2C;
TD=T1+T2D; % Ganador

P=Ao/(1+Ao/25); % intento de compensar el sistema ignorando efectos de los polos de P

Ts=-k*Ao; % realimentación simplificada sin compensar

Gs=Ao/(1-Ts); % modelo simplificado sin compensar

% LOS MODELOS SIMPLIFICADOS SOLO SIRVEN SI EL SEGUNDO AMPLIFICADOR TIENE
% POLOS DE ORDEN MUY SUPERIOR AL PRIMERO
Gt=Ao^2/(1-TD); % considerando todo

bode(Gs ,Gt) % comparación compensaciones

% Buscamos el valor exacto de wg:
frecuencias1 = logspace(log10(8e+06), log10(8e+08), 1000);  
[dB1, phi1, w1] = bode(TD,frecuencias1);

% Encuentra el índice donde la magnitud es aproximadamente 0 dB:
idx1 = find(dB1 <= 1.001, 1);

% Obtiene la frecuencia correspondiente al punto de 0 dB y la fase:
wg = w1(idx1);
phig = phi1(idx1);

% Buscamos el valor exacto donde la ganancia cae 3 dB:
frecuencias2 = logspace(log10(7e+04), log10(3e+05), 1000);  
[dB2, phi2, w2] = bode(Gt/dcgain(Gt),frecuencias2);

% Encuentra el índice donde la magnitud es aproximadamente -3 dB:
idx2 = find(dB2 <= 0.708, 1);

% Obtiene la frecuencia correspondiente al punto de -3 dB:
w3dB = w2(idx2);

% Muestra los resultados
disp(['El ancho de banda potencial es: ', sprintf('%.1f',wg/1e6), ' Mrad/s']);
disp(['La fase en la frecuencia wg es: ', sprintf('%.1f',phig), ' grados']);
disp(['La frecuencia del polo wp se encuentra en: ', sprintf('%.1f',wg/0.644/1e6), ' Mrad/s']);
disp(['La frecuencia de wh se encuentra también donde está wp']);
disp(['El ancho de banda a 3dB es desde los 0 rad/s hasta ',sprintf('%.1f',w3dB/1000),' krad/s']);