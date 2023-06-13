---
categories:  
- ""    #the front matter should be like the one found in, e.g., blog2.md. It cannot be like the normal Rmd we used
- ""
date: "2021-09-30"
description: Exploring Hollywood Love Interests using Movie Datasets  # the title that will show up once someone gets to this page
draft: false
image: h1_cover.png # save picture in \static\img\blogs. Acceptable formats= jpg, jpeg, or png . Your iPhone pics wont work

keywords: ""
slug: homework1_web
title: Love Imbalance in Hollywood
---



## The Hollywood Age Gap

Utilising the Hollywood Age Gap dataset, we can discover interesting facts and trends about how we view romantic relationships in movies, particularly over time. Firstly, we must import the dataset.


```r
age_gaps <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-02-14/age_gaps.csv')
```

```
## Rows: 1155 Columns: 13
## ── Column specification ────────────────────────────────────────────────────────
## Delimiter: ","
## chr  (6): movie_name, director, actor_1_name, actor_2_name, character_1_gend...
## dbl  (5): release_year, age_difference, couple_number, actor_1_age, actor_2_age
## date (2): actor_1_birthdate, actor_2_birthdate
## 
## ℹ Use `spec()` to retrieve the full column specification for this data.
## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
```

1.  **To explore the distribution of age differences between movie love interests, we can create a histogram or density plot of the age_difference variable. We can calculate summary statistics like mean, median, and standard deviation to get an idea of the typical age difference**

    
    ```r
    age_gaps <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-02-14/age_gaps.csv')
    ```
    
    ```
    ## Rows: 1155 Columns: 13
    ## ── Column specification ────────────────────────────────────────────────────────
    ## Delimiter: ","
    ## chr  (6): movie_name, director, actor_1_name, actor_2_name, character_1_gend...
    ## dbl  (5): release_year, age_difference, couple_number, actor_1_age, actor_2_age
    ## date (2): actor_1_birthdate, actor_2_birthdate
    ## 
    ## ℹ Use `spec()` to retrieve the full column specification for this data.
    ## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
    ```
    
    ```r
    # Histogram of age difference
    ggplot(age_gaps, aes(x = age_difference)) +
      geom_histogram(binwidth = 5, fill = 'blue') +
      labs(x = 'Age difference', y = 'Count', title = 'Distribution of Age Difference in Movies')
    ```
    
    <img src="/resume_files/figure-html/unnamed-chunk-3-1.png" width="672" />
    
    ```r
    # Summary statistics of age difference
    summary(age_gaps$age_difference)
    ```
    
    ```
    ##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    ##    0.00    4.00    8.00   10.42   15.00   52.00
    ```

    ![](images/paste-C7FA942C.png)

    When observing this data, it is clear that the most common age difference within movies is around 5-10 years. Although we see see some age differences ranging up to 50 years old, however, this is very uncommon.

2.  **We can apply the half plus seven rule to the dataset by calculating the age limits based on each character's age and see how frequently the age difference falls within the acceptable range.**

    
    ```r
    age_gaps <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-02-14/age_gaps.csv')
    ```
    
    ```
    ## Rows: 1155 Columns: 13
    ## ── Column specification ────────────────────────────────────────────────────────
    ## Delimiter: ","
    ## chr  (6): movie_name, director, actor_1_name, actor_2_name, character_1_gend...
    ## dbl  (5): release_year, age_difference, couple_number, actor_1_age, actor_2_age
    ## date (2): actor_1_birthdate, actor_2_birthdate
    ## 
    ## ℹ Use `spec()` to retrieve the full column specification for this data.
    ## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
    ```
    
    ```r
    # Compute minimum and maximum partner age according to the half plus seven rule
    min_partner_age <- age_gaps$actor_1_age / 2 + 7
    max_partner_age <- (age_gaps$actor_1_age - 7) * 2
    
    # Count how many times the rule applies
    sum(age_gaps$actor_2_age > min_partner_age & age_gaps$actor_2_age < max_partner_age)
    ```
    
    ```
    ## [1] 795
    ```
    
    ```r
    # Count how many times the rule does not apply
    sum(age_gaps$actor_2_age < min_partner_age & age_gaps$actor_2_age < max_partner_age)
    ```
    
    ```
    ## [1] 326
    ```
    
    ```r
    sum(age_gaps$actor_2_age < min_partner_age & age_gaps$actor_2_age > max_partner_age)
    ```
    
    ```
    ## [1] 0
    ```

    This occurs 795 times, however, there are many times in which the rule does not apply, for example, there are 326 occasions when the rule does not apply,.

3.  **We can identify the movie with the greatest number of love interests by grouping the data by movie_name and counting the number of unique couple_numbers.**

    
    ```r
    age_gaps <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-02-14/age_gaps.csv')
    ```
    
    ```
    ## Rows: 1155 Columns: 13
    ## ── Column specification ────────────────────────────────────────────────────────
    ## Delimiter: ","
    ## chr  (6): movie_name, director, actor_1_name, actor_2_name, character_1_gend...
    ## dbl  (5): release_year, age_difference, couple_number, actor_1_age, actor_2_age
    ## date (2): actor_1_birthdate, actor_2_birthdate
    ## 
    ## ℹ Use `spec()` to retrieve the full column specification for this data.
    ## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
    ```
    
    ```r
    # Summing of number of interests - using slice to get the answer from the descend order list.
    
    most_interests <- age_gaps %>% 
      group_by(movie_name) %>% 
      summarise(num_interests = n_distinct(couple_number)) %>% 
      arrange(desc(num_interests)) %>% 
      slice(1)
    
    most_interests
    ```
    
    ```
    ## # A tibble: 1 × 2
    ##   movie_name    num_interests
    ##   <chr>                 <int>
    ## 1 Love Actually             7
    ```

    The answer to this is Love Actually with 7 love interests. This is expected as this film follows various different characters and storylines, unlike typical movies which have a more focused, singular storyline.

