#### 1. Librerías

1. El paquete "classInt" sirve para clasificar vectores por varios métodos ("quantile", "equal interval", "Jenks"...). Instálalo en tu máquina usando la función `install.packages`.
2. Ahora carga la librería en esta sesión usando la función `library`. Ponla en el preámbulo (al principio) de tu script.
3. Genera un vector de 100 números aleatorios, tomados de una distribución normal con media 1.70 y desviación típica 0.2. Llámalo `alturas`.
4. Genera un histograma del vector alturas.
5. Ahora usa la función `classIntervals`, de la librería que hemos cargado, para hallar dividir el vector `alturas` en siete intervalos. Guarda el resultado en un objeto llamado `alturas_clasificadas`. ¿Qué clase de objeto es? ¿Qué hay en cada elemento?
6. Vuelve a usar la función `classIntervals` para dividir el vector en siete intervalos _por el método de Jenks (natural breaks)_. Guárdalo como `alturas_jenks`.
7. Borra todos los objetos de alturas de tu entorno de trabajo.

#### 2. Funciones

1. Crea una función que añada las palabras "y tal" a cualquier _string_ que pases como _input_. El resultado debería ser el siguiente:

   ~~~R
   > sudando("Me encanta programar")
   [1] "Me encanta programar y tal"
   ~~~

   **Pista:** Tendrás que usar la función `paste`.

   ¿Qué ocurre si das un vector de varios _strings_ como argumento a la función?

   ~~~R
   > sudando(c("Hola", "Qué tal"))
   ~~~

2. Crea una función que calcule el área y el volumen de un cilindro en función de su radio y su altura. Haz que `altura` sea un argumento opcional con valor por defecto `5`.

3. Haz lo mismo para calcular el volumen de un cono.

#### 3. Estructuras de control

###### For

1. Es hora de castigos. Saca en pantalla diez mil veces la frase "No llamaré a ningún objeto data2". Tendrás que usar la función `print` dentro del bucle.

2. La serie de Fibonacci aparece constantemente en la naturaleza. En ella, cada elemento es igual a la suma de los dos anteriores:

   ~~~R
   x[i] <- x[i-1] + x[i-2]
   ~~~

   Crea un bucle para calcular los primeros 300 elementos de la serie.

   > Pista: Tendrás que inicializar el vector con los dos primeros valores de la serie, 0 y 1.

3. Ahora utiliza ese bucle para crear una función que calcule los `n` primeros elementos de la serie.

###### While

1. Vamos a repetir el bucle de la serie de Fibonacci, pero en lugar de parar cuando alcance un número de repeticiones, el bucle parará cuando el último elemento calculado sea mayor de 1000.

   > Tendrás que utilizar un contador _explícito_, es decir, inicializarlo y luego añadirle uno en cada vuelta del bucle. Si no te sale, puedes encontrar la solución en el archivo "2-soluciones-avanzados.md"

###### if/else

1. Crea un pequeño programa que recorra los números del 1 al 100 y saque en pantalla "par" o "impar" si el número es par o impar.

2. Vamos a crear una función solucionadora de ecuaciones de segundo grado. Debe tomar tres argumentos de entrada, _a_, _b_ y _c_ tal que:

