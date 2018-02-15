### 4 - Estadística con R

**Resumen**

1. Estadística ¿para qué?
2. Mi hipótesis. Errores de tipo I y de tipo II
3. Tipos de test
4. Comparación de la media dos grupos: Testde hipótesis, t-Student.
5. Modelos lineales generales
   - Regresión lineal
   - Anova


***



#### 1. Estadística ¿para qué? 

Podemos decir que la estadística es un medio para un fin: conocer. 

Antes de la realización de cualquier análisis estadístico se han debido seguir unos pasos previos:

1. Diseño experimental: es una de las fases más delicadas y de mayor importancia, aquí es donde se invierte la mayor parte del tiempo. Es además en este momento donde se debe decidir qué tipo de análisis estadístico vamos a realizar según las hipótesis y realización del experimento que estoy diseñando.

2. Realización del experimento: toma de datos. Este apartado es básicamente poner en marcha y desarrollar lo que hemos pensado hacer en el anterior. No obstante, pueden ocurrir multitud de imprevistos que hagan que nuestros datos no sean recolectados como habíamos diseñado. Ello debe tenerse en cuenta a la hora de realizar el próximo paso.

3. Análisis estadístico.

   - ¿He tomado mis datos tal y como había diseñado? 

     - Sí --> Realizo el análisis estadístico de mi diseño experimental.
     - No --> Reevaluo: ¿Puedo usar el análisis estadístico de mi diseño experimental?
       - Sí, ¡a por ello!
       - No --> ¿Qué análisis estadístico puedo usar para mis datos?

   - Exploración de mis datos. ¿Hay puntos *raros/atípicos/aberrantes*?  ¿Qué hago con ellos?

     > Un dato raro/atípico sigue siendo un dato y debe ser analizado. Un dato aberrante puede ser un error en la toma o transcripción de tus datos. Debes conocer si en tu estudio existen datos observados de este tipo, saber diferenciarlos y tenerlos en cuenta cuando expliques los resultados de tu análisis.

   - Realización del análisis estadístico.

4. Análisis de los resultados, discusión y conclusiones.

   - ¿Se cumplen mi hipótesis? 

     - Si se cumplen, guay --> Discútelo.
     - No se cumplen, guay --> Discútelo.

     ​

     **Ambos casos son resultados y ambos casos generan nuevo conocimiento o debate acerca de una cuestión: todo lleva a planteamientos y explicaciones. **

     Durante mucho tiempo ha existido un sesgo científico a publicar resultados que cumplieran la hipótesis planteada, dejando de lado el conocimiento que se genera cuando no se cumplen tus expectativas. Por eso muchas veces se ha ido a lo seguro o se han hecho cosas que no son buenas para la ciencia (ver apartado de egoísmo científico).

     Desde hace ya algunos años, se está empezando a *promocionar* que se genere conocimiento sobre todo aquello que no cumple tus expectativas. ¡Pues claro! ¿Cuánto tiempo, recursos y preocupación has invertido en hacer tu diseño experimental,  ir a tomar tus datos, realizar el análisis estadístico... para tirarlo todo eso a la basura? **No hay resultados buenos o malos  simplemente hay resultados que deben ser discutidos.**



*El egoísmo científico*: muchas veces se hacen cosas vergonzosas en ciencia.

- Apostar por lo seguro: investigar algo que sabes de sobra lo que va a pasar, pero te aseguras publicar.

- Indiferencia académica: excluir resultados que contradicen tus resultados obtenidos.

- Muestreo (im)perfecto: usar el azar para que resuelva *casualmente* de manera favorable tu hipótesis.

- Manipulación numérica: eliminación de datos atípicos porque "me molestan".

- Inquisición estadística: torturade datos. Los retuerces (transformas) hasta que te de significativo.

  > ¡Ojo! Además de que las relaciones que buscas una vez transformados tus datos son más complejas de entender, debes tener en cuenta que estás inflando el error de tipo I (teorema del mono infinito) existe la probabilidad de que al probar muchas veces hacer algo te de significativo, **pero** el resultado significativo de tu test esta sobreestimado. 
  >
  > El error de tipo I se dispara si haces muchos test: **Unos datos --> un test** para eso has trabajado antes en todo lo anterior!



