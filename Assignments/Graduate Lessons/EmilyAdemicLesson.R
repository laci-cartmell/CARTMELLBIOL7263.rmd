##  _____________________
##
## Script: Emily Ademic Lesson
##
## Purpose of script: Loops in R
##
## Author: Laci Cartmell
##
## Date Created: 2022-10-27
##
##
## _____________________
##
## Notes:
##   https://emadamic.github.io/AdamicBIOL7263/MyLesson/LoopLesson.html
##
## _____________________

## load the packages needed: 

for (i in 1:5) {
  # i is the index variable
  print(i)
}


all_my_favourite_things = c("bikes", "coffee", "brains")

for( one_thing in all_my_favourite_things ) {
  cat("\nI love", one_thing)
}

all_words = c("bikes", "biology", "coffee", "serendipity")
for (word in all_words){
  print(word)
  num_char = nchar(word)
  sentence = paste0("There are ", num_char,
  "in the word", word, ".")
  print(sentence)
}


all_nums = c(10,12,28,34,NA,NA,11,11)

even_nums = NULL
odd_nums = NULL
for(n in all_nums){
  if( (n %% 2) == 0){
    even_nums = c(even_nums, n)
  }  else{
      odd_nums = c(odd_nums, n)
    }
}
}  #end for big loop
