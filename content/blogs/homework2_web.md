---
categories:  
- ""    #the front matter should be like the one found in, e.g., blog2.md. It cannot be like the normal Rmd we used
- ""
date: "2021-09-30"
description: Investigating a flight database, and understanding the underlying themes across it  # the title that will show up once someone gets to this page
draft: false
image: h2_cover.png # save picture in \static\img\blogs. Acceptable formats= jpg, jpeg, or png . Your iPhone pics wont work

keywords: ""
slug: homework2_web # slug is the shorthand URL address... no spaces plz
title: Flights, flights, flights!
---



# Manipulating Dataframes to Investigate patterns in Flight departures and Arrives


## Problem 1: Use logical operators to find flights that:


```r
# Had an arrival delay of two or more hours (> 120 minutes)
summary(flights)
```

```
##       year          month             day           dep_time    sched_dep_time
##  Min.   :2013   Min.   : 1.000   Min.   : 1.00   Min.   :   1   Min.   : 106  
##  1st Qu.:2013   1st Qu.: 4.000   1st Qu.: 8.00   1st Qu.: 907   1st Qu.: 906  
##  Median :2013   Median : 7.000   Median :16.00   Median :1401   Median :1359  
##  Mean   :2013   Mean   : 6.549   Mean   :15.71   Mean   :1349   Mean   :1344  
##  3rd Qu.:2013   3rd Qu.:10.000   3rd Qu.:23.00   3rd Qu.:1744   3rd Qu.:1729  
##  Max.   :2013   Max.   :12.000   Max.   :31.00   Max.   :2400   Max.   :2359  
##                                                  NA's   :8255                 
##    dep_delay          arr_time    sched_arr_time   arr_delay       
##  Min.   : -43.00   Min.   :   1   Min.   :   1   Min.   : -86.000  
##  1st Qu.:  -5.00   1st Qu.:1104   1st Qu.:1124   1st Qu.: -17.000  
##  Median :  -2.00   Median :1535   Median :1556   Median :  -5.000  
##  Mean   :  12.64   Mean   :1502   Mean   :1536   Mean   :   6.895  
##  3rd Qu.:  11.00   3rd Qu.:1940   3rd Qu.:1945   3rd Qu.:  14.000  
##  Max.   :1301.00   Max.   :2400   Max.   :2359   Max.   :1272.000  
##  NA's   :8255      NA's   :8713                  NA's   :9430      
##    carrier              flight       tailnum             origin         
##  Length:336776      Min.   :   1   Length:336776      Length:336776     
##  Class :character   1st Qu.: 553   Class :character   Class :character  
##  Mode  :character   Median :1496   Mode  :character   Mode  :character  
##                     Mean   :1972                                        
##                     3rd Qu.:3465                                        
##                     Max.   :8500                                        
##                                                                         
##      dest              air_time        distance         hour      
##  Length:336776      Min.   : 20.0   Min.   :  17   Min.   : 1.00  
##  Class :character   1st Qu.: 82.0   1st Qu.: 502   1st Qu.: 9.00  
##  Mode  :character   Median :129.0   Median : 872   Median :13.00  
##                     Mean   :150.7   Mean   :1040   Mean   :13.18  
##                     3rd Qu.:192.0   3rd Qu.:1389   3rd Qu.:17.00  
##                     Max.   :695.0   Max.   :4983   Max.   :23.00  
##                     NA's   :9430                                  
##      minute        time_hour                     
##  Min.   : 0.00   Min.   :2013-01-01 05:00:00.00  
##  1st Qu.: 8.00   1st Qu.:2013-04-04 13:00:00.00  
##  Median :29.00   Median :2013-07-03 10:00:00.00  
##  Mean   :26.23   Mean   :2013-07-03 05:22:54.64  
##  3rd Qu.:44.00   3rd Qu.:2013-10-01 07:00:00.00  
##  Max.   :59.00   Max.   :2013-12-31 23:00:00.00  
## 
```

```r
flights %>% 
  filter(arr_delay >= 120)
```