#### 2. Mi hipótesis. Errores de tipo I y de tipo II

**¿Cuál es mi hipótesis?**

Para iniciar una investigación debe haber siempre primero un fenómeno que tenga interés de ser observado y sobre el que puedo plantearme cosas: genero mi hipótesis de trabajo (*g.e.* puede ser que haya mayor reclutamiento de plántulas en un ambiente con pastoreo). A partir de tu hipótesis de trabajo generas tu hipótesis nula y tu hipótesis alternativa (g.e. Ho= el reclutamiento de plántulas es igual en zonas con pastoreo que en zonas sin pastoreo; H1= es diferente).



<u>Teorema del mono infinito:</u> 

*Si dejas a un mono una máquina de escribir te devolverá una novela de Shakespeare.*

Si Ho= es que el mono escribe por azar, ¿es posible que escriba una novela? Si. 

- Aunque aceptemos Ho, simplemente por probabilidad de dar a las teclas, por azar, puede ocurrir que el mono escriba una novela. Entonces estamos cometiendo un error de tipo II. 
- Si rechazamos Ho, el mono no escribe por azar, cometemos un error de tipo I, porque el mono escribe por azar.

**Los test estadísticos tratan de minimizar los errores de Tipo I (valor de α o p-valor)** 

El *error de tipo I* quiere decir que existe un intervalo (que va a depender de dónde hayas fijado α) en donde tu hipótesis se cumple, pero existe una probabilidad de que te estés equivocando. El valor de α es el máximo riesgo de error de tipo I que estás dispuesto asumir; cuanto mayor sea α, mayor error estás cometiendo si rechazas Ho. Debes tener en cuenta que el error de tipo I nunca es 0. Es en lo que se basan todas las publicaciones científicas. Por convenio, la significancia de tu test está asignado a los siguientes p-valores:

~~~R
Signif. codes: 	0 ‘***’					#no hay error --> no lo vas a encontrar
				0.001 ‘**’ 				#La probabilidad de que no ocurra tu Ho es del 0.1%
				0.01 ‘*’ 				#La probabilidad de que no ocurra tu Ho es del 1%
				0.05 ‘.’ 				#La probabilidad de que no ocurra tu Ho es del 5%
				0.1 ‘ ’ 1 				#La probabilidad de que no ocurra tu Ho es del 10%
										#A partir del 10% suele decirse que es marginalmente
										#significativo
~~~

- Lo estricto que seas con tu hipótesis nula, puede depender del ámbito de la ciencia en el que trabajes. Por ejemplo: la fiabilidad de que un fármaco cure es muy exigente.

- Cuando hagas modelos, tu VE también va a tener significación. A veces nos interesa ver la tendencia de las relaciones en mis datos y no tanto la significación  (Ver Nota 1).

  ​

El *error de tipo II, β*,  es el riesgo de cometer un error de tipo II asociado al test. Normalmente no se fija, porque va en función de α que es el que se fija normalmente: cuando reducimos α, aumentamos β necesariamente. Con el error de tipo II se puede calcular cómo de potente es mi test:

​						Potencia del test o poder del test estadístico = 1 - β  

El poder del test puede calcularse en dos circunstancias:

 - a priori: quiero conocer cual es el tamaño muestral que necesito para poder rechazar Ho, o 
 - a posteriori: Se hace cuando acepto Ho, bueno realmente se debería hacer, pero no lo hace nadie: no lo encontraréis fácilmente en publicaciones científicas



> Nota 1: Por rematar, daros información completa y que os suene: Hay una escuela estadística que no cree en la significación de  los modelos. Simplemente analiza cómo de bueno es el ajuste de mis datos para el modelo que estamos generando (valores del área bajo la curva ROC, AUC). En la compapración de qué modelo es mejor suelen usarse criterios de información, uno ampliamente utilizado es el de Aikaike (AIC). ¡Ahí lo dejamos que no acabamos sino!



