Early Childhood Education Outcomes Data Analysis
Juan Vega
8/29/2019
setwd("S:/Development/Outcomes/Uptake/Raw data")
Setting up package dependencies used in this script
The code chunk below calls the packages used in the execution of this program.
Generating vectors used in importing files of demographics and enrollment, family referrals, services, and visits from COPA
1.	The working directory is set to the folder in the shared drive that contains all the data sources or raw data used for this analysis - “S:/Development/Outcomes/Uptake/Raw data”. Please input all future data used for this analysis in this folder.(
2.	Vectors are generated containing the names of the files that will be imported into R. Please note that every vector element is sorrounded by quotes and separated by other vectors with a comma.(
When updating data for future years, please download the data pertaining to a year and name the file following the same name format in the vectors below.
For example, for the “demographics” data set for the 2019-2020 school year, please name the file as “Demographic and enrollment data for 2010-2020.csv” and add the file name to the “demographics” vector in lines 39-42.
1.	Please input all new data files in the working directory folder. Please follow the instructions in the file named “Instructions for Generating Data for   ECE Outcomes Dashboard and Data Analysis” in the “S:/Development/Outcomes/Uptake” folder.(
2.	Please note that the vector meals will contain all meal-counts data for program years starting with 2018-2019.All prior meal counts data will be imported using vector “meal_counts” but will only be used to import data prior to 2018-2019.(
Importing files
The “lapply” or list-apply function will apply the read_csv or read_tsv functions on the vectors with more than one element in code chunk “r name vector of files to be imported”.
Removing Child and Family IDs of test children and families and replacing duplicated Child and Family IDs from COPA
The following vectors are defined for Chidl and Family IDs to remove test children and families and assign an ID with children and families that have more than one ID.
Generate constant of length of vectors to index the Child and Family IDs that will be replaced.
If new duplicate Child and Family IDs are found, the should be added to the list of “duplicate_ids” and “duplicated_family_ids”.
An associated “replacement_id” and “new_family_id” should be added to those vectors. Those new IDs will be used in a for loop used to replace duplicated IDs.
ids_to_remove <- c("101556", "102167", "102106", "100313", "100220", "102657", "101251", "102742", "101817", "100128", "102398",  
                   "100366", "101100", "101938", "102240",  "101125", "101285", "101915", "102395", "102462")

duplicate_ids <- c("102226" , "102539" , "100325" , "101412" , "100455" , "101416" , "100582" , "101198", "100606", 
                   "101419" , "100328" , "101420" , "100665" , "101288" , "100463" , "101221" , "100304", "101422", 
                   "100321" , "101424" , "100389" , "101426" , "100893" , "101429" , "100263" , "101513" , "100362", 
                   "101559" , "100617" , "101306" , "100471" , "101197" , "100671" , "101440" , "100303" , "101442", 
                   "100462" , "101326" , "100394" , "101447" , "100459" , "101705" , "100688" , "101521" , "100637", 
                   "101463" , "100335" , "101464" , "100265" , "101465" , "100052" , "102124" , "100369" , "101470", 
                   "100368" , "101560" , "100595" , "101317" , "100438" , "101479" , "100918" , "101335" , "100409", 
                   "101532" , "101856" , "102075" , "100919" , "101212" , "102381" , "102629" , "100346" , "101483", 
                   "100536" , "101485" , "101374" , "102062" , "100661" , "101352" , "100187" , "101493" , "100645", 
                   "102164" , "100436" , "101497" , "100460" , "101386" , "102017" , "102454" , "100643" , "101368", 
                   "100639" , "101347" , "100388" , "101500" , "102261" , "102279" , "100555" , "101504" , "100803", 
                   "101248" , "100433" , "101505" , "100405" , "101508" , "100514" , "101209" , "102434" , "102665", 
                   "100574" , "101373" , "102038" , "102806")

replacement_ids <- c("300000" , "300000" , "300001" , "300001" , "300002" , "300002" , "300003" , "300003" , "300004" , 
                     "300004" , "300005" , "300005" , "300006" , "300006" , "300007" , "300007" , "300008" , "300008" , 
                     "300009" , "300009" , "300010" , "300010" , "300011" , "300011" , "300012" , "300012" , "300013" , 
                     "300013" , "300014" , "300014" , "300015" , "300015" , "300016" , "300016" , "300017" , "300017" , 
                     "300018" , "300018" , "300019" , "300019" , "300020" , "300020" , "300021" , "300021" , "300022" , 
                     "300022" , "300023" , "300023" , "300024" , "300024" , "300025" , "300025" , "300026" , "300026" , 
                     "300028" , "300028" , "300029" , "300029" , "300030" , "300030" , "300031" , "300031" , "300032" , 
                     "300032" , "300033" , "300033" , "300034" , "300034" , "300035" , "300035" , "300036" , "300036" , 
                     "300037" , "300037" , "300038" , "300038" , "300039" , "300039" , "300040" , "300040" , "300041" , 
                     "300041" , "300042" , "300042" , "300043" , "300043" , "300044" , "300044" , "300045" , "300045" , 
                     "300046" , "300046" , "300047" , "300047" , "300048" , "300048" , "300049" , "300049" , "300050" , 
                     "300050" , "300051" , "300051" , "300052" , "300052" , "300053" , "300053" , "300054" , "300054" , 
                     "300055" , "300055" , "300056" , "300056")

count_ids_to_remove <- length(ids_to_remove)
count_ids <- length(duplicate_ids)
family_ids_to_remove <- c("201928", "201929", "200005", "201473", "200366", "200330", "201294", "202174", "202058", "200252",
                          "200174", "200842",   "200511",   "201892", "201476", "200101", "202412", "200300", "200925", "201886", 
                          "202237", "200947", "200949", "200937", "202397", "200255")

count_family_ids_to_remove <- length(family_ids_to_remove) 



duplicated_family_ids <- c("201910" , "202593" , "200264" , "201179" , "200120" , "201185" , "200374" , "201028" , 
                           "200149" , "201187" , "200260" , "201189" , "200746" , "201193" , "200215" , "201254" , 
                           "200215" , "201254" , "200381" , "201009" , "200545" , "201204" , "200014" , "201206" , 
                           "200373" , "201111" , "200321" , "200321" , "200370" , "201409" , "200561" , "201262" , 
                           "200044" , "202077" , "200143" , "201222" , "200357" , "201230" , "200336" , "201271" , 
                           "202367" , "201946" , "200280" , "201234" , "201148" , "202021" , "200537" , "201131" , 
                           "200128" , "201240" , "200524" , "202171" , "201953" , "202509" , "200522" , "201144" , 
                           "200518" , "201127" , "202265" , "202275" , "200669" , "201052" , "200332" , "201249" , 
                           "200420" , "201018" , "202491" , "201019" , "202821" , "201976")

new_family_ids <- c("400000" , "400000" , "400001" , "400001" , "400005" , "400005" , "400007" , "400007" , "400008" , 
                    "400008" , "400009" , "400009" , "400011" , "400011" , "400012" , "400012" , "400013" , "400013" , 
                    "400015" , "400015" , "400016" , "400016" , "400017" , "400017" , "400018" , "400018" , "400019" , 
                    "400019" , "400020" , "400020" , "400021" , "400021" , "400025" , "400025" , "400026" , "400026" , 
                    "400030" , "400030" , "400032" , "400032" , "400035" , "400035" , "400036" , "400036" , "400038" , 
                    "400038" , "400039" , "400039" , "400040" , "400040" , "400041" , "400041" , "400044" , "400044" , 
                    "400045" , "400045" , "400046" , "400046" , "400048" , "400048" , "400050" , "400050" , "400052" , 
                    "400052" , "400053" , "400053" , "400054" , "400054" , "400055" , "400055")

count_family_ids <- length(duplicated_family_ids)
Using rbind - or row bind - to merge all elements of large list of individual data frames or files imported
The next set of chunks will combine the elements of in the lists generated by lapply in one data frame.
For instance, all the 7 elements of the “copa_program_year” list will be combined into one data frame named “program_year”.
This data frame will later be combined with other data frames. Please note that as new annual data are added, the highest element number
in the list will be the highest element in the current list + 1. For instance, as of the 2018-2019 school year, the copa_program_year
list contains 7 elements. When the 2019-2020 data are added to the Raw data folder, code below should be edited to include the eigth
element in the copa_program_year list.
Following each rbind call, data cleaning steps are implemented that are specific to each data frame
program_year <- rbind(copa_program_year[[1]], copa_program_year[[2]], copa_program_year[[3]], copa_program_year[[4]],
                      copa_program_year[[5]], copa_program_year[[6]], copa_program_year[[7]])

program_year$string_pattern1 <- grepl("Child Care Partnership", program_year$AgencySiteClass, fixed = TRUE)
program_year$string_pattern2 <- grepl("  DC - Columbia Rd / Old Upshur Street (Do Not Use)", program_year$AgencySiteClass, fixed = TRUE)
program_year$string_pattern3 <- grepl("  DC - Columbia Rd / Cardozo (Old Cardozo Site - Do not use)", program_year$AgencySiteClass, fixed = TRUE)
program_year$string_pattern4 <- grepl("Test Agency / Test Site / Test Class", program_year$AgencySiteClass, fixed = TRUE)
program_year$string_pattern5 <- grepl("  DC - OST / Columbia Road ", program_year$AgencySiteClass, fixed = TRUE)

program_year <- unique(subset(program_year, program_year$string_pattern1!=TRUE & program_year$string_pattern2!=TRUE & 
                                program_year$string_pattern3!=TRUE & program_year$string_pattern4!=TRUE &
                                program_year$string_pattern5!=TRUE))
#table(program_year$AgencySiteClass)
table(program_year$`Program year`)
## 
## 2012-2013 2013-2014 2014-2015 2015-2016 2016-2017 2017-2018 2018-2019 
##       126       130       274       241       589       789       875
#Remove string pattern columns
program_year <- unique(program_year[, -c(9:13)])
demographics_enrollment <- rbind(copa_dem_enrollment[[1]], copa_dem_enrollment[[2]], copa_dem_enrollment[[3]], 
                                 copa_dem_enrollment[[4]], copa_dem_enrollment[[5]], copa_dem_enrollment[[6]], 
                                 copa_dem_enrollment[[7]])

#Remove children from the Child Care Partnership & only keep unique children
demographics_enrollment <- demographics_enrollment[order(demographics_enrollment$`Child ID`),]
demographics_enrollment <- subset(demographics_enrollment, demographics_enrollment$`Child Agency`!="Child Care Partnership") 
demographics_enrollment <- subset(demographics_enrollment, demographics_enrollment$`Child Agency`!="Test Agency")
demographics_enrollment <- subset(demographics_enrollment, demographics_enrollment$`Child Agency`!="  DC - OST")
demographics_enrollment <- unique(demographics_enrollment[, !grepl("^X3", names(demographics_enrollment))])
all_meals <- rbind(copa_meal_counts[[1]], copa_meal_counts[[2]], copa_meal_counts[[3]], copa_meal_counts[[4]], 
                   copa_meal_counts[[5]], copa_meal_counts[[6]], copa_meal_counts[[7]], copa_meal_counts[[8]], 
                   copa_meal_counts[[9]], copa_meal_counts[[10]], copa_meal_counts[[11]], copa_meal_counts[[12]],  
                   copa_meal_counts[[12]], copa_meal_counts[[13]], copa_meal_counts[[14]], copa_meal_counts[[15]], 
                   copa_meal_counts[[16]], copa_meal_counts[[17]], copa_meal_counts[[18]], copa_meal_counts[[19]], 
                   copa_meal_counts[[20]], copa_meal_counts[[21]], copa_meal_counts[[22]], copa_meal_counts[[23]], 
                   copa_meal_counts[[24]], copa_meal_counts[[25]], copa_meal_counts[[26]], copa_meal_counts[[27]], 
                   copa_meal_counts[[28]], copa_meal_counts[[29]], copa_meal_counts[[30]], copa_meal_counts[[31]], 
                   copa_meal_counts[[32]], copa_meal_counts[[33]], copa_meal_counts[[34]], copa_meal_counts[[35]], 
                   copa_meal_counts[[36]], copa_meal_counts[[37]], copa_meal_counts[[38]], copa_meal_counts[[39]], 
                   copa_meal_counts[[40]], copa_meal_counts[[41]], copa_meal_counts[[42]], copa_meal_counts[[43]], 
                   copa_meal_counts[[44]], copa_meal_counts[[45]], copa_meal_counts[[46]], copa_meal_counts[[47]], 
                   copa_meal_counts[[48]], copa_meal_counts[[49]], copa_meal_counts[[50]], copa_meal_counts[[51]], 
                   copa_meal_counts[[52]], copa_meal_counts[[53]], copa_meal_counts[[54]], copa_meal_counts[[55]], 
                   copa_meal_counts[[56]], copa_meal_counts[[57]], copa_meal_counts[[58]], copa_meal_counts[[59]],
                   copa_meal_counts[[60]], copa_meal_counts[[61]], copa_meal_counts[[62]], copa_meal_counts[[63]], 
                   copa_meal_counts[[64]], copa_meal_counts[[65]], copa_meal_counts[[66]], copa_meal_counts[[67]], 
                   copa_meal_counts[[68]], copa_meal_counts[[69]], copa_meal_counts[[70]], copa_meal_counts[[71]], 
                   copa_meal_counts[[72]], copa_meal_counts[[73]], copa_meal_counts[[74]], copa_meal_counts[[75]], 
                   copa_meal_counts[[76]], copa_meal_counts[[77]], copa_meal_counts[[78]])
family_referrals<-rbind(copa_family_referrals[[1]], copa_family_referrals[[2]], copa_family_referrals[[3]], 
                        copa_family_referrals[[4]], copa_family_referrals[[5]], copa_family_referrals[[6]], 
                        copa_family_referrals[[7]], copa_family_referrals[[8]])

family_referrals<-subset(family_referrals, family_referrals$`Referral Status`!="Declined Services")
family_visits <- rbind(copa_family_visits[[1]], copa_family_visits[[2]], copa_family_visits[[3]],
                       copa_family_visits[[4]], copa_family_visits[[5]], copa_family_visits[[6]],
                       copa_family_visits[[7]])
From program_year, demographics_enrollment, all_meals, family_referrals, family_visits, and family_services, remove test IDs and duplicate IDs
for (index in 1:count_ids_to_remove) {
  program_year <- subset(program_year, program_year$`Child ID`!=ids_to_remove[[index]])
}

for (index in 1:count_ids) {
  program_year$`Child ID`[program_year$`Child ID` == duplicate_ids[[index]]] <- replacement_ids[[index]]
}

program_year <- program_year[order(program_year$`Child ID`),]
program_year <- unique(program_year)
for (index in 1:count_ids_to_remove) {
  demographics_enrollment <- subset(demographics_enrollment, demographics_enrollment$`Child ID`!=ids_to_remove[[index]])
}

count_ids <- length(duplicate_ids)

for (index in 1:count_ids) {
  demographics_enrollment$`Child ID`[demographics_enrollment$`Child ID` == duplicate_ids[[index]]] <- replacement_ids[[index]]
}

demographics_enrollment<-rename(demographics_enrollment, "Family ID"="Family/Prim Care ID")

for (index in 1:count_family_ids) {
  demographics_enrollment$`Family ID`[demographics_enrollment$`Family ID` == duplicated_family_ids[[index]]] <- new_family_ids[[index]]
}
for (index in 1:count_ids_to_remove) {
  all_meals <- subset(all_meals, all_meals$`ChildID`!=ids_to_remove[[index]])
}

count_ids <- length(duplicate_ids)

for (index in 1:count_ids) {
  all_meals$`ChildID`[all_meals$`ChildID` == duplicate_ids[[index]]] <- replacement_ids[[index]]
}

all_meals <- unique(all_meals)
for (index in 1:count_family_ids_to_remove) {
  family_referrals <- subset(family_referrals, family_referrals$`ID`!=family_ids_to_remove[[index]])
}

#Assign new IDs to observations that may be duplicated in Family IDs

for (index in 1:count_family_ids) {
  family_referrals$`ID`[family_referrals$`ID` == duplicated_family_ids[[index]]] <- new_family_ids[[index]]
}
for (index in 1:count_family_ids_to_remove) {
  family_services <- subset(family_services, family_services$`ID`!=family_ids_to_remove[[index]])
}

#Assign new IDs to observations that may be duplicated in Family IDs

for (index in 1:count_family_ids) {
  family_services$`ID`[family_services$`ID` == duplicated_family_ids[[index]]] <- new_family_ids[[index]]
}
for (index in 1:count_family_ids_to_remove) {
  family_visits <- subset(family_visits, family_visits$`ID`!=family_ids_to_remove[[index]])
}

#Assign new IDs to observations that may be duplicated in Family IDs

for (index in 1:count_family_ids) {
  family_visits$`ID`[family_visits$`ID` == duplicated_family_ids[[index]]] <- new_family_ids[[index]]
}
Generate the “Program year” column in family_referrals, family_services, family_visits, all_meals, and other data frames to reflect the program year at   starting on August 1 and ending on July 31 of the following year
Please adjust the program year field by adding updating the “Program year” column by updating the “Year” values as in the following lines of code
all_meals$`Program year` <- NA
all_meals$`Program year`[(all_meals$Month=="August" | all_meals$Month=="September" | all_meals$Month=="October"| all_meals$Month=="November" |
                            all_meals$Month=="December" & all_meals$Year==2014) |  (all_meals$Month=="January" | all_meals$Month=="February" |                                        all_meals$Month=="March"| all_meals$Month=="April" | all_meals$Month=="May" | all_meals$Month=="June" |                                                    all_meals$Month=="July" & all_meals$Year==2015)]<-"2014-2015"

all_meals$`Program year`[(all_meals$Month=="August" | all_meals$Month=="September" | all_meals$Month=="October"| all_meals$Month=="November" |
                            all_meals$Month=="December" & all_meals$Year==2015) | (all_meals$Month=="January" | all_meals$Month=="February" |
                                                                                     all_meals$Month=="March"| all_meals$Month=="April" | all_meals$Month=="May" | all_meals$Month=="June" | 
                                                                                     all_meals$Month=="July" & all_meals$Year==2016)]<-"2015-2016"

all_meals$`Program year`[(all_meals$Month=="August" | all_meals$Month=="September" | all_meals$Month=="October"| all_meals$Month=="November" |
                            all_meals$Month=="December" & all_meals$Year==2016) | (all_meals$Month=="January" | all_meals$Month=="February" | 
                                                                                     all_meals$Month=="March"| all_meals$Month=="April" | all_meals$Month=="May" | all_meals$Month=="June" | 
                                                                                     all_meals$Month=="July" & all_meals$Year==2017)]<-"2016-2017"

all_meals$`Program year`[(all_meals$Month=="August" | all_meals$Month=="September" | all_meals$Month=="October"| all_meals$Month=="November" |
                            all_meals$Month=="December" & all_meals$Year==2017) | (all_meals$Month=="January" | all_meals$Month=="February" |                                          all_meals$Month=="March"| all_meals$Month=="April" |all_meals$Month=="May" | all_meals$Month=="June" |                                                     all_meals$Month=="July" & all_meals$Year==2018)]<-"2017-2018"
family_referrals$`Referral Date` <- gsub("-", "/", family_referrals$`Referral Date`)
family_referrals$`Referral Date` <- as.Date(family_referrals$`Referral Date`, '%m/%d/%Y')
str(family_referrals$`Referral Date`)
##  Date[1:7448], format: "2013-02-07" "2012-08-21" "2012-06-12" "2012-05-11" "2012-08-24" ...
family_referrals$`Program year` <- NA
family_referrals$`Program year`[family_referrals$`Referral Date`>= as.Date("2012-08-01") &
                                  family_referrals$`Referral Date`<= as.Date("2013-07-31")] <- "2012-2013"

family_referrals$`Program year`[family_referrals$`Referral Date`>= as.Date("2013-08-01") &
                                  family_referrals$`Referral Date`<= as.Date("2014-07-31")] <- "2013-2014"

family_referrals$`Program year`[family_referrals$`Referral Date`>= as.Date("2014-08-01") &
                                  family_referrals$`Referral Date`<= as.Date("2015-07-31")] <- "2014-2015"

family_referrals$`Program year`[family_referrals$`Referral Date`>= as.Date("2015-08-01") &
                                  family_referrals$`Referral Date`<= as.Date("2016-07-31")] <- "2015-2016"

family_referrals$`Program year`[family_referrals$`Referral Date`>= as.Date("2016-08-01") &
                                  family_referrals$`Referral Date`<= as.Date("2017-07-31")] <- "2016-2017"

family_referrals$`Program year`[family_referrals$`Referral Date`>= as.Date("2017-08-01") &
                                  family_referrals$`Referral Date`<= as.Date("2018-07-31")] <- "2017-2018"

family_referrals$`Program year`[family_referrals$`Referral Date`>= as.Date("2018-08-01") &
                                  family_referrals$`Referral Date`<= as.Date("2019-07-31")] <- "2018-2019"

family_referrals <- family_referrals[order(family_referrals$ID, family_referrals$`Referral Reason`),] 
family_services$`Service Start Date` <- gsub("-", "/", family_services$`Service Start Date`)
family_services$`Service Start Date` <- as.Date(family_services$`Service Start Date`, '%m/%d/%Y')
str(family_services$`Service Start Date`)
##  Date[1:3274], format: "2018-03-07" "2018-02-16" "2017-12-07" "2017-11-01" "2017-10-10" ...
family_services$`Program year` <- NA
family_services$`Program year`[family_services$`Service Start Date`>= as.Date("2012-08-01") &
                                 family_services$`Service Start Date`<= as.Date("2013-07-31")] <- "2012-2013"

family_services$`Program year`[family_services$`Service Start Date`>= as.Date("2013-08-01") &
                                 family_services$`Service Start Date`<= as.Date("2014-07-31")] <- "2013-2014"

family_services$`Program year`[family_services$`Service Start Date`>= as.Date("2014-08-01") &
                                 family_services$`Service Start Date`<= as.Date("2015-07-31")] <- "2014-2015"

family_services$`Program year`[family_services$`Service Start Date`>= as.Date("2015-08-01") &
                                 family_services$`Service Start Date`<= as.Date("2016-07-31")] <- "2015-2016"

family_services$`Program year`[family_services$`Service Start Date`>= as.Date("2016-08-01") &
                                 family_services$`Service Start Date`<= as.Date("2017-07-31")] <- "2016-2017"

family_services$`Program year`[family_services$`Service Start Date`>= as.Date("2017-08-01") &
                                 family_services$`Service Start Date`<= as.Date("2018-07-31")] <- "2017-2018"

family_services$`Program year`[family_services$`Service Start Date`>= as.Date("2018-08-01") &
                                 family_services$`Service Start Date`<= as.Date("2019-07-31")] <- "2018-2019"
str(family_visits$`Visit Date`)
##  chr [1:725] "2/27/2012" "2/23/2012" "2/22/2012" "2/24/2012" ...
family_visits$`Visit Date` <- as.Date(family_visits$`Visit Date`, '%m/%d/%Y')

family_visits$`Program year` <- NA
family_visits$`Program year`[family_visits$`Visit Date`>= as.Date("2012-08-01") &
                               family_visits$`Visit Date`<= as.Date("2013-07-31")] <- "2012-2013"

family_visits$`Program year`[family_visits$`Visit Date`>= as.Date("2013-08-01") &
                               family_visits$`Visit Date`<= as.Date("2014-07-31")] <- "2013-2014"

family_visits$`Program year`[family_visits$`Visit Date`>= as.Date("2014-08-01") &
                               family_visits$`Visit Date`<= as.Date("2015-07-31")] <- "2014-2015"

family_visits$`Program year`[family_visits$`Visit Date`>= as.Date("2015-08-01") &
                               family_visits$`Visit Date`<= as.Date("2016-07-31")] <- "2015-2016"

family_visits$`Program year`[family_visits$`Visit Date`>= as.Date("2016-08-01") &
                               family_visits$`Visit Date`<= as.Date("2017-07-31")] <- "2016-2017"

family_visits$`Program year`[family_visits$`Visit Date`>= as.Date("2017-08-01") &
                               family_visits$`Visit Date`<= as.Date("2018-07-31")] <- "2017-2018"

family_visits$`Program year`[family_visits$`Visit Date`>= as.Date("2018-08-01") &
                               family_visits$`Visit Date`<= as.Date("2019-07-31")] <- "2018-2019"
Join data frames
demographics_prog_yr <- left_join(program_year, demographics_enrollment, by=c("Child ID", "Program year"))
demographics_prog_yr <- demographics_prog_yr[order(demographics_prog_yr$`Child ID`),]

demographics_prog_yr <- unique(demographics_prog_yr)
breakfast<-aggregate(all_meals$Breakfast, by=list(x=all_meals$ChildID, y=all_meals$`Program year`), FUN=sum)
colnames(breakfast) <- c("ChildID", "Program year", "Breakfast")

lunch<-aggregate(all_meals$Lunch, by=list(x=all_meals$ChildID, y=all_meals$`Program year`), FUN=sum)
colnames(lunch) <- c("ChildID", "Program year", "Lunch")

snack<-aggregate(all_meals$Snack, by=list(x=all_meals$ChildID, y=all_meals$`Program year`), FUN=sum)
colnames(snack) <- c("ChildID", "Program year", "Snack")

dinner<-aggregate(all_meals$Dinner, by=list(x=all_meals$ChildID, y=all_meals$`Program year`), FUN=sum)
colnames(dinner) <- c("ChildID", "Program year", "Dinner")

meals_counts <- cbind(breakfast, lunch["Lunch"], snack["Snack"], dinner["Dinner"])
meals_counts[is.na(meals_counts)] <- 0
meals_counts <-mutate(meals_counts, totalmeals=meals_counts$Breakfast+meals_counts$Lunch+meals_counts$Snack)
meals_counts <- meals_counts[, -c(3:6)]

meals_counts[is.na(meals_counts)] <- 0
meals_counts <- rename(meals_counts, "Child ID"="ChildID")
meals_counts <-rename(meals_counts, "Number of meals"="totalmeals")

demographics_enroll_meals <- left_join(demographics_prog_yr, meals_counts, by=c("Child ID", "Program year")) 

demographics_enroll_meals <- full_join(demographics_enroll_meals, meals, by=c("Child Name", "Program year"))
demographics_enroll_meals$`Number of meals.x`[is.na(demographics_enroll_meals$`Number of meals.x`)] <- 0
demographics_enroll_meals$`Number of meals.y`[is.na(demographics_enroll_meals$`Number of meals.y`)] <- 0

demographics_enroll_meals <- mutate(demographics_enroll_meals, `Number of meals`=demographics_enroll_meals$`Number of meals.x` +
                                      demographics_enroll_meals$`Number of meals.y`)

demographics_enroll_meals <- demographics_enroll_meals[, -c(39:40)]
Join data frames of family referrals, services, and visits and generate tables of the percentage of referrals, services, or visit types provided to families within a program year
#Generate data frame of aggregate family referrals

family_referrals <- family_referrals[order(family_referrals$ID, family_referrals$`Referral Reason`),] 

family_referrals_aggregate <- aggregate(family_referrals$`Referral Reason`, by=list(x=family_referrals$`ID`, 
                                                                                    y=family_referrals$`Program year`, z=family_referrals$`Referral Reason`), FUN=length)

colnames(family_referrals_aggregate) <- c("Family ID", "Program year", "Referral Reason", "Number of referrals")

family_referrals_aggregate <- family_referrals_aggregate[order(family_referrals_aggregate$`Family ID`, 
                                                               family_referrals_aggregate$`Referral Reason`),]

family_referrals_table <- table(family_referrals_aggregate$`Referral Reason`, family_referrals_aggregate$`Program year`)
family_referrals_table_freq <- prop.table(family_referrals_table, margin=2)
family_referrals_table_freq <- 100*(round(family_referrals_table_freq, 3))

family_referrals_table_freq
##                                                     
##                                                      2012-2013 2013-2014
##   Adult Education/GED/CDA                                  7.9       6.8
##   Assistance to families of incarcerated individuals       0.0       0.5
##   Child Abuse and Neglect Services                         0.8       0.0
##   Child Care Service Provider                              0.0       2.4
##   Child support assistance                                 1.6       1.0
##   Diapers                                                  0.0       0.0
##   Disabilities/Early Intervention                          0.8       0.5
##   Domestic violence services                               1.6       0.0
##   Early Intervention Services                              0.0       0.0
##   Emergency/crisis intervention                            1.6       6.8
##   Employment                                               4.8       7.2
##   ESL training                                             7.9       2.9
##   Family Literacy                                          0.0       0.0
##   Family/Social Relations                                  0.0       0.0
##   Financial Literacy                                       0.8       9.7
##   Food/Clothes/Basic Resources                             0.0       0.0
##   Health Care Coverage                                     0.0       0.0
##   Health Education (including prenatal education)          7.9      15.0
##   Housing assistance                                       4.0       1.0
##   Income                                                   0.0       0.0
##   Job Training                                             0.0       1.0
##   Legal                                                    0.0       0.0
##   Marriage education                                       0.8       3.4
##   Mental Health Services                                   7.9       1.0
##   Mobility                                                 0.0       0.0
##   Other                                                    0.0       0.0
##   Parenting Education                                     31.0      29.0
##   Social Security Income                                   0.0       0.0
##   Supplemental nutrition/WIC/Food Stamps                  20.6      12.1
##   Transportation assistance                                0.0       0.0
##                                                     
##                                                      2014-2015 2015-2016
##   Adult Education/GED/CDA                                  8.5       5.3
##   Assistance to families of incarcerated individuals       0.0       0.1
##   Child Abuse and Neglect Services                         0.0       0.0
##   Child Care Service Provider                              0.0       4.5
##   Child support assistance                                 0.0       0.6
##   Diapers                                                  0.0       0.0
##   Disabilities/Early Intervention                          1.7       0.8
##   Domestic violence services                               0.0       1.7
##   Early Intervention Services                              1.7       0.6
##   Emergency/crisis intervention                            6.0      10.8
##   Employment                                               7.7       7.4
##   ESL training                                             6.0       1.3
##   Family Literacy                                          0.0       0.0
##   Family/Social Relations                                  0.0       0.0
##   Financial Literacy                                       0.0       7.3
##   Food/Clothes/Basic Resources                             0.0      11.6
##   Health Care Coverage                                     0.0       0.0
##   Health Education (including prenatal education)         28.2      12.1
##   Housing assistance                                       5.1       9.6
##   Income                                                   0.0       0.0
##   Job Training                                             1.7       2.1
##   Legal                                                    0.0       0.1
##   Marriage education                                       0.0       0.3
##   Mental Health Services                                   0.9       0.8
##   Mobility                                                 0.0       0.0
##   Other                                                    0.0       3.0
##   Parenting Education                                     20.5      16.5
##   Social Security Income                                   0.0       0.1
##   Supplemental nutrition/WIC/Food Stamps                   8.5       1.3
##   Transportation assistance                                3.4       2.0
##                                                     
##                                                      2016-2017 2018-2019
##   Adult Education/GED/CDA                                  3.0       3.6
##   Assistance to families of incarcerated individuals       0.0       0.0
##   Child Abuse and Neglect Services                         0.4       0.4
##   Child Care Service Provider                              1.5       0.2
##   Child support assistance                                 0.0       1.1
##   Diapers                                                  9.4      23.7
##   Disabilities/Early Intervention                          0.7       0.4
##   Domestic violence services                               0.4       0.0
##   Early Intervention Services                              3.4       0.4
##   Emergency/crisis intervention                            9.7       3.8
##   Employment                                               5.2       0.2
##   ESL training                                             2.2       0.0
##   Family Literacy                                          0.0       0.4
##   Family/Social Relations                                  0.4       0.6
##   Financial Literacy                                       1.9       0.0
##   Food/Clothes/Basic Resources                            12.7      12.7
##   Health Care Coverage                                     1.5       3.6
##   Health Education (including prenatal education)          9.7       6.6
##   Housing assistance                                       7.1       1.1
##   Income                                                   0.4       0.0
##   Job Training                                             1.9       0.0
##   Legal                                                    0.4       0.2
##   Marriage education                                       0.0       0.0
##   Mental Health Services                                   4.9       2.3
##   Mobility                                                 0.0       0.2
##   Other                                                    9.0      17.4
##   Parenting Education                                     11.6      20.6
##   Social Security Income                                   0.0       0.0
##   Supplemental nutrition/WIC/Food Stamps                   0.4       0.0
##   Transportation assistance                                2.2       0.4
family_referrals_total <- aggregate(family_referrals_aggregate$`Number of referrals`, by=list(x=family_referrals_aggregate$`Family ID`,
                                                                                              y=family_referrals_aggregate$`Program year`), FUN=sum)

colnames(family_referrals_total) <- c("Family ID", "Program year", "Total number of referrals")

family_referrals_total <- family_referrals_total[order(family_referrals_total$`Family ID`),]

#Generate data frame of aggregate family services

family_services_aggregate<-aggregate(family_services$`Service Type`, by=list(x=family_services$ID, 
                                                                             y=family_services$`Program year`, z=family_services$`Service Type`), FUN=length)

colnames(family_services_aggregate ) <- c("Family ID", "Program year", "Service Type", "Number of Services")
family_services_aggregate <- family_services_aggregate[order(family_services_aggregate$`Family ID`),]

#Produce a table of the percentage of family services provided by service type and program year

family_services_table <- table(family_services_aggregate$`Service Type`, family_services_aggregate$`Program year`)
family_services_table_freq <- prop.table(family_services_table, margin=2)
family_services_table_freq <- 100*(round(family_services_table_freq, 3))

family_services_table_freq
##                                                       
##                                                        2015-2016 2016-2017
##   Adult Education                                            0.0       0.0
##   Child Care Service Provider                               96.3       0.0
##   Child sleep safety                                         0.0       0.0
##   Childcare                                                  0.0       0.0
##   Children Education                                         0.0       2.7
##   Diapers for low income families                            0.0      13.0
##   Early Intervention Services/School system                  3.7       0.0
##   Emergency/crisis intervention                              0.0       2.1
##   Family/Social Relations                                    0.0      17.0
##   Financial Literacy                                         0.0       0.3
##   Food/Clothes/Basic Resources                               0.0      25.5
##   Health Care Coverage                                       0.0       0.3
##   Health Education (including prenatal education)            0.0       5.8
##   Housing assistance                                         0.0       2.4
##   Income                                                     0.0       2.4
##   Legal                                                      0.0       0.0
##   Life Skills                                                0.0       4.8
##   Mental Health Services                                     0.0       0.0
##   Mobility                                                   0.0       2.4
##   Other                                                      0.0       1.2
##   Parent Engagement                                          0.0       8.8
##   Parenting Education                                        0.0      11.2
##   Preventive Health Services (Vision; Hearing; Dental)       0.0       0.0
##   Transportation assistance                                  0.0       0.0
##                                                       
##                                                        2017-2018 2018-2019
##   Adult Education                                            0.2       0.5
##   Child Care Service Provider                                0.0       0.0
##   Child sleep safety                                         1.3       0.8
##   Childcare                                                  5.2       0.3
##   Children Education                                         1.1       5.7
##   Diapers for low income families                            9.9      16.9
##   Early Intervention Services/School system                  0.0       0.0
##   Emergency/crisis intervention                              0.0       0.0
##   Family/Social Relations                                   18.7      26.3
##   Financial Literacy                                         0.1       0.0
##   Food/Clothes/Basic Resources                              16.8       0.0
##   Health Care Coverage                                       0.0       0.0
##   Health Education (including prenatal education)            4.6       0.0
##   Housing assistance                                         1.1       2.3
##   Income                                                    19.8       0.0
##   Legal                                                      0.0       3.9
##   Life Skills                                                3.4       0.3
##   Mental Health Services                                     2.1       0.0
##   Mobility                                                   6.9       0.0
##   Other                                                      1.1      16.1
##   Parent Engagement                                          7.1      18.5
##   Parenting Education                                        0.5       5.2
##   Preventive Health Services (Vision; Hearing; Dental)       0.0       3.1
##   Transportation assistance                                  0.3       0.0
family_services_total <- aggregate(family_services_aggregate$`Number of Services`, by=list(x=family_services_aggregate$`Family ID`,
                                                                                           y=family_services_aggregate$`Program year`), FUN=sum)

colnames(family_services_total) <- c("Family ID", "Program year", "Total number of services")
family_services_total <- family_services_total[order(family_services_total$`Family ID`),]

#Generate data frame of aggregate family visits

family_visits_aggregate <- aggregate(family_visits$`Visit Type`, by=list(x=family_visits$ID, 
                                                                         y=family_visits$`Program year`, z=family_visits$`Visit Type`), FUN=length)

colnames(family_visits_aggregate) <- c("Family ID", "Program year", "Visit Type", "Number of Visits")
family_visits_aggregate <- family_visits_aggregate[order(family_visits_aggregate$`Family ID`),]

#Create a table of the percentage of family visits provided by visit type and program year

family_visits_table <- table(family_visits_aggregate$`Visit Type`, family_visits_aggregate$`Program year`)
family_visits_table_freq <- prop.table(family_visits_table, margin=2)
family_visits_table_freq <- 100*(round(family_visits_table_freq, 3))

family_visits_table_freq 
##                                                                    
##                                                                     2012-2013
##   Adult Education                                                         0.0
##   Adult Education, Employment                                             0.0
##   Adult Education, Income                                                 0.0
##   Center Visit                                                            0.0
##   Center Visit, Family/Social Relations                                   0.0
##   Center Visit, Family/Social Relations, Other                            0.0
##   CFE/FSW Home Visit                                                      0.0
##   Child Care                                                              0.0
##   Children's Education                                                    0.0
##   Children's Education, Income                                            0.0
##   Children's Education, Legal                                             0.0
##   Disabilities                                                            0.0
##   Employment                                                              0.0
##   Employment, Family/Social Relations                                     0.0
##   Employment, Family/Social Relations, Legal, Mobility                    0.0
##   Family Contact Visit                                                    0.0
##   Family/Social Relations                                                 0.0
##   Family/Social Relations, Income, Mobility                               0.0
##   Family/Social Relations, Legal                                          0.0
##   Family/Social Relations, Other                                          0.0
##   Health                                                                 50.0
##   Health Care Coverage                                                    0.0
##   Health, Pregnancy Nutrition Visit                                       0.0
##   Health, Pregnancy Nutrition Visit, Children's Education                 0.0
##   Housing                                                                 0.0
##   Housing, Legal                                                          0.0
##   Income                                                                  0.0
##   Legal                                                                   0.0
##   Legal, Mobility                                                         0.0
##   Mental Health                                                           0.0
##   Mental Health, Children's Education, Family/Social Relations            0.0
##   Mental Health, Income                                                   0.0
##   Mental Health, Pregnancy Nutrition Visit, Family/Social Relations       0.0
##   Mobility                                                                0.0
##   Nutrition                                                               0.0
##   Other                                                                   0.0
##   Parent Conference                                                       0.0
##   Pregnancy Health Visit                                                  0.0
##   Pregnancy Nutrition Visit                                               0.0
##   Teacher Home Visit                                                     50.0
##   Teacher Home Visit, Pregnancy Nutrition Visit                           0.0
##                                                                    
##                                                                     2013-2014
##   Adult Education                                                         0.0
##   Adult Education, Employment                                             0.0
##   Adult Education, Income                                                 0.0
##   Center Visit                                                            0.0
##   Center Visit, Family/Social Relations                                   0.0
##   Center Visit, Family/Social Relations, Other                            0.0
##   CFE/FSW Home Visit                                                      0.0
##   Child Care                                                              0.0
##   Children's Education                                                    0.0
##   Children's Education, Income                                            0.0
##   Children's Education, Legal                                             0.0
##   Disabilities                                                            0.0
##   Employment                                                              0.0
##   Employment, Family/Social Relations                                     0.0
##   Employment, Family/Social Relations, Legal, Mobility                    0.0
##   Family Contact Visit                                                    0.0
##   Family/Social Relations                                                 0.0
##   Family/Social Relations, Income, Mobility                               0.0
##   Family/Social Relations, Legal                                          0.0
##   Family/Social Relations, Other                                          0.0
##   Health                                                                 50.0
##   Health Care Coverage                                                    0.0
##   Health, Pregnancy Nutrition Visit                                       0.0
##   Health, Pregnancy Nutrition Visit, Children's Education                 0.0
##   Housing                                                                 0.0
##   Housing, Legal                                                          0.0
##   Income                                                                  0.0
##   Legal                                                                   0.0
##   Legal, Mobility                                                         0.0
##   Mental Health                                                           0.0
##   Mental Health, Children's Education, Family/Social Relations            0.0
##   Mental Health, Income                                                   0.0
##   Mental Health, Pregnancy Nutrition Visit, Family/Social Relations       0.0
##   Mobility                                                                0.0
##   Nutrition                                                               0.0
##   Other                                                                   0.0
##   Parent Conference                                                       0.0
##   Pregnancy Health Visit                                                  0.0
##   Pregnancy Nutrition Visit                                               0.0
##   Teacher Home Visit                                                     50.0
##   Teacher Home Visit, Pregnancy Nutrition Visit                           0.0
##                                                                    
##                                                                     2014-2015
##   Adult Education                                                         0.0
##   Adult Education, Employment                                             0.0
##   Adult Education, Income                                                 0.0
##   Center Visit                                                           17.2
##   Center Visit, Family/Social Relations                                   0.0
##   Center Visit, Family/Social Relations, Other                            0.0
##   CFE/FSW Home Visit                                                      3.4
##   Child Care                                                              0.0
##   Children's Education                                                    0.0
##   Children's Education, Income                                            0.0
##   Children's Education, Legal                                             0.0
##   Disabilities                                                            0.0
##   Employment                                                              0.0
##   Employment, Family/Social Relations                                     0.0
##   Employment, Family/Social Relations, Legal, Mobility                    0.0
##   Family Contact Visit                                                   27.6
##   Family/Social Relations                                                 0.0
##   Family/Social Relations, Income, Mobility                               0.0
##   Family/Social Relations, Legal                                          0.0
##   Family/Social Relations, Other                                          0.0
##   Health                                                                  3.4
##   Health Care Coverage                                                    0.0
##   Health, Pregnancy Nutrition Visit                                       0.0
##   Health, Pregnancy Nutrition Visit, Children's Education                 0.0
##   Housing                                                                 0.0
##   Housing, Legal                                                          0.0
##   Income                                                                  0.0
##   Legal                                                                   0.0
##   Legal, Mobility                                                         0.0
##   Mental Health                                                           0.0
##   Mental Health, Children's Education, Family/Social Relations            0.0
##   Mental Health, Income                                                   0.0
##   Mental Health, Pregnancy Nutrition Visit, Family/Social Relations       0.0
##   Mobility                                                                0.0
##   Nutrition                                                               6.9
##   Other                                                                   0.0
##   Parent Conference                                                       0.0
##   Pregnancy Health Visit                                                  3.4
##   Pregnancy Nutrition Visit                                               3.4
##   Teacher Home Visit                                                     34.5
##   Teacher Home Visit, Pregnancy Nutrition Visit                           0.0
##                                                                    
##                                                                     2015-2016
##   Adult Education                                                         0.0
##   Adult Education, Employment                                             0.0
##   Adult Education, Income                                                 0.0
##   Center Visit                                                            7.1
##   Center Visit, Family/Social Relations                                   0.0
##   Center Visit, Family/Social Relations, Other                            0.0
##   CFE/FSW Home Visit                                                     38.1
##   Child Care                                                              0.0
##   Children's Education                                                    0.0
##   Children's Education, Income                                            0.0
##   Children's Education, Legal                                             0.0
##   Disabilities                                                            2.4
##   Employment                                                              0.0
##   Employment, Family/Social Relations                                     0.0
##   Employment, Family/Social Relations, Legal, Mobility                    0.0
##   Family Contact Visit                                                   23.8
##   Family/Social Relations                                                 0.0
##   Family/Social Relations, Income, Mobility                               0.0
##   Family/Social Relations, Legal                                          0.0
##   Family/Social Relations, Other                                          0.0
##   Health                                                                 19.0
##   Health Care Coverage                                                    0.0
##   Health, Pregnancy Nutrition Visit                                       0.0
##   Health, Pregnancy Nutrition Visit, Children's Education                 0.0
##   Housing                                                                 0.0
##   Housing, Legal                                                          0.0
##   Income                                                                  0.0
##   Legal                                                                   0.0
##   Legal, Mobility                                                         0.0
##   Mental Health                                                           4.8
##   Mental Health, Children's Education, Family/Social Relations            0.0
##   Mental Health, Income                                                   0.0
##   Mental Health, Pregnancy Nutrition Visit, Family/Social Relations       0.0
##   Mobility                                                                0.0
##   Nutrition                                                               0.0
##   Other                                                                   0.0
##   Parent Conference                                                       0.0
##   Pregnancy Health Visit                                                  0.0
##   Pregnancy Nutrition Visit                                               0.0
##   Teacher Home Visit                                                      4.8
##   Teacher Home Visit, Pregnancy Nutrition Visit                           0.0
##                                                                    
##                                                                     2016-2017
##   Adult Education                                                         1.9
##   Adult Education, Employment                                             0.0
##   Adult Education, Income                                                 0.0
##   Center Visit                                                           31.6
##   Center Visit, Family/Social Relations                                   0.0
##   Center Visit, Family/Social Relations, Other                            0.0
##   CFE/FSW Home Visit                                                     26.7
##   Child Care                                                              6.3
##   Children's Education                                                    1.0
##   Children's Education, Income                                            0.0
##   Children's Education, Legal                                             0.0
##   Disabilities                                                            0.0
##   Employment                                                              2.4
##   Employment, Family/Social Relations                                     0.0
##   Employment, Family/Social Relations, Legal, Mobility                    0.0
##   Family Contact Visit                                                    4.4
##   Family/Social Relations                                                 0.5
##   Family/Social Relations, Income, Mobility                               0.0
##   Family/Social Relations, Legal                                          0.0
##   Family/Social Relations, Other                                          0.0
##   Health                                                                  0.5
##   Health Care Coverage                                                    6.3
##   Health, Pregnancy Nutrition Visit                                       0.0
##   Health, Pregnancy Nutrition Visit, Children's Education                 0.0
##   Housing                                                                 0.5
##   Housing, Legal                                                          0.0
##   Income                                                                  1.5
##   Legal                                                                   0.5
##   Legal, Mobility                                                         0.0
##   Mental Health                                                           7.8
##   Mental Health, Children's Education, Family/Social Relations            0.0
##   Mental Health, Income                                                   0.0
##   Mental Health, Pregnancy Nutrition Visit, Family/Social Relations       0.0
##   Mobility                                                                2.9
##   Nutrition                                                               0.0
##   Other                                                                   2.9
##   Parent Conference                                                       1.0
##   Pregnancy Health Visit                                                  0.0
##   Pregnancy Nutrition Visit                                               0.0
##   Teacher Home Visit                                                      1.5
##   Teacher Home Visit, Pregnancy Nutrition Visit                           0.0
##                                                                    
##                                                                     2018-2019
##   Adult Education                                                         2.9
##   Adult Education, Employment                                             2.2
##   Adult Education, Income                                                 0.7
##   Center Visit                                                            8.8
##   Center Visit, Family/Social Relations                                   1.5
##   Center Visit, Family/Social Relations, Other                            2.2
##   CFE/FSW Home Visit                                                     15.4
##   Child Care                                                              0.0
##   Children's Education                                                   11.0
##   Children's Education, Income                                            1.5
##   Children's Education, Legal                                             0.7
##   Disabilities                                                            0.0
##   Employment                                                              6.6
##   Employment, Family/Social Relations                                     0.7
##   Employment, Family/Social Relations, Legal, Mobility                    0.7
##   Family Contact Visit                                                    0.7
##   Family/Social Relations                                                 3.7
##   Family/Social Relations, Income, Mobility                               0.7
##   Family/Social Relations, Legal                                          1.5
##   Family/Social Relations, Other                                          0.7
##   Health                                                                  0.0
##   Health Care Coverage                                                    0.0
##   Health, Pregnancy Nutrition Visit                                       2.2
##   Health, Pregnancy Nutrition Visit, Children's Education                 5.1
##   Housing                                                                 0.7
##   Housing, Legal                                                          0.7
##   Income                                                                  0.7
##   Legal                                                                   1.5
##   Legal, Mobility                                                         0.7
##   Mental Health                                                          17.6
##   Mental Health, Children's Education, Family/Social Relations            0.7
##   Mental Health, Income                                                   0.7
##   Mental Health, Pregnancy Nutrition Visit, Family/Social Relations       0.7
##   Mobility                                                                0.0
##   Nutrition                                                               0.0
##   Other                                                                   4.4
##   Parent Conference                                                       0.0
##   Pregnancy Health Visit                                                  0.0
##   Pregnancy Nutrition Visit                                               0.7
##   Teacher Home Visit                                                      0.0
##   Teacher Home Visit, Pregnancy Nutrition Visit                           0.7
family_visits_total <- aggregate(family_visits_aggregate$`Number of Visits`, by=list(x=family_visits_aggregate$`Family ID`,
                                                                                     y=family_visits_aggregate$`Program year`), FUN=sum)

colnames(family_visits_total) <- c("Family ID", "Program year", "Total number of Visits")
family_visits_total <- family_visits_total[order(family_visits_total$`Family ID`, family_visits_total$`Program year`),]

family_data <- full_join(family_referrals_total, family_services_total, by=c("Family ID", "Program year"))
family_data <- full_join(family_data, family_visits_total, by=c("Family ID", "Program year"))
family_data[is.na(family_data)]<-0
family_data <- unique(family_data)
demographics_enroll_meals_fam <- unique(left_join(demographics_enroll_meals, family_data, by=c("Family ID", "Program year")))

demographics_enroll_meals_fam <- demographics_enroll_meals_fam[, -c(3:4)]

demographics_enroll_meals_fam$`Child Birthdate` <- as.Date(demographics_enroll_meals_fam$`Child Birthdate`, 
                                                           format="%m/%d/%Y")
str(demographics_enroll_meals_fam$`Child Birthdate`)
##  Date[1:3034], format: "2010-10-28" "2008-12-03" "2010-08-04" "2010-08-04" "2009-05-16" ...
’s accounting system Sage/Abila MIP has a report named “Demographics-Review” which includes additional demographic information of children, but most importantly an ID that is used to link a child’s name with the Sage ID in  ’s monthly attendance reports.
Merge attendance data with demographics, meal counts, and family data frames
input_data <- left_join(demographics_enroll_meals_fam, demographics_sage_attendance,
                        by=c("Child Name", "Child Birthdate", "Program year"))

input_data <- unique(input_data)
Include environmental level data of the Early Development Inventory and Kindergarten Readiness Assessment from DC and MD
Include measures of program quality from the Classroom Assessment Scoring System (CLASS) and the Infants and Toddlers Environmental Rating Scale-Revised as well as an indicator of participation in the   Institute Reflective Practice Approach (CIRPA)
Import data of widely held expectations of development and merge with all other data frames in “input_data”
Remove intermediary data frames that will not be used in other parts of this project
rm(all_meals, breakfast, lunch, snack, dinner, meals_counts)

rm(copa_dem_enrollment, copa_meal_counts, copa_program_year, demographics_enrollment, demographics_prog_yr,
   meals, program_year)

rm(family_referrals, family_referrals_table)

rm(family_services_table, family_services)

rm(family_visits_table, copa_family_referrals, copa_family_visits,  family_visits)

rm(attendance, demographics_enroll_meals, 
   demographics_enroll_meals_fam, demographics_sage, demographics_sage_attendance)

rm(family_data, EDI, KRA, EDI_KRA, EDI_KRA_zip, zipcodes)
A regression analysis will be implemented to estimate the relationship between the services and efforts implemented by   to fulfill its mission of “educating young children and youth and strengthening families in a bilingual, multicultural environment” and the likelihood of children ages birth to five of meeting or exceeding widely held expectations of development.
In addition, the impact of teacher participation in the   Institute Reflective Practice Approach (CIRPA) on children’s language and cognitive development and teacher outcomes is estimated in the following chunk of code using a difference-in-difference model.
socialemotional <- lm(socialemotionalspring ~ `Total number of services` + `Total number of Visits` + `Total number of referrals`  +                          `Number of meals` + attendance_rate+ `Number of meals` + CIRPA+ `Instructional Support` + `Emotional Support`                            +`Classroom Organization`, data = outcomes_input_data)

physical <- lm(physicalspring ~ `Total number of services` + `Total number of Visits` + `Total number of referrals`  +                                 `Number of meals` + attendance_rate+ `Number of meals` + CIRPA+ `Instructional Support` + `Emotional Support`                            +`Classroom Organization`, data = outcomes_input_data)


language <- lm(languagespring ~ `Total number of services` + `Total number of Visits` + `Total number of referrals`  +                                 `Number of meals` + attendance_rate+ `Number of meals` + CIRPA+ `Instructional Support` + `Emotional Support`                            +`Classroom Organization`, data = outcomes_input_data)

cognitive <- lm(cognitivespring ~ `Total number of services` + `Total number of Visits` + `Total number of referrals`  +                                 `Number of meals` + attendance_rate+ `Number of meals` + CIRPA+ `Instructional Support` + `Emotional Support`                            +`Classroom Organization`, data = outcomes_input_data)

literacy <- lm(literacyspring ~ `Total number of services` + `Total number of Visits` + `Total number of referrals`  +                                 `Number of meals` + attendance_rate+ `Number of meals` + CIRPA+ `Instructional Support` + `Emotional Support`                            +`Classroom Organization`, data = outcomes_input_data)

mathematics <- lm(mathematicsspring ~ `Total number of services` + `Total number of Visits` + `Total number of referrals`  +                              `Number of meals` + attendance_rate+ `Number of meals` + CIRPA+ `Instructional Support` + `Emotional Support`                            +`Classroom Organization`, data = outcomes_input_data)

tab_model(socialemotional, physical, language, cognitive, literacy, mathematics, title = "Relationship between efforts at   and School Readiness Outcomes",   CSS = list(
  css.depvarhead = 'color: red;',
  css.centeralign = 'text-align: center;', 
  css.firsttablecol = 'font-weight: bold;', 
  css.summary = 'color: blue;'
) , show.ci = FALSE,  use.viewer = FALSE)
Relationship between efforts at   and School Readiness Outcomes 

socialemotionalspring 
physicalspring 
languagespring 
cognitivespring 
literacyspring 
mathematicsspring 
Predictors 
Estimates 
p 
Estimates 
p 
Estimates 
p 
Estimates 
p 
Estimates 
p 
Estimates 
p 
(Intercept) 
1.37 
0.002 
0.94 
0.529 
1.16 
0.008 
1.00 
<0.001 
1.72 
0.061 
2.30 
0.082 
Total number of services 
0.00 
0.652 
-0.00 
0.494 
-0.00 
0.933 
0.00 
0.806 
0.00 
0.385 
0.00 
0.862 
Total number of Visits 
-0.02 
0.426 


0.00 
0.830 
-0.00 
0.822 
-0.03 
0.472 
-0.01 
0.897 
Number of meals 
0.00 
0.973 
-0.00 
0.153 
-0.00 
0.591 
0.00 
0.454 
-0.00 
0.422 
0.00 
0.198 
attendance_rate 
-0.00 
0.474 
-0.01 
0.229 
-0.00 
0.927 
-0.00 
0.161 
-0.01 
0.250 
-0.01 
0.441 
CIRPA 
-0.00 
0.982 
-0.11 
0.216 
0.00 
0.933 
0.00 
0.635 
-0.16 
0.071 
0.01 
0.933 
Instructional Support 
0.03 
0.344 
0.21 
0.126 
0.00 
0.970 
-0.00 
0.554 
0.08 
0.321 
0.01 
0.955 
Emotional Support 
-0.09 
0.300 
0.17 
0.649 
-0.10 
0.275 
0.00 
0.729 
-0.09 
0.676 
-0.39 
0.210 
Classroom Organization 
0.04 
0.474 
-0.16 
0.248 
0.08 
0.165 
-0.00 
0.946 
0.01 
0.909 
0.24 
0.160 
Observations 
68 
41 
68 
68 
57 
60 
R2 / R2 adjusted 
0.061 / -0.066 
0.432 / 0.312 
0.045 / -0.084 
0.498 / 0.430 
0.170 / 0.031 
0.096 / -0.046 
The following ggplots generate plots about  ’s efforts to educate young children and youth and strengthen families in a bilingual multi-cultural environment as well as the school readiness outcomes achieved in a program year
Total children served
#Number of children served per year

total_enrollment <- ggplot(outcomes_input_data, aes(x=`Program year`)) +
  geom_bar(stat="count", fill="blue") + geom_text(aes(label=..count..), stat="count",
                                                  position=position_stack(0.5), size = 4, color="white") + labs(x="Program year", y = "Number of children ages birth to five")+
  theme_minimal() + ggtitle("Children enrolled by program year at  ") +
  theme(plot.title = element_text(hjust = 0.5))

total_enrollment

#Children by gender
child_gender_stats <- table(outcomes_input_data$`Program year`, outcomes_input_data$`Child Gender`)
child_gender_stats <- round(100*(prop.table(child_gender_stats, 1)))
child_gender_stats <- as.data.frame(child_gender_stats)
colnames(child_gender_stats) <- c("Program year", "Child Gender", "Percentage of children")

child_gender <- ggplot() + geom_bar(aes(x=`Program year`, y=`Percentage of children`, fill=`Child Gender`), 
                                    child_gender_stats, stat="identity") + geom_text(aes(x=child_gender_stats$`Program year`,
                                                                                         y=child_gender_stats$`Percentage of children`, label=child_gender_stats$`Percentage of children`),
                                                                                     position=position_stack(0.5), size = 4, color="white") + labs(x="Program year", y = "Percent of children by gender")+
  theme_minimal()+ ggtitle("Percentage of children by gender at  ") + theme(plot.title = element_text(hjust = 0.5),
                                                                            legend.position = "bottom")

child_gender

#Create pie charts of program-models; program models are a proxy for funding sources
child_program_model_stats <- table(outcomes_input_data$`Program year`,
                                   outcomes_input_data$`Child Program Model`)

child_program_model_stats <- round(100*(prop.table(child_program_model_stats, 1)))

child_program_model_stats <- as.data.frame(child_program_model_stats)

colnames(child_program_model_stats) <- c("Program year", "Child Program Model", "Percentage of children")

child_program_model_stats <- subset(child_program_model_stats, child_program_model_stats$`Child Program Model` != 
                                      "Out-of-School Time (OSSE)")

child_program_model_stats <- subset(child_program_model_stats, child_program_model_stats$`Percentage of children` > 1)

child_program_model <- ggplot(child_program_model_stats, aes(x = "", y = `Percentage of children`, 
                                                             fill = `Child Program Model`)) + geom_bar(stat = "identity", position = position_fill(), width = 1) +
  geom_text(aes(label = `Percentage of children`), position = position_fill(vjust = 0.2)) +
  coord_polar(theta = "y") + facet_wrap(~ `Program year`)  + theme(axis.title.x = element_blank(),
                                                                   axis.title.y = element_blank(), axis.text = element_blank(), axis.ticks = element_blank(),
                                                                   panel.grid  = element_blank()) + theme(legend.position='bottom', plot.title = element_text(hjust = 0.5)) + 
  guides(fill=guide_legend(nrow=2, byrow=TRUE)) +
  labs(title = "Percentage of children enrolled at   by Program Model and Program Year")

child_program_model

Calculate the average attendance rate by program year
Attendance data is not recorded in COPA
average_attendance <- subset(outcomes_input_data, outcomes_input_data$`Program Option`!= "Home Based")

monthly_attendance_rate <- aggregate(average_attendance$attendance_rate, by=list(average_attendance$`Program year`), mean, na.rm=T)

colnames(monthly_attendance_rate) <- c("Program year", "Monthly attendance rate")

monthly_attendance_rate$`Monthly attendance rate` <- round(monthly_attendance_rate$`Monthly attendance rate`, 1)

monthly_attendance_rate$`Monthly attendance rate`[is.na("Monthly attendance rate")] <- 0

monthly_attendance_rate <- subset(monthly_attendance_rate, monthly_attendance_rate$`Monthly attendance rate`!=0)

attendance_rate <- ggplot() + geom_bar(aes(x=`Program year`, y=`Monthly attendance rate`), 
                                       monthly_attendance_rate, stat="identity") + geom_text(aes(x=monthly_attendance_rate$`Program year`,
                                                                                                 y=monthly_attendance_rate$`Monthly attendance rate`, label=monthly_attendance_rate$`Monthly attendance rate`),
                                                                                             position=position_stack(0.5), color="white") + labs(x="Program year", y = "Monthly attendance rate")+ geom_text(size = 3, color ="white") +
  scale_fill_manual(values=c("#E69F00"))+ ggtitle("Monthly Attendance Rate")+ theme(plot.title=element_text(hjust=0.5, vjust=0.5, face='bold'), 
                                                                                    legend.position = "none")

attendance_rate

#Calculate the percentage of children enrolled by their primary language
child_primary_language_stats <- table(outcomes_input_data$`Program year`,
                                      outcomes_input_data$`Child Primary Language`)

child_primary_language_stats <- round(100*(prop.table(child_primary_language_stats, 1)))

child_primary_language_stats <- as.data.frame(child_primary_language_stats)

colnames(child_primary_language_stats) <- c("Program year", "Child Primary Language", "Percentage of children")

child_primary_language_stats <- subset(child_primary_language_stats, child_primary_language_stats$`Percentage of children` > 1)

child_primary_language <- ggplot(child_primary_language_stats, aes(x = "", y = `Percentage of children`, 
                                                                   fill = `Child Primary Language`)) + geom_bar(stat = "identity", position = position_fill(), width = 1) +
  geom_text(aes(label = `Percentage of children`), position = position_fill(vjust = 0.2)) +
  coord_polar(theta = "y") + facet_wrap(~ `Program year`)  + theme(axis.title.x = element_blank(),
                                                                   axis.title.y = element_blank(), axis.text = element_blank(), axis.ticks = element_blank(),
                                                                   panel.grid  = element_blank()) + theme(legend.position='bottom',plot.title = element_text(hjust = 0.5)) + 
  guides(fill=guide_legend(nrow=2, byrow=TRUE)) +
  labs(title = "Percentage of children enrolled at   by Primary Language and Program Year")

child_primary_language

#Calculate the proportion of children by their race categories
table(outcomes_input_data$`Child Race`)
## 
##                            Asian                  Asian,Caucasian 
##                               11                                1 
##           Bi-racial/Multi-racial     Bi-racial/Multi-racial,Black 
##                             1423                               12 
## Bi-racial/Multi-racial,Caucasian     Bi-racial/Multi-racial,Other 
##                               14                                6 
##                            Black                  Black,Caucasian 
##                              519                                2 
##            Black,Native American                      Black,Other 
##                                3                                3 
##                        Caucasian                  Caucasian,Other 
##                              389                                2 
##                  Native American                            Other 
##                                7                              121 
##           Other,Pacific Islander                      Unspecified 
##                                4                                6 
##                       Vietnamese 
##                                1
outcomes_input_data$`Child Race`[outcomes_input_data$`Child Race`=="Bi-racial/Multi-racial,Black"] <-"Bi-racial/Multi-racial"
outcomes_input_data$`Child Race`[outcomes_input_data$`Child Race`=="Bi-racial/Multi-racial,Other"] <-"Bi-racial/Multi-racial"
outcomes_input_data$`Child Race`[outcomes_input_data$`Child Race`=="Bi-racial/Multi-racial,Caucasian"] <-"Bi-racial/Multi-racial"
outcomes_input_data$`Child Race`[outcomes_input_data$`Child Race`=="Black,Caucasian"] <-"Black"
outcomes_input_data$`Child Race`[outcomes_input_data$`Child Race`=="Black,Other"] <-"Black"
outcomes_input_data$`Child Race`[outcomes_input_data$`Child Race`=="Black,Native American"] <-"Black"
outcomes_input_data$`Child Race`[outcomes_input_data$`Child Race`=="Caucasian,Other"] <-"Caucasian"
outcomes_input_data$`Child Race`[outcomes_input_data$`Child Race`=="Other,Pacific Islander"] <-"Other"
outcomes_input_data$`Child Race`[outcomes_input_data$`Child Race`=="Vietnamese"] <-"Other"

child_race_stats <- table(outcomes_input_data$`Program year`, outcomes_input_data$`Child Race`)

child_race_stats <- round(100*prop.table(child_race_stats, 1))

child_race_stats <- as.data.frame(child_race_stats)

colnames(child_race_stats) <- c("Program year", "Child Race", "Percentage of children")

child_race_stats <- subset(child_race_stats, child_race_stats$`Percentage of children`>5)

child_race <- ggplot() + geom_bar(aes(y=`Percentage of children`, x=`Program year`, fill=`Child Race`), 
                                  child_race_stats, stat="identity")+theme_minimal() + 
  labs(title="Percentage of children enrolled at   by race",
       x="Program year", y = "Percent of children enrolled")+
  geom_text(aes(x=child_race_stats$`Program year`, y=child_race_stats$`Percentage of children`,
                label = child_race_stats$`Percentage of children`, group = child_race_stats$`Child Race`),
            position = position_stack(vjust = 0.5), size = 4, color = "white") +
  theme(plot.title=element_text( hjust=0.5, face='bold'), legend.position = "bottom")

child_race

#Children by ethnicity
outcomes_input_data$`Child Ethnicity`[is.na(outcomes_input_data$`Child Ethnicity`)] <- "Latino No/Unknown"

child_ethnicity_stats <- table(outcomes_input_data$`Program year`, outcomes_input_data$`Child Ethnicity`)

child_ethnicity_stats <- round(100*(prop.table(child_ethnicity_stats, 1)))

child_ethnicity_stats <- as.data.frame(child_ethnicity_stats)

colnames(child_ethnicity_stats) <- c("Program year", "Child Ethnicity", "Percentage of children")

child_ethnicity <- ggplot() + geom_bar(aes(x=`Program year`, y=`Percentage of children`, fill=`Child Ethnicity`), 
                                       child_ethnicity_stats, stat="identity") + theme(plot.title=element_text( hjust=1, vjust=0.3, face='bold'), 
                                                                                       legend.position = 'bottom')+ labs(title="Percentage of children by ethnicity", x="Program year", 
                                                                                                                         y = "Percent of children enrolled")+theme_bw()+ geom_text(aes(x=child_ethnicity_stats$`Program year`, 
                                                                                                                                                                                       y=child_ethnicity_stats$`Percentage of children`, label = child_ethnicity_stats$`Percentage of children`, 
                                                                                                                                                                                       group = child_ethnicity_stats$`Child Ethnicity`), position = position_stack(vjust = 0.5), size = 4, color = "white") +
  theme_minimal()+ ggtitle("Percentage of children by ethnicity at  ") + theme(plot.title = element_text(hjust = 0.5),
                                                                               legend.position = "bottom")+ scale_fill_brewer(palette="Paired")
child_ethnicity

#Number of families with an income below the federal poverty guideline
outcomes_input_data$underincome <- grepl("Underincome", outcomes_input_data$`Child Income Status`, fixed = TRUE)

outcomes_input_data$underincome[outcomes_input_data$underincome == "TRUE"] <- "Underincome"
outcomes_input_data$underincome[outcomes_input_data$underincome == "FALSE"] <- "Overincome"

underincome <- table(outcomes_input_data$`Program year`, outcomes_input_data$underincome)

underincome <- round(100*prop.table(underincome, 1))

underincome <- as.data.frame(underincome)

colnames(underincome) <- c("Program year", "Income Status", "Percentage of children")

underincome <- subset(underincome, underincome$`Percentage of children`!=0 | underincome$`Income Status`!="Overincome")

underincome_rate <- ggplot() + geom_bar(aes(x=`Program year`, y=`Percentage of children`, fill=`Income Status`), 
                                        underincome, stat="identity") + theme(plot.title=element_text( hjust=1, vjust=0.3, face='bold'), 
                                                                              legend.position = 'bottom')+ labs(title="Percentage of children by income status", x="Program year", 
                                                                                                                y = "Percent of children enrolled")+theme_bw()+ geom_text(aes(x=underincome$`Program year`, 
                                                                                                                                                                              y=underincome$`Percentage of children`, label = underincome$`Percentage of children`, 
                                                                                                                                                                              group = underincome$`Income Status`), position = position_stack(vjust = 0.5), size = 4, color = "white") +
  theme_minimal()+ ggtitle("Percentage of children by income status at  ") + theme(plot.title = element_text(hjust = 0.5),
                                                                                   legend.position = "bottom")+ scale_fill_brewer(palette="Oranges")

underincome_rate

#Family services
family_services_aggregate$`Service Category`<-NA
family_services_aggregate$`Service Category`[family_services_aggregate$`Service Type`=="Child Care Service Provider"]<-"Childcare services"
family_services_aggregate$`Service Category`[family_services_aggregate$`Service Type`=="Child sleep safety"]<-"Childcare services"
family_services_aggregate$`Service Category`[family_services_aggregate$`Service Type`=="Childcare"]<-"Childcare services"
family_services_aggregate$`Service Category`[family_services_aggregate$`Service Type`=="Children Education"]<-"Children education"
family_services_aggregate$`Service Category`[family_services_aggregate$`Service Type`=="Adult Education"]<-"Adult education"
family_services_aggregate$`Service Category`[family_services_aggregate$`Service Type`=="Early Intervention Services/School system"]<-"Children education"
family_services_aggregate$`Service Category`[family_services_aggregate$`Service Type`=="Emergency/crisis intervention"]<-"Food/clothes/basic resources"
family_services_aggregate$`Service Category`[family_services_aggregate$`Service Type`=="Family/Social Relations"]<-"Family/social relations"
family_services_aggregate$`Service Category`[family_services_aggregate$`Service Type`=="Financial Literacy"]<-"Family/Social relations"
family_services_aggregate$`Service Category`[family_services_aggregate$`Service Type`=="Food/Clothes/Basic Resources"]<-"Food/clothes/basic resources"
family_services_aggregate$`Service Category`[family_services_aggregate$`Service Type`=="Health Care Coverage"]<-"Health education and care coverage"
family_services_aggregate$`Service Category`[family_services_aggregate$`Service Type`=="Health Education (including prenatal education)"]<-"Health education and care coverage"
family_services_aggregate$`Service Category`[family_services_aggregate$`Service Type`=="Housing assistance"]<-"Housing assistance"
family_services_aggregate$`Service Category`[family_services_aggregate$`Service Type`=="Income"]<-"Income"
family_services_aggregate$`Service Category`[family_services_aggregate$`Service Type`=="Legal"]<-"Legal"
family_services_aggregate$`Service Category`[family_services_aggregate$`Service Type`=="Life Skills"]<-"Life skills"
family_services_aggregate$`Service Category`[family_services_aggregate$`Service Type`=="Mental Health Services"]<-"Mental health"
family_services_aggregate$`Service Category`[family_services_aggregate$`Service Type`=="Mobility"]<-"Mobility"
family_services_aggregate$`Service Category`[family_services_aggregate$`Service Type`=="Transportation assistance"]<-"Mobility"
family_services_aggregate$`Service Category`[family_services_aggregate$`Service Type`=="Parent Engagement"]<-"Parent engagement"
family_services_aggregate$`Service Category`[family_services_aggregate$`Service Type`=="Other"]<-"Other"
family_services_aggregate$`Service Category`[family_services_aggregate$`Service Type`=="Parenting Education"]<-"Parenting education"
family_services_aggregate$`Service Category`[family_services_aggregate$`Service Type`=="Preventive Health Services (Vision; Hearing; Dental)"]<-"Vision, hearing, dental preventive services"
family_services_aggregate$`Service Category`[family_services_aggregate$`Service Type`=="Diapers for low income families"]<-"Diapers"

family_services <- aggregate(family_services_aggregate$`Number of Services`, by=list(family_services_aggregate$`Program year` , 
                                                                                     family_services_aggregate$`Service Category`), FUN=sum)

colnames(family_services) <- c("Program year", "Service Category", "Number of services")

all_family_services_total <- aggregate(family_services$`Number of services`, by=list(family_services$`Program year`), FUN=sum)

colnames(all_family_services_total) <- c("Program year", "Total number of services")

family_services_total <- full_join(family_services, all_family_services_total, by="Program year")

family_services_total <- mutate(family_services_total, `Percent of family services`=round(100*(`Number of services`/`Total number of services`)))

family_services_total <- subset(family_services_total, family_services_total$`Percent of family services` > 9)

family_services_plot <- ggplot() + geom_bar(aes(y=`Percent of family services`, x=`Program year`, fill=`Service Category`), 
                                            family_services_total, stat="identity") + labs(title="Percentage of family services provided by category", x="Program year", 
                                                                                           y = "Percent of family services")+ geom_text(aes(x=family_services_total$`Program year`, 
                                                                                                                                            y=family_services_total$`Percent of family services`, label = family_services_total$`Percent of family services`, 
                                                                                                                                            group = family_services_total$`Service Category`), position = position_stack(vjust = 0.5), size = 4, color = "white")+
  theme(plot.title=element_text( hjust=0.5, face='bold'), legend.position = "bottom")

family_services_plot

Family visits
family_visits_aggregate$`Visit Category`<-NA
family_visits_aggregate$`Visit Category`[family_visits_aggregate$`Visit Type`=="Adult Education"]<-"Adult education"
family_visits_aggregate$`Visit Category`[family_visits_aggregate$`Visit Type`=="Children's Education"]<-"Children education"
family_visits_aggregate$`Visit Category`[family_visits_aggregate$`Visit Type`=="Family/Social Relations"]<-"Family/social relations"
family_visits_aggregate$`Visit Category`[family_visits_aggregate$`Visit Type`=="Income"]<-"Income"
family_visits_aggregate$`Visit Category`[family_visits_aggregate$`Visit Type`=="Mobility"]<-"Mobility"
family_visits_aggregate$`Visit Category`[family_visits_aggregate$`Visit Type`=="Pregnancy Health Visit"]<-"Pregnancy"
family_visits_aggregate$`Visit Category`[family_visits_aggregate$`Visit Type`=="Pregnancy Nutrition Visit"]<-"Pregnancy"
family_visits_aggregate$`Visit Category`[family_visits_aggregate$`Visit Type`=="Center Visit"]<-"Center visit"
family_visits_aggregate$`Visit Category`[family_visits_aggregate$`Visit Type`=="Disabilities"]<-"Disabilities"
family_visits_aggregate$`Visit Category`[family_visits_aggregate$`Visit Type`=="Health"]<-"Health"
family_visits_aggregate$`Visit Category`[family_visits_aggregate$`Visit Type`=="Legal"]<-"Legal"
family_visits_aggregate$`Visit Category`[family_visits_aggregate$`Visit Type`=="Nutrition"]<-"Nutrition"
family_visits_aggregate$`Visit Category`[family_visits_aggregate$`Visit Type`=="CFE/FSW Home Visit"]<-"CFE/FSW home visit"
family_visits_aggregate$`Visit Category`[family_visits_aggregate$`Visit Type`=="Employment"]<-"Employment"
family_visits_aggregate$`Visit Category`[family_visits_aggregate$`Visit Type`=="Health Care Coverage"]<-"Health care coverage"
family_visits_aggregate$`Visit Category`[family_visits_aggregate$`Visit Type`=="Life Skills"]<-"Life skills"
family_visits_aggregate$`Visit Category`[family_visits_aggregate$`Visit Type`=="Other"]<-"Other"
family_visits_aggregate$`Visit Category`[family_visits_aggregate$`Visit Type`=="Teacher Home Visit"]<-"Teacher home visit"
family_visits_aggregate$`Visit Category`[family_visits_aggregate$`Visit Type`=="Child Care"]<-"Childcare services"
family_visits_aggregate$`Visit Category`[family_visits_aggregate$`Visit Type`=="Family Contact Visit"]<-"Family contact visit"
family_visits_aggregate$`Visit Category`[family_visits_aggregate$`Visit Type`=="Housing"]<-"Housing"
family_visits_aggregate$`Visit Category`[family_visits_aggregate$`Visit Type`=="Mental Health"]<-"Mental health"
family_visits_aggregate$`Visit Category`[family_visits_aggregate$`Visit Type`=="Parent Conference"]<-"Parent conference"

family_visits <- aggregate(family_visits_aggregate$`Number of Visits`, by=list(family_visits_aggregate$`Program year` , 
                                                                               family_visits_aggregate$`Visit Category`), FUN=sum)

colnames(family_visits) <- c("Program year", "Visit Category", "Number of Visits")

all_family_visits_total <- aggregate(family_visits$`Number of Visits`, by=list(family_visits$`Program year`), FUN=sum)

colnames(all_family_visits_total) <- c("Program year", "Total Number of Visits")

family_visits_total <- full_join(family_visits, all_family_visits_total, by="Program year")

family_visits_total <- mutate(family_visits_total, `Percent of family visits`=round(100*(`Number of Visits`/`Total Number of Visits`)))

family_visits_total <- subset(family_visits_total, family_visits_total$`Percent of family visits` > 9)

family_visits_plot <- ggplot() + geom_bar(aes(y=`Percent of family visits`, x=`Program year`, fill=`Visit Category`), 
                                          family_visits_total, stat="identity") + labs(title="Percentage of family visits provided by category", x="Program year",
                                                                                       y = "Percent of family visits")+ geom_text(aes(x=family_visits_total$`Program year`, 
                                                                                                                                      y=family_visits_total$`Percent of family visits`, label = family_visits_total$`Percent of family visits`, 
                                                                                                                                      group = family_visits_total$`Visit Category`), position = position_stack(vjust = 0.5), size = 4, color = "white")+
  theme(plot.title=element_text( hjust=0.5, face='bold'), legend.position = "bottom")

family_visits_plot

Family referrals
family_referrals_aggregate$`Referral Category`<-NA
family_referrals_aggregate$`Referral Category`[family_referrals_aggregate$`Referral Reason`=="Adult Education/GED/CDA"]<-"Adult education"
family_referrals_aggregate$`Referral Category`[family_referrals_aggregate$`Referral Reason`=="Family Literacy"]<-"Adult education"
family_referrals_aggregate$`Referral Category`[family_referrals_aggregate$`Referral Reason`=="Financial Literacy"]<-"Financial literacy"
family_referrals_aggregate$`Referral Category`[family_referrals_aggregate$`Referral Reason`=="Children's Education"]<-"Children education"
family_referrals_aggregate$`Referral Category`[family_referrals_aggregate$`Referral Reason`=="Child Abuse and Neglect Services"]<-"Child abuse and neglect services"
family_referrals_aggregate$`Referral Category`[family_referrals_aggregate$`Referral Reason`=="Child support assistance"]<-"Child support assistance"
family_referrals_aggregate$`Referral Category`[family_referrals_aggregate$`Referral Reason`=="Disabilities/Early Intervention"]<-"Disabilities/Early Intervention"
family_referrals_aggregate$`Referral Category`[family_referrals_aggregate$`Referral Reason`=="Early Intervention Services"]<-"Disabilities/Early Intervention"
family_referrals_aggregate$`Referral Category`[family_referrals_aggregate$`Referral Reason`=="Employment"]<-"Employment"
family_referrals_aggregate$`Referral Category`[family_referrals_aggregate$`Referral Reason`=="Health Care Coverage"]<-"Health care coverage"
family_referrals_aggregate$`Referral Category`[family_referrals_aggregate$`Referral Reason`=="Housing assistance"]<-"Housing"
family_referrals_aggregate$`Referral Category`[family_referrals_aggregate$`Referral Reason`=="Job Training"]<-"Employment"
family_referrals_aggregate$`Referral Category`[family_referrals_aggregate$`Referral Reason`=="Marriage education"]<-"Marriage education"
family_referrals_aggregate$`Referral Category`[family_referrals_aggregate$`Referral Reason`=="Other"]<-"Other"
family_referrals_aggregate$`Referral Category`[family_referrals_aggregate$`Referral Reason`=="Income"]<-"Income"
family_referrals_aggregate$`Referral Category`[family_referrals_aggregate$`Referral Reason`=="Social Security Income"]<-"Income"
family_referrals_aggregate$`Referral Category`[family_referrals_aggregate$`Referral Reason`=="Transportation assistance"]<-"Mobility"
family_referrals_aggregate$`Referral Category`[family_referrals_aggregate$`Referral Reason`=="Domestic violence services"]<-"Family/social relations"
family_referrals_aggregate$`Referral Category`[family_referrals_aggregate$`Referral Reason`=="Family/Social Relations"]<-"Family/social relations"
family_referrals_aggregate$`Referral Category`[family_referrals_aggregate$`Referral Reason`=="Assistance to families of incarcerated individuals"]<-"Family/social relations"
family_referrals_aggregate$`Referral Category`[family_referrals_aggregate$`Referral Reason`=="Child Care Service Provider"]<-"Child care"
family_referrals_aggregate$`Referral Category`[family_referrals_aggregate$`Referral Reason`=="Diapers"]<-"Diapers"
family_referrals_aggregate$`Referral Category`[family_referrals_aggregate$`Referral Reason`=="Emergency/crisis intervention"]<-"Emergency/crisis interventions"
family_referrals_aggregate$`Referral Category`[family_referrals_aggregate$`Referral Reason`=="ESL training"]<-"ESL training"
family_referrals_aggregate$`Referral Category`[family_referrals_aggregate$`Referral Reason`=="Food/Clothes/Basic Resources"]<-"Food/Clothes/Basic Resources"
family_referrals_aggregate$`Referral Category`[family_referrals_aggregate$`Referral Reason`=="Health Education (including prenatal education)"]<-"Health education"
family_referrals_aggregate$`Referral Category`[family_referrals_aggregate$`Referral Reason`=="Legal"]<-"Legal"
family_referrals_aggregate$`Referral Category`[family_referrals_aggregate$`Referral Reason`=="Mental Health Services"]<-"Mental health"
family_referrals_aggregate$`Referral Category`[family_referrals_aggregate$`Referral Reason`=="Parenting Education"]<-"Parenting education"
family_referrals_aggregate$`Referral Category`[family_referrals_aggregate$`Referral Reason`=="Supplemental nutrition/WIC/Food Stamps"]<-"Nutrition/WIC/Food Stamps"

family_referrals <- aggregate(family_referrals_aggregate$`Number of referrals`, by=list(family_referrals_aggregate$`Program year` , 
                                                                                        family_referrals_aggregate$`Referral Category`), FUN=sum)

colnames(family_referrals) <- c("Program year", "Referral Category", "Number of referrals")

all_family_referrals_total <- aggregate(family_referrals$`Number of referrals`, by=list(family_referrals$`Program year`), FUN=sum)

colnames(all_family_referrals_total) <- c("Program year", "Total Number of referrals")

family_referrals_total <- full_join(family_referrals, all_family_referrals_total, by="Program year")

family_referrals_total <- mutate(family_referrals_total, `Percent of family referrals`=round(100*(`Number of referrals`/`Total Number of referrals`)))

family_referrals_total <- subset(family_referrals_total, family_referrals_total$`Percent of family referrals` > 9)

family_referrals_plot <- ggplot() + geom_bar(aes(y=`Percent of family referrals`, x=`Program year`, fill=`Referral Category`), 
                                             family_referrals_total, stat="identity") + labs(title="Percentage of family referrals provided by category", 
                                                                                             x="Program year", y = "Percent of family referrals")+ geom_text(aes(x=family_referrals_total$`Program year`, 
                                                                                                                                                                 y=family_referrals_total$`Percent of family referrals`, label = family_referrals_total$`Percent of family referrals`,
                                                                                                                                                                 group = family_referrals_total$`Referral Category`), position = position_stack(vjust = 0.5), size = 4, color = "white")+
  theme(plot.title=element_text( hjust=0.5, face='bold'), legend.position = "bottom")

family_referrals_plot

#Number of families receiving services by program year
outcomes_input_data <- mutate(outcomes_input_data, `Total services`=outcomes_input_data$`Total number of referrals` + 
                                outcomes_input_data$`Total number of services`+outcomes_input_data$`Total number of Visits`)

number_of_families <- subset(outcomes_input_data, !is.na(outcomes_input_data$`Family ID`))
number_of_families <- subset(outcomes_input_data, outcomes_input_data$`Total services`!=0)
number_of_families <- unique(number_of_families[, c("Program year",  "Family ID")])

number_of_families <- aggregate(number_of_families$`Family ID`, by=list(number_of_families$`Program year`), FUN=length)
colnames(number_of_families) <- c("Program year", "Number of families")

number_of_families_plot <-ggplot(number_of_families, aes(number_of_families$`Program year`, `Number of families`))

number_of_families_plot <- number_of_families_plot + geom_bar(stat="identity", fill="lightblue")+
  ggtitle("Number of families served by program year at  ") +theme(plot.title=element_text( hjust=0.3, vjust=0.3, face='bold'),
                                                                   legend.position = 'bottom')+labs(x="Program year", y = "Number of families")+ geom_text(size = 3, position = position_stack(vjust = 0.5), 
                                                                                                                                                           aes(x=number_of_families$`Program year`, y=number_of_families$`Number of families`, label=number_of_families$`Number of families`))+
  ggtitle("Number of families served at  ") + theme(plot.title = element_text(hjust = 0.5))

number_of_families_plot

#Generate a plot of school readiness outcomes
school_readiness_program_year <- as.data.frame(unique(outcomes_input_data$`Program year`))
colnames(school_readiness_program_year) <- c("Program year")
school_readiness_program_year$`Program year` <- school_readiness_program_year[order(school_readiness_program_year$`Program year`), ]

school_readiness_program_year <- school_readiness_program_year %>% mutate(id = row_number())

last_school_year <- subset(school_readiness_program_year$`Program year`, 
                           school_readiness_program_year$id == max(school_readiness_program_year$id))
last_school_year <- droplevels(last_school_year)

school_readiness <- subset(outcomes_input_data, outcomes_input_data$`Program year` == last_school_year)

school_readiness <- subset(school_readiness, school_readiness$`Child Program Model`=="PRE-KEEP" | 
                             school_readiness$`Child Program Model`=="Maryland Pre-K")

table(school_readiness$`Program year`)
## 
## 2018-2019 
##       385
school_readiness <- school_readiness[, c("Program year", "Child ID", "Child Program Model", "socialemotionalfall", "socialemotionalwinter", 
                                         "socialemotionalspring", "physicalfall", "physicalwinter", "physicalspring", "languagefall", 
                                         "languagewinter", "languagespring", "cognitivefall", "cognitivewinter", "cognitivespring", 
                                         "literacyfall", "literacywinter", "literacyspring", "mathematicsfall", "mathematicswinter", 
                                         "mathematicsspring")]

average_school_readiness <- aggregate(school_readiness[,4:21], 
                                      by=list(school_readiness$`Program year`), FUN=mean, na.rm=TRUE)

average_school_readiness <- average_school_readiness[, -c(1)]
average_school_readiness <- round(100*average_school_readiness)

average_school_readiness_tr <- transpose(average_school_readiness)

average_school_readiness_tr <- average_school_readiness_tr %>% mutate(id = row_number())
average_school_readiness_tr$`Area of Development`[average_school_readiness_tr$id <= 3] <- "Social Emotional"
average_school_readiness_tr$`Area of Development`[average_school_readiness_tr$id <= 6 & 
                                                    average_school_readiness_tr$id >= 4] <- "Physical"
average_school_readiness_tr$`Area of Development`[average_school_readiness_tr$id <= 9 & 
                                                    average_school_readiness_tr$id >= 7] <- "Language"
average_school_readiness_tr$`Area of Development`[average_school_readiness_tr$id <= 12 & 
                                                    average_school_readiness_tr$id >= 10] <- "Cognitive"
average_school_readiness_tr$`Area of Development`[average_school_readiness_tr$id <= 15 & 
                                                    average_school_readiness_tr$id >= 13] <- "Literacy"
average_school_readiness_tr$`Area of Development`[average_school_readiness_tr$id <= 18 & 
                                                    average_school_readiness_tr$id >= 16] <- "Mathematics"

average_school_readiness_tr$Checkpoint[average_school_readiness_tr$id ==1 | average_school_readiness_tr$id ==4 |
                                         average_school_readiness_tr$id ==7 | average_school_readiness_tr$id ==10 |
                                         average_school_readiness_tr$id ==13 |  average_school_readiness_tr$id ==16] <- "Fall"

average_school_readiness_tr$Checkpoint[average_school_readiness_tr$id ==2 | average_school_readiness_tr$id ==5 |
                                         average_school_readiness_tr$id ==8 | average_school_readiness_tr$id ==11 |
                                         average_school_readiness_tr$id ==14 |  average_school_readiness_tr$id ==17] <- "Winter"

average_school_readiness_tr$Checkpoint[average_school_readiness_tr$id ==3 | average_school_readiness_tr$id ==6 |
                                         average_school_readiness_tr$id ==9 | average_school_readiness_tr$id ==12 |
                                         average_school_readiness_tr$id ==15 |  average_school_readiness_tr$id ==18] <- "Spring"
average_school_readiness_tr$Checkpoint <- factor(average_school_readiness_tr$Checkpoint,
                                                 levels=c("Fall", "Winter", "Spring"))
average_school_readiness_tr$`Area of Development` <- factor(average_school_readiness_tr$`Area of Development`,
                                                            levels=c("Social Emotional", "Physical", "Language", "Cognitive", "Literacy", "Mathematics"))

school_readiness_plot <- ggplot(average_school_readiness_tr, aes(`Area of Development`, V1)) +   
  geom_bar(aes(fill = `Checkpoint`), position = "dodge", stat="identity") + labs(title="Percentage of Pre-K children meeting or exceeding widely held expectations of development", 
                                                                                 x="Area of Development", y = "Percent of children")+ theme(plot.title=element_text( hjust=0.5, face='bold'), legend.position = "bottom")

school_readiness_plot

Using the ggplots created, generate a ShinyDashboard that can be accessed at http://127.0.0.1:6351/
  ##########################                    
#Create a shiny dashboard# 
##########################

ui <- dashboardPage(skin="purple",
                    dashboardHeader(title="  ECE Outcomes", titleWidth = 450),
                    dashboardSidebar(width=300, sliderInput("slider", "Year:", 2012, 2025, 2017),
                                     sidebarMenu(
                                       menuItem("Demographics-and-attendance", tabName = "Demographics-and-attendance", icon = icon("chalkboard-teacher")),
                                       menuItem("Child-Program-Model", tabName = "Child-Program-Model", icon = icon("school")),
                                       menuItem("Child-Primary-Language", tabName = "Child-Primary-Language", icon = icon("child")),
                                       menuItem("Family-Services", tabName = "Family-Services", icon = icon("school")),
                                       menuItem("Widely-Held-Expectations", tabName = "Widely-Held-Expectations", icon = icon("child"))
                                     )
                    ),
                    dashboardBody(
                      tabItems(
                        tabItem(tabName = "Demographics-and-attendance",
                                fluidRow(
                                  box(title = "Enrollment", status = "primary", solidHeader = TRUE, plotOutput("total_enrollment", height = 200)),
                                  box(title = "Average Monthly Attendance", status="success", solidHeader = TRUE, plotOutput("attendance_rate", height = 200))
                                ),
                                fluidRow(
                                  box(title = "Child Gender", status="warning", solidHeader = TRUE, plotOutput("child_gender", height = 200)),
                                  box(title = "Child Race", status = "danger", solidHeader = TRUE, plotOutput("child_race", height = 200))
                                ),
                                
                                fluidRow(
                                  box(title = "Child Ethnicity", status="warning", solidHeader = TRUE, plotOutput("child_ethnicity", height = 200)),
                                  box(title = "Income Status", status = "danger", solidHeader = TRUE, plotOutput("underincome_rate", height = 200))
                                )
                        ), 
                        
                        tabItem(tabName = "Child-Program-Model", 
                                fluidRow(    
                                  box(title = "Child Program Model", status = "info", solidHeader = TRUE, plotOutput("child_program_model"), height = 700, width = 700)
                                )), 
                        
                        tabItem(tabName ="Child-Primary-Language",
                                fluidRow(
                                  box(title = "Child Primary Language", status="primary", solidHeader = TRUE, plotOutput("child_primary_language"), 
                                      height = 700, width = 700)
                                )),
                        
                        tabItem(tabName = "Family-Services",
                                fluidRow(
                                  box(title = "Number of families served", status = "primary", solidHeader = TRUE, plotOutput("number_of_families_plot", height = 200)),
                                  box(title = "Family Service Categories", status="success", solidHeader = TRUE, plotOutput("family_services_plot", height = 200))
                                ),
                                
                                fluidRow(
                                  box(title = "Family Visits Categories", status="warning", solidHeader = TRUE, plotOutput("family_visits_plot", height = 200)),
                                  box(title = "Family Referrals Categories", status = "danger", solidHeader = TRUE, plotOutput("family_referrals_plot", height = 200))
                                )),
                        
                        tabItem(tabName = "Widely-Held-Expectations",
                                fluidRow(
                                  box(title = "School Readiness Outcomes", status = "success", solidHeader = TRUE, plotOutput("school_readiness_plot"), 
                                      height = 700, width = 900))
                        )
                      )
                    )
)

server <- function(input, output) {
  output$total_enrollment <-renderPlot({total_enrollment})
  output$child_gender <-renderPlot({child_gender})
  output$child_program_model <-renderPlot({child_program_model}, height= 630, width = 1000)
  output$attendance_rate <-renderPlot({attendance_rate})
  output$child_race <-renderPlot({child_race})
  output$child_primary_language <-renderPlot({child_primary_language}, height= 630, width = 1000)
  output$child_ethnicity <-renderPlot({child_ethnicity})
  output$underincome_rate <-renderPlot({underincome_rate})
  output$number_of_families_plot <-renderPlot({number_of_families_plot})
  output$family_services_plot <-renderPlot({family_services_plot})
  output$family_visits_plot <-renderPlot({family_visits_plot})
  output$family_referrals_plot <-renderPlot({family_referrals_plot})
  output$school_readiness_plot <-renderPlot({school_readiness_plot}, height= 630, width = 1000)
}

shinyApp(ui, server)
Shiny applications not supported in static R Markdown documents
Generate the R-markdown document
To review the code used in this project, and to review the data visualizations and regression output, please knit the output to an HTML document by clicking on the “Knit” button above. Choose “HTML”. After the HTML document generated, please save the document to this folder as “S:-ECE-Longitudinal-Data-Analysis.html”. When the option to export the file as a Shiny report opens, please select “No”.
