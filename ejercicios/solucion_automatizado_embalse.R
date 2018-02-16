## Función para leer todos los rasters del embalse de Brasil
## y extraer la vegetación
setwd(".../embalse")  # Tendrás que poner aquí tu propio "path"
library(raster)

## Función para calcular el NDVI
banda_roja <- 2
banda_ir_cercano <- 5
NDVI <- function(my_raster) {
  (my_raster[,banda_ir_cercano]-my_raster[,banda_roja])/(my_raster[,banda_ir_cercano]+my_raster[,banda_roja])
}

## Vamos con el bucle
for (fichero in list.files()) {
  nombre_guardar <- gsub(".tif", "_procesado.tif", fichero)
  embalse_raster <- stack(embalse)
  embalse_ndvi <- calc(embalse_raster, NDVI)
  embalse_ndvi <- embalse_ndvi > 0
  save_name <- gsub(".tif", "_ndvi.tif", embalse)
  save_path <- paste("../embalse_ndvi/", save_name, sep = "")
  writeRaster(embalse_ndvi, filename = save_path, format = "GTiff")
  print(paste("Output:", save_path))
}