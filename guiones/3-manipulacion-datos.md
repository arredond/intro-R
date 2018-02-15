intro-R: Introducción a la Programación y Manipulación de Datos en R

## 3 - Manipulación de datos: introducción al _Tidyverse_

#### Resumen

1. Data frames en _base R_
2. Presentamos... el Tidyverse
   1. ¿Qué es?
   2. Tidy data
   3. ¿Por qué usarlo?
   4. ¿Cómo instalarlo?
3. Paquetes importantes
   1. magrittr
   2. readr
   3. tidyr
   4. dplyr
   5. ggplot2
4. Flujo de trabajo
5. Automatización

----------------------

### 1. Data frames en _base R_

El objeto por excelencia para manipular datos es el `data frame`. Pero... ¿qué es exactamente?

> Un **data frame** es un conjunto de observaciones de diferentes variables. Vamos, lo que viene siendo una tabla.

R está hecho para trabajar con datos, pero se diseñó fundamentalmente para usar vectores. Aunque es posible hacer cosas increíbles con `data frames` en `base R`, existen una serie de paquetes que permiten hacer lo mismo más fácil y más rápido.

### 2. Presentamos... el Tidyverse

##### ¿Qué es?

El **tidyverse** es un conjunto de paquetes desarrollados, casi en su totalidad, por Hadley Wickham. Se basa en un concepto fundamental:

> _Tidy data_: una estructura única y lógica para ordenar datos en una tabla.

##### Tidy data

Existen muchas maneras de colocar nuestros datos en una tabla. Los dos formatos más comunes:

- _Long_ (también llamado **tidy**): Cada fila representa una observación y cada columna, una variable de esa observación.
- _Wide_: Podemos poner varias observaciones en una sola fila. Nos centramos _en el sujeto de la observación_, en lugar de en la observación en sí.

> Ejemplo:  Medimos la altura de varios niños y niñas cada año.

###### Wide

| Nombre   | 1999 | 2000 | 2001 |
| -------- | ---- | ---- | ---- |
| Mauricio | 1.23 | 1.32 | 1.38 |
| Genoveva | 1.31 | 1.35 | 1.41 |
| Félix    | 1.52 | 1.55 | 1.59 |
| Isabel   | 1.12 | 1.16 | 1.25 |

###### Long

| Nombre   | Año  | Altura |
| -------- | ---- | ------ |
| Mauricio | 1999 | 1.23   |
| Mauricio | 2000 | 1.32   |
| Mauricio | 2001 | 1.38   |
| Genoveva | 1999 | 1.31   |
| Genoveva | 2000 | 1.35   |
| Genoveva | 2001 | 1.41   |
| Félix    | 1999 | 1.52   |
| Félix    | 2000 | 1.55   |
| Félix    | 2001 | 1.59   |
| Isabel   | 1999 | 1.12   |
| Isabel   | 2000 | 1.16   |
| Isabel   | 2001 | 1.25   |

###### Ventajas del formato _tidy_

El formato _tidy_ es menos intuitivo para humanos y más largo de escribir a mano, pero es **inequívoco**: cada observación es una fila, cada variable es una columna.

> “Tidy datasets are all alike but every messy dataset is messy in its
> own way.” – Hadley Wickham

¿Qué pasaría si queremos añadir otra variable, peso? En el formato _tidy_ añadiríamos una sola columna; en el formato _wide_, tres (una por año).

##### ¿Por qué usarlo?

A la hora de manipular data frames, el _tidyverse_ es:

- más rápido que _base R_
- proporciona soluciones sencillas a problemas complejos
- más fácil de entender

##### ¿Cómo instalarlo (y cargarlo)?

Igual que cualquier otro paquete:

~~~R
install.packages("tidyverse")
library(tidyverse)
~~~

### 3. Paquetes importantes

El _tidyverse_ es una librería de librerías: contiene varios paquetes y cada uno de ellos proporciona una funcionalidad concreta. Aquí van los más importantes:

##### Magrittr

El único paquete no diseñado por Hadley Wickham, _magrittr_ tiene una única función: permitir el uso de **pipes**

> Una **pipe** es un operador especial que pasa el objeto a su izquierda como primer argumento de la función a su derecha. El símbolo de una _pipe_ es %>%

