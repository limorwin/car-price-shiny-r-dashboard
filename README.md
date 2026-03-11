# Car Price Shiny R Dashboard

This repository contains my individual assignment for DSCI 532.  
It is a simplified Shiny for R implementation of the car price analysis dashboard created in our group project.

The dashboard allows users to explore vehicle pricing patterns by filtering the dataset and visualizing the distribution of car prices.

## Features

- Filter cars by **brand**
- Filter cars by **price range**
- View **number of vehicles** in the filtered dataset
- View **average vehicle price**
- Explore the **price distribution histogram**
- View a **sample of the filtered dataset**

## Deployed App

https://connect.posit.cloud/limorwinter/content/019cddfb-bfb8-c0d4-42f9-a583283b0c36

## Running the App Locally

1. Install required R packages:

```r
install.packages(c("shiny", "dplyr", "ggplot2", "readr"))
```

2. Run the app:

```r
shiny::runApp()
```
