library(shiny)
library(shinydashboard)
library(readxl)
library(tidyverse)


dados <- read_excel("www\\dados_curso1.xlsx") 
dados <- dados |> select(-1)

ui <-  dashboardPage(
  dashboardHeader(title = "IMRS Demografia"),
  
  dashboardSidebar(),
  
  dashboardBody(numericInput(inputId = 'num_municipios', label = "Digite o número de municípios", value = 1),
                textOutput(outputId = 'municipios_sorteados', inline = FALSE),
                actionButton(inputId = 'atualiza', label = "Atualizar"),
                checkboxGroupInput(inputId = 'seletor', label = "Escolha o município", choices = NULL))
)

server <- function(input, output) {
  
  meus_dados <- reactiveValues()
  
  output$municipios_sorteados <- renderText({
    mun <- sample(dados$'MUNICIPIO', input$num_municipios)
    meus_dados$mun <- mun
    paste(mun, collapse = ", ")
    
  })
  
  observeEvent(input$atualiza, {
    updateCheckboxGroupInput(inputId = 'seletor', choices = meus_dados$mun)
   
  })
  
}

shinyApp(ui = ui, server = server)