# Create all needed lists of sets.
#
# Author: Maria Eckstein

output_dir = "/path/to/output"

library("permute")
library("combinat")

colors = c("b", "g", "r")
shapes = c("m", "s", "t")
fills  = c("d", "f", "l")

span0_SETs          = data.frame(Shape1 = NA, Shape2 = NA, Shape3 = NA)
span1_SETs          = data.frame(Shape1 = NA, Shape2 = NA, Shape3 = NA)
span2_SETs          = data.frame(Shape1 = NA, Shape2 = NA, Shape3 = NA)
span3_SETs          = data.frame(Shape1 = NA, Shape2 = NA, Shape3 = NA)
# span0_noSETs_1diff  = data.frame(Shape1 = NA, Shape2 = NA, Shape3 = NA)
span0_noSETs = data.frame(Shape1 = NA, Shape2 = NA, Shape3 = NA)
# span1_noSETs_1diff  = data.frame(Shape1 = NA, Shape2 = NA, Shape3 = NA)
span1_noSETs = data.frame(Shape1 = NA, Shape2 = NA, Shape3 = NA)
# span2_noSETs_1diff  = data.frame(Shape1 = NA, Shape2 = NA, Shape3 = NA)
span2_noSETs = data.frame(Shape1 = NA, Shape2 = NA, Shape3 = NA)
# span3_noSETs_1diff  = data.frame(Shape1 = NA, Shape2 = NA, Shape3 = NA)
span3_noSETs = data.frame(Shape1 = NA, Shape2 = NA, Shape3 = NA)

### Create all 0span SETs
row = 1
for (color in colors) {
  for (shape in shapes) {
    for (fill in fills) {
      item = paste(color, shape, fill, ".png", sep = "")
      span0_SETs[row,] = rep(item, 3)
      row = row + 1
    }
  }
}

### Create all 1span SETs
fill_permutations  = matrix(fills[allPerms(1:length(fills), how(observed = T))], ncol = length(fills))
shape_permutations = matrix(shapes[allPerms(1:length(shapes), how(observed = T))], ncol = length(shapes))
color_permutations = matrix(colors[allPerms(1:length(colors), how(observed = T))], ncol = length(colors))

row = 1
for (color in colors) {
  for (shape in shapes) {
    for (p_row in 1:nrow(fill_permutations)) {
      span1_SETs[row,] = paste(color, shape, fill_permutations[p_row,], ".png", sep = "")
      row = row + 1
    }
  }
}
for (fill in fills) {
  for (shape in shapes) {
    for (p_row in 1:nrow(color_permutations)) {
      span1_SETs[row,] = paste(color_permutations[p_row,], shape, fill, ".png", sep = "")
      row = row + 1
    }
  }
}
for (color in colors) {
  for (fill in fills) {
    for (p_row in 1:nrow(shape_permutations)) {
      span1_SETs[row,] = paste(color, shape_permutations[p_row,], fill, ".png", sep = "")
      row = row + 1
    }
  }
}

### Create all 3span SETs
row = 1
for (c_row in 1:nrow(color_permutations)) {
  for (s_row in 1:nrow(shape_permutations)) {
    for (f_row in 1:nrow(fill_permutations)) {
      span3_SETs[row,] = paste(color_permutations[c_row,], shape_permutations[s_row,], fill_permutations[f_row,], ".png", sep = "")
      row = row + 1
    }
  }
}

### Create all 2span SETs
row = 1
for (c_row in 1:nrow(color_permutations)) {
  for (s_row in 1:nrow(shape_permutations)) {
    for (fill in fills) {
      span2_SETs[row,] = paste(color_permutations[c_row,], shape_permutations[s_row,], fill, ".png", sep = "")
      row = row + 1
    }
  }
}
for (c_row in 1:nrow(color_permutations)) {
  for (shape in shapes) {
    for (f_row in 1:nrow(fill_permutations)) {
      span2_SETs[row,] = paste(color_permutations[c_row,], shape, fill_permutations[f_row,], ".png", sep = "")
      row = row + 1
    }
  }
}
for (color in colors) {
  for (s_row in 1:nrow(shape_permutations)) {
    for (f_row in 1:nrow(fill_permutations)) {
      span2_SETs[row,] = paste(color, shape_permutations[s_row,], fill_permutations[f_row,], ".png", sep = "")
      row = row + 1
    }
  }
}