Las _pipes_ permiten escribir código de manera más natural:

~~~R
## Sin pipe
x <- c(3, 6, 1)
round(exp(diff(log(x))), 1)

## Con pipe
x <- c(3, 6, 1)
x %>% log() %>% diff() %>% exp() %>% round(1)
~~~

Las _pipes_ parecen raras al principio, pero permiten que nuestro código sea mucho más legible y entendible por un humano:

>  Coge el vector x, calcula su logaritmo, luego la diferencia de cada elemento con el anterior, halla su exponencial y redondea a una cifra decimal.

En el _tidyverse_ es muy común encadenar varias funciones y es aquí donde brillan el uso de las _pipes_.

##### readr

Este paquete sirve para importar tablas en diferentes formatos, de manera más rápida y eficiente que _base-R_. La función más interesante de este paquete es `read_csv`, que permite leer archivos en formato CSV (Comma Separated Values).

Otro paquete similar, también desarrollado por Hadley Wickham pero no incluido en el _tidyverse_, es `readxl`. Este paquete provee funciones para leer archivos en formato Excel (.xls y .xlsx)

##### tidyr

Tiene por objetivo facilitar la conversión entre data frames en formato _long_ (tidy) y formato _wide_. Usa principalmente dos funciones:

- `gather`: agrupar datos de varias columnas en una sola. Para pasar de _wide_ a _long_.
- `spread`: "extender" los datos de una columna en varias. Para pasar de _long_ a _wide_.

En ambos casos la nomenclatura es muy parecida:

###### gather

~~~ R
alturas_long <- alturas_wide %>% 
  gather(key = "year", value = "altura", -nombre)
~~~

>  Con el símbolo `-`  indicamos la(s) columna(s) que NO queremos agrupar.

###### spread

~~~R
alturas_wide <- alturas_long %>%
  spread(key = "year", value = "altura") 
~~~

Las celdas de la columna `year` pasarán a ser los nombres de las nuevas columnas.

##### dplyr

`dplyr` es la esencia del _tidyverse_. Proporciona una serie de funciones (verbos) que permiten manipular fácilmente nuestro _data frame_. Aquí van algunos de los más importantes:

- `select` : selecciona las columnas que queramos.

  ~~~R
  alturas_long %>% select(year, altura) # Opción 1.
  alturas_long %>% select(-nombre)      # Opción 2.
  ~~~


- `rename`: cambia los nombres de una o más columnas

  ~~~R
  alturas_long %>% rename(name = nombre, height = altura)
  ~~~

- `filter` : filtra las observaciones (filas) por una o más condiciones

  ~~~R
  alturas_long %>% filter(altura >= 1.40, year >= 2000)
  ~~~

- `mutate`: añade columnas sin eliminar las ya existentes.

  ~~~R
  alturas_long %>% mutate(altura_cuadrado = altura^2)
  ~~~

- `transmute`: añade columnas y elimina las ya existentes

  ~~~R
  alturas_long %>% transmute(altura_cuadrado = altura^2)
  ~~~

##### ggplot2

R tiene multitud de opciones para hacer gráficos; tantas, que puede resultar confuso o difícil conseguir lo que quieres.`ggplot2` proporciona una "gramática de gráficas" por capas: una manera sistemática e inteligente de crear gráficas de manera lógica. Puede ser un poco difícil de entender al principio, pero una vez que se comprende la estructura resulta muy potente.

`ggplot2` sirve para dibujar datos contenidos en un _data frame_ (por ello es parte del _tidyverse_). La base de cualquier gráfico escrito con `ggplot2` está en definir cuáles son los datos y qué vamos a pintar en cada eje (_aesthetic mapping_):

~~~R
ggplot(data = alturas_long, aes(x = year, y = altura))
~~~

![alturas_init](/home/arredond/learn_teach/intro-R/images/ggplot2/alturas_init.png)

Esto _inicializará_ el gráfico, que no tendrá datos pintados sobre él. Para pintarlos podemos añadirle una _capa de puntos_.

~~~R
ggplot(data = alturas_long, aes(x = year, y = altura)) + 
  geom_point()
~~~

![alturas_año](/home/arredond/learn_teach/intro-R/images/ggplot2/alturas_puntos.png)

