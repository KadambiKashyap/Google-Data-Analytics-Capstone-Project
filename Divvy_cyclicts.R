# install packages and loading library
# tidyverse for data import and wrangling
# lubridate for date functions
# ggplot for visualization

install.packages("tidyverse")
install.packages("lubridate")
install.packages("ggplot2")


library(tidyverse)
library(lubridate)
library(ggplot2)

#=========================
# STEP 1: COLLECTING DATA
#=========================


# importing files
q2_2019 <- read.csv("Divvy_Trips_2019_Q2.csv")
q3_2019 <- read.csv("Divvy_Trips_2019_Q3.csv")
q4_2019 <- read.csv("Divvy_Trips_2019_Q4.csv")
q1_2020 <- read.csv("Divvy_Trips_2020_Q1.csv")

#========================================================
# STEP 2:DATA WRANGLING AND COMBINING INTO A SINGLE FILE
#========================================================

#Compare column names each of the files

colnames(q1_2020)
colnames(q4_2019)
colnames(q3_2019)
colnames(q2_2019)

# Renaming columns to make them consistent with q1_2020

(q2_2019 <-rename(q2_2019
                  ,ride_id = "X01...Rental.Details.Rental.ID"                    
                  ,started_at = "X01...Rental.Details.Local.Start.Time"            
                  ,ended_at = "X01...Rental.Details.Local.End.Time"               
                  ,rideable_type = "X01...Rental.Details.Bike.ID"                     
                  ,start_station_id = "X03...Rental.Start.Station.ID"                    
                  ,start_station_name = "X03...Rental.Start.Station.Name"                   
                  ,end_station_id = "X02...Rental.End.Station.ID"                      
                  ,end_station_name = "X02...Rental.End.Station.Name"                     
                  ,member_casual = "User.Type"))

(q3_2019 <-rename(q3_2019
                  ,ride_id = "trip_id"
                  ,started_at = "start_time"
                  ,ended_at = "end_time"
                  ,rideable_type = "bikeid"
                  ,start_station_id = "from_station_id"
                  ,start_station_name = "from_station_name"
                  ,end_station_id = "to_station_id"
                  ,end_station_name = "to_station_name"  
                  ,member_casual = "usertype"))

(q4_2019 <-rename(q4_2019
                  ,ride_id = "trip_id"
                  ,started_at = "start_time"
                  ,ended_at = "end_time"         
                  ,rideable_type = "bikeid"
                  ,start_station_id = "from_station_id"  
                  ,start_station_name = "from_station_name"
                  ,end_station_id = "to_station_id"
                  ,end_station_name = "to_station_name"  
                  ,member_casual = "usertype"))


# changing data types to characters
str(q2_2019)
str(q3_2019)
str(q4_2019)
str(q1_2020)


# Convert ride_id and rideable_type to character so that they can stack correctly

q4_2019 <-mutate(q4_2019, ride_id = as.character(ride_id),
                 rideable_type = as.character(rideable_type))

q3_2019 <-mutate(q3_2019, ride_id = as.character(ride_id),
                 rideable_type = as.character(rideable_type))

q2_2019 <-mutate(q2_2019, ride_id = as.character(ride_id),
                 rideable_type = as.character(rideable_type))


# appending data
all_trips <- bind_rows(q2_2019, q3_2019, q4_2019, q1_2020)


# removing unnecessary columns
all_trips <- all_trips %>%  
  select(-c(start_lat, start_lng, end_lat, end_lng, birthyear, gender, "01 - Rental Details Duration In Seconds Uncapped", "05 - Member Details Member Birthday Year", "Member Gender", "tripduration"))

#=============================================================
# STEP 3: CLEANING UP AND ADDING DATA TO PREPARE FOR ANALYSIS
#=============================================================

colnames(all_trips)  #List of column names

nrow(all_trips)  #How many rows are in data frame

dim(all_trips)  #Dimensions of the data frame

head(all_trips)  #collecting the first 6 rows of data frame.

str(all_trips)  #Seeing list of columns and data types (numeric, character, etc)

summary(all_trips)  #Statistical summary of data. Mainly for numerics

# In the "member_casual" column, replace "Subscriber" with "member" and "Customer" with "casual"
# Before 2020, Divvy used different labels for these two types of riders ... we will want to make our dataframe consistent with their current nomenclature


# Begin by seeing how many observations fall under each usertype

table(all_trips$member_casual)

# Reassigning to the desired values (we will go with the current 2020 labels)
  all_trips <-  all_trips %>% 
 	 mutate(member_casual = recode(member_casual
                           ,"Subscriber" = "member"
                           ,"Customer" = "casual"))

# Checking to make sure the proper number of observations were reassigned
table(all_trips$member_casual)


# Changing the format of month, day_of_week columns.The default format is yyyy-mm-dd

all_trips$date <- as.Date(all_trips$started_at) 
all_trips$month <- format(as.Date(all_trips$date), "%m")
all_trips$day <- format(as.Date(all_trips$date), "%d")
all_trips$year <- format(as.Date(all_trips$date), "%Y")
all_trips$day_of_week <- format(as.Date(all_trips$date), "%A")

