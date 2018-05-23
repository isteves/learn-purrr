library(tidyverse)

#purrr - aesthetic choice
#send hadley slide


# map("object with elements", "what to do with each element", "parameters")

map(mtcars, mean, na.rm = TRUE)

map_chr(mtcars, class)

# define your output with map_CLASS

map_df(mtcars, mean, na.rm = TRUE)

# map2(list1, list2, ~function(.x,.y), ...)

map2_chr(c("one", "two", "red", "blue"),
         c("fish"),
         paste)

pmap_chr(list(c("one", "two", "red", "blue"),
              c("fish"),
              c("!", "?", ".", "...")),
         paste)

sentence <- function(a, b, c) {
  paste("I saw", a, b, "yesterday", c)
}

pmap_chr(list(c("one", "two", "red", "blue"),
              c("fish"),
              c("!", "?", ".", "...")),
         sentence)

# most R users come from Excel background...
# R = fancy excel
# once you start using purrr/lists, you can start to shift that paradigm and harness the flexibility of R

# hmm...
data(got_chars)
got_chars[1:5] %>%
  map(`[`, c('name', 'allegiances')) #equivalent of calling `[` as a fxn [[1]]

got_chars %>%
  purrr::set_names(map_chr(., 'name')) %>% #good for naming lists!
  map(`[`, c("name", "allegiances")) %>%
  purrr::keep(~stringr::str_detect(.$name, 'Lannister'))
  #keep = list equivalent of filter
  #~ = indicates anonymous fxn

got_list <- got_chars %>%
  map(`[`, c('name', 'aliases', 'allegiances', 'born'))

#throws an error...
# got_list <- got_chars %>% {
#   list(
#     name = map_chr(., 'name'),
#     aliases = map_chr(., 'aliases'),
#     allegiances = map_chr(., 'allegiances'),
#     born = map_chr(., 'born')
#   )
# }

# debugging using `safely`
# in loop - it's easy to see where it failed and why

safe_log <- safely(log) #wrapper on fxn you're trying to use

diagnose_length <- length_data %>%
  map(~safe_log(.$lengths))

head(diagnose_length)

# now use purrr to figure out which tech was annoying

bad_lengths <- map_lgl(diagnose_length, ~!is.null(.x$error))
# use keep on this to check out which techs were bad

# add browse() to a fxn

# nesting - accordian effect

nest(mtcars, -mpg)

# tibble - nice, neat housing for anything; you can go bonkers inside!