¿Y si queremos que los puntos de cada niño aparezcan en un color diferente?

~~~R
ggplot(data = alturas_long, aes(x = year, y = altura, color = nombre)) + 
  geom_point()
~~~

![alturas_nombre](/home/arredond/learn_teach/intro-R/images/ggplot2/alturas_color.png)

En vez de puntos, podemos pintar líneas:

~~~R
ggplot(data = alturas_long, aes(x = year, y = altura, color = nombre)) + 
  geom_line(aes(group = nombre))
~~~

![alturas_linea](/home/arredond/learn_teach/intro-R/images/ggplot2/alturas_linea.png)

> Hemos tenido que añadir el argumento "group" para indicar cómo se unirán las líneas

Podemos tener puntos _sobre_ las líneas:

~~~R
ggplot(data = alturas_long, aes(x = year, y = altura, color = nombre)) + 
  geom_line(aes(group = nombre)) +
  geom_point()
~~~

![alturas_linea_punto](/home/arredond/learn_teach/intro-R/images/ggplot2/alturas_linea_punto.png)

Los argumentos en el _aesthetic mapping_ (aes) de la función `ggplot` afectan a todas las capas. En su lugar, podemos definirlo individualmente:

~~~R
ggplot(data = alturas_long, aes(x = year, y = altura)) + 
  geom_line(aes(color = nombre, group = nombre)) +
  geom_point()
~~~

![alturas_linea_punto_negro](/home/arredond/learn_teach/intro-R/images/ggplot2/alturas_linea_punto_negro.png)

#### Otros tipos de gráficos

###### Histograma

~~~R
ggplot(data = alturas_long, aes(x = altura)) + 
  geom_histogram(bins = 4)
~~~

![alturas_hist](/home/arredond/learn_teach/intro-R/images/ggplot2/alturas_hist.png)

###### Cajas y bigotes (boxplot)

~~~R
ggplot(data = alturas_long, aes(x = nombre, y = altura)) + 
  geom_boxplot()
~~~

![alturas_boxplot](/home/arredond/learn_teach/intro-R/images/ggplot2/alturas_boxplot.png)

### 4. Flujo de trabajo

Lo más difícil e importante de cualquier manipulación de datos es tener datos en primer lugar. El 90% de la calidad de los resultados va a venir derivado directamente de la calidad de los datos, y no de nuestro análisis.

> "In God we trust. All others must bring data." - W. Edwards Demming

Una vez que se tienen los datos necesarios, conviene seguir un flujo de trabajo organizado:

1. Importar o leer datos  {readr}
2. Formatear (hacer _tidy_, en caso de que no lo estén)   {tidyr}
3. Análisis exploratorio (ver histogramas, contar NAs...)  {base R}
4. Limpiar datos (tratar _outliers_, NAs...)  {dplyr}
5. Manipular (crear/modificar variables)  {dplyr}
6. Modelizar, si fuese necesario  {base R} o {purrr}
7. Crear gráficos, si fuesen necesarios  {ggplot2}
8. Extraer conclusiones

A los pasos 2, 3 y 4 se les conoce como _data wrangling_: convertir los datos brutos en algo utilizable. Aunque los modelos y los gráficos son la parte visible y apreciada, el _data wrangling_ es la etapa más fundamental  (y muchas veces complicada) de la manipulación.

##### Automatización

Como dijimos al principio de este curso, una de las grandes ventajas del _scripting_ es la automatización: poder repetir la misma tarea sobre multitud de archivos de una tacada.

Con la estructura de trabajo correcta, un bucle (o una función _apply_) y la magia del Tidyverse, esto es pan comido.

> Tengo un montón de ficheros en una carpeta llamada `carpeta_de_ficheros`, dentro de la carpeta `datos` de mi proyecto. Quiero leer todos los archivos, extraer los primeros 100 elementos y guardarlos en la carpeta `procesados`.

~~~R
## Extracción de los 100 primeros elementos de cada fichero
setwd(".../proyecto/datos/carpeta_de_ficheros")
library(tidyverse)
for (fichero in list.files()) {
  read_csv(fichero) %>% head(100) %>%
    write_csv(paste(".../proyecto/datos/procesados/", 
                    fichero, sep = ""))
}
~~~

