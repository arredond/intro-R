intro-R: Introducción a la Programación y Manipulación de Datos en R

## Clases de objetos, asignación de objetos y funciones base

#### Resumen

0. ¿Script o consola?

1. Usando R como calculadora
2. Asignación de objetos
3. Clases de objetos
   1. Vectores
   2. Listas
   3. Matrices
   4. Data Frames
   5. NULL
4. Funciones base
5. Nota sobre las funciones

----------------

### 0. ¿Script o consola?

Al abrir RStudio encontramos cuatro sectores diferenciados. Desde arriba a la izquierda, y en el sentido de las agujas del reloj son:

- **El _script_**. Es un fichero de texto simple donde escribimos los comandos que vamos a ejecutar, además de los comentarios que queramos aportar. Si no hay ningún _script_ activo podemos crear haciendo click en el botón adecuado o pulsando CTRL+SHIFT+N
- **El entorno (_environment_) de trabajo.** Muestra los objetos que hemos creado o están activos. En otra pestaña encontramos el historial de comandos.
- **La zona mágica**. Aquí podemos elegir entre varias pestañas para ver nuestros _plots_, la ayuda, los ficheros del directorio de trabajo o los paquetes instalados.
- **La consola**. La zona más importante; en la consola se ejecutan los comandos. Podemos escribir nuestros comandos aquí directamente o mandarlos desde el script pulsando CTRL+ENTER.

**Nota:** Podemos escribir comentarios en nuestro _script_ precediéndolos de una almohadilla. Los comentarios sirven para los humanos; no los interpreta R.

~~~R
# Esto es un comentario. No se enviará a la consola.
~~~

### 1. Usando R como calculadora

Podemos usar R como una calculadora muy avanzada:

~~~R
1 + 1
24 / 7.2
1i * 1i
~~~

Aparte de los operadores típicos, hay algunos otros que nos pueden resultar muy útiles:

~~~ R
24 %% 6
23 %% 6
23 %/% 6
~~~

En este ejemplo, `%%` es "mod division" (devuelve el resto de la división) y `%/%` es la división entera.

###### Comparación de cantidades

También puedes comparar cantidades. El resultado será verdadero (T) o falso (F)

~~~R
47 > 23 
1 <= 2
1 == 1  # Este es el símbolo de igualdad
3 != 3  # Esto significa "distinto de"
~~~



### 2. Asignación de objetos

Programar va, en gran medida, de guardar información en la memoria del ordenador (RAM; Random Access Memory). Un trozo de información guardada se llama un **objeto**. Podemos guardar objetos en R *asignándoles un nombre*. En R, la asignación se hace con el operador `<-`:

~~~R
a <- 2
b <- 3
~~~

Existen otras maneras menos recomendadas para asignar objetos:

~~~R
a = 2
3 -> b
~~~

Los nombres de objetos solo pueden empezar por una letra o un punto.

##### 2.1. Cómo escribir nombres de objetos

En programación existen varias prácticas para escribir nombres de objetos. Las dos más extendidas son:

- snake_case: todas las palabras van separadas por una barra baja y en minúsculas. Ejemplos: my_function, number_of_trees
- camelCase (lower): la primera letra de la palabra va en minúsculas; el resto de las palabras llevan la primera letra en mayúsculas. Ejemplos: myFunction, numberOfTrees

En este curso vamos a utilizar **snake_case** para nombrar nuestros objetos. Según un estudio, es más fácil de entender que camelCase.

##### 2.2. Buenos nombres para un objeto

El nombre de un objeto debe ser suficientemente descriptivo sin ser excesivamente largo (aunque es preferible pasarnos de longitud que quedarnos cortos). Recordemos que nuestro código siempre puede ser utilizado en el futuro por gente que no conozca el proyecto.

Un ejemplo: tenemos el número de árboles dentro de una masa forestal:

- numero_de_arboles: demasiado largo
- narb: demasiado corto (y feo)
- num_arboles: buen nombre

Según Andy Lester, los dos peores nombres para un objeto son data y data2. Hay que evitar añadir números secuenciales a los nombres de objetos porque, aunque parezcan buena idea en el momento, acaban confundiendo.

### 3. Clases de objetos

##### 3.1. Vectores

Los objetos que guardas en la memoria pueden ser de distinta clase. La clase más importante en R es el **vector atómico**.

Un vector es un conjunto de uno o más elementos _de un mismo tipo_. Hay tres tipos básicos: _numeric_, _character_ (o _string_) y _boolean_.

~~~R
a <- 2
b <- "dos palabras"
c <- TRUE
~~~

- _numeric_: puede ser de tres subtipos: _integer_ (para números enteros), _double_ (para números reales) y _complex_ (para números imaginarios).
- _character_: son cadenas de caracteres (palabras o números). Van siempre rodeadas de comillas simples o dobles.
- _boolean_: utilizado para valores binarios (_TRUE_ o _FALSE_, también abreviados como _T_ o _F_)

Los vectores se crean con la función `c` (abreviación de _concatenate_):

~~~R
numeric_vector <- c(1,2,3,4,5)
character_vector <- c("Lo Malo", "Aitana War")
boolean_vector <- c(T, T, T, F, F, T, F)
~~~

Existen otras formas de crear vectores atómicos. Una de las más frecuentes es usando dos puntos `:`  para crear una secuencia de números de 1 en 1:

~~~R
1:10
~~~

Para crear otro tipo de secuencias existe la función `seq`:

~~~R
seq(from = 6, to = 124, by = 2.2)
~~~

