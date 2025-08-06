#Daily Activity 
-- Making Database --
CREATE DATABASE project_bellabeat; 

-- Making Database --
USE project_bellabeat;
#6
-- Load Data --
#Load data use table import wizard

-- Standardizing Data --
#Rename Table
RENAME TABLE daily_activity_merged TO daily_activity;

SELECT * FROM daily_activity;

#Cheking Total Colums
SELECT COUNT(Id) AS total_columns FROM daily_activity; 

#Cheking Structure Table
DESCRIBE daily_activity;

#Standardizing Format Date
UPDATE daily_activity
SET ActivityDate = STR_TO_DATE(ActivityDate, '%m/%d/%Y');

#Change Column Name & Type Data
ALTER TABLE daily_activity
	CHANGE COLUMN Id id 												VARCHAR(20),
    CHANGE COLUMN ActivityDate activity_date 							DATE,
    CHANGE COLUMN TotalSteps total_steps 								INT,
    CHANGE COLUMN TotalDistance total_distance 							FLOAT(8,2),
    CHANGE COLUMN TrackerDistance tracker_distance 						FLOAT(8,2),
    CHANGE COLUMN LoggedActivitiesDistance logged_activities_distance 	INT,
    CHANGE COLUMN VeryActiveDistance very_active_distance 				FLOAT(8,2),
    CHANGE COLUMN ModeratelyActiveDistance moderately_active_distance 	FLOAT(8,2),
    CHANGE COLUMN LightActiveDistance light_active_distance 			FLOAT(8,2),
    CHANGE COLUMN SedentaryActiveDistance sedentary_active_distance 	INT,
    CHANGE COLUMN VeryActiveMinutes very_active_minutes 				INT,
    CHANGE COLUMN FairlyActiveMinutes fairly_active_minutes 			INT,
    CHANGE COLUMN LightlyActiveMinutes lightly_active_minutes 			INT,
    CHANGE COLUMN SedentaryMinutes sedentary_minutes 					INT,
    CHANGE COLUMN Calories calories 									INT;
    
-- Data Cleaning --
#Backup The Data Before Cleaning
CREATE TABLE daily_activity_backup LIKE daily_activity;
INSERT INTO daily_activity_backup 
	SELECT * FROM daily_activity;
    
#Ceking Missing Values
SELECT *
FROM daily_activity
WHERE id 							IS NULL
   OR activity_date 				IS NULL
   OR total_steps 					IS NULL
   OR total_distance 				IS NULL
   OR tracker_distance 				IS NULL
   OR logged_activities_distance 	IS NULL
   OR very_active_distance 			IS NULL
   OR moderately_active_distance 	IS NULL
   OR light_active_distance 		IS NULL
   OR sedentary_active_distance 	IS NULL
   OR very_active_minutes 			IS NULL
   OR fairly_active_minutes 		IS NULL
   OR lightly_active_minutes 		IS NULL
   OR sedentary_minutes 			IS NULL
   OR calories 						IS NULL; #Hasilnya 0
 
 #Cheking Duplicate Values
SELECT 
    id, activity_date, total_steps, total_distance, tracker_distance,
    logged_activities_distance, very_active_distance, moderately_active_distance,
    light_active_distance, sedentary_active_distance, very_active_minutes,
    fairly_active_minutes, lightly_active_minutes, sedentary_minutes, calories,
    COUNT(*) AS jumlah
FROM 
    daily_activity
GROUP BY 
    id, activity_date, total_steps, total_distance, tracker_distance,
    logged_activities_distance, very_active_distance, moderately_active_distance,
    light_active_distance, sedentary_active_distance, very_active_minutes,
    fairly_active_minutes, lightly_active_minutes, sedentary_minutes, calories
HAVING 
    COUNT(*) > 1; 

#Cheking unique data
SELECT
  COUNT(DISTINCT id) AS unique_id 
FROM daily_activity; #The data shows 33 unique entries. It was said there were 30 users, but after checking, it turns out some new users have recently joined.
#Cheking id Length
SELECT id,
  LENGTH(id) AS id_length
FROM daily_activity
GROUP BY id
ORDER BY id_length;

