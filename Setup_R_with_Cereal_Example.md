---
title: "Setup_R_Cereal_Example"
author: "Carlos Mercado"
date: "November 24, 2020"
output:
  html_document:
    keep_md: yes
    toc: true
    toc_depth: 3
---



# Step 0: Setting up R

The statistical programming language R is great for quick analysis with 
minimal headaches. You can download R and R Studio, install packages 
directly from CRAN and be off to the races within minutes. 

Unfortunately, this isn't always amenable to good science that is reproducible. 
So this document shows a quick R Setup using R Projects, Github for Desktop,
and the renv package to have a true first step for reproducible analysis. 

## 1) Programs 

I recommend the following programs: 

- [Github for Desktop](https://desktop.github.com/)
- [R (I use 4.0.3)](https://cran.r-project.org/bin/windows/base/)
- [RStudio](https://rstudio.com/products/rstudio/download/)

## 2) File Folders 

It's best to be on a mapped drive; it makes R behave a lot better. If you're 
in a network drive (like I am when I use my client laptop as a consultant)
you can simply "map" that folder to a new drive. For example, on one laptop
I mapped my "//client/username/virtual_machine/Documents/Carlos/" to become 
"R:/Carlos/".

Then you'll want to do the following: 

1. Create a new repo with Github for Desktop

<img src="Instruction_Screenshots/Github_Repo.png" width="400">

Notice I selected the R gitignore, this makes my repo a lot cleaner by
not tracking temporary files (e.g. don't version control where my mouse
last was when I closed my R Project).

2. Create a new R project as an existing directory and select the 
repo folder made by Github in step 1. 
<img src="Instruction_Screenshots/Associate_RProj_with_Git_Repo.png" 
width = "600">

## 3) Package Management 

Different versions of packages have different functions and given the 
interdependency of packages that build on each other, it is critical
to sort out which packages *your analysis* relied on to have its outputs. 

This is the core principle of reproducible programming. The same inputs,
under the same conditions, should always return the same output. 

Package management ensures the *same conditions* part holds true (well, as true 
as it can. In real life this is incredibly hard and involves concepts like
virtualization and tools like Docker or Kubernetes to abstract away from
Windows/Mac compiler/assembly level issues using "Containers".)

While [Docker](https://colinfay.me/docker-r-reproducibility/) is outside the scope of this tutorial, it is the logical next step for someone interested in really preventing reproducibility problems long-term at a data science organization.
This tutorial is scoped for more individual-level reproducibility and good
programming practices in R. 

1. install the renv package, load it, and activate it. 


```r
install.packages("renv")
library(renv)
renv::activate()
```

This will change your library paths to a new library and also update 
your git repo to strategically ignore and commit files that ensure 
packages can be tracked. 


```r
.libPaths()
```

```
## [1] "C:/Users/carlo/Documents/Messing with R/Cereal/renv/library/R-4.0/x86_64-w64-mingw32"
## [2] "C:/Users/carlo/AppData/Local/Temp/RtmpWuXIFf/renv-system-library"
```

<img src = "Instruction_Screenshots/Renv_self_commits_relevant_files.png" 
width = "400">


2. Now, when you install packages relevant to your analysis, renv will
track the packages and their versions while installing their dependencies. 

Here I **snapshot** my current packages in use and renv identifies that 
I have a bunch of packages not yet in my lock file (you may notice
these packages are the packages for creating R Markdown documents like this one!)

<img src = "Instruction_Screenshots/Renv_snapshot_updates_lockfile.png" 
width = "400">

## 4) Example Analysis 

Now, with my packages being tracked, my R Project ensuring portability across
other peoples computers, and Github serving as version control of my code, I'm
ready to do an analysis and show how renv ensures it is reproducible! 

### Background Note 

Selecting the [Cereal dataset](https://www.kaggle.com/crawford/80-cereals)
from the fun [beginner friendly datasets](https://www.kaggle.com/rtatman/fun-beginner-friendly-datasets) Kaggle page, I'll do a quick pair-plots exploration and then a more purposeful
visualization showing a relationship I found.

I may owe it to the reader to quickly link to some statistical philosophy sources
on why this is an *analytics* example and not a *statistics* or *machine learning* one. Most specifically, there isn't any decision to make under uncertainty. 

[We have what we have and it says what it says.](https://www.kdnuggets.com/2019/09/difference-analytics-statistics.html)


### Read Data

Read in the Cereal dataset in my Data folder. Merge in the full 
manufacturer names (instead of just the first letter). 


```r
library(ggplot2)
library(DT) # aesthetic tables 

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

cereal <- merge( x = cereal, y = full_name_merge_tbl)

DT::datatable(cereal, extensions = 'Buttons',
            options = list(dom = 'Blfrtip',
                           buttons = c('copy', 'csv')))
```

<!--html_preserve--><div id="htmlwidget-be2615fa5348bff2c8fa" style="width:100%;height:auto;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-be2615fa5348bff2c8fa">{"x":{"filter":"none","extensions":["Buttons"],"data":[["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50","51","52","53","54","55","56","57","58","59","60","61","62","63","64","65","66","67","68","69","70","71","72","73","74","75","76","77"],["A","G","G","G","G","G","G","G","G","G","G","G","G","G","G","G","G","G","G","G","G","G","G","K","K","K","K","K","K","K","K","K","K","K","K","K","K","K","K","K","K","K","K","K","K","K","N","N","N","N","N","N","P","P","P","P","P","P","P","P","P","Q","Q","Q","Q","Q","Q","Q","Q","R","R","R","R","R","R","R","R"],["Maypo","Apple Cinnamon Cheerios","Cocoa Puffs","Total Corn Flakes","Count Chocula","Basic 4","Raisin Nut Bran","Multi-Grain Cheerios","Clusters","Kix","Cheerios","Cinnamon Toast Crunch","Trix","Golden Grahams","Total Whole Grain","Lucky Charms","Oatmeal Raisin Crisp","Crispy Wheat &amp; Raisins","Honey Nut Cheerios","Triples","Total Raisin Bran","Wheaties Honey Gold","Wheaties","Apple Jacks","Product 19","Crispix","Corn Pops","Nut&amp;Honey Crunch","Cracklin' Oat Bran","Mueslix Crispy Blend","Raisin Squares","Frosted Mini-Wheats","Nutri-Grain Almond-Raisin","Froot Loops","Frosted Flakes","Just Right Crunchy  Nuggets","Smacks","All-Bran","All-Bran with Extra Fiber","Corn Flakes","Just Right Fruit &amp; Nut","Raisin Bran","Nutri-grain Wheat","Special K","Rice Krispies","Fruitful Bran","100% Bran","Shredded Wheat spoon size","Strawberry Fruit Wheats","Shredded Wheat 'n'Bran","Cream of Wheat (Quick)","Shredded Wheat","Golden Crisp","Post Nat. Raisin Bran","Fruity Pebbles","Great Grains Pecan","Fruit &amp; Fibre Dates; Walnuts; and Oats","Grape-Nuts","Bran Flakes","Grape Nuts Flakes","Honey-comb","Life","100% Natural Bran","Cap'n'Crunch","Quaker Oat Squares","Quaker Oatmeal","Puffed Wheat","Honey Graham Ohs","Puffed Rice","Rice Chex","Muesli Raisins; Dates; &amp; Almonds","Corn Chex","Wheat Chex","Muesli Raisins; Peaches; &amp; Pecans","Almond Delight","Double Chex","Bran Chex"],["H","C","C","C","C","C","C","C","C","C","C","C","C","C","C","C","C","C","C","C","C","C","C","C","C","C","C","C","C","C","C","C","C","C","C","C","C","C","C","C","C","C","C","C","C","C","C","C","C","C","H","C","C","C","C","C","C","C","C","C","C","C","C","C","C","H","C","C","C","C","C","C","C","C","C","C","C"],[100,110,110,110,110,130,100,100,110,110,110,120,110,110,100,110,130,100,110,110,140,110,100,110,100,110,110,120,110,160,90,100,140,110,110,110,110,70,50,100,140,120,90,110,110,120,70,90,90,90,100,80,100,120,110,120,120,110,90,100,110,100,120,120,100,100,50,120,50,110,150,110,100,150,110,100,90],[4,2,1,2,1,3,3,2,3,2,6,1,1,1,3,2,3,2,3,2,3,2,3,2,3,2,1,2,3,3,2,3,3,2,1,2,2,4,4,2,3,3,3,6,2,3,4,3,2,3,3,2,2,3,1,3,3,3,3,3,1,4,3,1,4,5,2,1,1,1,4,2,3,4,2,2,2],[1,2,1,1,1,2,2,1,2,1,2,3,1,1,1,1,2,1,1,1,1,1,1,0,0,0,0,1,3,2,0,0,2,1,0,1,1,1,0,0,1,1,0,0,0,0,1,0,0,0,0,0,0,1,1,3,2,0,0,1,0,2,5,2,1,2,0,2,0,0,3,0,1,3,2,0,1],[0,180,180,200,180,210,140,220,140,260,290,210,140,280,200,180,170,140,250,250,190,200,200,125,320,220,90,190,140,150,0,0,220,125,200,170,70,260,140,290,170,210,170,230,290,240,130,0,15,0,80,0,45,200,135,75,160,170,210,140,180,150,15,220,135,0,0,220,0,240,95,280,230,150,200,190,200],[0,1.5,0,0,0,2,2.5,2,2,0,2,0,0,0,3,0,1.5,2,1.5,0,4,1,3,1,1,1,1,0,4,3,2,3,3,1,1,1,1,9,14,1,2,5,3,1,0,5,10,3,3,4,1,3,0,6,0,3,5,3,5,3,0,2,2,0,2,2.7,1,1,0,0,3,0,3,3,1,1,4],[16,10.5,12,21,12,18,10.5,15,13,21,17,13,13,15,16,12,13.5,11,11.5,21,15,16,17,11,20,21,13,15,10,17,15,14,21,11,14,17,9,7,8,21,20,14,18,16,22,14,5,20,15,19,21,16,11,11,13,13,12,17,13,15,14,12,8,12,14,-1,10,12,13,23,16,22,17,16,14,18,15],[3,10,13,3,13,8,8,6,7,3,1,9,12,9,3,12,10,10,10,3,14,8,3,14,3,3,12,9,7,13,6,7,7,13,11,6,15,5,0,2,9,12,2,3,3,12,6,0,5,0,0,0,15,14,12,4,10,3,5,5,11,6,8,12,6,-1,0,11,0,2,11,3,3,11,8,5,6],[95,70,55,35,65,100,140,90,105,40,105,45,25,45,110,55,120,120,90,60,230,60,110,30,45,30,20,40,160,160,110,100,130,30,25,60,40,320,330,35,95,240,90,55,35,190,280,120,90,140,-1,95,40,260,25,100,200,90,190,85,35,95,135,35,110,110,50,45,15,30,170,25,115,170,-1,80,125],[25,25,25,100,25,25,25,25,25,25,25,25,25,25,100,25,25,25,25,25,100,25,25,25,100,25,25,25,25,25,25,25,25,25,25,100,25,25,25,25,100,25,25,25,25,25,25,0,25,0,0,0,25,25,25,25,25,25,25,25,25,25,0,25,25,0,0,25,0,25,25,25,25,25,25,25,25],[2,1,2,3,2,3,3,1,3,2,1,2,2,2,3,2,3,3,1,3,3,1,1,2,3,3,2,2,3,3,3,2,3,2,1,3,2,3,3,1,3,2,3,1,1,3,3,1,2,1,2,1,1,3,2,3,3,3,3,3,1,2,3,2,3,1,3,2,3,1,3,1,1,3,3,3,1],[1,1,1,1,1,1.33,1,1,1,1,1,1,1,1,1,1,1.25,1,1,1,1.5,1,1,1,1,1,1,1,1,1.5,1,1,1.33,1,1,1,1,1,1,1,1.3,1.33,1,1,1,1.33,1,1,1,1,1,0.83,1,1.33,1,1,1.25,1,1,1,1,1,1,1,1,1,0.5,1,0.5,1,1,1,1,1,1,1,1],[1,0.75,1,1,1,0.75,0.5,1,0.5,1.5,1.25,0.75,1,0.75,1,1,0.5,0.75,0.75,0.75,1,0.75,1,1,1,1,1,0.67,0.5,0.67,0.5,0.8,0.67,1,0.75,1,0.75,0.33,0.5,1,0.75,0.75,1,1,1,0.67,0.33,0.67,1,0.67,1,1,0.88,0.67,0.75,0.33,0.67,0.25,0.67,0.88,1.33,0.67,1,0.75,0.5,0.67,1,1,1,1.13,1,1,0.67,1,0.75,0.75,0.67],[54.850917,29.509541,22.736446,38.839746,22.396513,37.038562,39.7034,40.105965,40.400208,39.241114,50.764999,19.823573,27.753301,23.804043,46.658844,26.734515,30.450843,36.176196,31.072217,39.106174,28.592785,36.187559,51.592193,33.174094,41.50354,46.895644,35.782791,29.924285,40.448772,30.313351,55.333142,58.345141,40.69232,32.207582,31.435973,36.523683,31.230054,59.425505,93.704912,45.863324,36.471512,39.259197,59.642837,53.131324,40.560159,41.015492,68.402973,72.801787,59.363993,74.472949,64.533816,68.235885,35.252444,37.840594,28.025765,45.811716,40.917047,53.371007,53.313813,52.076897,28.742414,45.328074,33.983679,18.042851,49.511874,50.828392,63.005645,21.871292,60.756112,41.998933,37.136863,41.445019,49.787445,34.139765,34.384843,44.330856,49.120253],["American Home","General Mills","General Mills","General Mills","General Mills","General Mills","General Mills","General Mills","General Mills","General Mills","General Mills","General Mills","General Mills","General Mills","General Mills","General Mills","General Mills","General Mills","General Mills","General Mills","General Mills","General Mills","General Mills","Kelloggs","Kelloggs","Kelloggs","Kelloggs","Kelloggs","Kelloggs","Kelloggs","Kelloggs","Kelloggs","Kelloggs","Kelloggs","Kelloggs","Kelloggs","Kelloggs","Kelloggs","Kelloggs","Kelloggs","Kelloggs","Kelloggs","Kelloggs","Kelloggs","Kelloggs","Kelloggs","Nabisco","Nabisco","Nabisco","Nabisco","Nabisco","Nabisco","Post","Post","Post","Post","Post","Post","Post","Post","Post","Quaker Oats","Quaker Oats","Quaker Oats","Quaker Oats","Quaker Oats","Quaker Oats","Quaker Oats","Quaker Oats","Ralston Purina","Ralston Purina","Ralston Purina","Ralston Purina","Ralston Purina","Ralston Purina","Ralston Purina","Ralston Purina"]],"container":"<table class=\"display\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>mfr<\/th>\n      <th>name<\/th>\n      <th>type<\/th>\n      <th>calories<\/th>\n      <th>protein<\/th>\n      <th>fat<\/th>\n      <th>sodium<\/th>\n      <th>fiber<\/th>\n      <th>carbo<\/th>\n      <th>sugars<\/th>\n      <th>potass<\/th>\n      <th>vitamins<\/th>\n      <th>shelf<\/th>\n      <th>weight<\/th>\n      <th>cups<\/th>\n      <th>rating<\/th>\n      <th>MFR_Name<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"dom":"Blfrtip","buttons":["copy","csv"],"columnDefs":[{"className":"dt-right","targets":[4,5,6,7,8,9,10,11,12,13,14,15,16]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->

### Investigate Pairs Plot

A pairs plot shows the intersection of all variables as (small and 
often difficult to read) scatterplots. This is useful for identifying quick
relationships of interest, for example, the relationship between the grams
of sugar per serving and the consumer report rating. 

Instead of plotting directly, here is the code for saving it as a PNG and a PDF. 
I personally like saving plots as PDFs because it is cleaner to zoom in and 
extract sections. 


```r
# Remove cereal label column "name" and duplicative column "MFR_Name"
png(file = "pairs_plot_cereal.png")
pairs(cereal[, - which(colnames(cereal) %in% c("name","MFR_Name"))])
dev.off()

pdf(file = "pairs_plot_cereal.pdf")
pairs(cereal[, - which(colnames(cereal) %in% c("name","MFR_Name"))])
dev.off()
```

Here is the intersection of interest zoomed in. Like a correlation plot, the 
diagonal is shown as the reference and each relationship is duplicated (you
can either look at the bottom triangle or the top triangle of a pairs plot). 

<img src = "sugar_rating_identified_on_pairs_plot.png" width = "600">

The slope is negative, which frankly, I didn't expect; In my mind a little
bit of sugar is good up to a point and then it gets to be too much later. The
critics disagree, they seems to dislike sugar all-around. 

### The Critics Hate Sugar

This plot shows the relationship of interest in more detail. The negative
correlation between sugar in cereal and the cereal's rating across the 7
manufacturers. 


```r
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

gg
```

![](Setup_R_with_Cereal_Example_files/figure-html/unnamed-chunk-5-1.png)<!-- -->

## 5) Reproducibility 

Ok, so why did I do all that work if I'm just using ggplot2 and Data Table and
RMarkdown?

Because now YOU can run this code too. 

1. Go to [my Cereal repo github](https://github.com/CR-Mercado/Cereal) and 
download the zip folder. 

<img src = "Instruction_Screenshots/Github_Download_Repo_Reproduce.png" 
width = "800">

2. Extract it somewhere (pretty much anywhere!); here I extract it to a 
totally different folder in my directory. 
<img src = "Instruction_Screenshots/entire_repo_saved_somewhere_new.png" 
width = 600> 

Notice the Renv folder
doesn't have the custom libraries (we'll restore those to prove reproducibility).

<img src = "Instruction_Screenshots/renv_without_custom_libraries.png"
width = 600> 

3. Open the R Project (notice it's portable and has the updated 
working directory). 

<img 
src = "Instruction_Screenshots/reproduced_R_Project_Cereal.png"
width = "600"> 

4. Then Restore the R Project 


```r
 # Run this in your copy of the R Project. 
renv::restore() 
```

<img src = "Instruction_Screenshots/reproduced_restore_packages.png"
width = "600">

5. And Voila, you can run this markdown file repeating the analysis with the
**exact** same package versions; the only thing left would be to get out 
of the operating system concerns using the virtualization items I mentioned above.

Thank you for reading! 

You can [follow me on LinkedIn](http://linkedin.com/in/crmercado) for more
data science, economics, R, GIS, and related notes. 