Para acceder a los elementos de un vector usamos el número de orden del elemento entre corchetes (empezando por 1):

~~~R
plantas <- c("Fagus sylvatica", "Quercus suber", "Prunus spinosa", "Sorbus aucuparia")
plantas[1]
~~~

En realidad, dentro de los corchetes puedes poner _cualquier vector_:

~~~R
plantas[2:3]
plantas(c(1,3))
~~~

##### 3.2. Listas

A diferencia del vector atómico, una **lista** puede contener elementos de distinto tipo. Se crean con la función `list`:

~~~R
list(45, "jamón", T, 1i, c(1,2,3))
~~~

Incluso pueden contener otras listas:

~~~R
list(45, "jamón", list("esta es otra lista", 27.31))
~~~

Los elementos de una lista pueden tener nombre propio ("key"):

~~~R
plantas <- list("especie" = c("Fagus sylvatica", "Quercus suber"), "familia" = "Fagaceae")
~~~

Se puede acceder a los elementos de una lista de varias maneras:

- Usando número entre corchetes dobles:

  ```r
  plantas[[1]]
  ```

- Usando el nombre ("key") del elemento:

  ~~~R
  plantas$especie
  plantas$familia
  ~~~

##### 3.3. Matrices

Otra clase importante de R son las **matrices**. Una matriz es una particularización de un vector en dos dimensiones. Se crean utilizando la función `matrix`:

~~~R
mi_matriz <- matrix(1:9, ncol = 3, byrow = T)
~~~

Para acceder a los elementos de una matriz se utilizan la(s) fila(s) y la(s) columna(s) entre corchetes:

~~~R
mi_matriz[3,2]
mi_matriz[1,]
mi_matriz[2:3,2:3]
~~~

##### 3.4. Data Frame

Un **data frame** es a una matriz lo que una lista a un vector. Pueden contener elementos de distinto tipo _entre columnas_ y estas columnas pueden ser llamadas por nombre:

df <- data.frame("letras" = c("a", "b", "c", "d"), "numeros" = 4:7)

Se puede acceder a los elementos de un data frame de la misma manera que una matriz:

~~~R
df[3,]
~~~

También se puede acceder a las columnas por nombre:

~~~R
df$letras
df$letras[2]
~~~

#### 3.5. Factores

Los factores son objetos que representan información categórica. Es una manera eficiente de guardar cadenas de caracteres (_strings_) pero pueden llevar a confusión. No los vamos a utilizar en este curso.

#### 3.6. NULL

La clase `NULL` sirve para crear objetos vacíos; no pertenecen a ninguna otra clase. En general, no creamos objetos de esta clase, sino que los obtenemos como respuesta a una función.

### 4. Funciones base

Para crear, modificar o eliminar objetos en R utilizamos **funciones**.  R tiene muchas funciones ya instaladas; hemos utilizado algunas en los ejemplos anteriores.

Una función puede tomar varios **argumentos**. Por ejemplo, la función `sort`, que sirve para ordenar los elementos de un vector, toma dos:

~~~R
sort(c(1, 4, 2), decreasing = T)
~~~

Algunos argumentos son opcionales; si no los definimos, se utiliza la opción por defecto:

~~~R
sort(c(1,4,2) # La opción por defecto es ordenar ascendentemente
~~~

Otros son obligatorios:

~~~R
sort(decreasing = T) # Devuelve un error
~~~

Si no sabemos qué hace exactamente una función o en qué orden pasarle las variables, podemos abrir la ayuda de esa función escribiendo una interrogación y su nombre. Si no conocemos el nombre exacto, podemos hacer una búsqueda más amplia usando dos interrogaciones.

~~~R
?sort
??sort # Devuelve todas las páginas de la 
       # ayuda donde aparece la palabra "sort"
~~~

A continuación se muestran algunas funciones importantes:

##### Crear o manipular objetos

- `c`: Concatenar elementos para crear un vector. También sirve para concatenar dos o más vectores.
- `list`: Crea una lista a partir elementos separados por comas.
- `matrix`: Crea una matriz a partir de un vector.
- `paste`: Unir _strings_ a partir de dos o más objetos.
- `rep`: Crea un vector repitiendo tantas veces los elementos de otro.
- `sort`: Ordena los elementos de un vector.
- `toupper`/`tolower`: cambia un vector de caracteres a mayúsculas/minúsculas.

##### Funciones estadísticas:

`max`,`min`,`mean`,`median`,`quantile` 

##### Operadores matemáticos

`+`,`-`,`*`,`/`,`^`,`%%`,`%/%`, `abs`, `sqrt` 

##### Gráficos

`plot`, `hist`, `lines`, `points`, `curve`

### 5. Nota sobre las funciones

Un apunte importante sobre cómo actuán las funciones: **una función nunca cambia el objeto original**. Esto es _bueno_.

Prueba a ejecutar las siguientes líneas para ordenar alfabéticamente los géneros de algunas especies forestales:

~~~R
generos_arboles <- c("Quercus", "Fagus", "Sorbus", "Acer", "Pinus")
sort(generos_arboles)
generos_arboles
~~~

Aparecen dos líneas de resultados: la primera es el esperado, pero en la segunda, la variable `generos_arboles` sigue estando desordenada. Esto ocurre porque no hemos guardado en memoria el vector ordenado. Tenemos dos opciones:

~~~ R
# Opción 1: Crear un objeto nuevo
generos_ordenados <- sort(generos_arboles)

# Opción 2: Sobreescribir el objeto original
generos_arboles <- sort(generos_arboles)
~~~