#### 3. Tipos de test

Existen multitud de tipos de test que se usarán dependiendo de cómo sean mis datos: variable respuesta (VR) y variable o variables explicativas (VE) y lo que queremos comprobar. En la imagen siguiente se muestra un resumen del test que se debe realizar según los datos que tengamos.

![TestHipotesis](C:\CursoR\TestHipotesis.PNG)

Aquí sólo vamos a comentar unos tipos concretos de test paramétricos: t-Student y Anova.



#### 4. Comparación de la media dos grupos: Test de hipótesis, t-Student.

- Se utiliza para comparar los valores cuantitativos de la variable respuesta (VR) de 2 muestras/grupos.

- Es un tipo de test *paramétrico* eso quiere decir que los datos de mi variable respuesta (VR) deben ser normales y continuos.

- Para poder realizar este tipo de test debe cumplirse que:

  - Normalidad de la variable respuesta(VR).

    - Testde Siegel

    - Testde Kolmogorov-Smirnov; 

    - **Test de Shapiro-Wilks** 

      > Usa este que es el más potente.

  - Homocedasticidad: la varianza de los grupos son iguales.

    - Test de la F de Snedecor (poco recomendable porque es muy sensible a la violación de normalidad).

    - Test de Levene

      > Usa este

    - Test de Brown-Forsythe

  - Las muestras son independientes (-->Muestreo aleatorio).

**Si no se cumplen las asunciones del test:**

~~~R
> for (i in 1:10^9){
          print("Debo cambiar de test")
        }
~~~

Veámoslo con un *ejemplo*:

Observamos dos grupos de 30 niños de la misma edad y medimos su altura. Un grupo de niños juega al fútbol y el otro grupo de niños juega al baloncesto. ¿Serán sus alturas diferentes?

H0= la alturas medias no son distintas

H1= la alturasmedias no son distintas

~~~R
basket<-rnorm(30, 133, 8) ; futbol<-rnorm(30, 130,10)
kids<-(c(basket,futbol)) ; deportes<-c(rep("basket",30),rep("futbol",30))
alturas<-data.frame(kids, deportes)
~~~

- Exploro mis datos

  > Explora tus datos con un gráfico de barras de error. Es incorrecto realizarlo con un diagrama de cajas y bigotes

  ~~~R
  > alturas_summary<-alturas %>% 
                    group_by(deportes)%>% 
                    summarise(mean_h=mean(kids),sd_h=sd(kids),n_h=n(),se_h=sd(kids)/sqrt(n()))


  >ggplot(alturas_summary,aes(deportes,mean_h))+
      geom_point()+
      geom_errorbar(aes(x=deportes, ymin=(mean_h-sd_h), 
                        ymax=(mean_h+sd_h),width=0.2))+ylab("")
  #Comprueba siempre si en tus datos hay valores “raros/extremos”, esos valores pueden ser verdaderos, es decir, ocurren en la realidad o puede ser un error al introducir tus datos. Si es/son un error estás a tiempo de corregirlo y evitar problemas futuros.
  ~~~

- Compruebo las asunciones del modelo:

  - Normalidad

    ~~~R
    > shapiro.test(alturas$kids) 
    ~~~

  - Homocedasticidad

    ~~~R
    leveneTest(alturas$kids, group=alturas$deportes)
    ~~~

    ¿Puedo aceptar las Ho de normalidad y homocedasticidad? Sí, a tope, vamos a por el test! 

  - ¿Hay diferencias entre las medias de los niños que juegan al baloncesto y al fútbol?

    ~~~R
    t.test(alturas$kids~
              alturas$deportes)
    ~~~

    Nos fijamos en el *p-value*, como es mayor a 0.05 (0.5419), tengo que aceptar Ho, porque la probabilidad de equivocarme si rechazo Ho es muy grande. Por lo tanto, podemos decir que las alturas medias de niños de 10 años que juegan a baloncesto y fútbol no son distintas.



