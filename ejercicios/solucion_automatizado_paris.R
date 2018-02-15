## Función para leer todos los ficheros de datos
## de AirBnB París y agregarlos por barrio.
setwd(".../paris")  # Tendrás que poner aquí tu propio "path"
library(tidyverse)

for (fichero in list.files()) {
  read_csv(fichero) %>% 
    select(neighborhood,
           reviews,
           overall_satisfaction,
           bedroom,
           price) %>% 
    group_by(neighborhood) %>% 
    summarize(num_apart = n(),
              price = mean(price),
              reviews = mean(reviews),
              overall_satisfaction = mean(overall_satisfaction)) %>%
    write_csv(paste(".../paris_procesados/",  # Tendrás que poner aquí tu propio "path"
                    fichero, sep = ""))
}