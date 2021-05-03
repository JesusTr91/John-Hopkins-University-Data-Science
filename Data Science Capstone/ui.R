library(shiny)
library(shinythemes)
library(markdown)
library(dplyr)
library(tm)

shinyUI(
    navbarPage("Word Predictor App",
               theme = shinytheme("spacelab"),
               tabPanel("App",
                        fluidPage(
                            titlePanel("Application"),
                            sidebarLayout(
                                sidebarPanel(
                                    textInput("userInput",
                                              "Start typing for prediction:",
                                              value =  "",
                                              placeholder = "Type here"),
                                    br(),
                                    sliderInput("numPredictions", "Posible Predictions number:",
                                                value = 2.0, min = 1.0, max = 3.0, step = 1.0)
                                ),
                                mainPanel(
                                    h4("Your text:"),
                                    verbatimTextOutput("userSentence"),
                                    br(),
                                    h4("Posible words:"),
                                    verbatimTextOutput("prediction1"),
                                    verbatimTextOutput("prediction2"),
                                    verbatimTextOutput("prediction3")
                                )
                            )
                        )
               ),
               tabPanel("Documentation",
                        h3("About the App"),
                        br(),
                        div("The goal of this Shiny app is to teach our computer 
                            to learn the English language, by implementing a 
                            text prediction algorithm that can foretell the next 
                            word(s) based on the user's input.",
                            br(),
                            br(),
                            "The algorithm makes use of a simple back-off strategy. 
                            As text is inputted, the algorithm iterates from the longest
                            to the shortest n-gram to detect matches. The word suggested 
                            is considered using the longest and most frequent matching n-gram.
                            ",
                            br(),
                            br(),
                            "The app uses an n-gram language model that assigns 
                            probabilities to sequences of words. Once the user types
                            a word or phrase, the model will calculate up to 3 possible
                            words that will be displayed on screen, being the top prediction
                            the most likely to follow the phrase of the user input.",
                            br(),
                            br(),
                            "The corpus used to build the model was obtain from 
                            news, twitter and blogs text data. this data was previously
                            cleaned: converted to lowercase, removed non-ascii characters, urls,
                            whitespaces, puntuations, hash tags, ordinal numbers and a list of
                            profane words provided by google. It is subsequentialy tokenized into
                            n-grams.",
                            br(),
                            br(),
                            "This app source code can be found on GitHub:",
                            "https://github.com/JesusTr91/datasciencecoursera/tree/master/Data%20Science%20Capstone"
                            
                            )
               )
    )
)