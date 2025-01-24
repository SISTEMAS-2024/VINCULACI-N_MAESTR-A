## Ing Ramiro Bonilla

# AN�LISIS DE CL�STER
# Segmentaci�n de Grupos: Utilizar t�cnicas de clustering (como K-means) 
# para identificar segmentos de la poblaci�n con comportamientos y actitudes 
# similares hacia la gesti�n de residuos. 

# Instala las librer�as necesarias (si a�n no est�n instaladas)
if (!require("readxl")) install.packages("readxl")
if (!require("dplyr")) install.packages("dplyr")
if (!require("factoextra")) install.packages("factoextra")
if (!require("magrittr")) install.packages("magrittr") 

# Cargar librer�as
library(readxl)
library(magrittr)
library(dplyr)
library(factoextra)

# Cargar el archivo Excel
file_path <- "c:/DATOS/Set Datos/DATOS_FINAL.xlsx"  
# Omitir las primeras filas
data <- read_excel("C:/DATOS/Set Datos/DATOS FINAL.xlsx", sheet = "GRUPO 1", skip = 4)
data

# Selecci�n de columnas num�ricas relevantes (ajustar seg�n los datos espec�ficos)
data_numeric <- data %>% select(where(is.numeric)) %>% na.omit()  # Solo columnas num�ricas y sin NA
data_numeric

# Escalar los datos
data_scaled <- scale(data_numeric)

# Determinar el n�mero �ptimo de cl�steres usando el m�todo del codo
fviz_nbclust(data_scaled, kmeans, method = "wss")

# Aplicar K-means con el n�mero de cl�steres elegido (por ejemplo, k = 3)
set.seed(123)
kmeans_result <- kmeans(data_scaled, centers = 3, nstart = 25)

# Agregar la asignaci�n de cl�steres al conjunto de datos original
data$Cluster <- kmeans_result$cluster

# Visualizar los cl�steres
fviz_cluster(kmeans_result, data = data_scaled)

# Mostrar el resumen del resultado
print(kmeans_result)