#### 4. Modelos lineales generales (MLG)

Relacionan una variable respuesta (VR) y una variable explicativa (VE). El tipo de modelo lineal general que se utilice, al igual que pasaba en los test de hipótesis, depende de cómo son mis variables, tanto la respuesta como la explicativa. En la siguiente imagen se muestran diferentes tipos de modelos lineales generales según mis variables:

![MLG](C:\CursoR\MLG.PNG)

Nosotros vamos a centrarnos en los dos que están recuadrados de verde.



##### Regresión lineal

Modelo predictivo en el que conozco **y** a través de **x**.

~~~reStructuredText
Realidad														Mi predicción
	y = a + b · x + Error 	   como desconozco el Error:			y ' = a + b · x

en donde
a: es el intercepto (punto en el corta el eje x=0),
b: es la pendiente, cuánto aumenta o disminuye y cada unidad que aumenta x
~~~

El modelo de regresión lineal tiene unas asunciones que deben comprobarse:

- Que existe relación lineal entre VR y VE

  > Antes de realizar el análisis: mira si tus datos muestran la exitencia relación lineal. 
  >
  > ¿Cómo? Usa ggplot() plot()

- Homocedasticidad de los residuos 

  > Míralo una vez realizado el modelo, al contrario que los test de hipótesis no es *imprescindible* que hagas esta comprobación de manera estadística. Entonces, ¿cómo lo hago? 
  >
  > Dibuja con plot(tu_modelo). El resultado te va a dar cuatro gráficos, por comodidad puedes usar la función par() para verlos todos en la misma ventana.
  >
  > - Muy importante que el gráfico de *residuals values ~fitted values* no muestre ningún patrón. Es decir, observes una nube de puntos estrellada por todos los lados. Eso nos indica que cumple homocedasticidad: los residuos se distribuyen con igual varianza, por lo que mi modelo va a predecir igual de bien o igual de mal todos los valores.
  >   - Si muestra patrón: mi modelo va a predecir unos valores mejor que otros. No es un buen modelo porque el error de mi predicción va a depender del valor que esté prediciendo.
  > - También es importante ver que en el gráfico *standarized residuals ~theorical quantiles* mis puntos siguen más o menos la línea diagonal.
  > - Los otros dos gráficos, siguen siendo importantes (no creas que no lo son), pero me preocupo por ellos si en el tercero mis valores sobrepasan el +- 2 y en el cuarto cuando el índice de Leverage, $hi> 2 · p/n $
  >   - No se ha comentado previamente pero la regresión lineal asume que **no existen errores en la medición de los valores del eje de las x**. El índice de Leverage nos dice si hay puntos aberrantes en los valores del eje x (como ves no es tan trivial este gráfico, para tu tranquilidad suele salir guay, pero nunca está de más echarle un ojo).

- Las observacionse son independientes

  > Esto se abarca con el diseño muestral



**Vale, todo esto está muy bien...pero ¿en qué se basa la regresión lineal? ¿Cómo se genera la recta?**

