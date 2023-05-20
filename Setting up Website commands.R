install.packages("blogdown")

blogdown::install_hugo()

install.packages("rtools")

install.packages("xfun")

blogdown::new_site(theme = "MarcusVirg/forty", 
                   sample = TRUE, 
                   theme_example = TRUE,            
                   empty_dirs = TRUE,            
                   to_yaml = TRUE)

