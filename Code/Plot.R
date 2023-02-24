setwd("/Users/ancher/Desktop/Winter 2023/PSTAT 296B/Benefit Data")

library(NMF)
library(tidyverse)
library(tidymodels)
library(ggplot2)
library(ggthemes)
library(cowplot)
library(ggpubr)

# Load result
load("nmfResults296_20230203")

plot(lee,snmfl,what = c("cophenetic", "rss"))

lee.cop <- lee$measures$cophenetic
lee.rss <- lee$measures$rss
snmfl.cop <- snmfl$measures$cophenetic
snmfl.rss <- snmfl$measures$rss
index <- c(2:50)
data <- data.frame(index, lee.cop, lee.rss, snmfl.cop, snmfl.rss)


rss.plot <- data %>%
  ggplot(aes(x = index)) +
  geom_point(aes(y = lee.rss), color = "darkgreen", shape = 1) +
  geom_point(aes(y = snmfl.rss), color = "darkgreen", shape = 2) +
  geom_line(aes(y = lee.rss), color = "darkgreen", lty = 1) +
  geom_line(aes(y = snmfl.rss), color = "darkgreen", lty = 2) +
  xlab("rank") + ylab("rss") + theme_bw()
rss.plot


cop.plot <- data %>%
  ggplot(aes(x = index)) +
  geom_point(aes(y = lee.cop),color = "#FFCC00", shape = 1) +
  geom_point(aes(y = snmfl.cop), color = "#FFCC00", shape = 2) +
  geom_line(aes(y = lee.cop), color = "#FFCC00", lty = 1) + 
  geom_line(aes(y = snmfl.cop), color = "#FFCC00", lty = 2) +
  xlab("rank") + ylab("cophenetic") + theme_bw()

cop.plot

plot_grid(rss.plot,cop.plot,labels = c("Rss","Cophenetic"))