La recta se genera a través del método de mínimos cuadrados, lo cual quiere decir que la recta que vemos es la que maximiza la variabilidad que explican mis puntos, o lo que es lo mismo, la que minimiza el error entre mi valor observado de *y*, y el valor que predice mi recta (*y'*). 

![LM_1](C:\CursoR\LM_1.png)

El objetivo de la regresión es que la recta vertical que une mi punto con la recta, sea lo más pequeña posible. Esa recta son los residuos del modelo, es decir, lo que no está explicando tu modelo, cuanto más pequeña sea, más explica tu modelo tus datos.

*(....)* - Pues a mí siempre me habían contado que lo que importa en regresión lineal es el $R^2$, que es lo que me dice cómo de bien ajusta la recta...

- ¡Claro! Y no estás equivocad, el valor del ajuste de la regresión, $R^2$, guarda la siguiente relación:

![LM_2](C:\CursoR\LM_2.png)



Como puedes ver cuanto mayor sea $R^2$ , mejor ajuste de la regresión, es porque la variabilidad explicada de tus datos es mayor: cuanto más pequeña sea la distancia entre mi punto observado (y) y mi punto predicho (y'), más grandes es  $R^2$.



Para realizar una regresión lineal en R, comprobar todas las asunciones y realizar apropiadamente el análisis estadístico, cerciórate que tienes cargado en tu script:

~~~R
library(car)

lm(variable_respuesta~variable_explicativa)			#hacer un modelo de regresión lineal es así
													#de sencillo

#Ya sé dibujar la nube de puntos de mis datos con plot o con ggplot, ¿cómo añado la recta de la regresión?
plot(variable respuesta~variable explicativa)
abline(objeto en el que he guardado mi modelo)

ggplot(datos, aes(variable explicativa, variable respuesta))+
	geom_point(size=3.5,pch=1)+					 #size= hace más grande o pequeños el tamaño de 
												 #los puntos; pch= investiga qué es
	geom_smooth(method = "lm", col="red", se=F)+ #dibuja la recta de la regresión, investiga 
												 #qué es se=F

~~~



Ya he hecho el modelo, lo he visto...pero ¿hay relación entre mi VR y mi VE?, ¿cómo son?

~~~R
> anova(modelo1)	#comprueba la significación del modelo
Analysis of Variance Table Response: 
alturas$peso 
	 		 Df  Sum Sq  Mean Sq  F value  Pr(>F) 
alturas$kids 1   0.4368  0.43677  7.4296   0.008469 ** 					
Residuals    58  3.4097  0.05879 
--- Signif. codes: 0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

#Pr(>F) te dice si VE explica significativamente los valores de tu VR.
# F value: 7.4296: Te dice cuánto más es la variabilidad explicada respecto a la variabilidad de los residuos. Cuanto mayor sea este valor, mejor. 
# Este valor sale de Mean Sq alturas$kids/ Mean Sq Residuals
#Puedes comprobar que:
0.43677 / 0.05879 = 7.4296	 #en nuestro caso la variabilidad explicada por el mdoelo es
							#7.4296 veces superior a la variabilidad explicada por los residuos

#Mean Sq (en la fila Residuals): cuanto más pequeño sea este valor: mejor. Hace referencia a la variabilidad de tus datos que tu modelo no es capaz de explicar
~~~

~~~R
> summary(modelo1)			#resumen del modelo
Call: lm(formula = alturas$peso ~ alturas$kids) 
Residuals: 
   Min 	1Q      Median  3Q    Max 
   -0.5826 -0.1994 -0.0039 0.1909 0.6566 
Coefficients: 
			Estimate Std.Error t value  Pr(>|t|) 
(Intercept) 16.03683 1.46949   10.913   1.1e-15 *** 
alturas$kids 0.03011 0.01105   2.726    0.00847 ** 
--- 
Signif. codes: 0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1 
Residual standard error: 0.2425 on 58 degrees of freedom 
Multiple R-squared: 0.1136, Adjusted R-squared: 0.09827 
F-statistic: 7.43 on 1 and 58 DF, p-value: 0.008469


# Hay datos que se repiten con la tabla anterior del anova, no pasa nada, puedes elegir donde verlos.
# Debemos fijarnos en: 
#Estimate intercept: para concoer a 
#Estimate altura$kids: para conocer b (la pendiente). El símbolo de b (positivo o negativo) indica cómo es la relación. Su valor indica cuánto influye en los valores de mi variable respuesta.
#Adjusted R-squared: R^2		ajuste de mi modelo

~~~



##### Anova

Es un modelo predictivo lineal que sirve para testar la hipótesis de si existen diferencias entre las medias de unas poblaciones debido a una variable explicativa cualitativa.

El resultado del Anova te dice si las medias son o no diferentes, pero no te dice cuánto lo son. Hay que hacer pruebas a posteriori (test post-hoc) para ver cómo de diferentes son las medias de los grupos (*e.g.* Test de Bonferroni, test de Tukey).



**Asunciones de la Anova: hay que comprobarlo SIEMPRE:**

1. Normalidad de la variable respuesta (VR).
2. Homocedasticidad: la varianza de los grupos son iguales.
3. Las muestras son independientes (--> Muestreo aleatorio).
4. Independencia de los residuos: cualquier variación quehay en mi VR se debe al azar y no a otro factor que esté influyendo sin que nos demos cuenta.



El Anova evalúa cómo de diferentes son las medias de los grupos (SSA), ¿cómo?  

- Calcula la desviación individual respecto a la media total de los grupos (SST).
- Calcula la desviación de cada grupo respecto a la media de su grupo (SSE).
- Hace la diferencia entre ellos para cada grupo $SSA  = SST - SSE $

![anova](C:\CursoR\anova.PNG)



Ejemplo*: Vamos a ver si existe diferencia en la diversidad media de una serie de hábitats (pastizal, bosque, matorral y desierto).

- Lo primero, como siempre, observa tus datos.

  > Ya sabes ggplot() plot() es guay para esto. Debes visualizarlo con barras de error, es incorrecto hacerlo diagramas de cajas y bigotes.

- Comprueba las asunciones estadísticas.

  ~~~R 
  > shapiro.test(diverso$div)
  >leveneTest(diverso$div, diverso$names)
  ~~~

  ¿Se cumplen? Sigue con el análisis.

- Realización del Anova

  ~~~R
  >diver<-lm(diverso$div~diverso$names)

  >anova(diver)
  Analysis of Variance Table 
  Response: diverso$div 
  	        	Df    Sum Sq     Mean Sq    F value    Pr(>F) 
  diverso$names   3      422.85     140.950     43.819     1.037e-14 *** 
  Residuals 	    56    180.13     3.217 
  --- Signif. codes: 0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

  #Si hay diferencias en las medias de mis hábitats me lo va a decir Pr(>F). Ello me está indicando que existen diferencias, pero no me dice entre quiénes las hay, ni cómo son las diferencias de las medias.

  ~~~

  Como hemos visto que hay diferencias y queremos saber entre quiénes tenemos que realizar un test a posterior (pots-hoc)

  ~~~R
  >pairwise.t.test(x=diverso$div, g=diverso$names, 		#Test de Bonferroni
  	p.adjust.method=c("bonferroni"))
  	Pairwise comparisons using t tests with pooled SD 
  data: diverso$div and diverso$names 
  			bosque   desierto matorral 
  desierto 	0.0012          -              - 
  matorral 	1.0000     1.8e-05      -
  pastizal 	5.9e-09    2.7e-15  6.1e-07 
  P value adjustment method: bonferroni 

  #Nos dice entre quienes hay diferencias entre las medias. Por ejemplo: entre desierto y pastizal hay diferencias, pero entre bosque y matorral no hay diferencias en las medias.
  # Aun así  no nos da como resutlado cómo es la diferencia entre las medias.
  ~~~

  **Alternativamente** podemos usar el test de Tukey

  ~~~R
  >TukeyHSD(aov(diver))
  Tukey multiple comparisons of means 95% 
  family-wise confidence level 
  Fit: aov(formula = diver) 
  $`diverso$names` 
  	        		diff                  lwr             upr 	        	p adj 
  desierto-bosque     -2.6                -4.3340911       -0.8659089         0.0011565 
  matorral-bosque     0.8                 -0.9340911        2.5340911         0.6159418 
  pastizal-bosque     4.8                  3.0659089        6.5340911         0.0000000 
  matorral-desierto   3.4                  1.6659089        5.1340911         0.0000176 
  pastizal-desierto   7.4                  5.6659089        9.1340911         0.0000000 
  pastizal-matorral   4.0                  2.2659089        5.7340911         0.0000006

  #diff nos dice cómo son las diferencias entre las medias.

  #si te fijas en los valores de p adj y los comparas con los de los que hemos obtenido con Bonferroni, verás que son iguales.

  ~~~

