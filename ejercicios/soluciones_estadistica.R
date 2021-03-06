#Soluciones ejercicios Estad�stica en R

#Carga las librer�as siguientes:
library(dplyr)
library(ggplot2)
library(car)

#               1) Ejercicios de la t-Student

#_ _ _ _ _ _ _ _ _ _ Primer ejercicio _ _ _ _ _ _ _ _ _ _ _ 
#En las islas gal�pagos habitan diversas especies de lagartos, entre ellos las iguanas. Hemos estado en las islas y hemos observado que la misma especie presenta morfolog�a dispar en dos islas. Hemos realizado un muestreo aleatorio sobre los individuos en cada una de las islas, para conocer si nuestras observaciones son o no correctas. Los datos colectados se encuentran en el archivo iguanas.csv.

iguanas<-read_csv("iguanas.csv")
head(iguanas)												                        #observa c�mo es tu tabla
iguanas<-iguanas %>% select(iland, bodymass, metab_energy)	#elimina columnas innecesarias
ggplot(iguanas, aes(iland,bodymass))+						            #explora el contenido que has cargado
  geom_boxplot()+											
  xlab("Isla")+ylab("Masa corporal (g)")

#Comprueba las asunciones de tu modelo:Aunque tienes que comprobar estad�sticamente las asunciones del test, puede resulta �til dibujar la distribuci�n de tus datos, sobre todo si tienes que realizar alguna transformaci�n de tus variables para que se cumpla la asunci�n de normalidad. Pista: density() 
plot(density(iguanas$bodymass))   #Nuestra variable masa corporal tiene buena pinta que vaya a cumplir la condici�n de normalidad seg�n como muestra su distribuci�n; comprob�moslo.
shapiro.test(iguanas$bodymass)		#para normalidad

#--> No podemos rechazar la hip�tesis nula, es decir, no podemos decir que la variable no sea normal; por ello se asume que la variable es normal.

leveneTest(iguanas$bodymass, group=iguanas$iland)		#para homocedasticidad
#Es posible que salga un warning. Anal�zalo!

#1) Comprueba cu�l es la clase de iguanas$iland. 
#2) Transformalo a factor:usa la funci�n as.factor().
#3) Observa los resultados. �Son iguales o distintos? Recuerda que la clase chr es la "versi�n moderna" de la antigua factor.

#--> No podemos rechazar la hip�tesis nula, es decir, no podemos decir que la variabilidad de cada isla no sea igual; por ello se asume que variabilidad de cada isla es igual.

#Perfecto, se cumplen las asunciones: a por el test!
t.test(bodymass~iland, data=iguanas)					#test de la t-Student
           
#Rechazamos la hip�tesis nula. Est�bamos en lo cierto con las observaciones: los pesos de las iguanas de cada isla son significativamente distintos.




#_ _ _ _ _ _ _ _ _ _ Segundo ejercicio  _ _ _ _ _ _ _ _ _ _ _ 
#Realizo un muestreo durante un mes sobre el �xito de caza de conejos de dos poblaciones de lince ib�rico. Los datos los encontraras en el archivo lynx.csv  �Existen diferencias en el �xito de caza de las dos poblaciones?
  
lynx<-read_csv("lynx.csv")								#carga tus datos
head(lynx)										        		#observa su contenido
ggplot(lynx, aes(poblacion, caza))+						# explora el contenido que has cargado
  geom_boxplot()
plot(density(lynx$caza),main="Distribuci�n de caza de los linces")	#la variable no tiene mucha pinta de ser normal, pero comprob�moslo

shapiro.test(lynx$caza)     #pvalor: 1.435e-05 < 0.05 Rechazamos la Ho: la variables no es normal.

#Como la variable no es normal: no podemos utilizar la t-Student para realizar el an�lisis que queremos. No hay problema, simplemente deberemos usar otro estad�stico!


##############################################

#               2) Ejercicios de modelos lineales


#_ _ _ _ _ _ _ _ _ _ Primer ejercicio _ _ _ _ _ _ _ _ _ _ _ 
#�Te acuerdas de las iguanas de las gal�pagos? Es una especie muy curiosa, por eso adem�s en nuestro muestreo hemos recogido datos del metabolismo energ�tico(kJ/day). Ya tienes los datos cargados.

#1.- Ver si existe relaci�n lineal aparentemente entre las variables.
ggplot(iguanas, aes(bodymass, metab_energy))+
  geom_point()+xlab("Peso (g)")+ylab("Metabolismo energ�tico (kJ/d)")   #Tiene pinta de que si puede existir relaci�n lineal

