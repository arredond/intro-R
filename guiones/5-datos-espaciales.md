intro-R: Introducción a la Programación y Manipulación de Datos en R

## 5 - Datos espaciales

#### Resumen

- ¿Por qué R?
- Raster vs. Vector
- Raster
  - Estructura
  - Librería `raster`
  - Bandas
  - Aritmética ráster
  - Operaciones espaciales
- Vector
  - Estructura
  - Formatos
    - Formatos históricos
    - Simple Features
  - Librería `sf`
  - `sf` y `tidyverse`
  - Operaciones espaciales
- Juntando `raster` y `sf`

-----------

### 1. ¿Por qué R?

La información espacial es 

### 2. Raster vs. Vector

Existen dos formas principales de almacenar información espacial: _raster_ y _vector_.

- _Raster:_ Un formato matricial. Esencialmente, son imágenes (generalmente) ortogonales al territorio. La unidad mínima de información es la celda o _píxel_. Pueden estar compuestos por una o más bandas; cada banda guarda un dato por píxel, normalmente números del 0 al 255 (_8 bit_)
- _Vector_: Un formato vectorial. Guardamos las coordenadas de cada objeto espacial, al que va asociado un registro en una tabla de atributos. Puede haber varios tipos de objetos espaciales: puntos, líneas y polígonos, así como multipuntos, multilíneas y multipolígonos.

Y ahora, la pregunta del millón:

> ¿Qué formato es mejor?

Se suele decir que el formato vectorial es más eficiente y ligero. ¿Es cierto en todos los casos?

Pensemos en dos ejemplos:

![road_above](/home/arredond/learn_teach/intro-R/images/road_above.jpg)

> Fuente: https://iso.500px.com/10-tips-thatll-take-your-drone-photography-to-new-heights/

Si lo que queremos es describir la carretera, será mucho más eficiente guardar una línea (puntos concatednados) o polígono (puntos concatenados y cerrados) que toda una imagen donde nos sobran los árboles y estamos obligados a capturar un rectángulo.

Pero... ¿y en este otro ejemplo?



![chessboard](/home/arredond/learn_teach/intro-R/images/chessboard.png)

Aquí el formato _ráster_ es mucho más eficiente: solo tenemos que guardar un bit por celda, además del número de filas y columnas. En un formato vectorial guardaríamos cuatro puntos por cada cuadrado, además de asociar una tabla de atributos a cada uno.

Es un ejemplo extremo pero no es muy distinto de este otro:

![madrid](/home/arredond/learn_teach/intro-R/images/madrid.jpeg)

En general, usaremos formatos **ráster para información continua** y **vector para información discreta**.

### 3. Ráster

##### Estructura

Un archivo ráster es una imagen _georreferenciada_. Esto quiere decir que, además de la imagen en sí, guardaremos en él las coordenadas de sus esquinas y su sistema de coordenadas (CRS). Del número de filas y columnas de un ráster, dividido por el área que cubre, se puede obtener la _resolución_, expresada frecuentemente en **tamaño del píxel**.

Un ráster puede contener varias bandas. En este caso, todas ellas contienen los mismos metadatos (extensión, CRS y resolución).

Existen multitud de formatos ráster disponibles y utilizados en la actualidad. El más utilizado en la actualidad es el _GeoTIFF_ (`.tif`).

##### Librería `raster`

Es la librería por excelencia para tratar archivos _ráster_. Se leen con la función del mismo nombre:

~~~R
madrid <- raster("ortofoto_madrid.tif")
~~~

Podemos conocer información sobre nuestro ráster de varias maneras:

~~~R
crs(madrid)    # Sistema de referencia (CRS)
extent(madrid) # Extensión (coordenadas de las esquinas)
res(madrid)    # Resolución del ráster
nbands(madrid) # Número de bandas
plot(madrid)   # Ver una imagen del ráster
hist(madrid)   # Ver el histograma del ráster
madrid         # Un resumen de toda esta información
~~~

Podemos guardar nuestro ráster con la función `writeRaster`:

~~~R
writeRaster(madrid, "ortofoto_madrid.tif", format = "GeoTIFF")
~~~

##### Bandas

La función `raster` solo importa una banda; por defecto, la primera del archivo. Si tenemos un ráster con varias bandas usaremos la función `stack`. Podemos seleccionar cada banda como si fuese una matriz:

~~~R
madrid <- stack("ortofoto_madrid.tif")
madrid[,1]     # Seleccionar solo la primera banda
plot(madrid)   # Veremos una imagen por cada banda
hist(madrid)   # Veremos un histograma por cada banda
~~~

> Los archivos ráster pueden ser muy grandes. Por defecto, los objetos de tipo `RasterLayer` o `RasterStack` no se guardan enteros en memoria, sino que R va leyendo trozos y procesándolos para no llenar la RAM. Este comportamiento se puede cambiar cargando archivos con la función `brick`.

##### Aritmética ráster

Una de las manipulaciones más frecuentes de un ráster es la aritmética ráster (equivalente al "Raster Calculator" en varios GIS). R nos permite hacer operaciones como si fuese un vector cualquiera:

~~~R
madrid_doble <- madrid * 2
madrid_binario <- madrid > 100 # Binarización
~~~

