# Documentation

In this shiny app I've collect some data regarding to the weather of the city I've been living fo a while. Whit this data I've builded an application that will tells us if the weather will be bearable for camping or not. 

The data was minned from a weather webpage and consits of 5 variables:

- Outlook
- Temperature
- Humidity
- Windy
- Play 

This fifth variable is a binary factor ("Stay" or "Go") that I decided based on my camping experience. 
The app consist of the user input and will calculate an output based on a random forest model trained by
the original data. The output will be displayed in a small table telling the user the percentages of the
binary factor ("Stay" and "Go"). In the end it is desicion of the user to go camping or not, but this app 
will guide him into his desicion.

This app may just work where I'm from, but you are welcome to modify it and adapt it to the place you are living in.






