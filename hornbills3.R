# Hornbills 3----

# load packages----
install.packages("pacman")
pacman::p_load(tidyverse,seewave,tuneR,SoundShape,dplyr,tidyr,warbleR,Rraven,ggmap)

  # https://cran.r-project.org/web/packages/warbleR/vignettes/warbleR_workflow_01.html



# warbleR----

# Query xeno-canto for all Phaethornis recordings (e.g., by genus)
Hornbills <- query_xc(qword = "Bucerotidae", download = FALSE) 

# Check out the structure of resulting the data frame
str(Hornbills)
View(Hornbills)

# exploratory analysis----
colSums(is.na(Hornbills))
class(Hornbills) 
ls(Hornbills) #variable list
dim(Hornbills) # rows, cols
unique(Hornbills$Genus)
unique(Hornbills$Vocalization_type)

Hornbills_2 <- Hornbills %>% 
  select(Genus,Specific_epithet,English_name,Subspecies,Country,Locality,Latitude,Longitude,Bird_seen,
         Quality,Length,Spectrogram_full,Time,file.name,Url)

# concatenate Genus and specific_epithet
Hornbills_2$Latin_name <- paste(Hornbills_2$Genus, Hornbills_2$Specific_epithet)
# re-order
Hornbills_2 <- Hornbills_2[, c(1,2,16,3,4,5,6,7,8,9,10,11,12,13,14,15)]

# Factor time

# I can convert to factors one by one, but this is time consuming
Hornbills_2$Genus<-factor(Hornbills_2$Genus) # convert
summary (Hornbills_2$Genus) # confirm. Success!
Hornbills_2$English_name<-factor(Hornbills_2$English_name)
summary(Hornbills_2$English_name)
Hornbills_2$Subspecies<-factor(Hornbills_2$Subspecies)
summary(Hornbills_2$Subspecies)

# this code allows for conversion of multiple columns to factors in one go.
Hornbills_2 <- Hornbills_2 %>%
  mutate_at(vars(Country, Locality,Bird_seen,Quality,Latin_name,Specific_epithet), factor)

# select

species_list<-Hornbills_2 %>% 
  group_by(English_name,Latin_name) %>% 
  summarise(unique(Latin_name))
  
# Query specific species like this
  # Oriental_pied <- query_xc(qword = "Anthracoceros albirostris", download = FALSE) 

# Or pick them out from the transformed Hornbills_2 data with pipe filter
Oriental_pied <- Hornbills_2 %>% 
  filter(Latin_name == "Anthracoceros albirostris")






