#### Raster

En el fichero comprimido `embalse.zip` encontrarás una serie de imágenes de satélite de un brazo de un embalse en Brasil. Vamos a escribir un programa para detectar automáticamente la vegetación en cada una de las imágenes.

1. Crea dos nuevas carpetas en tu carpeta de proyecto: `embalse` y `embalse_procesados`. Extrae los contenidos de `embalse.zip` en la carpeta `embalse`.

   > Comprueba que dentro de esta carpeta solo hay ficheros .tif; no guardes aquí nada más, ni siquiera `embalse.zip`.

2. Crea un nuevo script y escribe en él un preámbulo adecuado, fijando `embalse` como tu directorio de trabajo y cargando la librería `raster`.

3. Importa **el primero** de los ficheros `.tif` usando la función `raster` y guárdalo con un nombre que te parezca adecuado. Explora sus contenidos:

   1. Dibújalo usando `plot`.
   2. Observa su histograma con `hist`. ¿Ves algo de particular en la distribución?
   3. Llama al objeto para ver un resumen de sus características en pantalla. ¿Hay algo raro en el apartado de bandas?

   > El archivo tenía múltiples bandas pero solo hemos importado la primera.

4. Usa la función `stack` para importar el archivo de nuevo y sobreescribe el objeto que habías creado. Vuelve a ejecutar los comandos `plot` y `hist`. Deberías ver cinco gráficos en cada caso, uno por cada banda.

5. Ahora vamos a calcular su Índice Diferencial de Vegetación Normalizado (NDVI). Este índice se calcula usando varias bandas de un ráster y sirve para identificar la vegetación. Tiene la siguiente fórmula:
   $$
   NDVI = \frac{IR_c - Rojo}{IR_c + Rojo}
   $$
   En estas imágenes, la banda del rojo es la segunda y la del infrarrojo cercano, la quinta.

   1. Crea una función para calcular este índice.
   2. Usa la función `calc` para aplicar la función a tu ráster y obtener un nuevo objeto.
   3. Dibuja el nuevo ráster que has obtenido

6. Ahora vamos a _binarizar_ el ráster que has calculado: separar la información en dos clases. Para ello, usa una operación que solo guarde los píxeles con valores de NDVI mayores de 0.

7. Guarda el resultado en la carpeta `embalse_procesado` usando la función `writeRaster`.

8. Ahora toca automatizar el proceso. Basándote en el ejercicio de ayer, usa un bucle para leer todos los archivos ráster y guardar el resultado de todos en `embalse_procesado`.

   > Esto puede tardar un poco. Incluye un `print` en tu bucle para ver en la consola cuándo acaba de procesar cada raster.


#### Vector

¿Recuerdas la tabla con árboles de Nueva York? Vamos a utilizar `sf` para averiguar a qué barrio pertenece cada uno.

> Como siempre, crea un nuevo script y explica qué vas a hacer en él, además de fijar tu directorio de trabajo y llamar a las librerías que vayas a usar (en este caso, `tidyverse` y `sf`)

1. Descarga el fichero `barrios.zip` y descomprímelo en la misma carpeta que `arboles_ny.csv`.

2. Importa el fichero `arboles_ny.csv` y asígnalo al objeto `arboles`.

3. Convierte el data frame `arboles` en un objeto espacial usando la función `st_as_sf`. 

   > Al tener datos de latitud y longitud, tendrás que fijar el CRS como 4326 (lat/lon).

4. Ahora importa el shapefile de los barrios usando `st_read` y guarda el objeto con el nombre `barrios`.

5. Usa `ggplot2` para hacer mapa de los barrios de Nueva York.

6. Añade a ese mapa una capa con los árboles. ¿Ves algún problema?

   > Ojo: los data frames de cada uno (barrios y árboles) son distintos. Tendrás que poner el argumento "data" dentro de cada capa individual.