### Create all 0span noSETs
row_2diff = 1
# row_1diff = 1
for (color in colors) {
  for (shape in shapes) {
    for (fill in fills) {
      
      # ITEM
      item = paste(color, shape, fill, ".png", sep = "")
      
      # ODDBALL DIFFERING ON 2 DIMENSIONS FROM MATCHING ITEM
      for (no_col in colors[colors != color]) {
        for (no_sha in shapes[shapes != shape]) {
          oddball = paste(no_col, no_sha, fill, ".png", sep = "")
          span0_noSETs[row_2diff,] = c(item, item, oddball)
          row_2diff = row_2diff + 1
        }
      }
      for (no_col in colors[colors != color]) {
        for (no_fil in fills[fills != fill]) {
          oddball = paste(no_col, shape, no_fil, ".png", sep = "")
          span0_noSETs[row_2diff,] = c(item, item, oddball)
          row_2diff = row_2diff + 1
        }
      }
      for (no_sha in shapes[shapes != shape]) {
        for (no_fil in fills[fills != fill]) {
          oddball = paste(color, no_sha, no_fil, ".png", sep = "")
          span0_noSETs[row_2diff,] = c(item, item, oddball)
          row_2diff = row_2diff + 1
        }
      }
      
#       # ODDBALL DIFFERING ON 1 DIMENSION FROM MATCHING ITEM
#       for (no_col in colors[colors != color]) {
#         oddball = paste(no_col, shape, fill, ".png", sep = "")
#         span0_noSETs_1diff[row_1diff,] = c(item, item, oddball)
#         row_1diff = row_1diff + 1
#       }
#       for (no_sha in shapes[shapes != shape]) {
#         oddball = paste(color, no_sha, fill, ".png", sep = "")
#         span0_noSETs_1diff[row_1diff,] = c(item, item, oddball)
#         row_1diff = row_1diff + 1
#       }
#       for (no_fil in fills[fills != fill]) {
#         oddball = paste(color, shape, no_fil, ".png", sep = "")
#         span0_noSETs_1diff[row_1diff,] = c(item, item, oddball)
#         row_1diff = row_1diff + 1
#       }
    }
  }
}

### Create all 1span noSETs
row_2diff = 1

for (color in colors) {
  for (shape in shapes) {
    for (p_row in 1:nrow(fill_permutations)) {
      item1 = paste(color, shape, fill_permutations[p_row,], ".png", sep = "")[1]
      item2 = paste(color, shape, fill_permutations[p_row,], ".png", sep = "")[2]
      # ODDBALL DIFFERING ON 2 DIMENSIONS FROM MATCHING ITEM (always differs on 1 matching and 1 spanning dimension)
      for (no_col in colors[colors != color]) {
        for (no_fil in fill_permutations[p_row,1:2]) {
          oddball = paste(no_col, shape, no_fil, ".png", sep = "")
          span1_noSETs[row_2diff,] = c(item1, item2, oddball)
          row_2diff = row_2diff + 1
        }
      }
      for (no_sha in shapes[shapes != shape]) {
        for (no_fil in fill_permutations[p_row,1:2]) {
          oddball = paste(color, no_sha, no_fil, ".png", sep = "")
          span1_noSETs[row_2diff,] = c(item1, item2, oddball)
          row_2diff = row_2diff + 1
        }
      }
    }
  }
}
for (fill in fills) {
  for (shape in shapes) {
    for (p_row in 1:nrow(color_permutations)) {
      item1 = paste(color_permutations[p_row,], shape, fill, ".png", sep = "")[1]
      item2 = paste(color_permutations[p_row,], shape, fill, ".png", sep = "")[2]
      # ODDBALL DIFFERING ON 2 DIMENSIONS FROM MATCHING ITEM (always differs on 1 matching and 1 spanning dimension)
      for (no_fil in fills[fills != fill]) {
        for (no_col in color_permutations[p_row,1:2]) {
          oddball = paste(no_col, shape, no_fil, ".png", sep = "")
          span1_noSETs[row_2diff,] = c(item1, item2, oddball)
          row_2diff = row_2diff + 1
        }
      }
      for (no_sha in shapes[shapes != shape]) {
        for (no_col in color_permutations[p_row,1:2]) {
          oddball = paste(no_col, no_sha, fill, ".png", sep = "")
          span1_noSETs[row_2diff,] = c(item1, item2, oddball)
          row_2diff = row_2diff + 1
        }
      }
    }
  }
}
for (color in colors) {
  for (fill in fills) {
    for (p_row in 1:nrow(shape_permutations)) {
      item1 = paste(color, shape_permutations[p_row,], fill, ".png", sep = "")[1]
      item2 = paste(color, shape_permutations[p_row,], fill, ".png", sep = "")[2]
      # ODDBALL DIFFERING ON 2 DIMENSIONS FROM MATCHING ITEM (always differs on 1 matching and 1 spanning dimension)
      for (no_col in colors[colors != color]) {
        for (no_sha in shape_permutations[p_row,1:2]) {
          oddball = paste(no_col, no_sha, fill, ".png", sep = "")
          span1_noSETs[row_2diff,] = c(item1, item2, oddball)
          row_2diff = row_2diff + 1
        }
      }
      for (no_fil in fills[fills != fill]) {
        for (no_sha in shape_permutations[p_row,1:2]) {
          oddball = paste(color, no_sha, no_fil, ".png", sep = "")
          span1_noSETs[row_2diff,] = c(item1, item2, oddball)
          row_2diff = row_2diff + 1
        }
      }
    }
  }
}

