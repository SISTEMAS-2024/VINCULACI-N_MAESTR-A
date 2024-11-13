## Ing Ramiro Bonilla

# ANÁLISIS DE CLÚSTER
# Segmentación de Grupos: Utilizar técnicas de clustering (como K-means) 
# para identificar segmentos de la población con comportamientos y actitudes 
# similares hacia la gestión de residuos. 

# Instala las librerías necesarias (si aún no están instaladas)
if (!require("readxl")) install.packages("readxl")
if (!require("dplyr")) install.packages("dplyr")
if (!require("factoextra")) install.packages("factoextra")
if (!require("magrittr")) install.packages("magrittr") 

# Cargar librerías
library(readxl)
library(magrittr)
library(dplyr)
library(factoextra)

# Cargar el archivo Excel
file_path <- "c:/DATOS/Set Datos/DATOS_FINAL.xlsx"  
# Omitir las primeras filas
data <- read_excel("C:/DATOS/Set Datos/DATOS FINAL.xlsx", sheet = "GRUPO 1", skip = 4)
data

# Selección de columnas numéricas relevantes (ajustar según los datos específicos)
data_numeric <- data %>% select(where(is.numeric)) %>% na.omit()  # Solo columnas numéricas y sin NA
data_numeric

# Escalar los datos
data_scaled <- scale(data_numeric)

# Determinar el número óptimo de clústeres usando el método del codo
fviz_nbclust(data_scaled, kmeans, method = "wss")

# Aplicar K-means con el número de clústeres elegido (por ejemplo, k = 3)
set.seed(123)
kmeans_result <- kmeans(data_scaled, centers = 3, nstart = 25)

# Agregar la asignación de clústeres al conjunto de datos original
data$Cluster <- kmeans_result$cluster

# Visualizar los clústeres
fviz_cluster(kmeans_result, data = data_scaled)

# Mostrar el resumen del resultado
print(kmeans_result)

