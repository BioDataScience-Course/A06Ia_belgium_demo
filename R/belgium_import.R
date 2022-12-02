# Importation, la transformation et la fusion des 6 tableaux
# date : ___
# auteur: ___ 
#############################

# Avant 2000 ------------------------------------------------------------------
# lecture des trois tableau de données 
## Region Wallonne
rw_av <- ___("data/region_wallonne_av_2000.csv")
## Region flamande
rf_av <- ___("data/region_flamande_av_2000.xls")
## Region Bruxelles capitale
rb_av <- ___("data/region_bxl_av_2000.rds")

# Combinaison des trois tableau en un seul tableau
av <- ___

# Après 2000  ------------------------------------------------------------------
# lecture des trois tableau de données 
## Region Wallonne
rw_ap <- ___("data/region_wallonne_ap_2000.csv")
## Region flamande
rf_ap <- ___("data/region_flamande_ap_2000.xls")
## Region Bruxelles capitale
rb_ap <- ___("data/region_bxl_ap_2000.rds")

# Combinaison des trois tableau en un seul tableau
ap <- ___

# Recombinaison en un seul tableau de `av` (avant 2000) et de `ap` (après 2000)
# Combiner les données avant et après 2000
population <- ___

# Conversion du tableau large vers long 
## noms de variable year (pour l'année de la mesure) et number (pour le nombre d'individu)
pop <- ___

# rework variable 'year'
pop <- smutate(pop, year = as.numeric(stringr::str_remove(year, "^population_au_01_janvier_")))

# Sauvegarde des données retravaillées au format rds, et
write$rds(pop, "data/belgium.rds", compress = "xz")