```
## # A tibble: 10,200 × 19
##     year month   day dep_time sched_dep_time dep_delay arr_time sched_arr_time
##    <int> <int> <int>    <int>          <int>     <dbl>    <int>          <int>
##  1  2013     1     1      811            630       101     1047            830
##  2  2013     1     1      848           1835       853     1001           1950
##  3  2013     1     1      957            733       144     1056            853
##  4  2013     1     1     1114            900       134     1447           1222
##  5  2013     1     1     1505           1310       115     1638           1431
##  6  2013     1     1     1525           1340       105     1831           1626
##  7  2013     1     1     1549           1445        64     1912           1656
##  8  2013     1     1     1558           1359       119     1718           1515
##  9  2013     1     1     1732           1630        62     2028           1825
## 10  2013     1     1     1803           1620       103     2008           1750
## # ℹ 10,190 more rows
## # ℹ 11 more variables: arr_delay <dbl>, carrier <chr>, flight <int>,
## #   tailnum <chr>, origin <chr>, dest <chr>, air_time <dbl>, distance <dbl>,
## #   hour <dbl>, minute <dbl>, time_hour <dttm>
```

```r
# Flew to Houston (IAH or HOU)

flights %>% 
  filter(dest == "TAH" | dest == "HOU")
```

```
## # A tibble: 2,115 × 19
##     year month   day dep_time sched_dep_time dep_delay arr_time sched_arr_time
##    <int> <int> <int>    <int>          <int>     <dbl>    <int>          <int>
##  1  2013     1     1     1208           1158        10     1540           1502
##  2  2013     1     1     1306           1300         6     1622           1610
##  3  2013     1     1     1708           1700         8     2037           2005
##  4  2013     1     1     2030           2035        -5     2354           2342
##  5  2013     1     2      734            700        34     1045           1025
##  6  2013     1     2     1156           1158        -2     1517           1502
##  7  2013     1     2     1319           1305        14     1633           1615
##  8  2013     1     2     1810           1655        75     2146           2000
##  9  2013     1     2     2031           2035        -4     2353           2342
## 10  2013     1     3      704            700         4     1036           1025
## # ℹ 2,105 more rows
## # ℹ 11 more variables: arr_delay <dbl>, carrier <chr>, flight <int>,
## #   tailnum <chr>, origin <chr>, dest <chr>, air_time <dbl>, distance <dbl>,
## #   hour <dbl>, minute <dbl>, time_hour <dttm>
```

```r
# Were operated by United (`UA`), American (`AA`), or Delta (`DL`)

flights %>% 
  filter(carrier == "UA" | carrier == "AA" | carrier == "DL")
```

```
## # A tibble: 139,504 × 19
##     year month   day dep_time sched_dep_time dep_delay arr_time sched_arr_time
##    <int> <int> <int>    <int>          <int>     <dbl>    <int>          <int>
##  1  2013     1     1      517            515         2      830            819
##  2  2013     1     1      533            529         4      850            830
##  3  2013     1     1      542            540         2      923            850
##  4  2013     1     1      554            600        -6      812            837
##  5  2013     1     1      554            558        -4      740            728
##  6  2013     1     1      558            600        -2      753            745
##  7  2013     1     1      558            600        -2      924            917
##  8  2013     1     1      558            600        -2      923            937
##  9  2013     1     1      559            600        -1      941            910
## 10  2013     1     1      559            600        -1      854            902
## # ℹ 139,494 more rows
## # ℹ 11 more variables: arr_delay <dbl>, carrier <chr>, flight <int>,
## #   tailnum <chr>, origin <chr>, dest <chr>, air_time <dbl>, distance <dbl>,
## #   hour <dbl>, minute <dbl>, time_hour <dttm>
```

```r
# Departed in summer (July, August, and September)
  
flights %>% 
  filter(month == 7 | month == 8 | month == 9)
```

```
## # A tibble: 86,326 × 19
##     year month   day dep_time sched_dep_time dep_delay arr_time sched_arr_time
##    <int> <int> <int>    <int>          <int>     <dbl>    <int>          <int>
##  1  2013     7     1        1           2029       212      236           2359
##  2  2013     7     1        2           2359         3      344            344
##  3  2013     7     1       29           2245       104      151              1
##  4  2013     7     1       43           2130       193      322             14
##  5  2013     7     1       44           2150       174      300            100
##  6  2013     7     1       46           2051       235      304           2358
##  7  2013     7     1       48           2001       287      308           2305
##  8  2013     7     1       58           2155       183      335             43
##  9  2013     7     1      100           2146       194      327             30
## 10  2013     7     1      100           2245       135      337            135
## # ℹ 86,316 more rows
## # ℹ 11 more variables: arr_delay <dbl>, carrier <chr>, flight <int>,
## #   tailnum <chr>, origin <chr>, dest <chr>, air_time <dbl>, distance <dbl>,
## #   hour <dbl>, minute <dbl>, time_hour <dttm>
```

