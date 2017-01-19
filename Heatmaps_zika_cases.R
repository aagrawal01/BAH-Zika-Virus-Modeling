# This R environment comes with all of CRAN preinstalled, as well as many other helpful packages
# The environment is defined by the kaggle/rstats docker image: https://github.com/kaggle/docker-rstats
# For example, here's several helpful packages to load in 

library(ggplot2) # Data visualization
library(readr) # CSV file I/O, e.g. the read_csv function
library(rworldmap)
# Input data files are available in the "../input/" directory.
# For example, running this (by clicking run or pressing Shift+Enter) will list the files in the input directory

#system("ls ../Volumes/Ariic")

data<-read.csv("cdc-zika-data/Countsby_country.csv")
data<-as.data.frame(data)
#Selecting university name and the country
#new_data<-as.data.frame( data[,c(2:3)], drop=false)
#Removing duplicate entries so as to count each university once
#new_data_f<-unique(new_data)
#plot_data<-as.data.frame(table(data$countries))
#colnames(plot_data)<-c("Country","No_of_zika_cases")
#Some misspelled countries were observed.So were removed manually 
#plot_data<-plot_data[plot_data$Country != "Unisted States of America", ]
#plot_data<-plot_data[plot_data$Country != "Unted Kingdom", ]

country<-as.data.frame(data$countries)
freq<-as.data.frame(data$zika_count)
dF <- data.frame(country=country, data=freq)
colnames(dF)<-c("country","data")
sPDF <- joinCountryData2Map(dF, joinCode='NAME', nameJoinColumn='country')
mapParams <-mapCountryData(sPDF, nameColumnToPlot='data',mapRegion = 'latin america',missingCountryCol="grey",oceanCol="white",colourPalette="heat",numCats=100,borderCol = 'black',lwd = 2.3,addLegend = FALSE,mapTitle="Zika Cases in Latin America")
do.call(addMapLegend, c(mapParams
                        ,legendLabels="all"
                        ,legendWidth=0.5
                        ,legendIntervals="dF$freq"))
# Any results you write to the current directory are saved as output.

state_data<-read.csv("cdc-zika-data/Countsby_state.csv")
state_data<-as.data.frame(state_data)
state<-as.data.frame(state_data$states)
state_freq<-as.data.frame(state_data$zika_count)
state_dF <- data.frame(state=state, data=state_freq)
colnames(state_dF)<-c("state","zika_data")
sPDF <- joinCountryData2Map(state_dF, joinCode='NAME', nameJoinColumn='state')
mapParams <-mapCountryData(sPDF, nameColumnToPlot='data',mapRegion = 'north america',missingCountryCol="grey",oceanCol="white",colourPalette="heat",numCats=100,borderCol = 'black',lwd = 2.3,addLegend = FALSE,mapTitle="Zika Cases in the US")
do.call(addMapLegend, c(mapParams
                        ,legendLabels="all"
                        ,legendWidth=0.5
                        ,legendIntervals="state_dF$state_freq"))