# Obtiene información de los servidores de Inegi
library(tidyverse)
library(foreign)
library(sf)

# Carga los datos de defunciones Covid
f_covid <- read_csv("https://datos.covid-19.conacyt.mx/Downloads/Files/Casos_Diarios_Estado_Nacional_Confirmados_20220529.csv")

f_gto <- f_covid |> 
  filter(nombre == "GUANAJUATO")

f_nal <- f_covid |> 
  filter(nombre == "Nacional")

rm(f_covid)

base_gto <- f_gto |> 
  pivot_longer(cols = 4:length(f_gto), 
               names_to = "fecha", 
               values_to = "fallecimientos_diarios") |>  
  mutate(fecha = as.Date(fecha, format = "%d-%m-%Y")) 

base_nal <- f_nal |> 
  pivot_longer(cols = 4:length(f_nal), 
               names_to = "fecha", 
               values_to = "fallecimientos_diarios") |>  
  mutate(fecha = as.Date(fecha, format = "%d-%m-%Y")) 

rm(f_gto, f_nal)

base_gto |> 
  ggplot(aes(x = fecha, y = fallecimientos_diarios)) + 
  geom_col() + 
  labs(x = "Fecha", y = "Fallecimientos") + 
  scale_x_date(breaks = "2 months") + 
  theme(axis.text.x =  element_text(angle = 90))

#Fallecimientos diarios COVID-19
#Datos para el Estado de Guanajuato
#Fuente: Tablero CONACYT Consultado el 27 de Mayo del 2022
ggsave("3_Comunicar/media/image2b.png",
       width = 5.17,
       height = 4.1,
       units = "in")



# Descarga los datos de mortalidad del servidor de Inegi
fuente_inegi = c(
  "https://www.inegi.org.mx/contenidos/programas/mortalidad/microdatos/defunciones/2015/defunciones_base_datos_2015_dbf.zip",
  "https://www.inegi.org.mx/contenidos/programas/mortalidad/microdatos/defunciones/2016/defunciones_base_datos_2016_dbf.zip",
  "https://www.inegi.org.mx/contenidos/programas/mortalidad/microdatos/defunciones/2017/defunciones_base_datos_2017_dbf.zip",
  "https://www.inegi.org.mx/contenidos/programas/mortalidad/microdatos/defunciones/2018/defunciones_base_datos_2018_dbf.zip",
  "https://www.inegi.org.mx/contenidos/programas/mortalidad/microdatos/defunciones/2019/defunciones_base_datos_2019_dbf.zip",
  "https://www.inegi.org.mx/contenidos/programas/mortalidad/microdatos/defunciones/2020/defunciones_base_datos_2020_dbf.zip"
  )

i <- 15
for(file in fuente_inegi) {
  print(file)
  curl::curl_download(file, destfile = paste0("data/", i, "/def.zip"))
  unzip(paste0("data/", i,"/def.zip"), exdir = paste0("data/",i))
  i <- i + 1
}

db <- read.dbf("data/20/defun20.dbf")