```r
# Arrived more than two hours late, but didn't leave late

flights %>% 
  filter(arr_delay >= 120 & dep_delay <= 0)
```

```
## # A tibble: 29 × 19
##     year month   day dep_time sched_dep_time dep_delay arr_time sched_arr_time
##    <int> <int> <int>    <int>          <int>     <dbl>    <int>          <int>
##  1  2013     1    27     1419           1420        -1     1754           1550
##  2  2013    10     7     1350           1350         0     1736           1526
##  3  2013    10     7     1357           1359        -2     1858           1654
##  4  2013    10    16      657            700        -3     1258           1056
##  5  2013    11     1      658            700        -2     1329           1015
##  6  2013     3    18     1844           1847        -3       39           2219
##  7  2013     4    17     1635           1640        -5     2049           1845
##  8  2013     4    18      558            600        -2     1149            850
##  9  2013     4    18      655            700        -5     1213            950
## 10  2013     5    22     1827           1830        -3     2217           2010
## # ℹ 19 more rows
## # ℹ 11 more variables: arr_delay <dbl>, carrier <chr>, flight <int>,
## #   tailnum <chr>, origin <chr>, dest <chr>, air_time <dbl>, distance <dbl>,
## #   hour <dbl>, minute <dbl>, time_hour <dttm>
```

```r
# Were delayed by at least an hour, but made up over 30 minutes in flight

flights %>% 
  filter(dep_delay >= 60 & dep_delay - arr_delay >=30)
```

```
## # A tibble: 2,074 × 19
##     year month   day dep_time sched_dep_time dep_delay arr_time sched_arr_time
##    <int> <int> <int>    <int>          <int>     <dbl>    <int>          <int>
##  1  2013     1     1     1716           1545        91     2140           2039
##  2  2013     1     1     2205           1720       285       46           2040
##  3  2013     1     1     2326           2130       116      131             18
##  4  2013     1     3     1503           1221       162     1803           1555
##  5  2013     1     3     1821           1530       171     2131           1910
##  6  2013     1     3     1839           1700        99     2056           1950
##  7  2013     1     3     1850           1745        65     2148           2120
##  8  2013     1     3     1923           1815        68     2036           1958
##  9  2013     1     3     1941           1759       102     2246           2139
## 10  2013     1     3     1950           1845        65     2228           2227
## # ℹ 2,064 more rows
## # ℹ 11 more variables: arr_delay <dbl>, carrier <chr>, flight <int>,
## #   tailnum <chr>, origin <chr>, dest <chr>, air_time <dbl>, distance <dbl>,
## #   hour <dbl>, minute <dbl>, time_hour <dttm>
```

## Problem 2: What months had the highest and lowest proportion of cancelled flights? Interpret any seasonal patterns. To determine if a flight was cancelled use the following code

<!-- -->

```         
flights %>% 
  filter(is.na(dep_time)) 
```


```r
# What months had the highest and lowest % of cancelled flights?
# Calculate the total number of flights and cancelled flights for each month
flights_summary <- flights %>%
  group_by(year, month) %>%
  summarise(total_flights = n(), cancelled_flights = sum(is.na(dep_time)))
```

```
## `summarise()` has grouped output by 'year'. You can override using the
## `.groups` argument.
```

```r
# Calculate the proportion of cancelled flights for each month
flights_summary <- flights_summary %>%
  mutate(prop_cancelled = cancelled_flights / total_flights)

# Determine the months with the highest and lowest proportion of cancelled flights
highest_prop_cancelled <- flights_summary %>% 
  arrange(desc(prop_cancelled)) %>% 
  slice(1)

lowest_prop_cancelled <- flights_summary %>% 
  arrange(prop_cancelled) %>% 
  slice(1)

# Interpret any seasonal patterns in the data
# You can create a bar plot to visualize the proportion of cancelled flights across different months:

library(ggplot2)   # load the ggplot2 package

ggplot(flights_summary, aes(x = month, y = prop_cancelled)) +
  geom_bar(stat = "identity") +
  xlab("Month") +
  ylab("Proportion of cancelled flights") +
  ggtitle("Proportion of cancelled flights by month")
```