### Create all 3span noSETs
row = 1
for (c_row in 1:nrow(color_permutations)) {
  for (s_row in 1:nrow(shape_permutations)) {
    for (f_row in 1:nrow(fill_permutations)) {
      item1 = paste(color_permutations[c_row,], shape_permutations[s_row,], fill_permutations[f_row,], ".png", sep = "")[1]
      item2 = paste(color_permutations[c_row,], shape_permutations[s_row,], fill_permutations[f_row,], ".png", sep = "")[2]
      
      for (no_sha in shape_permutations[s_row,1:2]) {
        for (no_fil in fill_permutations[f_row,1:2]) {
          oddball = paste(color_permutations[c_row,3], no_sha, no_fil, ".png", sep = "")
          span3_noSETs[row,] = c(item1, item2, oddball)
          row = row + 1
        }
      }
      for (no_col in color_permutations[c_row,1:2]) {
        for (no_fil in fill_permutations[f_row,1:2]) {
          oddball = paste(no_col, shape_permutations[s_row,3], no_fil, ".png", sep = "")
          span3_noSETs[row,] = c(item1, item2, oddball)
          row = row + 1
        }
      }
      for (no_sha in shape_permutations[s_row,1:2]) {
        for (no_col in color_permutations[c_row,1:2]) {
          oddball = paste(no_col, no_sha, fill_permutations[f_row,3], ".png", sep = "")
          span3_noSETs[row,] = c(item1, item2, oddball)
          row = row + 1
        }
      }
    }
  }
}

### Create all 2span SETs
row = 1
for (c_row in 1:nrow(color_permutations)) {
  for (s_row in 1:nrow(shape_permutations)) {
    for (fill in fills) {
      item1 = paste(color_permutations[c_row,], shape_permutations[s_row,], fill, ".png", sep = "")[1]
      item2 = paste(color_permutations[c_row,], shape_permutations[s_row,], fill, ".png", sep = "")[2]
      
      for (no_col in color_permutations[c_row,1:2]) {
        for (no_fil in fills[fills != fill]) {
          oddball = paste(no_col, shape_permutations[s_row,3], no_fil, ".png", sep = "")
          span2_noSETs[row,] = c(item1, item2, oddball)
          row = row + 1
        }
      }
      for (no_sha in shape_permutations[s_row,1:2]) {
        for (no_fil in fills[fills != fill]) {
          oddball = paste(color_permutations[c_row,3], no_sha, no_fil, ".png", sep = "")
          span2_noSETs[row,] = c(item1, item2, oddball)
          row = row + 1
        }
      }
    }
  }
}
for (c_row in 1:nrow(color_permutations)) {
  for (shape in shapes) {
    for (f_row in 1:nrow(fill_permutations)) {
      item1 = paste(color_permutations[c_row,], shape, fill_permutations[f_row,], ".png", sep = "")[1]
      item2 = paste(color_permutations[c_row,], shape, fill_permutations[f_row,], ".png", sep = "")[2]
      
      for (no_col in color_permutations[c_row,1:2]) {
        for (no_sha in shapes[shapes != shape]) {
          oddball = paste(no_col, no_sha, fill_permutations[f_row,3], ".png", sep = "")
          span2_noSETs[row,] = c(item1, item2, oddball)
          row = row + 1
        }
      }
      for (no_fil in fill_permutations[f_row,1:2]) {
        for (no_sha in shapes[shapes != shape]) {
          oddball = paste(color_permutations[c_row,3], no_sha, no_fil, ".png", sep = "")
          span2_noSETs[row,] = c(item1, item2, oddball)
          row = row + 1
        }
      }
    }
  }
}
for (color in colors) {
  for (s_row in 1:nrow(shape_permutations)) {
    for (f_row in 1:nrow(fill_permutations)) {
      item1 = paste(color, shape_permutations[s_row,], fill_permutations[f_row,], ".png", sep = "")[1]
      item2 = paste(color, shape_permutations[s_row,], fill_permutations[f_row,], ".png", sep = "")[2]
      
      for (no_sha in shape_permutations[s_row,1:2]) {
        for (no_col in colors[colors != color]) {
          oddball = paste(no_col, no_sha, fill_permutations[f_row,3], ".png", sep = "")
          span2_noSETs[row,] = c(item1, item2, oddball)
          row = row + 1
        }
      }
      for (no_fil in fill_permutations[f_row,1:2]) {
        for (no_col in colors[colors != color]) {
          oddball = paste(no_col, shape_permutations[s_row,3], no_fil, ".png", sep = "")
          span2_noSETs[row,] = c(item1, item2, oddball)
          row = row + 1
        }
      }
    }
  }
}


