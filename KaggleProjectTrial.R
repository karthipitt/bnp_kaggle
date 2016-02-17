setwd('~/Documents/KaggleDataPictures')
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

bnp.train.missingcount<-sapply(bnp.trainraw, function(x) sum(is.na(x)))
bnp.train.missrate<-bnp.train.missingcount/114321
jpeg(file = "MissrateHist.jpg")
hist(bnp.train.missrate)
dev.off()

## map missing data by provided feature
require(Amelia)
jpeg(file = "Missmap.jpg")
missmap(bnp.trainraw, main="BNP_Kaggle Training Data - Missings Map", 
        col=c("yellow", "black"), legend=FALSE)
dev.off()

bnp.train.num<-bnp.trainraw[,sapply(bnp.trainraw, is.numeric)]
bnp.train.numscaled<-scale(bnp.train.num[3:ncol(bnp.train.num)], center=TRUE, scale=TRUE);

Cpear<-cor(bnp.train.numscaled, y = NULL, use = "na.or.complete", method = "pearson")
CairoPNG(file = "PearsonCorrelatioMatrix.jpeg", width = 1500, height = 1500, pointsize = 12)
corrplot(Cpear,method = "square", type = "full", title = "Feature Correlation Matrix", is.corr = TRUE, diag = TRUE, order ='hclust', hclust.method = "complete")
dev.off()

jpeg(file = "CorrHist.jpeg")
hist(Cpear)
dev.off()

highlyCor <- findCorrelation(Cpear, 0.70)
#Apply correlation filter at 0.70,
#then we remove all the variable correlated with more 0.7.
bnp.train.filteredscale <- bnp.train.numscaled[,-highlyCor]
Cpear.filter <- cor(bnp.train.filteredscale, y = NULL, use = "na.or.complete", method = "pearson")
CairoPNG(file = "FilteredPearsonCorrelatioMatrix.jpeg", width = 1500, height = 1600, pointsize = 12)
corrplot(Cpear.filter,method = "square", type = "full", title = " Filtered Feature Correlation Matrix", is.corr = TRUE, diag = TRUE, order ='hclust', hclust.method = "complete")
dev.off()

#Remove
bnp.train.numfiltered<-bnp.train.num[,-highlyCor]

#Segregate Approved and Rejected instances into two dfs
bnp.train.numfiltapp<-bnp.train.numfiltered[bnp.train.numfiltered$target>0,]
bnp.train.numfiltrej<-bnp.train.numfiltered[bnp.train.numfiltered$target==0,]

hist(bnp.train.numfiltapp[,3],col=rgb(1,0,0,0.5), xlab='v1', main="Distribution of v1 Value for Approved and Rejected Instances")
hist(bnp.train.numfiltrej[,3], col=rgb(0,0,0,0.5), add=T)
legend("topright", c("Approved", "Rejected"), col=c("blue", "red"), lwd=10)
box()


#PCA Analysis
require(FactoMineR)

