% =========================================================================
% Clasificación de movimientos de la mano mediante SVM
% =========================================================================

clc;
clear;
close all;

%% Cargar los datos desde archivo Excel
archivo_excel = 'Datos_SVM.xlsx';  % Archivo con características extraídas de señales EMG

% ============================
% Datos de entrenamiento
% ============================
hoja_entrenamiento = 'Train'; 
datos_entrenamiento = xlsread(archivo_excel, hoja_entrenamiento);

% Separar características y etiquetas
X_train = datos_entrenamiento(:, 1:3);  % Características: VMA, Energía, Entropía
Y_train = datos_entrenamiento(:, 4);    % Etiqueta: movimiento (2 o 4)

% ============================
% Datos de prueba
% ============================
hoja_prueba = 'Test'; 
datos_prueba = xlsread(archivo_excel, hoja_prueba);

X_test = datos_prueba(:, 1:3);  
Y_test = datos_prueba(:, 4);    

%% Entrenamiento del modelo SVM
% Se entrena un clasificador SVM con núcleo lineal, adecuado para
% clasificación binaria con datos separables linealmente.

svm = fitcsvm(X_train, Y_train, 'KernelFunction', 'linear');
model = fitPosterior(svm);  % Ajuste posterior para estimar probabilidades

%% Evaluación del modelo
% Predicciones sobre el conjunto de prueba
y_pred = predict(model, X_test);

% Cálculo de la exactitud
accuracy = sum(y_pred == Y_test) / numel(Y_test);
fprintf('Exactitud del modelo: %.2f%%\n', accuracy * 100); 

%% Visualización de datos y del hiperplano
% Asignar colores a las clases
color_map = [1 0 0; 0 0 1]; % Rojo para clase 2, Azul para clase 4
colors = zeros(size(Y_train, 1), 3);

for i = 1:length(Y_train)
    if Y_train(i) == 2
        colors(i, :) = color_map(1, :);
    elseif Y_train(i) == 4
        colors(i, :) = color_map(2, :);
    end
end

% Gráfico 3D de las características con color por clase
figure;
scatter3(X_train(:, 1), X_train(:, 2), X_train(:, 3), 20, colors, 'filled');
hold on;

% Obtener parámetros del hiperplano
W = model.Beta;
b = model.Bias;

% Crear malla para trazar el plano de decisión
x_min = min(X_train(:, 1)); x_max = max(X_train(:, 1));
y_min = min(X_train(:, 2)); y_max = max(X_train(:, 2));
[X, Y] = meshgrid(linspace(x_min, x_max, 100), linspace(y_min, y_max, 100));
Z = (W(1) * X + W(2) * Y + b) / (-W(3));  % Ecuación del plano

% Dibujar el hiperplano
mesh(X, Y, Z, 'FaceAlpha', 0, 'LineWidth', 2, 'EdgeColor', 'k');

% Etiquetas y título del gráfico
title('Clasificación SVM de características EMG');
xlabel('Característica 1: VMA');
ylabel('Característica 2: Energía');
zlabel('Característica 3: Entropía');
axis tight;
hold off;