### Check how many there are of each
nrow(span0_SETs)
nrow(span1_SETs)
nrow(span2_SETs)
nrow(span3_SETs)

nrow(span0_noSETs)
nrow(span1_noSETs)
nrow(span2_noSETs)
nrow(span3_noSETs)

### Randomize the order for each
rand_span0_SETs = span0_SETs[sample(nrow(span0_SETs)),]
rand_span1_SETs = span1_SETs[sample(nrow(span1_SETs)),]
rand_span2_SETs = span2_SETs[sample(nrow(span2_SETs)),]
rand_span3_SETs = span3_SETs[sample(nrow(span3_SETs)),]

rand_span0_noSETs = span0_noSETs[sample(nrow(span0_noSETs)),]
rand_span1_noSETs = span1_noSETs[sample(nrow(span1_noSETs)),]
rand_span2_noSETs = span2_noSETs[sample(nrow(span2_noSETs)),]
rand_span3_noSETs = span3_noSETs[sample(nrow(span3_noSETs)),]

### Get the right number of trials
number_lat   = length(c("LL", "LR", "MM", "RL", "RR"))
number_set   = length(c("SET", "noSET"))
number_spans = length(0:3)
number_trials_per = 10
trial_duration = 2

experiment_duration = (number_lat * number_set * number_trials_per * number_spans * trial_duration) / 60
number_trials_per_span = number_lat * number_set * number_trials_per

exp_span0_SETs = rbind(rand_span0_SETs, rand_span0_SETs, rand_span0_SETs, rand_span0_SETs)[1:number_trials_per_span,]
exp_span1_SETs = rand_span1_SETs[1:number_trials_per_span,]
exp_span2_SETs = rand_span2_SETs[1:number_trials_per_span,]
exp_span3_SETs = rand_span3_SETs[1:number_trials_per_span,]

exp_span0_noSETs = rand_span0_noSETs[1:number_trials_per_span,]
exp_span1_noSETs = rand_span1_noSETs[1:number_trials_per_span,]
exp_span2_noSETs = rand_span2_noSETs[1:number_trials_per_span,]
exp_span3_noSETs = rand_span3_noSETs[1:number_trials_per_span,]

### Write as .csvs
# write.csv(exp_span0_SETs, paste(output_dir, "/span0_SETs.csv", sep = ""), row.names = F)
# write.csv(exp_span1_SETs, paste(output_dir, "/span1_SETs.csv", sep = ""), row.names = F)
# write.csv(exp_span2_SETs, paste(output_dir, "/span2_SETs.csv", sep = ""), row.names = F)
# write.csv(exp_span3_SETs, paste(output_dir, "/span3_SETs.csv", sep = ""), row.names = F)
# 
# write.csv(exp_span0_noSETs, paste(output_dir, "/span0_noSETs.csv", sep = ""), row.names = F)
# write.csv(exp_span1_noSETs, paste(output_dir, "/span1_noSETs.csv", sep = ""), row.names = F)
# write.csv(exp_span2_noSETs, paste(output_dir, "/span2_noSETs.csv", sep = ""), row.names = F)
# write.csv(exp_span3_noSETs, paste(output_dir, "/span3_noSETs.csv", sep = ""), row.names = F)
