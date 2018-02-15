### Ejercicios Estadística en R

> <u>Consejo: Se organizado y repite siempre los mismos pasos.</u>
>
> 1) Explora tus datos. 
>
> - ¿Hay valores imposibles (existen errores en mis datos) *vs.* hay valores raros (son valores atípicos pero pueden darse en mis datos)?	
>   - Limpia tus datos.
> - Organiza tus datos, ¿qué datos necesitas de los que tienes para el análisis que vas a realizar? 
>
> 2) Analiza tus datos. 
>
> - **Recuerda comprobar antes de hacer el test estadístico sus asunciones** 
>   - ¿Se cumplen? 
>     - Genial, usa el test que habías pensado. 
>   - ¿No se cumplen? 
>     - Transforma tus variables (no lo hemos visto en clase y no lo vas a necesitar para estos ejercicios, pero que sepas que se puede hacer) y vuelve a probar las asunciones del modelo.
>   - ¿Siguen sin cumplirse?
>     - Es posible que el test que habías probado no sea el apropiado: debes realizar tu análisis con otro tipo de test.
>
> 3) Realiza el análisis estadístico y obtén las respuestas a tus curiosidades.



*Descárgate el archivo datos_estadística.zip, y descomprímelo en tu carpeta de trabajo.*

Carga las librerías siguientes:

~~~R
library(dplyr)
library(ggplot2)
library(car)
~~~

#### Ejercicios de la t-Student

##### Primer ejercicio

En las islas galápagos habitan diversas especies de lagartos, entre ellos las iguanas. Hemos estado en las islas y hemos observado que la misma especie presenta morfología dispar en dos islas. Hemos realizado un muestreo aleatorio sobre los individuos en cada una de las islas, para conocer si nuestras observaciones son o no correctas. Los datos colectados se encuentran en el archivo *iguanas.csv*.

- Comprueba que la carpeta del curso es tu directorio de trabajo. Si no lo es dile a R cuál debe ser su directorio de trabajo. Utiliza:

  ~~~R
  getwd()
  setwd()
  ~~~

  Lee el archivo *iguanas.csv* en tu script y guárdalo como un objeto.

  >  Explora el contenido del archivo que has cargado. 


- Comprueba las asunciones de tu modelo 

  ~~~R
  shapiro.test()		#para normalidad
  leveneTest()		#para homocedasticidad
  ~~~

  > Aunque tienes que comprobar estadísticamente las asunciones del test, puede resulta útil dibujar la distribución de tus datos, sobre todo si tienes que realizar alguna transformación de tus variables para que se cumpla la asunción de normalidad. Pista: *density()* 

- ¿Es verdad que el tamaño de las iguanas en las islas es diferente?

  ~~~R
  t.test()			#test de la t-Student
  ~~~

  ​


##### Segundo ejercicio

Realizo un muestreo durante un mes sobre el éxito de caza de conejos de dos poblaciones de lince ibérico. Los datos los encontraras en el archivo *lynx.csv*  ¿Existen diferencias en el éxito de caza de las dos poblaciones?

> Realiza los mismos pasos que en el ejercio anterior. Piensa si puedes utilizar este tipo de test para los datos que estás analizando.



#### Ejercicios de modelos lineales

##### Primer ejercicio

¿Te acuerdas de las iguanas de las galápagos? Es una especie muy curiosa, por eso además en nuestro muestreo hemos recogido datos del metabolismo energético(kJ/day). Ya tienes los datos cargados.

- Realiza un modelo lineal para saber 

  - si el tamaño de los ejemplares explica su gasto energético. 
  - cómo es la relación entre el tamaño de los ejemplares y su gasto energético. 

- ¿Es bueno mi modelo?

  ~~~R
  anova()				#analiza la salida de esta función
  ~~~



Según como has comprobado en el primer ejercicio de la t-Student, existen diferencias significativas en el tamaño de los individuos según la isla en la que se encuentran.

- Relaciona el tamaño de las iguanas con su gasto energético para cada una de las islas.

  > Haz dos modelos, uno para cada isla.

  - Los modelos que acabas de realizar...
    - ¿explican más, menos o la misma variabilidad de tus datos?
    - ¿qué modelo de los dos es mejor?



- Dibuja en un único gráfico tus datos coloreados según a la isla a la que pertenecen y la línea de regresión de cada uno de los modelos.

  > Prueba cómo te resulta más fácil hacerlo,  ¿plot() o ggplot()?

- ¿Son buenas las predicciones de tus modelos?

  > Para saber si son buenas las prediciones de mi modelo debo comparar los valores que predice (y') con los valores que he observado (y). ¿Cómo?
  >
  > 1. Genera tus predicciones **predict()**
  > 2. Realiza un test de correlación de Pearson **cor.test()**

- Predice el gasto energético de una iguana de la isla de Santa Fe cuyo tamaño corporal es de 307 cm. Haz lo mismo para una iguana de la isla Genovesa.

**NOTA**: Acostúmbrate a comprobar las asunciones de tu modelo <u>siempre</u> al principio, si no lo has comprobado antes y ahora por algún casual no se cumplieran, puedes sentir que has estado perdiendo el tiempo.



##### Segundo ejercicio

Se dice que cuanto mayor es el peso de una especie, mayor es su tiempo de gestación. Queremos saber si esto ocurre para el orden *Artiodactyla*. 

- Carga *datos_bovidos.csv* en tu script. Explora tus datos.

- ¿Existe relación entre el peso de la especie con el tiempo de gestación? ¿Cómo es esa relación?

  > ¿Has comprobado las asunciones del modelo lineal? ¿Hay relación lineal entre las variables?





#### Ejercicios de Anova

##### Primer ejercicio

Investiga si el tamaño de la materia orgánica particulada gruesa (MOPG) depende de la tipología del río (meandriforme, anastomasado, rectilíneo). Los datos están en el archivo *rios.csv*

- Carga el archivo en tu script.
- Explora los datos.
- Comprueba que se cumplen las asunciones del análisis estadístico.
- Realiza el análisis estadístico
  - ¿Tiene importancia la tipología del río?
  - ¿Cuál es la diferencia en las medias entre un río anastomasado y un río rectilíneo?

##### Segundo ejercicio

Hemos realizado un muestreo de la cantidad de artrópodos en distitnos cultivos. En ellos se utilizan diferentes pesticidas (desecantes, fungicidas, insecticidas, repelentes, reguladores del crecimiento). Determina si el utilizar un pesticida es importante para la presencia de artrópodos. Los datos están en el archivo *pesticidas.csv*.

> Realiza los mismos pasos que en el apartado anterior.

- ¿Cuál es el pesticida que muestra una mayor diferencia, respecto al tratamiento sin pesticida?