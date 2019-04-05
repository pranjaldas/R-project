#Set working directory
setwd("F:/R project/Electricity")

######Electricity Consumption#######

#Read the files 
ene<-read.csv("enexis_electricity_01012010.csv")
lian<-read.csv("liander_electricity_01012010.csv")
ste<-read.csv("stedin_electricity_2010.csv")


#Combining the three files
electricity1<-rbind(ene,lian,ste)
head(electricity1)


#Checking for the missing Values
sum(is.na(electricity1))


#Remove the missing values
newfile<-na.omit(electricity1)
sum(is.na(newfile))

#to check unique values in each parameter
sapply(newfile, function(newfile) length(unique(newfile)))

#Taking a sample of the whole file
set.seed(40)
index<- sample(1:nrow(newfile),40)
index
seed<-newfile[index,]
head(seed)


#mean of the annual consumption of electricity
mean(newfile$annual_consume)


#Univariate Visualization of Quantitative Variable
# Create a dot plot of cities

plot(
  x = seed$annual_consume, 
  y = rep(0, nrow(seed)), 
  ylab = "", 
  yaxt = "n")


# Create a R ggplot Dot plot

# Importing the ggplot2 library
library(ggplot2)

# Create a Violin plot
ggplot(seed, aes(x = annual_consume)) + 
  geom_dotplot(bandwidth=0.5,dotsize = 1,col="red")

# Create a boxplot of annual consume
boxplot(
  x = seed$annual_consume, 
  xlab = "Annual Consumption", 
  horizontal = TRUE)


# Plot the chart.
boxplot(annual_consume ~ net_manager, data =seed, 
        xlab = "Net Manager",
        ylab = "Annual consumption", 
        main = "NetManager vs Consumption",
        notch = TRUE, 
        varwidth = TRUE, 
        col = c("green","yellow","purple"))




# Create a histogram of runtime
hist(seed$annual_consume,xlab = "Annual Consume",col="green",main = "Histogram of Annual consume",breaks=7)


# Create a density plot of annual consume
plot(density(seed$annual_consume),main="Kernel Density of Annual consume")
polygon(density(seed$annual_consume), col="red", border="black") 


# Bivariate visualizations for 
# two quantitiative variables
# Create scatterplot of last period (July 2015)
#Create a Scatter plot
library(plotly)
plot(
  x=newfile$city,
  y=newfile$annual_consume,
  xlab = "City",
  ylab = "Annual consume",
  main = "City Vs Annual consume"
)
#ggplot for the whole data
plot_ly(newfile, x = ~city, y = ~annual_consume,
        text = paste('Electricity Consume: ', 
        newfile$annual_consume))
#ggplot for the seed
plot_ly(seed,x=~city,y=~annual_consume,text = paste('Electricity Consume: ', 
                                                    seed$annual_consume))
#new data frame

city1<-subset(newfile$city, newfile$annual_consume>=10000 & newfile$annual_consume<=60000)
annual1<-subset(newfile$annual_consume, newfile$annual_consume>=10000 & newfile$annual_consume<=60000)
df<-data.frame(city1,annual1)
tail(df)
plot_ly(df, x = ~city1, y = ~annual1, text = paste('Electricity Consume: ', df$annual1))




plot(
  x=newfile$annual_consume,
  y=newfile$num_connections,
  xlab="Annual consume",
  ylab="Number of connections",
  main="Annual consume Vs Number of Connections"
)

#pair Scatter plots
pairs(~net_manager+city+annual_consume+num_connections,data=newfile,
      main="Simple Scatterplot Matrix")

#Word cloud
class(newfile$city)

#Convert to charecter
newfile$city<-as.character(newfile$city)

#packages
library(wordcloud)
library(tm)
library(SnowballC)
library(RColorBrewer)

# Convert plots into a corpus
corpus <- Corpus(VectorSource(newfile$city))

# Inspect first entry in the corpus
corpus[[1]]$content

# Convert terms to lower case
corpus <- tm_map(corpus, content_transformer(toupper))

# Strip whitespace from corpus
corpus <- tm_map(corpus, stripWhitespace)

# Create a frequency word cloud
wordcloud(
  words = corpus,
  max.words = 100)

######Gas Consumption######
#Set working Directory
setwd("F:/R project/Gas")

#Read the files
ene1<-read.csv("enexis_gas_01012010.csv")
lian1<-read.csv("liander_gas_01012010.csv")
ste1<-read.csv("stedin_gas_2010.csv")

#Combining the three files
gas1<-rbind(ene1,lian1,ste1)
head(gas1)


