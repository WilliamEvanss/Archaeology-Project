install.packages("sp")
install.packages("sf")
library(sp)
library(sf)
load ("myA2Data copy.Rda")

# Make a Map
#Plan of males vs females also indicating unsampled data

coordinates (fsham) <- ~Easting+Northing
coordinates (fsamp) <- ~Easting+Northing

plot(fglplan, border="grey70", axes=TRUE)

plot(fglplan, col="grey89", border=NA, axes=FALSE)

points(fsham, col="grey68", pch=19, cex=0.5)

points (fsamp[fsamp$Sex=="male",], col="cornflowerblue", pch=19, cex=0.6)

points (fsamp[fsamp$Sex=="probable male",], col="cornflowerblue", pch=19, cex=0.6)

points (fsamp[fsamp$Sex=="female",], col="brown2", pch=19, cex=0.6)

points (fsamp[fsamp$Sex=="probable female",], col="brown2", pch=19, cex=0.6)

points (fsamp[fsamp$Sex=="unknown",], col="palegreen2", pch=19, cex=0.6)

legend (632615 ,153350, 
        legend=c("Total Males", "Total Females", "Unknown", "Unsampled"),
        col=c("cornflowerblue", "brown2", "palegreen2", "grey70"), pch=19, cex=1)

dev.print(device=pdf, file="Finglesham_Map_SexDistribution.pdf")


# TABLE # TABLE # TABLE # TABLE # TABLE # TABLE # TABLE # TABLE

# Select only Sex and Dating columns
dating.known.sex <- fsamp[fsamp$Sex != "unknown", c("Sex", "Dating")]

# Dropping unused levels
dating.known.sex$Sex <- droplevels(dating.known.sex$Sex)

# Make a table with probables and certains
dating.known.sex.tab <- xtabs(~ Sex + Dating, data = dating.known.sex)

# For visual reasons, make the males followed by probable males, and same for females.
dating.known.sex.tab <- dating.known.sex.tab[c("male", "possible male", "female", "possible female"), ]
dating.known.sex.tab
write.csv(dating.known.sex.tab, file="Table 1.csv")


# BARPLOT # BARPLOT # BARPLOT # BARPLOT # BARPLOT # BARPLOT 

barplot(dating.known.sex.tab,
        beside = TRUE,                    
        col = c("blue", "lightblue", "red", "lightpink"),
        main = "Sex distribution by Dating period",
        xlab = "Dating period",
        ylab = "Count",
        ylim = c(0, 50)
)

legend("topright",
       legend = rownames(dating.known.sex.tab),
       fill = c("blue", "lightblue", "red", "lightpink"),
       cex = 0.8)

dev.print(device=pdf, file="SexDatingBarplot.pdf")


# HYPOTHESIS TEST # HYPOTHESIS TEST # HYPOTHESIS TEST # HYPOTHESIS TEST

# H0: The proportion of males and females is equal, 50:50

# H1: The proportion of males and females differs from 50:50.

# The significance level is p = 0.05

# To excecute this i will do one hypothesis test for each dating group, then compare if the male:female proportion is (a) significant in 500-600 (b) changes in significance in 600-700

# I want to hypothesis test the certain males and females, but I also want to test the totals, so I need to combine categories

# Combining Categories - 10,9.3
old <- levels(dating.known.sex$Sex)
new <- c("total female", "total male", "total female", "total male")

dating.known.sex$SexGrouped <- factor(dating.known.sex$Sex, old, new)

# Contingency table - 10,10.1
sex.dating.tab <- xtabs(~SexGrouped + Dating, data = dating.known.sex)
sex.dating.tab
write.csv(sex.dating.tab, file="Table 2.csv")

# For 500-600:
sex.500_600 <- dating.known.sex[dating.known.sex$Dating=="500-600",]
sex.500_600.tab <- xtabs (~SexGrouped, data=sex.500_600)
chisq.test (sex.500_600.tab)

# For 600-700
sex.600_700 <- dating.known.sex[dating.known.sex$Dating=="600-700",]
sex.600_700.tab <- xtabs (~SexGrouped, data=sex.600_700)
chisq.test (sex.600_700.tab)

# Now to test the certain males and females

# I need to drop the levels for probables

# Select only Sex and Dating columns - 10,9.1
sex.hyp.2 <- dating.known.sex[dating.known.sex$Sex %in% c("male", "female"), c("Sex", "Dating")]

# Dropping unused levels - 10,9.2
sex.hyp.2$Sex <- droplevels(sex.hyp.2$Sex)

# For 500-600:
sex.500_600.2 <- sex.hyp.2[sex.hyp.2$Dating=="500-600",]
sex.500_600.2.tab <- xtabs (~Sex, data=sex.500_600.2)
chisq.test (sex.500_600.2.tab)

# For 600-700
sex.600_700.2 <- sex.hyp.2[sex.hyp.2$Dating=="600-700",]
sex.600_700.2.tab <- xtabs (~Sex, data=sex.600_700.2)
chisq.test (sex.600_700.2.tab)

#For extra clarity, i wanted to run a proportions test to see if the proporiton changes at all between 500-600 and 600-700: 


# The significance level is p = 0.05

# I want to hypothesis test the certain males and females, but I also want to test the totals, so I need to combine categories

#Proportion Test for totals
prop.test(sex.dating.tab, alternative = "two.sided")

# Now to test the certain males and females

#Proportion Test for certains
prop.test(sex.dating.tab.2, alternative = "two.sided")

# In all cases, p > 0.05, therefore the difference between males and female representation is insignificant the the p level and does not change from 500-700
