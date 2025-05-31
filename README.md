# Clasificación de Señales EMG con SVM en MATLAB

Este proyecto implementa un modelo de **Máquinas de Vectores de Soporte (SVM)** con núcleo lineal para clasificar dos movimientos de la mano, utilizando características extraídas de señales electromiográficas (EMG).

## 📂 Descripción

El sistema toma como entrada un archivo Excel con características extraídas previamente:
- **VMA (Valor Medio Absoluto)**
- **Energía**
- **Entropía**

Estas características se usan para entrenar y evaluar un clasificador SVM.

## 🧠 Objetivo

Desarrollar una herramienta de clasificación de movimientos utilizando aprendizaje automático en MATLAB.

## 📁 Estructura del archivo Excel

El archivo `Datos_SVM.xlsx` debe contener:
- Hoja `Train`: datos de entrenamiento
- Hoja `Test`: datos de prueba

Cada hoja debe tener 4 columnas:
1. Característica 1: VMA
2. Característica 2: Energía
3. Característica 3: Entropía
4. Etiqueta de clase (2 o 4)

## 🚀 Ejecución

Abre el archivo `.m` en MATLAB y ejecuta el script principal.

```matlab
run('nombre_del_script.m')