# Adding a "ride_length" calculation to all_trips (in seconds)

all_trips$ride_length <- difftime(all_trips$ended_at,all_trips$started_at)

# Inspecting the structure of the columns
str(all_trips)

# Converting "ride_length" from Factor to numeric 
all_trips$ride_length <- as.numeric(as.character(all_trips$ride_length))
is.numeric(all_trips$ride_length)

# Removing null values as checked for quality by Divvy or ride_length was negative

all_trips_v2 <- all_trips[!(all_trips$start_station_name == "HQ QR" | all_trips$ride_length<0),]


#===========================================
# STEP 4: CONDUCTING DESCRIPTIVE ANALYSIS
#===========================================

# Descriptive analysis on ride_length (all figures in seconds)

mean(all_trips_v2$ride_length) 
median(all_trips_v2$ride_length) #midpoint number in the ascending array of ride lengths
max(all_trips_v2$ride_length) 
min(all_trips_v2$ride_length) 

# Comparing members and casual users
aggregate(all_trips_v2$ride_length ~ all_trips_v2$member_casual, FUN = mean)
aggregate(all_trips_v2$ride_length ~ all_trips_v2$member_casual, FUN = median)
aggregate(all_trips_v2$ride_length ~ all_trips_v2$member_casual, FUN = max)
aggregate(all_trips_v2$ride_length ~ all_trips_v2$member_casual, FUN = min)

# Checking teh average ride time by each day for members vs casual users
aggregate(all_trips_v2$ride_length ~ all_trips_v2$member_casual + all_trips_v2$day_of_week, FUN = mean)


# Noticing that the days of the week are out of order
all_trips_v2$day_of_week <- ordered(all_trips_v2$day_of_week, levels=c("Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"))

# Now running the same code as above before to verify if the weekday column is in order
aggregate(all_trips_v2$ride_length ~ all_trips_v2$member_casual + all_trips_v2$day_of_week, FUN = mean)


# Analyzing ridership data by type and weekday

all_trips_v2 %>% 
  mutate(weekday = wday(started_at, label = TRUE)) %>%  
  group_by(member_casual, weekday) %>%  
  summarise(number_of_rides = n(),average_duration = mean(ride_length)) %>% 
  arrange(member_casual, weekday)	


# Visualizing the number of rides by rider type

all_trips_v2 %>% 
  mutate(weekday = wday(started_at, label = TRUE)) %>% 
  group_by(member_casual, weekday) %>% 
  summarise(number_of_rides = n(),average_duration = mean(ride_length)) %>% 
  arrange(member_casual, weekday)  %>% 
  ggplot(aes(x = weekday, y = number_of_rides, fill = member_casual)) +
  geom_col(position = "dodge")


# Creating a visualization for average duration by Day (Bar Graph)

all_trips_v2 %>% 
  mutate(weekday = wday(started_at, label = TRUE)) %>% 
  group_by(member_casual, weekday) %>% 
  summarise(number_of_rides = n(),average_duration = mean(ride_length)) %>% 
  arrange(member_casual, weekday)  %>% 
  ggplot(aes(x = weekday, y = average_duration, fill = member_casual)) +
  geom_col(position = "dodge")+
  theme (axis.text.x = element_text(angle =45)) +
  labs(title = " Average Trip Duration by Day and Rider Type",
       x = "Weekday", y = "Average Trip Duration (min)", fill = "Rider Type")

# Trip Count by Month and Rider Type (Bar Graph)
all_trips_v2 %>% 
  mutate(weekday = wday(started_at, label = TRUE)) %>%
  group_by(member_casual, month) %>% 
  summarise(number_of_rides = n(), .groups = "drop") %>% 
  arrange(member_casual, month)  %>% 
  ggplot(aes(x = month, y = number_of_rides, fill = member_casual)) +
  scale_y_continuous(label=scales::comma) +
  geom_col(position = "dodge") +
  labs(title = "Trip Count by Month and Rider Type",
       x = "Month", y = "Trip Count", fill = "Rider Type")+
  coord_flip()


# Trip Count by Hour of Day and Rider Type (Line Graph)
all_trips_v2 %>% 
      mutate(weekday = wday(started_at, label = TRUE)) %>%
  	group_by(member_casual, hour) %>% 
 	summarise(number_of_rides = n(), .groups = "drop") %>% 
  	arrange(member_casual, hour) %>% 
  	ggplot(aes(x = hour, y = number_of_rides, color = member_casual)) +
 	scale_y_continuous(label=scales::comma) +
  	geom_line(aes(group = member_casual)) +
  	theme (axis.text.x = element_text(angle =90)) +
  	labs(title = " Trip Count by Hour of Day and Rider Type", x = "Hour", 
       y = "Trip Count", color = "Rider Type")


#====================================================
# STEP 5: EXPORTING SUMMARY FILE FOR FURTHER ANALYSIS
#====================================================

# Create a csv file that we will visualize in Excel, Tableau

counts <- aggregate(all_trips_v2$ride_length ~ all_trips_v2$member_casual + all_trips_v2$day_of_week, FUN = mean)
write.csv(counts, file = 'C:\Users\Documents\Divvy_Exercise\avg_ride_length.csv')

