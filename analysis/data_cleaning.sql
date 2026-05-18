
-- 1. CHECK FOR NULL VALUES

-- Users Table
SELECT *
FROM Users
WHERE name IS NULL
   OR email IS NULL
   OR gender IS NULL
   OR age IS NULL
   OR country IS NULL;

-- Content Table
SELECT *
FROM Content
WHERE title IS NULL
   OR type IS NULL
   OR genre IS NULL
   OR language IS NULL;

-- UserEngagement Table
SELECT *
FROM UserEngagement
WHERE watch_date IS NULL
   OR watch_duration_minutes IS NULL;



-- 2. CHECK FOR DUPLICATE RECORDS

-- Duplicate Emails
SELECT email,
       COUNT(*) AS duplicate_count
FROM Users
GROUP BY email
HAVING COUNT(*) > 1;

-- Duplicate Content Titles
SELECT title,
       COUNT(*) AS duplicate_count
FROM Content
GROUP BY title
HAVING COUNT(*) > 1;

-- Duplicate Engagement Records
SELECT user_id,
       content_id,
       watch_date,
       COUNT(*) AS duplicate_count
FROM UserEngagement
GROUP BY user_id, content_id, watch_date
HAVING COUNT(*) > 1;



-- 3. VALIDATE USER DATA

-- Invalid Ages
SELECT *
FROM Users
WHERE age < 10
   OR age > 100;

-- Invalid Gender Values
SELECT DISTINCT gender
FROM Users;

-- Standardize Gender Values
UPDATE Users
SET gender = UPPER(gender);



-- 4. VALIDATE CONTENT DATA

-- Invalid Release Years
SELECT *
FROM Content
WHERE release_year < 1900
   OR release_year > YEAR(CURDATE());

-- Invalid Duration
SELECT *
FROM Content
WHERE duration_minutes <= 0;

-- Standardize Content Type
UPDATE Content
SET type = UPPER(type);

-- Standardize Genre Names
UPDATE Content
SET genre = TRIM(genre);



-- 5. VALIDATE USER ENGAGEMENT DATA

-- Invalid Watch Duration
SELECT *
FROM UserEngagement
WHERE watch_duration_minutes <= 0;

-- Watch Duration Greater Than Content Duration
SELECT ue.engagement_id,
       ue.user_id,
       c.title,
       ue.watch_duration_minutes,
       c.duration_minutes
FROM UserEngagement ue
JOIN Content c
ON ue.content_id = c.content_id
WHERE ue.watch_duration_minutes > c.duration_minutes;

-- Invalid Ratings
SELECT *
FROM UserEngagement
WHERE rating < 1
   OR rating > 5;

-- Missing Reviews
SELECT *
FROM UserEngagement
WHERE review IS NULL;



-- 6. VALIDATE SUBSCRIPTION DATA

-- Invalid Subscription Price
SELECT *
FROM Subscriptions
WHERE price_per_month <= 0;

-- Invalid Duration Months
SELECT *
FROM Subscriptions
WHERE duration_months <= 0;



-- 7. VALIDATE USER SUBSCRIPTIONS

-- End Date Before Start Date
SELECT *
FROM UserSubscriptions
WHERE end_date < start_date;

-- Invalid Subscription Status
SELECT DISTINCT status
FROM UserSubscriptions;

-- Standardize Status Values
UPDATE UserSubscriptions
SET status = UPPER(status);



-- 8. CHECK REFERENTIAL INTEGRITY

-- Engagement Records with Missing Users
SELECT ue.*
FROM UserEngagement ue
LEFT JOIN Users u
ON ue.user_id = u.user_id
WHERE u.user_id IS NULL;

-- Engagement Records with Missing Content
SELECT ue.*
FROM UserEngagement ue
LEFT JOIN Content c
ON ue.content_id = c.content_id
WHERE c.content_id IS NULL;

-- UserSubscriptions with Missing Users
SELECT us.*
FROM UserSubscriptions us
LEFT JOIN Users u
ON us.user_id = u.user_id
WHERE u.user_id IS NULL;

-- UserSubscriptions with Missing Subscription Plans
SELECT us.*
FROM UserSubscriptions us
LEFT JOIN Subscriptions s
ON us.subscription_id = s.subscription_id
WHERE s.subscription_id IS NULL;



-- 9. REMOVE INVALID RECORDS (OPTIONAL)

-- Remove Invalid Watch Durations
DELETE FROM UserEngagement
WHERE watch_duration_minutes <= 0;

-- Remove Invalid Ratings
DELETE FROM UserEngagement
WHERE rating < 1
   OR rating > 5;



-- 10. FINAL DATA QUALITY CHECKS

-- Total Users
SELECT COUNT(*) AS total_users
FROM Users;

-- Total Content
SELECT COUNT(*) AS total_content
FROM Content;

-- Total Engagement Records
SELECT COUNT(*) AS total_engagement_records
FROM UserEngagement;

-- Total Active Subscriptions
SELECT COUNT(*) AS active_subscriptions
FROM UserSubscriptions
WHERE status = 'ACTIVE';
