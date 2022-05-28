# Obtiene información de los servidores de Inegi
library(tidyverse)
library(foreign)
library(sf)

# Carga los datos de defunciones Covid
f_covid <- read_csv("https://datos.covid-19.conacyt.mx/Downloads/Files/Casos_Diarios_Estado_Nacional_Confirmados_20220522.csv")

f_gto <- f_covid |> 
  filter(nombre == "GUANAJUATO")

base_grafica <- f_gto |> 
  pivot_longer(cols = 4:798, 
               names_to = "fecha", 
               values_to = "fallecimientos_diarios") %>% 
  mutate(fecha = as.Date(fecha, format = "%d-%m-%Y")) 

base_grafica |> 
  ggplot(aes(x = fecha, y = fallecimientos_diarios)) + 
  geom_col() + 
  labs(x = "Fecha", y = "Fallecimientos") + 
  scale_x_date(breaks = "2 months") + 
  theme(axis.text.x =  element_text(angle = 90))

#Fallecimientos diarios COVID-19
#Datos para el Estado de Guanajuato
#Fuente: Tablero CONACYT Consultado el 27 de Mayo del 2022
ggsave("3_Comunicar/media/image2.png",
       width = 5,
       height = 4,
       units = "in")


# Descarga los datos de mortalidad del servidor de Inegi
curl::curl_download("https://www.inegi.org.mx/contenidos/programas/mortalidad/microdatos/defunciones/2020/defunciones_base_datos_2020_dbf.zip",
                    destfile = "data/def.zip")
unzip("data/def.zip", exdir = "data")
db <- read.dbf("data/defun20.dbf")
