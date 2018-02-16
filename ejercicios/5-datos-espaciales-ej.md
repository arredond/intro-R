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

![ndvi_formula](https://user-images.githubusercontent.com/19406854/36313229-384d7982-1331-11e8-9fac-61f78dabb8f0.png)

   En estas imágenes, la banda del rojo es la segunda y la del infrarrojo cercano, la quinta.

   1. Crea una función para calcular este índice.
   2. Usa la función `calc` para aplicar la función a tu ráster y obtener un nuevo objeto.
   3. Dibuja el nuevo ráster que has obtenido

6. Ahora vamos a _binarizar_ el ráster que has calculado: separar la información en dos clases. Para ello, usa una operación que solo guarde los píxeles con valores de NDVI mayores de 0.

7. Guarda el resultado en la carpeta `embalse_procesado` usando la función `writeRaster`.

8. Ahora toca automatizar el proceso. Basándote en el ejercicio de ayer, usa un bucle para leer todos los archivos ráster y guardar el resultado de todos en `embalse_procesado`.

   > Esto puede tardar un poco. Incluye un `print` en tu bucle para ver en la consola cuándo acaba de procesar cada raster.

   ​
