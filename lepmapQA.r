args = commandArgs(trailingOnly = TRUE)

if (length(args)==0) {
  stop("Trims the ends for clusters away from the main map using unmodified LepMap3 OrderedMarkers2 output as input 
       [usage] Rscript lepmapQA.r <directory> <inputfile matching pattern> <cM distance cutoff (default=10)>
       [example] Rscript lepmapQA.r . ordered
       [example] Rscript lepmapQA.r ./beardata chromosome 15", call.=FALSE)
}  else if (length(args)==2) {
  # default cM distance cutoff
  args[3] = 10
}

suppressMessages(if (!require("dplyr")) install.packages("dplyr"))
suppressMessages(library("dplyr"))
path = args[1]
setwd(args[1])
file.names <- dir(path, pattern = args[2])

##### Pruning the ends #####

for(i in file.names){  
  lgfile <- read.delim(paste(path,"/",i, sep = ""), 
                       header = FALSE, 
                       sep = "\t", 
                       comment.char="#"
                       )
  passing_markers<- lgfile

  for (j in 2:3){   # iterate over male (2) and female (3)
    # prune beginning
    pass_sort<-passing_markers[order(passing_markers[,j]),]   # sort good markers
    filelength10 <- length(pass_sort[,j]) * 0.10
    for(a in 1:filelength10){ #first 10% of total markers from the beginning
      diff <- abs(pass_sort[a+1,j]-pass_sort[a,j]) # difference between two points
      if( diff > args[3] ){ # is the difference between the two points > distance argument?
        pass_sort[1:a,] <- NA # mark that marker and all markers BEFORE it as NA
      }
    }

    # prune ends
    filelen<-length(pass_sort[,j])  # get new file lengths for each time we remove NA's
    filelength10 <- round(filelen * 0.10)
    for(z in filelen:(filelen-filelength10)){  #iterate 10% total markers in starting from the end
      diff <- abs(pass_sort[z,j]-pass_sort[z-1,j]) # difference between two points
      if( diff > args[3] ){ # is the difference between the two points > distance argument?
        pass_sort[filelen:z,] <- NA # mark that marker and all markers AFTER it as NA
      }
    }
    passing_markers <- pass_sort %>% filter(V1 != "NA")   # overwrite passing_markers after pruning ends
  }
  
  # isolate bad markers by comparing to original input file
  removed_markers<- as.vector(setdiff(lgfile[,1],passing_markers[,1]))
  
  # outputting filtered files
  filename<- paste("goodpositions",i, sep=".")
  print(paste("Removing",length(removed_markers),"markers from",i , "and writing new file", filename, sep = " "))
  writeLines(readLines(i, n=3),con = filename)
  write.table(passing_markers, 
            file = filename, 
            sep = "\t",
            quote = FALSE, 
            row.names = FALSE,
            col.names = FALSE,
            append=TRUE
            )
  write.table(removed_markers,
              file="bad_markers.txt",
              append=TRUE, 
              sep = "\t", 
              quote = FALSE, 
              row.names = FALSE, 
              col.names = FALSE
              )
}

print("Find poorly mapped loci in bad_markers.txt")
