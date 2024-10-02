library(readxl)
library(dplyr)

options(scipen=999) #getting rid of decimal sci notation format

excel_sheets("Abuelezam_Flu_COVID_DL2029_toSEND1.xlsx")

primaryseries<-read_excel("Abuelezam_Flu_COVID_DL2029_toSEND1.xlsx", sheet="COVID Primary Series Complete")

totalboost<-read_excel("Abuelezam_Flu_COVID_DL2029_toSEND1.xlsx", sheet="COVID Total Boosters")

atleastoneboost<-read_excel("Abuelezam_Flu_COVID_DL2029_toSEND1.xlsx", sheet="COVID Boosted")

unique(primaryseries$RACE_ETH)
  #"Unknown/Other"  "AI/AN"   "Asian"   "Black" "Hispanic" "Multi"  "NH/PI"  "White"       
table(primaryseries$RACE_ETH)

#create table of sum counts
sumcounts<- primaryseries%>%
  group_by(RACE_ETH,SEX)%>%
  summarise(count=sum(COUNT))

estimates5year2020<-c(4105,5373,1,240832,221801,1,242780,228344,1,417262,411290,1,91390,89580,1,830,1070,1,1,1,1,2508611,2354790,1)
estimates5year2021<-c(3740,4880,1,249208,229606,1,242193,229034,1,434057,430377,1,113865,112435,1,837,831,1,1,1,1,2501062,2375747,1)
estimates2020<-c(6371,6339,1,262729,246637,1,262654,252011,1,441316,439789,1,67784,66536,1,1617,1479,1,1,1,1,2525985,2414482,1)
estimates2019<-c(6218,6190,1,256006,234017,1,260570,245187,1,430248,424659,1,65502,63117,1,1545,1444,1,1,1,1,2526846,2370954,1)
estimates2021<-c(2761,2708,1,257396,233910,1,222137,209664,1,448991,448014,1,179038,168471,1,884,948,1,1,1,1,2418709,2298612,1)
sumcounts$totalpop<-estimates5year2021

#new column of % vaccinated
sumcounts<-mutate(sumcounts,percent=((count/totalpop)*100))
sumcounts<-mutate(sumcounts,rate=((count/totalpop)*100000))

