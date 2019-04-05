#Set Working Directory
setwd("F:/R project/Electricity")


#reading the files
ene1<-read.csv("enexis_electricity_01012010.csv")
ene1
unique(ene1$city)
ene2<-read.csv("enexis_electricity_01012011.csv")
ene3<-read.csv("enexis_electricity_01012012.csv")
ene4<-read.csv("enexis_electricity_01012013.csv")
ene5<-read.csv("enexis_electricity_01012014.csv")
ene6<-read.csv("enexis_electricity_01012015.csv")
ene7<-read.csv("enexis_electricity_01012016.csv")
ene8<-read.csv("enexis_electricity_01012017.csv")
ene9<-read.csv("enexis_electricity_01012018.csv")
allene<-rbind(ene1,ene2,ene3,ene4,ene5,ene6,ene7,ene8)
lian1<-read.csv("liander_electricity_01012009.csv")
lian2<-read.csv("liander_electricity_01012010.csv")
lian3<-read.csv("liander_electricity_01012011.csv")
lian4<-read.csv("liander_electricity_01012012.csv")
lian5<-read.csv("liander_electricity_01012013.csv")
lian6<-read.csv("liander_electricity_01012014.csv")
lian7<-read.csv("liander_electricity_01012015.csv")
lian8<-read.csv("liander_electricity_01012016.csv")
lian9<-read.csv("liander_electricity_01012017.csv")
lian10<-read.csv("liander_electricity_01012018.csv")
alllian<-rbind(lian1,lian2,lian3,lian4,lian5,lian6,lian7,lian8,lian10)
#head(alllian)
#alllian
ste1<-read.csv("stedin_electricity_2009.csv")
ste2<-read.csv("stedin_electricity_2010.csv")
ste3<-read.csv("stedin_electricity_2011.csv")
ste4<-read.csv("stedin_electricity_2012.csv")
ste5<-read.csv("stedin_electricity_2013.csv")
ste6<-read.csv("stedin_electricity_2014.csv")
ste7<-read.csv("stedin_electricity_2015.csv")
ste8<-read.csv("stedin_electricity_2016.csv")
ste9<-read.csv("stedin_electricity_2017.csv")
ste10<-read.csv("stedin_electricity_2018.csv")
allste<-rbind(ste1,ste2,ste3,ste4,ste5,ste6,ste7,ste8,ste9,ste10)
electricity<-rbind(allste,alllian,allene)

#Checking for the missing values.
sum(is.na(electricity))
#Removing missing values
newelectricity<-na.omit(electricity)
sum(is.na(newelectricity))


plot(newelectricity$net_manager,newelectricity$city)

#taking a sample
set.seed(40)
index<- sample(1:nrow(newelectricity),40)
index
x<-newelectricity[index,]
plot(x$city,x$annual_consume)



#as.data.frame(x)
#table(x)
#sapply(x, function(x) length(unique(x)))
#sapply(allste, function(allste) length(unique(allste)))

