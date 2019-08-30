# clnr
clnr is the collection of experiments for a complete R package in order to clean character(for now) vectors by clustering and merging similar ones. 

Inspired quite much from [open refine](http://openrefine.org/) project but aims to generalize and make cleaning tasks more reproducible. That being said, other types of data should be able to clean as well. 
Look at [refinr](https://github.com/ChrisMuir/refinr) package for only automated string cleaning 

## How is it useful?
Imagine we just have a new dataset just arrived and as usual first thing is to explore and clean the data.

```r
# Load example character vector from clnr
data(candyhierarchy_localities)
# See how many unique values 
unique(candyhierarchy_localities) %>% length()
# [1] 460
# See most common values
sort(table(candyhierarchy_localities), decreasing = TRUE) %>% head(5)
# candyhierarchy_localities
# California         CA   Illinois      Texas    Ontario 
#        153         89         68         63         59 
candyhierarchy_localities_cleaned <- clean(candyhierarchy_localities, ask_user = F)
# Main modifications are as following:
# # A tibble: 133 x 3
#    s          fingerprint final_value_to_keep
#    <chr>      <chr>       <chr>              
#  1 ca         ca          CA                 
#  2 california california  California         
#  3 ontario    ontario     Ontario            
#  4 Ca         ca          CA                 
#  5 ma         ma          MA                 
#  6 Ny         ny          NY                 
#  7 Wa         wa          WA                 
#  8 ny         ny          NY                 
#  9 wa         wa          WA                 
# 10 oregon     oregon      Oregon             
# # … with 123 more rows
unique(candyhierarchy_localities_cleaned) %>% length()
# See how many unique values 
# [1] 327
# See most common values
sort(table(candyhierarchy_localities_cleaned), decreasing = TRUE) %>% head(5)
# candyhierarchy_localities_cleaned
# California         CA    Ontario   Illinois      Texas 
#        171        128         79         72         71 
``` 

## Things to come:
- [x] Build initial version with simple functionality
- [ ] Create more fingerprint functions
- [ ] Ensure independency of dplyr
- [ ] Let user pass their own fingerprint functions
- [ ] Store combined texts as fingerprint functions so it can be used in the future easily for repro purpose
- [x] Better printing while getting user feedback
- [x] Log what has been done
- [ ] Brainstorming on Iterative vs. one shot perspective

Thanks for feedback and contribution 