4.  **We can identify the actors/actresses with the greatest number of love interests by grouping the data by actor_1\_name and actor_2\_name and counting the number of unique movie_names they appear in.**

    
    ```r
    age_gaps <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-02-14/age_gaps.csv')
    ```
    
    ```
    ## Rows: 1155 Columns: 13
    ## ── Column specification ────────────────────────────────────────────────────────
    ## Delimiter: ","
    ## chr  (6): movie_name, director, actor_1_name, actor_2_name, character_1_gend...
    ## dbl  (5): release_year, age_difference, couple_number, actor_1_age, actor_2_age
    ## date (2): actor_1_birthdate, actor_2_birthdate
    ## 
    ## ℹ Use `spec()` to retrieve the full column specification for this data.
    ## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
    ```
    
    ```r
    age_gaps %>%
      group_by(actor_1_name) %>%
      summarise(n_love_interests = n_distinct(movie_name)) %>%
      arrange(desc(n_love_interests)) %>%
      head(10)
    ```
    
    ```
    ## # A tibble: 10 × 2
    ##    actor_1_name      n_love_interests
    ##    <chr>                        <int>
    ##  1 Keanu Reeves                    20
    ##  2 Adam Sandler                    17
    ##  3 Harrison Ford                   12
    ##  4 Johnny Depp                     11
    ##  5 Leonardo DiCaprio               10
    ##  6 Richard Gere                    10
    ##  7 Brad Pitt                        9
    ##  8 Humphrey Bogart                  9
    ##  9 Sean Connery                     9
    ## 10 Tom Cruise                       9
    ```
    
    ```r
    age_gaps %>%
      group_by(actor_2_name) %>%
      summarise(n_love_interests = n_distinct(movie_name)) %>%
      arrange(desc(n_love_interests)) %>%
      head(10)
    ```
    
    ```
    ## # A tibble: 10 × 2
    ##    actor_2_name       n_love_interests
    ##    <chr>                         <int>
    ##  1 Scarlett Johansson               12
    ##  2 Emma Stone                       11
    ##  3 Keira Knightley                  10
    ##  4 Drew Barrymore                    9
    ##  5 Julia Roberts                     9
    ##  6 Amanda Seyfried                   8
    ##  7 Renee Zellweger                   8
    ##  8 Audrey Hepburn                    7
    ##  9 Emily Blunt                       7
    ## 10 Jennifer Aniston                  7
    ```

5.  **We can create a scatter plot of release_year against age_difference to see if the mean/median age difference stays constant over the years.**

    
    ```r
    # calculate mean and median age difference by release year
    age_diff_by_year <- age_gaps %>%
      group_by(release_year) %>%
      summarise(mean_age_diff = mean(age_difference), 
                median_age_diff = median(age_difference))
    
    # create line plots to visualize the trend over time
    ggplot(age_diff_by_year, aes(x = release_year)) +
      geom_line(aes(y = mean_age_diff, color = "Mean Age Difference")) +
      geom_line(aes(y = median_age_diff, color = "Median Age Difference")) +
      labs(title = "Mean and Median Age Difference by Release Year",
           x = "Release Year", y = "Age Difference in Years",
           color = "Statistic") +
      scale_color_manual(values = c("Mean Age Difference" = "blue", "Median Age Difference" = "red"))
    ```
    
    <img src="/resume_files/figure-html/unnamed-chunk-7-1.png" width="672" />

    It certainly does not stay constant over the years, and has even seen a high increase in both mean and median age difference in recent years.

6.  **We can filter the data by same-gender love interests and calculate the frequency of occurrence to see how often Hollywood depicts same-gender relationships.**

    
    ```r
    age_gaps <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-02-14/age_gaps.csv')
    ```
    
    ```
    ## Rows: 1155 Columns: 13
    ## ── Column specification ────────────────────────────────────────────────────────
    ## Delimiter: ","
    ## chr  (6): movie_name, director, actor_1_name, actor_2_name, character_1_gend...
    ## dbl  (5): release_year, age_difference, couple_number, actor_1_age, actor_2_age
    ## date (2): actor_1_birthdate, actor_2_birthdate
    ## 
    ## ℹ Use `spec()` to retrieve the full column specification for this data.
    ## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
    ```
    
    ```r
    age_gaps %>%
      filter(!is.na(character_1_gender), !is.na(character_2_gender)) %>%
      group_by(character_1_gender, character_2_gender) %>%
      summarise(n_movies = n_distinct(movie_name)) %>%
      mutate(total_movies = sum(n_movies)) %>%
      mutate(percentage = n_movies/total_movies*100) %>%
      select(character_1_gender, character_2_gender, n_movies, percentage) %>%
      arrange(desc(n_movies))
    ```
    
    ```
    ## `summarise()` has grouped output by 'character_1_gender'. You can override
    ## using the `.groups` argument.
    ```
    
    ```
    ## # A tibble: 4 × 4
    ## # Groups:   character_1_gender [2]
    ##   character_1_gender character_2_gender n_movies percentage
    ##   <chr>              <chr>                 <int>      <dbl>
    ## 1 man                woman                   717      98.5 
    ## 2 woman              man                     186      94.9 
    ## 3 man                man                      11       1.51
    ## 4 woman              woman                    10       5.10
    ```

It portrays same-sex love interests 6.61% of the time. This is very uncommon, however, when observing the data is appears it has become more common in recent years.
