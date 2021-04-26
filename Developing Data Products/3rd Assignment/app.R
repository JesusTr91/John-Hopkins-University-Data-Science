
library(shiny)
library(shinythemes)
library(data.table)
library(RCurl)
library(randomForest)

weather <- read.csv("https://raw.githubusercontent.com/JesusTr91/datasciencecoursera/master/Developing%20Data%20Products/3rd%20Assignment/camping_weather.csv")
weather$outlook <- as.factor(weather$outlook)
weather$play <- as.factor(weather$play)

model <- randomForest(play ~ ., data = weather, ntree = 500, mtry = 4, importance = TRUE)
saveRDS(model, "model.rds")
model <- readRDS("model.rds")

ui <- fluidPage(theme = shinytheme("united"),
                
                # Page header
                headerPanel('Should you go camping?'),
                
                # Input values
                sidebarPanel(
                    HTML("<h3>Input parameters</h3>"),
                    
                    selectInput("outlook", label = "Outlook:", 
                                choices = list("Sunny" = "sunny", "Overcast" = "overcast", "Rainy" = "rainy"), 
                                selected = "Rainy"),
                    sliderInput("temperature", "Temperature (Celcius):",
                                min = 10, max = 32,
                                value = 20),
                    sliderInput("humidity", "Humidity (%):",
                                min = 65, max = 96,
                                value = 90),
                    selectInput("windy", label = "Windy:", 
                                choices = list("Yes" = "TRUE", "No" = "FALSE"), 
                                selected = "TRUE"),
                    
                    actionButton("submitbutton", "Submit", class = "btn btn-primary")
                ),
                
                mainPanel(
                    tags$label(h3('Status/Output')), # Status/Output Text Box
                    verbatimTextOutput('contents'),
                    tableOutput('tabledata') # Prediction results table
                    
                )
)

server <- function(input, output, session) {
    
    # Input Data
    datasetInput <- reactive({  
        
        # outlook,temperature,humidity,windy,play
        df <- data.frame(
            Name = c("outlook",
                     "temperature",
                     "humidity",
                     "windy"),
            Value = as.character(c(input$outlook,
                                   input$temperature,
                                   input$humidity,
                                   input$windy)),
            stringsAsFactors = FALSE)
        
        play <- "play"
        df <- rbind(df, play)
        input <- transpose(df)
        write.table(input,"input.csv", sep=",", quote = FALSE, row.names = FALSE, col.names = FALSE)
        test <- read.csv(paste("input", ".csv", sep=""), header = TRUE)
        test$outlook <- factor(test$outlook, levels = c("overcast", "rainy", "sunny"))
        Output <- data.frame(Prediction=predict(model,test), round(predict(model,test,type="prob"), 3))
        print(Output)
        
    })
    
    # Status/Output Text Box
    output$contents <- renderPrint({
        if (input$submitbutton>0) { 
            isolate("Prediction complete.") 
        } else {
            return("Ready for calculation.")
        }
    })
    
    # Prediction results table
    output$tabledata <- renderTable({
        if (input$submitbutton>0) { 
            isolate(datasetInput()) 
        } 
    })
    
}

shinyApp(ui = ui, server = server)