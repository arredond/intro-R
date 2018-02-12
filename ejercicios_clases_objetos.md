## Ejercicios

#### Introducción a la programación

#### Clases de objetos

###### Clases básicas: atomic vector, list, NULL

- Intenta adivinar la clase de los siguientes objetos. Luego, usa la función `class` para comprobarlo:

  `23`,`"42.5"`,`42.5`,`"salchipapa"`, `3L`, `T`, `"T"`, `1i`, `list`, `list()`, `NULL`

- Ahora haz lo mismo usando la función `typeof`. ¿Ves alguna diferencia?

  > La diferencia es que `typeof` devuelve la clase "double" en vez de "numeric" para objetos con decimales ("float"). ¿Y por qué `23` no es integer? Los "integers" están pasados de moda. Cuando creas un objeto R reserva X espacio en la memoria según su clase. Antes, esto ahorraba memoria, pero con la capacidad de ordenadores modernos, en algunos casos es innecesario ("integer" o "factor")

- El comando `c(2, "a")`, ¿dará algún error? ¿Por qué? Compruébalo; si el resultado no es el esperado, intenta comprender por qué. 

  >  Esto se llama **"coercion"**; es cuando R convierte un objeto de una clase a otra (en este caso, de "numeric" a "character").



- Crea un vector a que sea 6 y un vector b que sea 24. Divide b/a. ¿Qué obtienes?

  > Consejo: ¡Trata de optimizar tus códigos! Recuerda cómo nombrar objetos que vas a seguir utilizando. 
  >
  > --> Prueba a repetir el ejercicio de la calculadora guardándolo como objeto, ¿cuánto tiempo has optimizado?

  ​

- **5a)** Crea el siguiente vector y guárdalo con el nombre que quieras y obtén: 

  (45, 12,-6, 7, 64, 32, 86, 2, 1, 98, 53, 10, -56, -42, 121, 0, 5.3)

  b) su máximo valor, su media y su mediana.

  c)  Crea una secuencia de números, de 2 a 4, introduciendoun nuevo número cada 0.05. ¿Cuántos números posee el nuevo vector?

  d) Crea un vector del 1 al 65 y obtén la mediana.

  e) Ordena el vector del apartado a) de mayor a menor.

  f) Selecciona los elementos del vector que sean mayores a 27. 

  g) Y los que sean menores a 2.

  h) Selecciona los elementos que cumplan al menos una de las dos condiciones anteriores.

  > Tendrás que utilizar operadores lógicos: búsca como funciona & | !

  ​

- Crea una lista con una lista interna de los 4 primeros números pares y otra lista interna de los 4 primeros números impares. Nombra - “par” e “impar”- las listas contenidas  en la lista principal.

  - Obtén los elementos impares de la lista.
  - Realiza una lista de la compra añadiendo la tienda dónde tienes que comprar cada producto.

  ~~~R 
  #Ejemplo:
  Frutería- Manzanas, peras, sandía, melocotones, kiwi.
  Pescadería- Calamar, besugo, salmón
  …
  ~~~

  - Muestra en pantalla una de las tiendas para recordar lo que tenías que comprar.

  ​

###### Clases compuestas: matrix, data frame, factor

- Crea un vector de números secuenciales entre 19 y 78  en intervalos de 3.5 y guárdalo con un nombre que te parezca apropiado. 

  - ¿Cuál es el decimoctavo elemento del vector? ¿Y los elementos del 3 al 18?
  - Ahora usa la función `length` para determinar su longitud.

- Ahora usa el vector que has guardado para crear una matriz y guárdala con otro nombre. Usa `ncol` para determinar el número de columnas que tendrá tu matriz.

  - Saca los elementos comprendidos entre la primera y cuarta fila y la segunda columna.

- Usa de nuevo la función `length` para determinar el tamaño de la matriz. ¿Sale lo que esperabas? Prueba usando `dim` . ¿Qué relación hay entre ambos?

  > Date cuenta de que la longitud de la matriz es igual a la del vector. En R, las matrices son solo vectores "plegados".

- Crea una matriz de 5 filas con el vector del ejercicio **5a)** y ordenado por filas.

  - Obtén el número situado en la 3ª columna y 2ª fila.
  - Obtén los números que incluye la 4ª fila.
  - Obtén los números de la 2ª y 3ª  columna de todas las filas, excepto de la primera.

- Crea un dataframe que relacione los siguientes nombres con su edad:

  Elisa- 15 años; Eva- 24 años; Quique- 51 años; Lola- 71 años; Nati- 22 años; Paul- 46 años

  -  ¿Cuántos años tiene la 5ª persona de la lista y cómo se llama? Nombra a este vector “Quinta”.
  - Ordena de mayor a menor las edades de estas personas yllama a este vector “Edades”.
  - Obtén un vector sólo con los nombres de estas personas, nómbralo “NOMBRES”. Cambia todas las letras del vector por letras mayúsculas.



###### Funciones base

- Usa la función `rep` para crear un vector que repita los valores 0 y 1 alternados 20 veces.

- ¿Y si quieres que aparezcan primero 20 unos y luego 20 ceros? **Pista:** Usa `?rep` para ver las opciones disponibles que le puedes pasar a la función.

- Abre la página de ayuda de la función `ls` para comprender para qué sirve. A continuación, úsala. **Nota: ls no toma ningún argumento; tendrás que escribir ls()**

- Haz lo mismo con la función `rm`. A continuación, úsala sobre un objeto de tu entorno de trabajo. ¿Hay alguna manera de borrar todas las variables a la vez? **Pista: Google es tu amigo aquí**

- Un ejemplo guiado sample con números, otro en los ejercicios libres con caracteres.

- Crea un vector de 100 números “1”.

- Crea un vector de 11 números del 0 al 10.

- Añade a este últimovector, otro vector que asigna “par” o “impar” a sus números.

- Vector aleatorio:

  - a) Crea un vector de 47 números con una distribución normal y llámalo "alturas". 

  > La función `rnorm` crea un vector de números con la _media_ y _sd_ indicada en los argumentos.
  >
  > Utiliza `?rnorm` si necesitas ayuda.

  - b) Ahora haz`hist(alturas)`. ¿Qué has obtenido?
  - c) Esta vez, en lugar de `hist` utiliza la función `plot`. ¿Qué diferencia hay en los ejes respecto a `hist`?
  - d) Crea otro vector de la misma longitud y llámalo "pesos". Ahora haz `plot(alturas, pesos)`. ¿Qué representa el gráfico?