modelo_iguanas1<-lm(metab_energy~bodymass, data=iguanas)

#2) Comprobar las asunciones del modelo. Lo vemos con los gr�ficos del modelo.
par(mfrow=c(2,2))
plot(modelo_iguanas1)
#El gr�fico de residuos vs. valores ajustados se distribuyen como una "nube de puntos" sin patrones. El segundo gr�fico vemos que los valores se ajustan bastante bien a la diagonal.

anova(modelo_iguanas1)
# pvalor:2.898e-12 *** --> La masa corporal de los ejemplares explica significativamente su gasto energ�tico.
#Mi modelo es bueno porque la variable peso, explica una gran variabilidad de los datos del gasto energ�tico y lo que no explica mi modelo, en comparaci�n, es poco: la variabilidad explicada por mi modelo es 63.568 veces superior a la variabilidad de los residuos.

summary(modelo_iguanas1)
# La relaci�n entre el tama�o de los ejemplares y su gasto energ�tico, me lo da la b (pendiente). La relaci�n es positiva, es decir a mayor peso, mayor gasto energ�tico, aunque el incremento del gasto energ�tico en relaci�n al incremento de peso es peque�o (0.031088).

ggplot(iguanas, aes(bodymass, metab_energy))+
  geom_smooth(method = "lm", col="red", se=FALSE)+
  geom_point()+xlab("Peso (g)")+ylab("Metabolismo energ�tico (kJ/d)")

#Para ver c�mo se ajusta la recta de regresi�n lineal a los datos.


#2. Relaciona el tama�o de las iguanas con su gasto energ�tico para cada una de las islas.

iguanas_G<-iguanas %>% filter(iland=="Genovesa")
iguanas_SF<-iguanas %>% filter(iland=="SantaFe")

#1) Ver si existe relaci�n lineal aparentemente entre las variables, por separado para cada isla.
ggplot(iguanas, aes(bodymass, metab_energy, col=iland))+
  geom_point()+xlab("Peso (g)")+ylab("Metabolismo energ�tico (kJ/d)")	 #tiene pinta de que si

modelo_iguanasG<-lm(metab_energy~bodymass, data=iguanas_G)
modelo_iguanasSF<-lm(metab_energy~bodymass, data=iguanas_SF)

#2) compruebo las asunciones de los modelos
plot(modelo_iguanasG)
plot(modelo_iguanasSF)								#parece que s�

anova(modelo_iguanasG)
anova(modelo_iguanasSF)

#El modelo de las iguanas de la isla Genovesa explica mayor variabilidad de los datos que el modelo de la isla de Santa Fe: Fvalue:0.7954 (modelo de genovesa)  > Fvalue: 0.5229
# Es mejor el modelo de Genovesa, porque la variabilidad explicada del modelo es mayor a la explicada por el modelo de SantaFe.
#SIN EMBARGO: en ambos modelos la masa corporal de las iguanas no explica de manera significativa el gasto energ�tico de los individuos.

#Si se comparan los modelos de cada isla con el modelo anterior, en el que consider�bamos las islas conjuntamente, vemos que es mejor el primer modelo: �ste explica mayor variabilidad de mis datos y adem�s resulta ser una variable significativa.

ggplot(iguanas, aes(bodymass, metab_energy, col=iland))+
  geom_point()+xlab("Peso (g)")+ylab("Metabolismo energ�tico (kJ/d)")+
  geom_smooth(method = "lm", fill=NA)

#no te molestes en probar con plot() algo que puedes hacer f�cilmente con ggplot(): optimiza tu tiempo y usa siempre los recursos que consideres m�s eficientes.



#3.- �Son buenas las predicciones de tus modelos?
cor.test(iguanas_G$metab_energy, predict(modelo_iguanasG))  #El coeficiente de correlaci�n de Pearson nos dice c�mo se ajsutan los datos observados con los predichos. 0.1276736^2 --> Comprueba que es el valor del R^2 de tu modelo --> El modelo es muy malo.

cor.test(iguanas_SF$metab_energy, predict(modelo_iguanasSF))   #Coeficiente de correlaci�n de Pearson: 0.1038083^2 --> Comprueba que es el valor del R^2 de tu modelo --> El modelo es muy malo.



#4.- Predice el gasto energ�tico de una iguana de la isla de Santa Fe cuyo tama�o corporal es de 307 cm. Haz lo mismo para una iguana de la isla Genovesa.