<img src="/blogs/homework2_web_files/figure-html/problem-2-1.png" width="672" />

There appears to be no consistent pattern in the proportion of cancelled flights across the year, however, very qualitative assumptions can be made from the following graph. It must be remembered that additional analysis is required to confirm these assumptions.

The months that appear to have the highest proportion of cancellations are February, June, July and December.

December is likely to have increased cancellations due to winter weather. February is often a stormy month in many countries. For example, this is seen particularly in the US as this is when their own Winter storms occur, such as the recent Winter Storm Olive.

June and July are likely to have a higher proportion of cancellations and this is a very busy time for flying, with it being the start of summer. Airlines will often be at capacity during this period, and increase strain will likely increase the proportion of issues and therefore cancellations.

## Problem 3: What plane (specified by the `tailnum` variable) traveled the most times from New York City airports in 2013? Please `left_join()` the resulting table with the table `planes` (also included in the `nycflights13` package).

For the plane with the greatest number of flights and that had more than 50 seats, please create a table where it flew to during 2013.


```r
top_plane_tailnum <- planes %>%
  filter(seats > 50) %>%
  select(tailnum) %>%
  left_join(flights, by = "tailnum") %>%
  filter(year == 2013, origin %in% c("LGA", "JFK", "EWR")) %>%
  group_by(tailnum) %>%
  summarise(num_flights = n()) %>%
  filter(num_flights == max(num_flights)) %>%
  pull(tailnum)

top_plane_tailnum
```

```
## [1] "N328AA"
```

```r
top_plane_routes <- flights %>%
  filter(year == 2013, tailnum == top_plane_tailnum) %>%
  group_by(dest) %>%
  summarise(num_flights = n()) %>%
  arrange(desc(num_flights))

top_plane_routes
```

```
## # A tibble: 6 × 2
##   dest  num_flights
##   <chr>       <int>
## 1 LAX           313
## 2 SFO            52
## 3 MIA            25
## 4 BOS             1
## 5 MCO             1
## 6 SJU             1
```

N328AA (an American Airlines Boeing 767-223ER) is the plane with the greatest number of flights from NYC airports in 2013.

## Problem 4: The `nycflights13` package includes a table (`weather`) that describes the weather during 2013. Use that table to answer the following questions:

