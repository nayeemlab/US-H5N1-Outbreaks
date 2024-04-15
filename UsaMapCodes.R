packages = c("gtrendsR","tidyverse","usmap")

package.check <- lapply(packages, FUN = function(x) {
  if (!require(x, character.only = TRUE)) {
    install.packages(x, dependencies = TRUE)
    library(x, character.only = TRUE)
  }
})

orange <- "#56B4E9"

options(scipen = 999)
setwd('E:\\ResearchProject\\Najmul Bhai\\USA Map')

USAData <- read.csv("USAData.csv")
USAData

USAData$fips <-fips(USAData$location)

x <- plot_usmap(data = USAData, values = "hits",  color = orange, labels=FALSE, linewidth = 1) + 
  scale_fill_continuous( low = "white", high = orange, 
                         name = "Number of herds") + 
  theme(legend.position = "right",
        legend.title = element_text(size=15),
        legend.text = element_text(size=15),
        plot.title = element_text(hjust = 0.5),
        text=element_text(size=15),
        axis.text = element_text(size = 12)) + 
  theme(panel.background = element_rect(colour = "black")) + 
  labs(title = "HPAI in Domestic Livestock")
x$theme$legend.justification.inside <- NULL
x


tiff("USA.tiff", units="in", width=15, height=8, res=300)
gridExtra::grid.arrange(x, nrow=1)
dev.off()
