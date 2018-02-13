#### Fibonnaci (while)

~~~R
x <- c(0,1)
i <- 2
while ( x[i] < 1000) {
  i <- i + 1
  x[i] <- x[i-1] + x[i-2]
}
~~~

#### Árbol de Navidad

~~~R
christmas_tree <- function(n) {
  total_characters <- 2*n - 1
  for (i in 1:n) {
    n_stars <- 2*i - 1
    n_space <- total_characters - n_stars
    space_each_side <- paste0(rep(" ", n_space/2), collapse = "")
    stars <- paste0(rep("*", n_stars), collapse = "")
    print(paste0("|", space_each_side, stars, 
                     space_each_side, "|", collapse = ""))
  }
}
~~~

#### Dinámica de poblaciones



~~~R
lines(años,Nt)

tasa_crec_per_capita<-function(Nt_,Nt1_){
  log(Nt1_/Nt_)
  }
plot(Nt,tasa_crec_per_capita(Nt,Nt1), col="blue", pch=16,
     ylab="Tasa de crecimiento per cápita", xlab="Tamaño de la población")

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

r_teorica<-function(N){
  ro<-max(tasa_crec_per_capita(Nt,Nt1))
  ro*((1-(0.5/N))*(1-((N/97.185)^0.8)))
}
r_teorica(Nt)

N_teorica<-function(r_teorica){
  Nt*exp(r_teorica(Nt))  
}
as.integer(N_teorica(r_teorica))
~~~

>  Nota: Salta constántemente un warning, descubre el porqué. ¿Tiene sentido? ¿Qué indica? 
>
>  <u>Pista:</u> Piensa sobre lo que puedes y no puedes saber teóricamente de la población.

~~~R
años3<-seq(1989,2018,by=1)

N_1989_2018<-c()
r_1989_2018<-c()
for (i in 1:length(años3)){
  if (i==1){
    N_1989_2018[i]<-N_teorica(r_teorica)[26]
    r_1989_2018[i]<-r_teorica(N_teorica(r_teorica)[26])
  }else {
    N_1989_2018[i]<-N_1989_2018[i-1]*exp(r_1989_2018[i-1])  
    r_1989_2018[i]<-r_teorica(N_1989_2018[i])
      }
}


#¿Cómo ha evolucionado mi población de 1963 a la actualidad? ¿Qué observamos que ocurre a partir de la década de 1990? 
años22<-años[(-1)]
años_periodo<-c(años22,años3)
N_1964_1988<-(N_teorica(r_teorica))[-26]
N_teorica_pobla<-c(N_1964_1988,N_1989_2018)

plot(años_periodo,N_teorica_pobla, col="blue", pch=1,
     ylab="Tamaño poblacional", xlab="Años")
lines(años_periodo,N_teorica_pobla, col="red", lty=2,
      ylab="Tamaño poblacional", xlab="Años")
~~~

#### Teoría de islas



~~~R
I<-function(D,sp_cont,sp_isla,c,f){
  c<-0.1
  f<-0.01
  round((c*(sp_cont-sp_isla))/(f*(D)),0)
}
~~~

- Función extinción:

```r
E<-function(S,A,q,m){
  q<-0.2
  m<-0.25
  round((q*S/A^m), 0)
}
```



2. ¿Cuando alcanza el equilibrio mi isla? Cuando los *ratios* de inmigración  y extinción son iguales (que no 0). Veámoslo con el gráfico.

```r
R_sp<-seq(0,1000, by=100)

I_<-numeric()
for (i in 1:length(R_sp)){
  I_[i]=I(300,1000,R_sp[i])
  }
I_

E_<-numeric()
E_<-numeric()
for (i in 1:length(R_sp)){
  E_[i]=E(R_sp[i],200)
  }
E_

T_islas<-cbind(R_sp,I_,E_)
T_islas

par(mfrow=c(1,2))
plot(R_sp, I_, pch=16, 
     xlab="Riqueza de especies", ylab="Tasa de inmigración",
     lines(loess.smooth(R_sp,I_),col="darkgreen", lwd=2, lty=1), 
     xlim=c(0,1000), ylim=c(0,55))
plot(R_sp, E_, pch=1, col="black",
     xlab="Riqueza de especies", ylab="Tasa de extinción",
     lines(loess.smooth(R_sp,E_), col="red", lwd=2, lty=1), 
     xlim=c(0,1000), ylim=c(0,55))

```

3. Caso real: 

~~~R
for (i in (1:100)){
  if (i==1){
    R_sp[i]=0
    } else 
    R_sp[i]=R_sp[i-1]+I_[i-1]-E_[i-1]
    I_[i]=I(300,1000,R_sp[i])
    E_[i]=E(R_sp[i],200)
}

t<-seq(1:100)
mi_isla<-cbind(t,R_sp,I_,E_)

head(mi_isla)
tail(mi_isla)

par(mfrow=c(1,1))
plot(t,R_sp, col="green", ylab="Riqueza de especies", xlab="Tiempo",
     ylim=c(0,400), xlim=c(0,30))
par(new=TRUE)
plot(t, I_, col="blue",ylab="", xlab="Tiempo",
     ylim=c(0,400), xlim=c(0,30))
par(new=TRUE)
plot(t, E_, col="red",ylab="", xlab="Tiempo",
     ylim=c(0,400), xlim=c(0,30))
~~~

¿En qué momento (tiempo) alcanza el equilibrio mi isla? ¿Cuál es el valor de la tasa de inmigración/extinción en ese momento?

~~~R
I_!=E_							#qué elementos de esos vectores son distintos
length(I_[I_!=E_])				#cantidad de elementos que son distintos
length(I_[I_!=E_])+1			#momento   **tiempo**  en el que los elementos comienzan
								#a ser iguales => cuando alcanza el equilibrio mi isla
I_[I_==E_]						#el valor de la tasa de inmigración y de extinción es el mismo
~~~