**What is the distribution of temperature (\`temp\`) in July 2013? Identify any important outliers in terms of the \`wind_speed\` variable.**


```r
weather
```

```
## # A tibble: 26,115 × 15
##    origin  year month   day  hour  temp  dewp humid wind_dir wind_speed
##    <chr>  <int> <int> <int> <int> <dbl> <dbl> <dbl>    <dbl>      <dbl>
##  1 EWR     2013     1     1     1  39.0  26.1  59.4      270      10.4 
##  2 EWR     2013     1     1     2  39.0  27.0  61.6      250       8.06
##  3 EWR     2013     1     1     3  39.0  28.0  64.4      240      11.5 
##  4 EWR     2013     1     1     4  39.9  28.0  62.2      250      12.7 
##  5 EWR     2013     1     1     5  39.0  28.0  64.4      260      12.7 
##  6 EWR     2013     1     1     6  37.9  28.0  67.2      240      11.5 
##  7 EWR     2013     1     1     7  39.0  28.0  64.4      240      15.0 
##  8 EWR     2013     1     1     8  39.9  28.0  62.2      250      10.4 
##  9 EWR     2013     1     1     9  39.9  28.0  62.2      260      15.0 
## 10 EWR     2013     1     1    10  41    28.0  59.6      260      13.8 
## # ℹ 26,105 more rows
## # ℹ 5 more variables: wind_gust <dbl>, precip <dbl>, pressure <dbl>,
## #   visib <dbl>, time_hour <dttm>
```

```r
weather %>%
  filter(month == 7, year == 2013) %>%
  ggplot(aes(x = temp)) +
  geom_histogram(binwidth = 1, fill = "lightblue") +
  labs(title = "Temperature Distribution in July 2013",
       x = "Temperature (F)", y = "Count")
```

<img src="/blogs/homework2_web_files/figure-html/unnamed-chunk-5-1.png" width="672" />

From the plot, we can see that the distribution of temperature is roughly normal, with a peak around 80 degrees Fahrenheit. There are a few outliers with very high wind speeds, which we can identify using a scatter plot of temperature against wind speed:


```r
weather %>%
  filter(month == 7, year == 2013) %>%
  ggplot(aes(x = temp, y = wind_speed)) +
  geom_point() +
  labs(title = "Temperature vs. Wind Speed in July 2013",
       x = "Temperature (F)", y = "Wind Speed (mph)")
```

```
## Warning: Removed 2 rows containing missing values (`geom_point()`).
```

<img src="/blogs/homework2_web_files/figure-html/unnamed-chunk-6-1.png" width="672" />

We can see that there are a few points with very high wind speeds (\> 22.5 mph). These points could be considered outliers in terms of the wind speed variable.

**- What is the relationship between \`dewp\` and \`humid\`?**


```r
weather %>%
  ggplot(aes(x = dewp, y = humid)) +
  geom_point(alpha = 0.2) +
  labs(title = "Relationship between Dew Point and Humidity",
       x = "Dew Point (F)", y = "Humidity (%)")
```

```
## Warning: Removed 1 rows containing missing values (`geom_point()`).
```

<img src="/blogs/homework2_web_files/figure-html/unnamed-chunk-7-1.png" width="672" />

We can see that there is a strong positive relationship between **`dewp`** and **`humid`**. As the dew point temperature increases, the humidity also tends to increase.

**- What is the relationship between \`precip\` and \`visib\`?**


```r
weather %>%
  ggplot(aes(x = precip, y = visib)) +
  geom_point(alpha = 0.2) +
  labs(title = "Relationship between Precipitation and Visibility",
       x = "Precipitation (inches)", y = "Visibility (miles)")
```

<img src="/blogs/homework2_web_files/figure-html/unnamed-chunk-8-1.png" width="672" />

Although it would be plausible to think that higher precipitation will lead to lower visibility, there does not seem to be a strong relationship between the two, as seen through the large variety in visibility at similar levels of precipitation.

## Problem 5: Use the `flights` and `planes` tables to answer the following questions

**- How many planes have a missing date of manufacture?**


```r
planes
```

```
## # A tibble: 3,322 × 9
##    tailnum  year type              manufacturer model engines seats speed engine
##    <chr>   <int> <chr>             <chr>        <chr>   <int> <int> <int> <chr> 
##  1 N10156   2004 Fixed wing multi… EMBRAER      EMB-…       2    55    NA Turbo…
##  2 N102UW   1998 Fixed wing multi… AIRBUS INDU… A320…       2   182    NA Turbo…
##  3 N103US   1999 Fixed wing multi… AIRBUS INDU… A320…       2   182    NA Turbo…
##  4 N104UW   1999 Fixed wing multi… AIRBUS INDU… A320…       2   182    NA Turbo…
##  5 N10575   2002 Fixed wing multi… EMBRAER      EMB-…       2    55    NA Turbo…
##  6 N105UW   1999 Fixed wing multi… AIRBUS INDU… A320…       2   182    NA Turbo…
##  7 N107US   1999 Fixed wing multi… AIRBUS INDU… A320…       2   182    NA Turbo…
##  8 N108UW   1999 Fixed wing multi… AIRBUS INDU… A320…       2   182    NA Turbo…
##  9 N109UW   1999 Fixed wing multi… AIRBUS INDU… A320…       2   182    NA Turbo…
## 10 N110UW   1999 Fixed wing multi… AIRBUS INDU… A320…       2   182    NA Turbo…
## # ℹ 3,312 more rows
```

```r
missingmanufacturedate <- planes %>% 
  filter(is.na(year)) %>% 
  count()

missingmanufacturedate
```

```
## # A tibble: 1 × 1
##       n
##   <int>
## 1    70
```

There are 70 planes with a missing date of manufacture.

**- What are the five most common manufacturers?**


```r
planes %>% 
  mutate(manufacturer = recode(manufacturer, `AIRBUS INDUSTRIE` = 'AIRBUS')) %>%
  count(manufacturer, sort = TRUE) %>% 
  head(5)
```

```
## # A tibble: 5 × 2
##   manufacturer          n
##   <chr>             <int>
## 1 BOEING             1630
## 2 AIRBUS              736
## 3 BOMBARDIER INC      368
## 4 EMBRAER             299
## 5 MCDONNELL DOUGLAS   120
```

The five most common manufacturers are Boeing, McDonnell Douglas, Bombardier, Airbus and Embraer.

**- Has the distribution of manufacturer changed over time as reflected by the airplanes flying from NYC in 2013? (Hint: you may need to use case_when() to recode the manufacturer name and collapse rare vendors into a category called Other.)\
**


```r
tailnums_from_NYC <- flights %>%
  filter(origin %in% c("LGA", "JFK", "EWR")) %>%
  distinct(tailnum) %>%
  rename(tailnum = tailnum)

planes_dept_nyc <- left_join(tailnums_from_NYC, planes, by = "tailnum") %>%
  select(tailnum, manufacturer, year)

planes_dept_nyc <- planes_dept_nyc %>%
  mutate(manufacturer = case_when(
    manufacturer %in% c("AIRBUS INDUSTRIE", "AIRBUS") ~ "AIRBUS",
    manufacturer %in% c("MCDONNELL DOUGLAS", "MCDONNELL DOUGLAS AIRCRAFT CO", "MCDONNELL DOUGLAS CORPORATION") ~ "MCDONNELL",
    manufacturer == "BOEING" ~ "BOEING",
    manufacturer == "EMBRAER" ~ "EMBRAER",
    manufacturer == "BOMBARDIER" ~ "BOMBARDIER",
    TRUE ~ "OTHER"
  )) %>%

  group_by(year, manufacturer) %>%
  summarise(planes_manufactured = n()) %>%
  arrange(desc(planes_manufactured))
```

```
## `summarise()` has grouped output by 'year'. You can override using the
## `.groups` argument.
```

```r
ggplot(planes_dept_nyc, aes(x = year, y = planes_manufactured, color = manufacturer)) +
  geom_line(size = 2, alpha = 0.7) +
  scale_y_continuous(limits = c(0, 150)) +
  theme_minimal() +
  labs(title = "Number of Planes from each Manufacturer over Time")
```

```
## Warning: Using `size` aesthetic for lines was deprecated in ggplot2 3.4.0.
## ℹ Please use `linewidth` instead.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

```
## Warning: Removed 5 rows containing missing values (`geom_line()`).
```

<img src="/blogs/homework2_web_files/figure-html/unnamed-chunk-11-1.png" width="672" />

Over time, less popular plane manufacters such as Embraer and McDonnell have fallen into obscurity. Although the market became more fragmented prior to 2010, it is clear now that the market is mainly consolidated between Airbus and Boeing.

## Problem 6: Use the `flights` and `planes` tables to answer the following questions:

```         
-   What is the oldest plane (specified by the tailnum variable) that flew from New York City airports in 2013?
-   How many airplanes that flew from New York City are included in the planes table?
```

N381AA is the oldest plane that flew from NYC airports in 2013


```r
# What is the oldest plane (specified by the tailnum variable) that flew from New York City airports in 2013?
flights %>% 
  filter(year == 2013, origin %in% c("JFK", "LGA", "EWR")) %>% 
  select(tailnum) %>% 
  distinct() %>% 
  left_join(planes %>% 
              select(tailnum, year) %>% 
              group_by(tailnum) %>% 
              summarise(min_year = min(year, na.rm = TRUE)), 
            by = "tailnum") %>% 
  arrange(min_year) %>% 
  slice_head(n = 1)
```

```
## Warning: There were 70 warnings in `summarise()`.
## The first warning was:
## ℹ In argument: `min_year = min(year, na.rm = TRUE)`.
## ℹ In group 187: `tailnum = "N14558"`.
## Caused by warning in `min()`:
## ! no non-missing arguments to min; returning Inf
## ℹ Run `dplyr::last_dplyr_warnings()` to see the 69 remaining warnings.
```

```
## # A tibble: 1 × 2
##   tailnum min_year
##   <chr>      <dbl>
## 1 N381AA      1956
```

```r
# How many airplanes that flew from New York City are included in the planes table?
flights %>% 
  filter(origin %in% c("JFK", "LGA", "EWR")) %>% 
  select(tailnum) %>% 
  distinct() %>% 
  left_join(planes %>% 
              select(tailnum) %>% 
              distinct(), 
            by = "tailnum") %>% 
  count()
```

```
## # A tibble: 1 × 1
##       n
##   <int>
## 1  4044
```

4044 planes that flew from NYC are included in the planes table.

## Problem 7: Use the `nycflights13` to answer the following questions:

```         
-   What is the median arrival delay on a month-by-month basis in each airport?
-   For each airline, plot the median arrival delay for each month and origin airport.
```

**- What is the median arrival delay on a month-by-month basis in each airport?**


```r
flights %>%
  group_by(month, origin) %>%
  summarise(median_arr_delay = median(arr_delay, na.rm = TRUE))
```

```
## `summarise()` has grouped output by 'month'. You can override using the
## `.groups` argument.
```

```
## # A tibble: 36 × 3
## # Groups:   month [12]
##    month origin median_arr_delay
##    <int> <chr>             <dbl>
##  1     1 EWR                   0
##  2     1 JFK                  -7
##  3     1 LGA                  -4
##  4     2 EWR                  -2
##  5     2 JFK                  -5
##  6     2 LGA                  -4
##  7     3 EWR                  -4
##  8     3 JFK                  -7
##  9     3 LGA                  -7
## 10     4 EWR                  -1
## # ℹ 26 more rows
```

**- For each airline, plot the median arrival delay for each month and origin airport.**


```r
flights %>%
  group_by(carrier, month, origin) %>%
  summarise(median_arr_delay = median(arr_delay, na.rm = TRUE)) %>%
  ggplot(aes(x = month, y = median_arr_delay, color = origin)) +
  geom_line() +
  facet_wrap(~ carrier, scales = "free_y")
```

```
## `summarise()` has grouped output by 'carrier', 'month'. You can override using
## the `.groups` argument.
```

<img src="/blogs/homework2_web_files/figure-html/unnamed-chunk-14-1.png" width="672" />

## Problem 8: Let's take a closer look at what carriers service the route to San Francisco International (SFO). Join the `flights` and `airlines` tables and count which airlines flew the most to SFO. Produce a new dataframe, `fly_into_sfo` that contains three variables: the `name` of the airline, e.g., `United Air Lines Inc.` not `UA`, the count (number) of times it flew to SFO, and the `percent` of the trips that that particular airline flew to SFO.


```r
# Join flights and airlines tables
fly_sfo <- flights %>%
  filter(dest == "SFO") %>%
  left_join(airlines, by = "carrier") 

# Count flights by airline
fly_into_sfo <- fly_sfo %>%
  group_by(name) %>%
  summarise(count = n()) %>%
  arrange(desc(count)) %>%
  mutate(percent = round((count/sum(count))*100, 2))

# View fly_into_sfo dataframe
fly_into_sfo
```

```
## # A tibble: 5 × 3
##   name                   count percent
##   <chr>                  <int>   <dbl>
## 1 United Air Lines Inc.   6819   51.2 
## 2 Virgin America          2197   16.5 
## 3 Delta Air Lines Inc.    1858   13.9 
## 4 American Airlines Inc.  1422   10.7 
## 5 JetBlue Airways         1035    7.76
```

And here is some bonus ggplot code to plot the dataframe:


```r
fly_into_sfo %>% 
  
  # sort 'name' of airline by the numbers it times to flew to SFO
  mutate(name = fct_reorder(name, count)) %>% 
  
  ggplot() +
  
  aes(x = count, 
      y = name) +
  
  # a simple bar/column plot
  geom_col() +
  
  # add labels, so each bar shows the % of total flights 
  geom_text(aes(label = percent),
             hjust = 1, 
             colour = "white", 
             size = 5)+
  
  # add labels to help our audience  
  labs(title="Which airline dominates the NYC to SFO route?", 
       subtitle = "as % of total flights in 2013",
       x= "Number of flights",
       y= NULL) +
  
  theme_minimal() + 
  
  # change the theme-- i just googled those , but you can use the ggThemeAssist add-in
  # https://cran.r-project.org/web/packages/ggThemeAssist/index.html
  
  theme(#
    # so title is left-aligned
    plot.title.position = "plot",
    
    # text in axes appears larger        
    axis.text = element_text(size=12),
    
    # title text is bigger
    plot.title = element_text(size=18)
      ) +

  # add one final layer of NULL, so if you comment out any lines
  # you never end up with a hanging `+` that awaits another ggplot layer
  NULL
```

<img src="/blogs/homework2_web_files/figure-html/ggplot-flights-toSFO-1.png" width="672" />
