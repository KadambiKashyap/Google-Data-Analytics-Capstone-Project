# Google-Data-Analytics-Capstone-Project
  - - - -
  This repository contains code for Capstone Project (Case Study 1) done as part of Coursera Google Data Analytics Professional Certificate.

## Scenario
  You are a junior data analyst working in the marketing analyst team at Cyclistic, a bike-share company in Chicago. The director of marketing believes the company’s future success depends on maximizing the number of annual memberships. Therefore, your team wants to understand how casual riders and annual members use Cyclistic bikes differently. From these insights, your team will design a new marketing strategy to convert casual riders into annual members. But first, Cyclistic executives must approve your recommendations, so they must be backed up with compelling data insights and professional data visualizations.

  The project contains the following six step data analysis process: ask, prepare, process, analyze, share, and act.

# Step 1. Ask

## About the Company
In 2016, Cyclistic launched a successful bike-share offering. Since then, the program has grown to a fleet of 5,824 bicycles that are geo-tracked and locked into a network of 692 stations across Chicago. The bikes can be unlocked from one station and returned to any other station in the system anytime.



## Summary of Business Task
The goal of this case study is to identify how do annual members and casual riders use Cyclistic bikes differently in order to develop a new marketing strategy by the Marketing group to introduce more annual cyclists members 

## Project Objectives
Why would casual riders buy Cyclistic annual memberships?
How do annual members and casual riders use Cyclistic bikes differently?
How can Cyclistic use digital media to influence casual riders to become members?

## Stakeholders

 * Primary Stakeholders: **Lily Moreno(Director of marketing)** and **Cyclistic executive team**
 * Secondary Stakeholders: Cyclistic marketing analytics team
  - - - -
# Step 2. Prepare
 
[12-month Cyclistic trip data](https://divvy-tripdata.s3.amazonaws.com/index.html) (May-2020 to Apr-2021) provided by Divvy, the data has been made available by Motivate International Inc.

ROCCC approach is used to determine the credibility of the data

* Reliable – It is complete and accurate and it represents all bike rides taken in the city of Chicago for the selected duration of our analysis.
* Original - The data is made available by Motivate International Inc. which operates the city of Chicago’s Divvy bicycle sharing service which is powered by Lyft.
* Comprehensive - the data includes all information about ride details including starting time, ending time, station name, station ID, type of membership and many more.
* Current – It is up-to-date as it includes data until end of May 2021
* Cited - The data is cited and is available under Data License Agreement.

### Tool
Analysis of the data is done by using R programming
  - - - -
# Step 3. Process
The following [.r code](https://github.com/KadambiKashyap/Google-Data-Analytics-Capstone-Project/blob/main/Divvy_cyclicts.R) are the detailed code for the Process step
  - - - -
# Step 4. Analyze
The following [.r code](https://github.com/KadambiKashyap/Google-Data-Analytics-Capstone-Project/blob/main/Divvy_cyclicts.R) are the detailed code for the Analyze step
 - - - -
# Step 5. Share
The following [.r code](https://github.com/KadambiKashyap/Google-Data-Analytics-Capstone-Project/blob/main/Divvy_cyclicts.R) are the detailed code for the Share step
  - - - -
# Step 6. Act
After the analysis of the given Cyclists Data, we can come to the following conclusions:

- **Casual riders have the highest rides on weekends while Annual members, on weekdays.**
- **Casual riders take less number of rides but for longer durations.**
- **Summer(June, July & August) would be the months with the highest number of trips made by casual riders..**
- **Casual riders mostly use bikes for recreational purposes.**
- **The stations with highest casual riders are Streeter Dr & Grand Ave.**


## Recommendations

* Increase of marketing efforts at the top 5 most frequented stations by casual riders.
* Introduce a point-award incentive system for riding more trips in a membership format to receive discount and additional offers. Note:(Points should   be based on trip duration given that casual riders have higher trip duration/ride length when compared to Annual members)
* Implement a Membership referral program . Social media would make it easier for the current members to participate in such promotion plan.
* Implement a weekend promo where riders can purchase weekend passes as it is the most popular time in the week to use Cyclistic bikes.
* Implement a summer discount where riders can purchase summer passes given that the total amount of trips increases in the summer and highest in       August.