![ecuacion_segundo_grado](https://user-images.githubusercontent.com/19406854/36221247-c77ef5ec-11bd-11e8-9d7b-ac57c190ccab.png)

   La función debe comprobar, primero, si el discriminante (lo que va dentro de la raíz cuadrada) es negativo, y de ser así devolver un mensaje como "La ecuación no tiene soluciones".

   Si el discriminante es positivo, calcula las dos soluciones posibles y devúelvelas en un solo vector.

#### 4. Vectorización

1. Repite el ejemplo par/impar sin usar un bucle

   > Tendrás que usar la función vectorizada **ifelse**

#### 5. Funciones avanzadas

> Disclaimer: estos ejercicios pueden ser bastante complicados. Tómatelos con calma y no te frustres. Las soluciones están en el archivo "2-soluciones-avanzadas.md"

1. Escribe una función que calcule la distancia entre dos puntos sobre la superficie terrestre, dadas una latitud y longitud. Tendrás que utilizar las fórmulas de Haversine:

![haversine](https://user-images.githubusercontent.com/19406854/36221248-c7a18cb0-11bd-11e8-9999-394da1b85888.png)

  Úsala para calcular la distancia entre Madrid (40.42, -3.7) y Toronto (43.65, -79.4).

2. Vamos a dibujar árboles de navidad. Crea una función con el siguiente comportamiento:

   ~~~R
   > christmas_tree(3)
   [1] "|  *  |"
   [1] "| *** |"
   [1] "|*****|"
   > christmas_tree(10)
   [1] "|         *         |"
   [1] "|        ***        |"
   [1] "|       *****       |"
   [1] "|      *******      |"
   [1] "|     *********     |"
   [1] "|    ***********    |"
   [1] "|   *************   |"
   [1] "|  ***************  |"
   [1] "| ***************** |"
   [1] "|*******************|"
   ~~~

   **Pista**: Tendrás que utilizar la opción `collapse = ""` cada vez que uses la función `paste`.

4. Ejercicio de dinámica de poblaciones:

   Tenemos los siguientes datos:

   ~~~R
   años<-seq(1963, 1988, by=1)
   Nt<-c(1,9,14,16,3,1,4,16,30,14,12,19,51,11,7,137,204,67,197,183,149,102,141,147,178,52)
   Nt1<-c(Nt[(-1)],NA)			#¿Comprendes esto? Analiza lo que estás haciendo siempre.
   ~~~

   - ¿Cómo ha variado la población con el tiempo? ¿Cuándo aumenta drásticamente la población?

     > Míralo en un gráfico. 

   - Observa si existe relación entre el tamaño de la población (Nt) y la tasa de crecimiento per cápita de la población.

     > Pista: Haz primero una función que calcule la tasa de crecimiento per cápita entre Nt y Nt1.


   - Sigamos avanzando: ¿cómo crees que es la población en la actualidad?

     > Para conocerlo se debe analizar el tipo de relación que hay, a través de un modelo, entre mi variable explicativa (población observada) y mi variable dependiente (tasa de crecimiento per cápita). Si quieres conocerlo puedes ajustar un modelo lineal, un modelo logarítmico, un modelo polinomial...
     >
     > En este momento del curso no nos vamos a detener para ver cómo hacerlo (puedes llamar a tu amigo Google), pero te adelantamos que la varianza explicada de nuestros datos por el modelo es muy pequeña. Por tanto, con los datos que introducimos al modelo, éste no es capaz de generar un buen ajuste y por eso **NO ** debe utilizarse para predecir cómo será la población en el futuro y debemos recurrir a una **aproximación cualitativa teórica** ( *¿Dudas? Ve a los apuntes de dinámica de poblaciones de limnología*).
     >
     > ​					Nt1_teorico = Nt*exp(r_teorico)
     >
     > ​					r_teorico = Ro · (1-U/Nt) · (1-(Nt/K)^θ)
     >
     > ​
     >
     > Ro, por parametrización del modelo sabemos que es el máximo de la tasa de crecimiento per cápita observada (*¿Dudas? Mira por la diapo. 81 del tema teoría dinámica de poblaciones de limno*)
     >
     > U es el umbral de extinción (En nuestro ejemplo: 0.5)
     >
     > K máxima capacidad de carga (En nuestro ejemplo: 97.185).
     >
     > θ  se toma 0.8 de manera general (Sibly *et al.* 2005)

     ​


   - **¿Qué le pasa a mi población?**

     > **Ayuda**: Realiza el ejercicio en dos partes. 
     >
     > - 1) Crea las funciones que necesites para conocer teóricamente cómo es la población de 1963-1988. 
     >   - Analiza lo que estás haciendo: no puedes conocer el tamaño poblacional teórico para 1963, por falta de datos, en cambio si lo puedes conocer para 1989.
     > - 2) Creáte un bucle que te calcule los valores de tu población a futuro (1989-2018) y de su tasa de crecimiento per cápita, a partir de los últimos valores teóricos que has podido calcular con los datos.
     > - 3) Observa el gráfico de tendencia de la población.