predict(modelo_iguanasSF, newdata = data.frame(bodymass=307))
predict(modelo_iguanasG, newdata = data.frame(bodymass=307))
# Puedes probar a a�adir a la funci�n predict () interval="predict", �qu� ocurre? 
#Como observar�s aparecen los niveles de confianza de la predicci�n que has hecho, pero....�cu�l es el nivel de confianza que nos da por defecto esta funci�n? Utiliza dentro de la funci�n predict() level para conocer lo anterior.


#_ _ _ _ _ _ _ _ _ _ Segundo ejercicio  _ _ _ _ _ _ _ _ _ _ _ 
#Se dice que cuanto mayor es el peso de una especie, mayor es su tiempo de gestaci�n. Queremos saber si esto ocurre para el orden Artiodactyla. 
ggplot(bovidos, aes(Biomasa_g, Tiempo_gestacion_meses))+
  geom_point()
#No parece existir relaci�n lineal entre mi variable explicativa y mi variable respuesta, por lo tanto: no se puede aplicar el modelo de regresi�n lineal para conocer la relaci�n entre estas variables.


#               3) Ejercicios de ANOVA

#_ _ _ _ _ _ _ _ _ _ Primer ejercicio _ _ _ _ _ _ _ _ _ _ _ 

#Investiga si el tama�o de la materia org�nica particulada gruesa (MOPG) depende de la tipolog�a del r�o (meandriforme, anastomasado, rectil�neo). Los datos est�n en el archivo rios.csv

rios<-read_csv("rios.csv")									# Carga el archivo en tu script.

rios_summary<-rios %>% 										# Explora tus datos
  group_by(tipo)%>% 
  summarise(mean_h=mean(mopg),sd_h=sd(mopg),n_h=n(),se_h=sd(mopg)/sqrt(n()))
ggplot(rios_summary,aes(tipo,mean_h))+
  geom_point()+
  geom_errorbar(aes(x=tipo, ymin=(mean_h-sd_h), ymax=(mean_h+sd_h), width=0.2))+ylab("Diversidad")+xlab("Tipo de h�bitat")
#Parece que si pueden existir diferencias en las medias de la MOPG de los distintos tipos de r�os.

shapiro.test(rios$mopg)									    	#Acepto normalidad de los datos
leveneTest(rios$mopg, group=rios$tipo)				#Acepto homocedasticidad

modelo_rio<-lm(mopg~tipo, data=rios)					#Realizo el modelo 
anova(modelo_rio)						                	#Compruebo si la tipolog�a del r�o es importante
                                              #La tipolog�a del r�o es significativa (pvalor<0.05), por lo tanto si tiene imoprtancia el tipo de r�o.

TukeyHSD(aov(modelo_rio))                     #Las diferencias entre las medias entre un r�o anastomasado y un r�o rectil�neo es significativa y con un valor de 0.233319 (el valor del resultado depender� del orden! Si la pregunta hubiera sido: "La diferencia entre las medias de un r�o rectil�neo y un anastomasado", la soluci�n hubiera sido -0.233319).



#_ _ _ _ _ _ _ _ _ _ Primer ejercicio _ _ _ _ _ _ _ _ _ _ _ 
#Hemos realizado un muestreo de la cantidad de artr�podos en distintos cultivos. En ellos se utilizan diferentes pesticidas (desecantes, fungicidas, insecticidas, repelentes, reguladores del crecimiento). Determina si el utilizar un pesticida es importante para la presencia de artr�podos. Los datos est�n en el archivo pesticidas.csv.
pesticidas<-read_csv("pesticidas.csv")						# Carga el archivo en tu script.
pest_summary<-pesticidas %>% 							      	# Explora tus datos
  group_by(pestic)%>% 
  summarise(mean_h=mean(c_artropodos),sd_h=sd(c_artropodos),n_h=n(),se_h=sd(c_artropodos)/sqrt(n()))
ggplot(pest_summary,aes(pestic,mean_h))+
  geom_point()+
  geom_errorbar(aes(x=pestic, ymin=(mean_h-sd_h), ymax=(mean_h+sd_h), width=0.2))+ylab("Diversidad")+xlab("Tipo de h�bitat")
#Parece que si pueden existir diferencias en las medias de la cantidad de artr�podos seg�n el tipo de pesticida que se echa en el cultivo.

shapiro.test(pesticidas$c_artropodos)			#No se cumple la condici�n de normalidad
leveneTest(pesticidas$c_artropodos, 
           group=pesticidas$pestic) 			#No se cumple la condici�n de homocedasiticdad

#No se puede realizar el test ANOVA porque no se cumplen las asunciones de este modelo lineal general para su realizaci�n.