#Cheking Minus Value
SELECT *
FROM daily_activity
WHERE 
  total_steps < 0 OR
  total_distance < 0 OR
  tracker_distance < 0 OR
  logged_activities_distance < 0 OR
  very_active_distance < 0 OR
  moderately_active_distance < 0 OR
  light_active_distance < 0 OR
  sedentary_active_distance < 0 OR
  very_active_minutes < 0 OR
  fairly_active_minutes < 0 OR
  lightly_active_minutes < 0 OR
  sedentary_minutes < 0 OR
  calories < 0;

#Dercriptive Statistic
-- Activity Date --
SELECT
  COUNT(activity_date) 			AS count_activity_date,
  MIN(activity_date) 			AS min_activity_date,
  MAX(activity_date) 			AS max_activity_date
FROM daily_activity;

-- Total Steps --
SELECT
  COUNT(total_steps) 			AS total_steps,
  MIN(total_steps) 				AS min_total_steps,
  MAX(total_steps) 				AS max_total_steps,
  ROUND(AVG(total_steps),2) 	AS avg_total_steps,
  ROUND(STDDEV(total_steps),2) 	AS stddev_total_steps
FROM daily_activity;

  -- Total Distance --
SELECT
  COUNT(total_distance) 			AS total_steps,
  MIN(total_distance) 				AS min_total_distance,
  MAX(total_distance) 				AS max_total_distance,
  ROUND(AVG(total_distance), 2)		AS avg_total_distance,
  ROUND(STDDEV(total_distance), 2) 	AS stddev_total_distance
FROM daily_activity;

  -- Tracker Distance --
SELECT
  COUNT(tracker_distance) 				AS tracker_distance,
  MIN(tracker_distance) 				AS min_tracker_distance,
  MAX(tracker_distance) 				AS max_tracker_distance,
  ROUND(AVG(tracker_distance), 2) 		AS avg_tracker_distance,
  ROUND(STDDEV(tracker_distance), 2) 	AS stddev_tracker_distance
FROM daily_activity;

  -- Logged Activities Distance --
SELECT
  COUNT(logged_activities_distance) 			AS total_logged_activities_distance,
  MIN(logged_activities_distance) 				AS min_logged_activities_distance,
  MAX(logged_activities_distance) 				AS max_logged_activities_distance,
  ROUND(AVG(logged_activities_distance),	2) 	AS avg_logged_activities_distance,
  ROUND(STDDEV(logged_activities_distance), 2) 	AS stddev_logged_activities_distance
FROM daily_activity;

  -- Very Active Distance --
SELECT
  COUNT(very_active_distance) 				AS very_active_distance,
  MIN(very_active_distance) 				AS min_very_active_distance,
  MAX(very_active_distance) 				AS max_very_active_distance,
  ROUND(AVG(very_active_distance), 2) 		AS avg_very_active_distance,
  ROUND(STDDEV(very_active_distance), 2) 	AS stddev_very_active_distance
FROM daily_activity;

  -- Moderately Active Distance --
SELECT
  COUNT(moderately_active_distance) 			AS very_moderately_active_distance,
  MIN(moderately_active_distance) 				AS min_moderately_active_distance,
  MAX(moderately_active_distance) 				AS max_moderately_active_distance,
  ROUND(AVG(moderately_active_distance), 2) 	AS avg_moderately_active_distance,
  ROUND(STDDEV(moderately_active_distance), 2) 	AS stddev_moderately_active_distance
FROM daily_activity;

  -- Light Active Distance --
SELECT 
  COUNT(light_active_distance) 				AS count_light_active_distance,
  MIN(light_active_distance) 				AS min_light_active_distance,
  MAX(light_active_distance) 				AS max_light_active_distance,
  ROUND(AVG(light_active_distance), 2) 		AS avg_light_active_distance,
  ROUND(STDDEV(light_active_distance), 2) 	AS stddev_light_active_distance
FROM daily_activity;

  -- Sedentary Active Distance --
SELECT 
  COUNT(sedentary_active_distance) 				AS count_sedentary_active_distance,
  MIN(sedentary_active_distance) 				AS min_sedentary_active_distance,
  MAX(sedentary_active_distance) 				AS max_sedentary_active_distance,
  ROUND(AVG(sedentary_active_distance), 2) 		AS avg_sedentary_active_distance,
  ROUND(STDDEV(sedentary_active_distance), 2) 	AS stddev_sedentary_active_distance
FROM daily_activity;

  -- Very Active Minutes --
