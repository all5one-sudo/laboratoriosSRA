
% Especificar la direccion del archivo de texto donde
% estan almacenados los datos exportados de LTspice 
datosLT = 'C:\Users\Nico\AppData\Local\LTspice\Draft3.txt';

% Lee los datos desde el archivo de texto
datos = dlmread(datosLT);

% Extrae las columnas 2 y 3
x = datos(:, 2);
y = datos(:, 3);

% Grafica los datos
plot(x, y,'red','LineWidth', 1);  %de color rojo y con mayor grosor determinado por el numero
xlabel('Vin','FontWeight', 'bold', 'FontSize', 12);%Se grafica los datos 
ylabel('Vo','FontWeight', 'bold', 'FontSize', 12);
title('Comparador con histeresis');
grid on;


