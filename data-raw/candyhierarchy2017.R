## code to prepare `candyhierarchy2017` dataset goes here
# Source file can be found in
# https://boingboing.net/2017/10/30/the-2017-halloween-candy-hiera.html

candyhierarchy2017 <- readr::read_csv(
  file = "raw-data/candyhierarchy2017.csv", locale = readr::locale(encoding = 'ISO-8859-1'))

candyhierarchy_localities <- candyhierarchy2017$`Q5: STATE, PROVINCE, COUNTY, ETC`
usethis::use_data(candyhierarchy_localities)