SELECT 
  COUNT(very_active_minutes)			 	AS count_very_active_minutes,
  MIN(very_active_minutes)					AS min_very_active_minutes,
  MAX(very_active_minutes) 					AS max_very_active_minutes,
  ROUND(AVG(very_active_minutes), 2) 		AS avg_very_active_minutes,
  ROUND(STDDEV(very_active_minutes), 2) 	AS stddev_very_active_minutes
FROM daily_activity; 

  -- Fairly Active Minutes --
SELECT 
  COUNT(fairly_active_minutes) 				AS count_fairly_active_minutes,
  MIN(fairly_active_minutes) 				AS min_fairly_active_minutes,
  MAX(fairly_active_minutes) 				AS max_fairly_active_minutes,
  ROUND(AVG(fairly_active_minutes), 2) 		AS avg_fairly_active_minutes,
  ROUND(STDDEV(fairly_active_minutes), 2) 	AS stddev_fairly_active_minutes
FROM daily_activity;

  -- Lightly Active Minutes --
SELECT 
  COUNT(lightly_active_minutes) 			AS count_lightly_active_minutes,
  MIN(lightly_active_minutes)			 	AS min_lightly_active_minutes,
  MAX(lightly_active_minutes) 				AS max_lightly_active_minutes,
  ROUND(AVG(lightly_active_minutes), 2) 	AS avg_lightly_active_minutes,
  ROUND(STDDEV(lightly_active_minutes), 2) 	AS stddev_lightly_active_minutes
FROM daily_activity;

  -- Sedentary Minutes --
SELECT 
  COUNT(sedentary_minutes) 				AS count_sedentary_minutes,
  MIN(sedentary_minutes) 				AS min_sedentary_minutes,
  MAX(sedentary_minutes) 				AS max_sedentary_minutes,
  ROUND(AVG(sedentary_minutes), 2) 		AS avg_sedentary_minutes,
  ROUND(STDDEV(sedentary_minutes), 2) 	AS stddev_sedentary_minutes
FROM daily_activity;

  -- Calories --
SELECT 
  COUNT(calories) 				AS count_calories,
  MIN(calories) 				AS min_calories,
  MAX(calories) 				AS max_calories,
  ROUND(AVG(calories), 2) 		AS avg_calories,
  ROUND(STDDEV(calories), 2) 	AS stddev_calories
FROM daily_activity;

#Sleep Day
-- Load Data --
#Load data use table import wizard

-- Standardizing Data --
#Rename Table
RENAME TABLE sleepday_merged TO sleep_day;

SELECT * FROM sleep_day;

#Cheking Total Colums
SELECT COUNT(Id) AS total_columns FROM sleep_day; 

#Cheking Structure Table
DESCRIBE sleep_day;

#Standardizing Format Date
UPDATE sleep_day
SET SleepDay = STR_TO_DATE(TRIM(SleepDay), '%m/%d/%Y %r');

#Change Column Name & Type Data
ALTER TABLE sleep_day
	CHANGE COLUMN Id id 				   					VARCHAR(20),
    CHANGE COLUMN SleepDay sleep_datetime 					DATETIME,
    CHANGE COLUMN TotalSleepRecords total_sleep_records 	INT,
    CHANGE COLUMN TotalMinutesAsleep total_minutes_asleep 	INT,
    CHANGE COLUMN TotalTimeInBed total_time_in_bed			INT;
    
-- Data Cleaning --
#Backup The Data Before Cleaning
CREATE TABLE sleep_day_backup LIKE sleep_day;
INSERT INTO sleep_day_backup 
	SELECT * FROM sleep_day;

#Ceking Missing Values
SELECT *
FROM sleep_day
WHERE id 					IS NULL
   OR sleep_datetime 		IS NULL
   OR total_sleep_records  	IS NULL
   OR total_minutes_asleep 	IS NULL
   OR total_time_in_bed		IS NULL; #Hasilnya 0
 
 #Cheking Duplicate Values
SELECT id, sleep_datetime, total_sleep_records, total_minutes_asleep, total_time_in_bed,
    COUNT(*) AS count_of_duplicate
FROM sleep_day
GROUP BY id, sleep_datetime, total_sleep_records, total_minutes_asleep, total_time_in_bed
HAVING COUNT(*) > 1; #There 3 duplicate data

