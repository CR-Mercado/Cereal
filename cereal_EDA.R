library(ggplot2)

# Load and Clean Up 
cereal <- read.csv("Data/cereal.csv", stringsAsFactors = TRUE)

# Manufacturer Names

full_name_merge_tbl <- data.frame(
  mfr = c("A","G","K","N","P","Q","R"),
  MFR_Name = c(
    "American Home",
    "General Mills",
    "Kelloggs",
    "Nabisco",
    "Post",
    "Quaker Oats",
    "Ralston Purina")
)

cereal = merge( x = cereal, y = full_name_merge_tbl)

##### How many cereals have "Bran" in their name? 

table(
  grepl(pattern = "bran", x = cereal$name, ignore.case = TRUE)
)

##### How many cereals have "Corn" in their name? 

table(
  grepl(pattern = "corn", x = cereal$name, ignore.case = TRUE)
)

##### How many cereals have "Honey" in their name? 

table(
  grepl(pattern = "honey", x = cereal$name, ignore.case = TRUE)
)

##### How many unique values of each non-name column
lapply(cereal, function(x){
  length(unique(x))
})

png(file = "pairs_plot_cereal.png")
pairs(cereal[, - which(colnames(cereal) %in% c("name","MFR_Name"))])
dev.off()

# Plotting Sugar vs Ratings by Manufacturer

gg <- ggplot(cereal, aes(x = sugars, y = rating)) + 
  geom_point(aes(col = MFR_Name)) +
  geom_smooth(method = "lm", se = FALSE,
              linetype = "dashed", color = "black") +
  labs(x = "Sugar (grams) per serving", 
       y = "Consumer Report Ratings", 
       title="Cereal Critics Rail Against Big Sugar",
       subtitle = "A gram of sugar costs you nearly 2.5 points!",
       caption = "Source: kaggle.com/crawford/80-cereals") + theme_classic() + 
  theme(axis.title = element_text(size = rel(1.25)), 
        plot.title = element_text(size = rel(1.3), hjust = 0.5),
        plot.subtitle = element_text(size = rel(1.3), hjust = 0.5))
gg$labels$colour <- "Cereal Manufacturer"

png(file = "Critics_Against_Sugar.png")
gg
dev.off()






