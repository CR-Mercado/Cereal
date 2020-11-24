---
title: "Setup_R_Cereal_Example"
author: "Carlos Mercado"
date: "November 24, 2020"
output:
  html_document:
    keep_md: yes
---



# Step 0: Setting up R

The statistical programming language R is great for quick analysis with 
minimal headaches. You can download R and R Studio, install packages 
directly from CRAN and be off to the races within minutes. 

Unfortunately, this isn't always amenable to good science that is reproducible. 
So this document shows a quick R Setup using R Projects, Github for Desktop,
and the renv package to have a true first step for reproducible analysis. 

### 1) Programs 

I recommend the following programs: 

- [Github for Desktop](https://desktop.github.com/)
- [R (I use 4.0.3)](https://cran.r-project.org/bin/windows/base/)
- [RStudio](https://rstudio.com/products/rstudio/download/)

### 2) File Folders 

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
<img src="Instruction_Screenshots/Associate_RProj_with_Git_Repo.png" width = "600">

### 3) Package Management 

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

This will change your library paths to an new library and also update 
your git repo to strategically ignore and commit files that ensure 
packages can be tracked. 


```r
.libPaths()
```

```
## [1] "C:/Users/carlo/Documents/Messing with R/Cereal/renv/library/R-4.0/x86_64-w64-mingw32"
## [2] "C:/Users/carlo/AppData/Local/Temp/RtmpYlFXCw/renv-system-library"
```

<img src = "Instruction_Screenshots/Renv_self_commits_relevant_files.png" width = "400">


2. Now, when you install packages relevant to your analysis, renv will
track the packages and their versions while installing their dependencies. 

Here I **snapshot** my current packages in use and renv identifies that 
I have a bunch of packages not yet in my lock file (you may notice
these packages are the packages for creating R Markdown documents like this one!)

<img src = "Instruction_Screenshots/Renv_snapshot_updates_lockfile.png" width = "400">