5. Teoría de islas.

   ### 3) Teoría de islas

   La teoría de islas de McArthur y Wilson trata de comprender cómo cambia la riqueza de especies de las islas, es decir, de qué depende que el número de especies aumente, disminuya o se mantenga estable. 

   Para que **aumente** el número de especies debe producirse **inmigración/colonización  (I)** y ello va a depender de la **distancia** entre la isla y el continente (*fuente*), es decir, cuanto más lejos esté una isla del continente es más complicado que puedan llegar especies nuevas. Así como de la cantidad de especies presentes en el continente que no están presentes en la isla, es decir, cuántas nuevas especies pueden llegar a la isla, y de la probabilidad de que estas especies puedan llegar (c). 

   Para que **disminuya** deben producirse **extinciones (E)** y ello va a depender del tamaño de la isla (A; cuanto más pequeña más probable que se extingan), y de las especies que haya (S; cuantas más especies, más probable que alguna se extinga).

   Vamos a  **<u>simular</u>** la teoría de islas. Para ello debes crear: la función de inmigración y la función de extinción. (<u>Consulta Google si no estás seguro cómo son estas funciones, hay unos factores de escalamiento para la distancia (f) y para el área (m)</u>)

   ​

   Supon que, inicialmente, tu isla está a 300 km del continente, su tamaño es de 200, que en ella aún no ha colonizado ninguna especie (0) y que la cantidad de especies en el continente es de 1000.  

   Hay factores que se mantienen constantes (¿recuerdas cómo hacer que un factor sea constante en una función?): 

   - Factor de escalamiento para la distancia (f) = 0.01
   - Factor de escalamiento para el área es de (m) = 0.25
   - Probabilidad de colonización (c) = 0.1
   - Probabilidad de extinción (q) = 0.2



   **¿Antes de nada, has comprobado que tiene sentido los resultados de tu función? ... ¿¿¿¿Seguro???? ¿Pueden inmigrar o extinguirse especies decimalmente? No. Redondea los resultados a la unidad.**

   1. ¿Qué pasa si aumenta / disminuye la distancia? Prueba a cambiar el nº de especies, ¿qué ocurre? ¿Y si aumenta / disminuye el área de la isla? De nuevo, prueba a cambiar el nºde especies. Analiza tus resultados, ¿tiene sentido?.
   2. ¿Cómo aumenta/disminuye la tasa de inmigración/extinción según aumenta la riqueza de especies en la isla? Dibújalo.

   >  **Ayuda: **
   >
   >  - Crea un vector *mi_isla* (llámalo como quieras!) que cambie la riqueza de especies en la isla de 100 en 100, hasta 1000.
   >  - Crea un bucle que te calcule la inmigración y la extinción de especies para cada valor del vector creado.
   >  - Haz un gráfico para la tasa de inmigración/riqueza de especies y otro para la tasa de extinción/riqueza de especies; pero haz que aparezcan simultáneamente en el plot (consulta la función *par*).  Ponle: título al gráfico y a los ejes, y dibuja de distinto color la curva de cada gráfico.
   >  - Ahora haz que las dos curvas aparezcan en el mismo gráfico. Igualmente, éstas deben de ser de distinto color y el gráfico debe aparecer correctamente identificado (título y ejes) para entender correctamente la representación que estamos mostrando.

   ​

   pero... ¿es este caso real? Analicemos uno que si lo sea:

   ​

   3. Mi isla está desierta en un inicio, pero según pasa el tiempo comienza a haber colonización y extinción de especies en ella: la riqueza de mi isla cambia con el tiempo, al igual que la cantidad de especies que colonizan y se extinguen. 

   > Es buena idea escribir en un papel tus ideas y pensar cómo pedirle al programa lo que quieres.
   > Una **ayuda**, con los datos que hemos estado usando:
   >
   > Tiempo		Riqueza		Colonización		Extinción
   >
   > ​	1			0				33			0
   >
   > ​	2			33				32			2
   >
   > ​	3			63				31			3
   >
   > ​
   >
   > ¿Ves el patrón? Ahora dile a R cómo poder generarlo. Utiliza la estructura de bucle y las funciones que has creado.

   - ​¿En qué momento (tiempo) alcanza el equilibrio mi isla? ¿Cuál es el valor de la tasa de inmigración/extinción en ese momento?
