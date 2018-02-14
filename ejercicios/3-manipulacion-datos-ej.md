#### Tidy data

1. Crea una carpeta nueva en el ordenador que se llame `proyectos_intro_r` 

2. Dentro de esa carpeta, crea otra carpeta llamada `datos`. Descarga los archivos de la carpeta del mismo nombre de la [web](https://github.com/arredond/intro-R/tree/master/datos) y colócalos en la carpeta que acabas de crear.

3. Abre un nuevo script. Servirá para practicar la conversión entre datos en formato _long_ y formato _wide_.

4. En el preámbulo del script (al principio):

   1. Pon un comentario explicando qué va a hacer el _script_
   2. Fija la carpeta que has creado como directorio de trabajo
   3. Carga el _tidyverse_

5. Importa el fichero `pasajeros_aereos.csv` usando la función `read_csv` y guárdalo como un objeto.

   > Este fichero contiene números de pásajeros aéreos por mes y año en forma de tabla.

6. ¿En qué formato están los datos?  Conviértelos a formato _tidy_ usando la función _gather_. Guarda el nuevo data frame con otro nombre.

   > Pista: tendrás que evitar que la columna `year` sea seleccionada.

7. Vuelve a convertir la nueva tabla que has creado a formato _wide_ usando la función _spread_. Guarda el resultado como otro objeto.

#### Cinturones

La ley que obliga a los conductores a llevar cinturón en Reino Unido entró en vigor en enero de 1983. 

El archivo "cinturones.csv" contiene información sobre fallecimientos en carretera entre enero de 1969 y diciembre de 1984. Vamos a utilizar R para analizarlo y comprender si la entrada en vigor de la ley cambió algo.

1. Importa el fichero `cinturones.csv` y guárdalo como un objeto.

2. Análisis exploratorio: 
   1. ¿Qué columnas contiene el objeto? Puedes usar la función `head` o `glimpse` para saberlo.
   2. Saca un histograma de las columnas que te parezcan interesantes. Usa el operador `$` para acceder a las columnas del data frame.
   3. Usa la función `plot` para obtener un gráfico del número de conductores fallecidos. ¿Ves alguna tendencia?

3. Solo nos interesan las columnas `year`, `month`, `conductores_fallecidos`, `conductores` y `ley`. Selecciónalas usando la función `select`.

4. No podemos comparar el número de fallecimientos de un año a otro porque el número de conductores es distinto. Crea una nueva columna `fallecidos_tasa` que muestre la tasa de fallecidos en cada mes.

5. Queremos comparar el porcentaje de fallecidos antes y después de la entrada en vigor de la ley. No obstante, hay muchos más datos de antes que de después. Filtra los datos para tener en cuenta solo aquellos ocurridos a partir de 1980.

6. Por último, vamos a ver en qué años era mayor la tasa de fallecidos. Usa las funciones `group_by` y `summarise` para obtener la media de la tasa en cada grupo.

   > Pista: Tendrás que agrupar por la variable `ley`.