También podemos usar la función `calc` para operaciones más complejas. Esto es especialmente útil en el caso de rásters con varias bandas:

~~~~R
mi_funcion <- function(x) {x[,1] + x[,2]^2 - 100}
madrid_modificado <- calc(madrid, fun = mi_funcion)
~~~~

Otra función muy utilizada es `reclassify`, para reclasificar los valores de un objeto ráster a otros valores 

> p.e. dar a todos los valores menores de 50 el valor 0, entre 50 y 100 el 1 y a todos los valores mayores de 100 darles el valor 2)

~~~R
rcl <- matrix(c(0, 50, 0, 50, 100, 1, 100, 1000, 2), ncol = 3, byrow = T)
reclassify(madrid, rcl)
~~~

###### Operaciones espaciales

Otra manipulación muy frecuente de una imagen ráster son las operaciones espaciales. Algunas de las más importantes son `crop`, `merge` , `mask`, `aggregate`, `disaggregate`, `resample`, `alignExtent`, `drawExtent`.

### 4. Vector

##### Estructura

En el formato vectorial guardamos, fundamentalmente, dos cosas:

- Información espacial (_features_)
- Tabla de atributos

Podemos tener también información adicional (metadatos):

- Sistema de coordenadas
- Índice de la tabla de atributos
- Índices espaciales

###### Formatos históricos

Existen muchos formatos vectoriales pero el más utilizado sin duda es el _shapefile_.

> Un _shapefile_ es un conjunto de ficheros que guarda cada parte de los datos por separado.

Una shapefile tiene _por obligación_ tres ficheros:

- `.shp`: la información espacial
- `.dbf`: la tabla de atributos en formato dBase
- `.shx`: los índices de la información espacial, para buscar y juntar rápidamente la información espacial y la tabla de atributos.

Además, puede tener multitud de ficheros opcionales, de los cuales los más frecuentes son:

- `.prj`: el sistema de coordenadas (CRS) y proyección
- `.sbn y .sbx`: índices espaciales.

###### Simple Features

En el año 2004 el Open Geospacial Consortium propone un estándar (norma ISO) para ordenar la información vectorial conocido como Simple Features.

> El estándar _Simple Features_ consiste en almacenar toda la información en un solo fichero, integrando la información espacial en la tabla de atributos en formato Well Known Binary (WKB) o Well Known Text (WKT).

Este estándar simplifica enormemente la estructura y permite manejar la información más rápidamente.

Un tipo de fichero muy popular y extremadamente eficiente que implementa este estándar es el GeoPackage (`.gpkg`). Además, tiene la ventaja de ser un formato Open Source.

##### Librería `sf`

`sf` es una librería que permite importar y manejar información espacial en R siguiendo el estándar Simple Features. Un objeto importado por `sf` será siempre un `data frame`.

> La librería `sf` es de muy reciente creación y está creada para sustituir a su predecesora, `sp`.

Todas las funciones de `sf` empiezan por `st_`. Por ejemplo, para leer y escribir usaremos las funciones `st_read` y `st_write`:

~~~R
setwd(".../directorio_de_trabajo/datos/")
municipios <- st_read("municipios.shp")
st_write(municipios, "municipios.gpkg")
~~~

También podemos convertir un data frame normal en un objeto `sf`, si tiene columnas de coordenadas:

~~~R
arboles <- st_as_sf(arboles, 
                    coords = c("longitude", "latitude"), 
                    crs = 4326)
~~~

##### `sf` y `tidyverse`

Al ser todos los objetos importados por `sf` un `data frame`, podemos manipularlos con las herramientas del `tidyverse`:

~~~R
municipios %>% 
  select(habitantes, area) %>% 
    mutate(densidad = habitantes/area) %>%
      ggplot() + geom_sf(aes(fill = densidad))
~~~

##### Operaciones espaciales

Podemos llevar a cabo multitud de operaciones espaciales con funciones de `sf`. Aquí van solo unas pocas:

~~~R
st_geometry(municipios)          # Extraer solo la información espacial de la capa
st_geometry(municipios) <- NULL  # Eliminar la información espacial de la capa
st_crs(municipios)               # Conocer el CRS de la capa
st_transform(municipios, 4326)   # Reproyectar la capa a otro CRS (e.j. 4326, lat/lon)
st_buffer(municipios, 100)       # Crear un buffer de 100 unidades (depende del CRS)
st_centroid(municipios)          # Hallar el centroide de cada elemento de la capa
st_intersects(municipios, zepas) # Intersección de dos capas
~~~

### 4. `sf` y `raster`

A veces tenemos que combinar información vectorial y ráster. Por desgracia, las librerías `sf` y `raster` son, a día de hoy, mayoritariamente incompatibles; por suerte, se está desarrollando una nueva librería para tratar archivos `raster` compatible con `sf` y los estándares Simple Features.

> Es posible utilizar conjuntamente información vectorial y ráster en R utilizando el predecesor de `sf`, `sp`. No vamos a tratarlo en este curso pero existen multitud de recursos para hacerlo; por ejemplo, [este curso de la Universidad de Wageningen](http://geoscripting-wur.github.io/VectorRaster/).