#Checking for the missing Values
sum(is.na(gas1))


#Remove the missing values
newfile1<-na.omit(gas1)
sum(is.na(newfile1))

#to check unique values in each parameter
sapply(newfile1, function(newfile1) length(unique(newfile1)))


#Create a Scatter plot
library(plotly)
plot(
  x=newfile1$city,
  y=newfile1$annual_consume,
  xlab = "City",
  ylab = "Annual consume",
  main = "City Vs Annual consume"
)
#ggplot for the whole data
plot_ly(newfile1, x = ~city, y = ~annual_consume,
        text = paste('Gas Consume: ', 
                     newfile1$annual_consume))

#new data frame

city2<-subset(newfile1$city, newfile1$annual_consume>=10000 & newfile1$annual_consume<=60000)
annual2<-subset(newfile1$annual_consume, newfile1$annual_consume>=10000 & newfile1$annual_consume<=60000)
df1<-data.frame(city2,annual2)
tail(df1)
df1
plot_ly(df1, x = ~city1, y = ~annual2, text = paste('Gas Consume: ', df1$annual2))

#Word cloud
class(newfile1$city)

#Convert to charecter
newfile1$city<-as.character(newfile1$city)

#packages
library(wordcloud)
library(tm)
library(SnowballC)
library(RColorBrewer)

# Convert plots into a corpus
corpus <- Corpus(VectorSource(newfile1$city))

# Inspect first entry in the corpus
corpus[[1]]$content

# Convert terms to lower case
corpus <- tm_map(corpus, content_transformer(toupper))

# Strip whitespace from corpus
corpus <- tm_map(corpus, stripWhitespace)

# Create a frequency word cloud
wordcloud(
  words = corpus,
  max.words = 100)














#Shinny App
library(shiny)
library(shinydashboard)

#Dashboard header carrying the title of the dashboard
header <- dashboardHeader(title = "Energy Consumption in Natherland",
                          titleWidth = 275) 

#Sidebar content of the dashboard
sidebar <- dashboardSidebar(width = 275,
                            sidebarMenu(
                              menuItem("Background", tabName = "background"),
                              menuItem("Electricity Consumption", tabName = "Electricity"),
                              menuItem("Gas Consumption", tabName = "Gas")
                            )
)
#for tab1
frow1 <- fluidRow( 
  box(
    width = "1000px",
    title = "Plot for City Vs Electricity Consumption"
    ,status = "primary"
    ,solidHeader = TRUE 
    ,collapsible = TRUE 
    , plotlyOutput("plot1"), height = "500px",inline = FALSE)
  
)
frow2 <- fluidRow( 
  box(
    width = "1000px",
    title = "Word cloud for the frequent City"
    ,status = "primary"
    ,solidHeader = TRUE 
    ,collapsible = TRUE 
    , plotOutput("plot2"), height = "500px",inline = FALSE)
  
)
t1<-tabItem(tabName = "Electricity", 
            frow1,frow2)


#for tab2
frow3 <- fluidRow( 
  box(
    width = "1000px",
    title = "Plot for City Vs Gas Consumption"
    ,status = "primary"
    ,solidHeader = TRUE 
    ,collapsible = TRUE 
    , plotlyOutput("plot3"), height = "500px",inline = FALSE)
  
)
frow4 <- fluidRow( 
  box(
    width = "1000px",
    title = "Word Cloud of frequent City for Gas Consumption"
    ,status = "primary"
    ,solidHeader = TRUE 
    ,collapsible = TRUE 
    , plotOutput("plot4"), height = "500px",inline = FALSE)
  
)

t2<-tabItem(tabName = "Gas", 
            frow3,frow4)





# Create a UI with I/O controls
body <- dashboardBody(tabItems(t1,t2))
ui <- dashboardPage(title = 'This is my Page title', header, sidebar, body, skin='red')

# Create a server that maps input to output
server <- function(input, output) {
  output$plot1 <- renderPlotly({
    plot_ly(df, x = ~city1, y = ~annual1, text = paste('Electricity Consume: ', df$annual1))})
  
  output$plot2 <- renderPlot({
    wordcloud(
      words = corpus,
      max.words = 100)})
  output$plot3 <- renderPlotly({
    plot_ly(newfile1, x = ~city, y = ~annual_consume,
            text = paste('Gas Consume: ', 
                         newfile1$annual_consume))})
  output$plot4 <- renderPlot({
    wordcloud(
      words = corpus,
      max.words = 100)})

}

# Create a shiny app
shinyApp(
  ui = ui,
  server = server)
