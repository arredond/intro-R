intro-R: Introducción a la Programación y Manipulación de Datos en R

## 2 - Librerías, funciones personales y estructuras de control

#### Resumen

1. Librerías
2. Creación de funciones propias
   1. ¿Por qué?
   2. ¿Cómo?
   3. Alcance (scope) de un objeto
3. Estructuras de control
   1. Condiciones: if/else
   2. Bucles: for y while
4. Vectorización

---------------

### 1. Librerías

A veces las funciones que vienen instaladas con R ("base-R") no son suficientes para cumplir nuestros propósitos. Para ello, existen multitud de librerías disponibles en CRAN, que podemos utilizar en R en dos pasos:

1. Instalar el paquete en nuestro ordenador usando la función `install.packages("nombre_del_paquete")`.
2. Cargar la librería en nuestro script con la función `library(nombre_del_paquete)`.

~~~R
install.packages("dplyr")
library(dplyr)
~~~

El primer paso solo hay que hacerlo una vez. No obstante, debemos cargar la librería cada vez que iniciemos una nueva sesión, abriendo RStudio. Por ello, es una buena idea cargar todas las librerías que necesitemos al principio de cada script.

**Nota**: A través de librerías podemos cargar no solo funciones, sino también objetos (data frames, matrices, vectores...)

### 2. Creación de funciones propias

##### 2.1. ¿Por qué?

> La regla número 1 de la programación es: **No reinventes la rueda**. Si puedes usar alguna función que ya exista, úsala. Ahorrarás tiempo y esfuerzo.

No obstante, hay veces (muchas) en que necesitamos automatizar un proceso y no existe ninguna función disponible. Escribir funciones es la esencia de la programación; cuando veas que estás copiando las mismas líneas de código más de una vez... deberías haber escrito una función.

##### 2.2. ¿Cómo?

Escribir una función se hace de la misma manera en que se crea un objeto: asignándole un nombre. No obstante, la nomenclatura es algo particular. Vamos a aprender escribiendo una función para presentarnos:

~~~R
presentacion <- function(nombre, comida_preferida){
  paste("Hola, me llamo", nombre, "y me encanta comer", comida_preferida)
}
presentacion("Álvaro", "croquetas")
~~~

Como vemos, para crear una función hay que:

1. Utilizar la palabra clave `function`
2. Poner las variables que vamos a utilizar entre paréntesis y separadas por comas.

¿Te acuerdas de las variables _opcionales_? Podemos especificar opciones por defecto para variables que el usuario no defina.

~~~R
presentacion <- function(nombre, comida_preferida = "murciélagos"){
  paste("Hola, me llamo", nombre, "y me encanta comer", comida_preferida)
}
presentacion("Ozzy")
~~~

Por defecto, R devuelve lo que haya en la última línea de la función. Sin embargo, a veces queremos que nuestra función devuelva otra cosa. Para ello podemos usar el comando `return`. Veremos más sobre esto en el apartado de estructuras de control.

##### 2.3. Alcance (_scope_) de un objeto

Llamamos alcance (_scope_) de un objeto al entorno en el que "existe". Un objeto creado dentro de una función pertenece a un _entorno local_.  Esto quiere decir que ese objeto no será reconocido fuera de la función.

~~~R
funcion_ejemplo <- function(x){
  y <- x^2 + 3
  y
}
funcion_ejemplo(3) # Devuelve 12, el valor esperado
y                  # Devuelve un error. 
                   # El objeto "y" no existe en el entorno global
~~~

Sin embargo, un objeto creado fuera de una función pertenece al _entorno global_. Estos objetos _sí_ son reconocidos dentro de una función.

~~~R
a <- 4
funcion_ejemplo <- function(x){
  y <- x^a + 3
  y
}
funcion_ejemplo(2)    # Devuelve 19, el valor esperado
~~~

### 3. Estructuras de control

A la hora de dar órdenes es importante poder especificar condiciones o repeticiones:

> Si llueve, tiende la ropa. Si no, saca al perro y da tres vueltas a la manzana.

En programación, a este tipo de directrices se les llama **estructuras de control**.

##### 3.1. Bucles: _for_ y _while_

Un **bucle** define cuántas veces se debe repetir una cierta acción. El bucle más típico es el **for**:

~~~R
for (i in 10:1) {
  print(paste("Quedan", i, "segundos para el despegue"))
}
~~~

El contador, **i**,  va tomando todos los valores posibles del vector `10:1`. También podemos usar dos bucles anidados para, por ejemplo, recorrer los elementos de una matriz.

