bnp.datafile <-"train.csv"
missing.types <- c("NA","")
train.column.types <- c('int', #ID
                        'factor', #target
                        'numeric', 'numeric', 'character','numeric', 'numeric','numeric', 'numeric','numeric',
                        'numeric','numeric', 'numeric','numeric', 'numeric','numeric', 'numeric','numeric', 
                        'numeric','numeric', 'numeric','numeric', 'numeric','factor', #look@v22MoreCarefully!
                        'numeric','character','numeric', 'numeric','numeric', 'numeric','numeric','character', 
                        'character','numeric', 'numeric','numeric', 'numeric','numeric', 'numeric','factor',
                        'numeric', 'numeric','numeric', 'numeric','numeric', 'numeric','numeric', 'numeric',
                        'factor','numeric', 'numeric','numeric', 'numeric','character','numeric','numeric', 'numeric',
                        'factor', 'numeric', 'numeric','numeric', 'numeric','numeric', 'factor','numeric', 'numeric',
                        'numeric','character','numeric', 'numeric','numeric', 'numeric','character', 'factor',
                        'numeric', 'character','character', 'numeric', 'numeric','numeric','character','numeric', 
                        'numeric','numeric', 'numeric','numeric', 'numeric','numeric','numeric','numeric', 'numeric',
                        'numeric','character','numeric', 'numeric','numeric', 'numeric','numeric', 'numeric',
                        'numeric', 'numeric','numeric', 'numeric','numeric','numeric', 'numeric','numeric', 'numeric',
                        'character', 'numeric', 'numeric','character','numeric','character','character','numeric', 
                        'numeric','numeric', 'numeric','numeric', 'numeric','numeric', 'numeric','numeric', 'numeric',
                        'numeric','factor','numeric', 'numeric','numeric','factor','numeric','numeric')

bnp.trainraw <- read.csv(bnp.datafile, header = TRUE, sep = ",", dec = ".", na.string=missing.types)