#Cheking duplicate value
SELECT *
FROM sleep_Day
WHERE (Id = '4388161847' AND Sleep_datetime = '2016-05-05 00:00:00')
   OR (Id = '4702921684' AND Sleep_datetime= '2016-05-07 00:00:00')
   OR (Id = '8378563200' AND Sleep_datetime = '2016-04-25 00:00:00');
   
#Delete Data Duplicate
ALTER TABLE sleep_day ADD COLUMN row_id INT AUTO_INCREMENT PRIMARY KEY;
DELETE a
FROM sleep_day a
LEFT JOIN (
  SELECT MIN(row_id) AS keep_row_id, id, sleep_datetime
  FROM sleep_day
  GROUP BY id, sleep_datetime
) b
ON a.row_id = b.keep_row_id
AND a.id = b.id
AND a.sleep_datetime = b.sleep_datetime
WHERE b.keep_row_id IS NULL;
ALTER TABLE sleep_day DROP COLUMN row_id;
ALTER TABLE sleep_day DROP COLUMN is_duplicate;

#Cheking unique data
SELECT
  COUNT(DISTINCT id) AS unique_id 
FROM sleep_day; #There are 24 unique data entries, but in the daily activity, there are 33. It was said there were 30 users, but after checking, it turns out some users have just joined.

#Cheking id Length
SELECT id,
  LENGTH(id) AS id_length
FROM sleep_day
GROUP BY id
ORDER BY id_length;

#Cheking Minus Value
SELECT *
FROM sleep_day
WHERE total_sleep_records < 0 OR
	  total_minutes_asleep < 0 OR
      total_time_in_bed < 0;

#Dercriptive Statistic
-- Sleep Datetime --
SELECT 
  COUNT(sleep_datetime) 			AS count_sleep_datetime,
  MIN(sleep_datetime) 				AS min_sleep_datetime,
  MAX(sleep_datetime) 				AS max_sleep_datetime
FROM sleep_day;

-- Total Sleep Records --
SELECT 
  COUNT(total_sleep_records) 			AS count_total_sleep_records,
  MIN(total_sleep_records) 				AS min_total_sleep_records,
  MAX(total_sleep_records) 				AS max_total_sleep_records,
  ROUND(AVG(total_sleep_records), 2) 	AS avg_total_sleep_records,
  ROUND(STDDEV(total_sleep_records), 2) AS stddev_total_sleep_records
FROM sleep_day;

-- Total Minutes Asleep --
SELECT 
  COUNT(total_minutes_asleep) 				AS count_total_minutes_asleep,
  MIN(total_minutes_asleep) 				AS min_total_minutes_asleep,
  MAX(total_minutes_asleep) 				AS max_total_minutes_asleep,
  ROUND(AVG(total_minutes_asleep), 2) 		AS avg_total_minutes_asleep,
  ROUND(STDDEV(total_minutes_asleep), 2) 	AS stddev_total_minutes_asleep
FROM sleep_day;

-- Total Time in Bed --
SELECT 
  COUNT(total_time_in_bed) 				AS count_total_time_in_bed,
  MIN(total_time_in_bed) 				AS min_total_time_in_bed,
  MAX(total_time_in_bed) 				AS max_total_time_in_bed,
  ROUND(AVG(total_time_in_bed), 2) 		AS avg_total_time_in_bed,
  ROUND(STDDEV(total_time_in_bed), 2) 	AS stddev_total_time_in_bed
FROM sleep_day;

#Weight Log Info
-- Load Data --
#Load data use table import wizard

-- Standardizing Data --
#Rename Table
RENAME TABLE weight_log_info_merged TO weight_log_info;

SELECT * FROM weight_log_info;

#Cheking Total Colums
SELECT COUNT(Id) AS total_columns FROM weight_log_info; 

#Cheking Structure Table
DESCRIBE weight_log_info;

#Standardizing Format Date
UPDATE weight_log_info
SET Date = STR_TO_DATE(TRIM(Date), '%m/%d/%Y %r');

#Standardizing Format Column Is Manual Report
UPDATE weight_log_info
SET IsManualReport = 
    CASE
        WHEN IsManualReport = 'True' THEN 1
        WHEN IsManualReport = 'False' THEN 0
        ELSE NULL
    END;

#Standardizing Format Column Fat is missing value to null
UPDATE weight_log_info
SET Fat = NULL
WHERE Fat = '';

