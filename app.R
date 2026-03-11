library(shiny)
library(dplyr)
library(ggplot2)
library(readr)

cars <- read_csv("data/global_cars_enhanced.csv", show_col_types = FALSE)

ui <- fluidPage(
  
  titlePanel("Global Car Price Explorer"),
  
  sidebarLayout(
    
    sidebarPanel(
      
      selectInput(
        "brand",
        "Select Brand",
        choices = c("All", sort(unique(cars$Brand))),
        selected = "All"
      ),
      
      sliderInput(
        "price",
        "Price Range (USD)",
        min = floor(min(cars$Price_USD)),
        max = ceiling(max(cars$Price_USD)),
        value = c(
          floor(min(cars$Price_USD)),
          ceiling(max(cars$Price_USD))
        )
      )
      
    ),
    
    mainPanel(
      
      h3("Number of Cars"),
      textOutput("count"),
      
      h3("Average Price"),
      textOutput("avg"),
      
      plotOutput("price_plot"),
      
      tableOutput("table")
      
    )
  )
)

server <- function(input, output) {
  
  filtered <- reactive({
    
    df <- cars
    
    if(input$brand != "All"){
      df <- df %>% filter(Brand == input$brand)
    }
    
    df %>%
      filter(
        Price_USD >= input$price[1],
        Price_USD <= input$price[2]
      )
    
  })
  
  output$count <- renderText({
    nrow(filtered())
  })
  
  output$avg <- renderText({
    paste0("$", round(mean(filtered()$Price_USD, na.rm=TRUE),0))
  })
  
  output$price_plot <- renderPlot({
    
    ggplot(filtered(), aes(x = Price_USD)) +
      geom_histogram(bins = 30) +
      theme_minimal() +
      labs(
        title = "Price Distribution",
        x = "Price (USD)",
        y = "Count"
      )
    
  })
  
  output$table <- renderTable({
    head(filtered(), 10)
  })
  
}

shinyApp(ui, server)