~~~R
mi_matriz <- matrix(1:10, ncol = 2, byrow = T)
matriz_cuadrados <- matrix(rep(0, times = 10), ncol = 2) # Inicializamos una matriz vacía
for (i in 1:nrow(mi_matriz)) {
  for (j in 1:ncol(mi_matriz)) {
    matriz_cuadrados[i,j] <- mi_matriz[i,j]^2
  }
}
~~~

En los bucles **for** sabemos de antemano cuántas veces queremos repetir las acciones. En cambio, los bucles **while** paran cuando se alcanza una cierta condición:

~~~R
x <- 0
while (x != 3) {
  print(x)
  x <- sample(1:10, 1)
}
~~~

##### 3.2. Condiciones: if/else

La estructura **if/else** sirve para ordenarle al programa que haga algo _solo si se cumple una cierta condición_ (if). Si no, puede hacer otra cosa (else).

Por lo general, esta estructura suele usarse dentro de una función o de un bucle.

**Ejemplo**: Tenemos un vector de poblaciones de municipios y queremos discernir cuáles podemos considerar o no ciudad. El criterio para que un municipio se considere ciudad es que supere los 100000 habitantes

```r
poblaciones <- c(200, 120000, 1300000, 2300, 9500)
for (municipio in poblaciones) {
  if (municipio > 10000) {
    print ("Es ciudad")
  } else {
    print("No es ciudad")
  }
}
```

No siempre hace falta que haya cláusula `else`. En ese caso, si no se cumple la condición, el programa no hará nada.

~~~R
poblaciones <- c(200, 120000, 1300000, 23000, 9500)
for (municipio in poblaciones) {
  if (municipio > 10000) {
    print ("Es ciudad")
  }
}
~~~

También podemos concatenar varias condiciones, o incluso anidarlas:

~~~R
poblaciones <- c(200, 120000, 1300000, 23000, 9500)
for (municipio in poblaciones) {
  if (municipio > 10000) {
    if (municipio > 1e6) {
      print("Es una ciudad muy grande!")
    } else {
      print("Es una ciudad normal")
    }
  } else if (municipio > 8000) {
    print("Es un pueblo grandecito")
  } else {
    print("Es un pueblo")
  }
}
~~~

### 4. Vectorización

_Esta parte solo la daremos si vamos bien de tiempo. Si no, queda aquí para quien tenga interés_

Como comentamos en la lección anterior, R es un lenguaje hecho para trabajar con _vectores_. Muchas funciones base de R sirven tanto para un vector de un solo elemento como de varios elementos. Cuando les pasamos un vector de varios elementos, R procesa todos _a la vez_.

> A R se le da muy bien el trabajo **simultáneo**, pero no tanto el trabajo **secuencial**.

Suele ser una buena idea en R evitar bucles demasiado largos (hay otros lenguajes mejores para esto, como Python o C++).

Al proceso de adaptar una función para que trabaje con vectores de cualquier longitud se le llama **vectorización**. La vectorización es un proceso complejo pero importante para escribir programas eficientes. En este curso vamos a ver dos ejemplos concretos.

##### 4.1. ifelse()

La función **ifelse** es una versión vectorizada de una condición if/else. Toma tres argumentos: un test lógico, el resultado si el test es verdadero y el resultado si el test es falso.

El ejemplo anterior quedaría de la siguiente manera:

~~~R
poblaciones <- c(200, 120000, 1300000, 23000)
ifelse(poblaciones > 100000, "Es ciudad", "No es ciudad")
~~~

Al igual que con un if/else clásico, podemos tener condiciones anidadas.

~~~R
poblaciones <- c(200, 120000, 1300000, 23000)
ifelse(poblaciones > 100000, "Es ciudad", 
       ifelse(poblaciones > 8000, "Es un pueblo grande", "Es un pueblo pequeño"))
~~~

##### 4.2. apply

Cuando nuestra función no está vectorizada, es decir, no puede aplicarse a todos los elementos de un vector a la vez, aún nos queda un as en la manga:

> La familia de funciones `apply` sirven para _aplicar_ una función a los elementos de un vector, lista, matriz... Los dos casos más típicos son `lapply`, que devuelve una lista, y `sapply`, que devuelve un vector.

Imaginemos que tenemos una lista con diámtros de árboles de diferentes rodales y queremos hallar la media y la desviación típica de cada rodal:

~~~R
alturas <- list(rodal_1 = c(32, 24, 56), rodal_2 = c(13, 16, 21))
lapply(alturas, mean) # Devuelve una lista
sapply(alturas, sd)   # Devuelve un vector
~~~