#Change Column Name & Type Data
ALTER TABLE weight_log_info
	CHANGE COLUMN Id id 				   			VARCHAR(20),
    CHANGE COLUMN Date date 						DATETIME,
    CHANGE COLUMN WeightKg weight_kg 				FLOAT(8,2),
    CHANGE COLUMN WeightPounds weight_pounds		FLOAT(8,2),
    CHANGE COLUMN Fat fat							INT,
    CHANGE COLUMN BMI bmi 							FLOAT(8,2),
    CHANGE COLUMN IsManualReport is_manual_report 	BOOLEAN,
    CHANGE COLUMN LogId log_id 						BIGINT;
    
-- Data Cleaning --
#Backup The Data Before Cleaning
CREATE TABLE weight_log_info_backup LIKE weight_log_info;
INSERT INTO weight_log_info_backup 
	SELECT * FROM weight_log_info;
    
#Ceking Missing Values
SELECT *
FROM weight_log_info
WHERE id 				IS NULL
   OR date 				IS NULL
   OR weight_kg  		IS NULL
   OR weight_pounds		IS NULL
   OR fat				IS NULL
   OR bmi				IS NULL
   OR is_manual_report	IS NULL
   OR log_id			IS NULL; #Missing value in column fat is 65

#Delete Column Fat
ALTER TABLE weight_log_info
DROP COLUMN fat;

 #Cheking Duplicate Values
SELECT id, date, weight_kg, weight_pounds, fat, bmi, is_manual_report, log_id,
    COUNT(*) AS total_duplicate
FROM weight_log_info
GROUP BY id, date, weight_kg, weight_pounds, fat, bmi, is_manual_report, log_id
HAVING COUNT(*) > 1; 

#Cheking unique data
SELECT 
    COUNT(DISTINCT id) 					AS unique_ids,
    COUNT(DISTINCT is_manual_report) 	AS unique_manual_flags,
    COUNT(DISTINCT log_id) 				AS unique_log_ids
FROM weight_log_info;
#The data shows 8 unique entries, 33 in daily activity, and 24 in sleep day. It was said there were 30 users, but after checking, it turns out some users have just joined.

#Cheking id Length
SELECT id,
  LENGTH(id) AS id_length
FROM weight_log_info
GROUP BY id
ORDER BY id_length;

#Cheking Minus Value
SELECT *
FROM weight_log_info
WHERE weight_kg < 0 OR
	  weight_pounds < 0 OR
      fat < 0 OR
      bmi < 0 ;

#Dercriptive Statistic
-- Date --
SELECT 
  COUNT(date) 	AS count_date,
  MIN(date) 	AS min_date,
  MAX(date) 	AS max_date
FROM weight_log_info;

-- Weight Kg --
SELECT 
  COUNT(weight_kg) 				AS count_weight_kg,
  MIN(weight_kg) 				AS min_weight_kg,
  MAX(weight_kg) 				AS max_weight_kg,
  ROUND(AVG(weight_kg), 2) 		AS avg_tweight_kg,
  ROUND(STDDEV(weight_kg), 2) 	AS stddev_weight_kg
FROM weight_log_info;

-- Weight Pounds --
SELECT 
  COUNT(weight_pounds) 				AS count_weight_pounds,
  MIN(weight_pounds) 				AS min_weight_pounds,
  MAX(weight_pounds) 				AS max_weight_pounds,
  ROUND(AVG(weight_pounds), 2) 		AS avg_weight_pounds,
  ROUND(STDDEV(weight_pounds), 2) 	AS stddev_weight_pounds
FROM weight_log_info;

-- Fat --
SELECT 
  COUNT(fat) 			AS count_fat,
  MIN(fat) 				AS min_fat,
  MAX(fat) 				AS max_fat,
  ROUND(AVG(fat), 2) 	AS avg_fat,
  ROUND(STDDEV(fat), 2) AS stddev_fat
FROM weight_log_info;

-- BMI --
SELECT 
  COUNT(bmi) 			AS count_bmi,
  MIN(bmi) 				AS min_bmi,
  MAX(bmi) 				AS max_bmi,
  ROUND(AVG(bmi), 2) 	AS avg_bmi,
  ROUND(STDDEV(bmi), 2) AS stddev_bmi
FROM weight_log_info;

#The analysis process is continued in Python
