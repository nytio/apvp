# Obtiene información de los servidores de Inegi
library(tidyverse)
library(foreign)

# Descarga los datos de mortalidad del servidor de Inegi
curl::curl_download("https://www.inegi.org.mx/contenidos/programas/mortalidad/microdatos/defunciones/2020/defunciones_base_datos_2020_dbf.zip",
                    destfile = "data/def.zip")
unzip("data/def.zip", exdir = "data")
db <- read.dbf("data/defun20.dbf")
