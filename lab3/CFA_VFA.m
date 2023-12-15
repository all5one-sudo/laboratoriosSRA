clear all; close all; clc;

s=tf('s');
R1=45;
R2=925;

T1=-((0.1*(1/R1+1/R2)*2.37*10^11)+(1/R2)*2.37*10^6*(1+s/(2*pi*10))*(1+s/(2*pi*5060000)))/((1+s/(2*pi*10))*(1+s/(2*pi*5060000))*(1+s/(2*pi*14000))*(1+s/(2*pi*82300000)));
T2=-(0.1*(1+R2/R1)*10^5)/((1+s/(2*pi*10))*(1+s/(2*pi*5060000))*(1+s*R2*4.8*10^-12));

A1=(1/R1+1/R2)*2.37*10^11/((1+s/(2*pi*10))*(1+s/(2*pi*5060000))*(1+s/(2*pi*14000))*(1+s/(2*pi*82300000)));
A2=((1+R2/R1)*10^5)/((1+s/(2*pi*10))*(1+s/(2*pi*5060000))*(1+s*R2*4.8*10^-12));
frecuencias = logspace(log10(1e+06), log10(1e+08), 1000);  % Por ejemplo, 1000 puntos

[dB, phi, w] = bode(T2,frecuencias);

idB = find(dB <= 1,1);
iphi = find(phi <= 65,1);

Avf1=A1/(1-T1); % Modelo completo
Avf2=A2/(1-T2); % Modelo simplificado

% Modelo compensado con una red pasiva

R1P=23;
R2P=925;

P=(1+s/(2*pi*5060000))/(2*(1+s/(2*pi*10120000)));

T1P=-P*((0.1*(1/R1P+1/R2P)*2.37*10^11))/((1+s/(2*pi*10))*(1+s/(2*pi*5060000))*(1+s/(2*pi*14000))*(1+s/(2*pi*82300000)))-(1/R2P)*2.37*10^6/((1+s/(2*pi*14000))*(1+s/(2*pi*82300000)));
T2P=-P*(0.1*(1+R2P/R1P)*10^5)/((1+s/(2*pi*10))*(1+s/(2*pi*5060000))*(1+s*R2P*4.8*10^-12));

A1P=P*(1/R1P+1/R2P)*2.37*10^11/((1+s/(2*pi*10))*(1+s/(2*pi*5060000))*(1+s/(2*pi*14000))*(1+s/(2*pi*82300000)));
A2P=P*((1+R2P/R1P)*10^5)/((1+s/(2*pi*10))*(1+s/(2*pi*5060000))*(1+s*R2P*4.8*10^-12));
frecuenciasP = logspace(log10(1e+06), log10(1e+08), 1000);  % Por ejemplo, 1000 puntos

[dBP, phiP, wP] = bode(T1P,frecuenciasP);

idBP = find(dBP <= 1,1);
iphiP = find(phiP <= 75,1);

Avf1P=A1P/(1-T1P); % Modelo completo
Avf2P=A2P/(1-T2P); % Modelo simplificado