USE OTT;

-- 1. How many total users are registered on the platform?
SELECT COUNT(*) AS total_users
FROM users;

-- ANSWER:
-- Total registered users = 297


-- 2. Which country has the highest number of users?
SELECT country, COUNT(*) AS total_users
FROM users
GROUP BY country
ORDER BY total_users DESC;

-- ANSWER:
-- India = 295 users
-- USA = 1 user
-- UK = 1 user
-- India has the highest number of users.


-- 3. What is the gender distribution of users?
SELECT gender, COUNT(*) AS total_users
FROM users
GROUP BY gender;

-- ANSWER:
-- Male = 148
-- Female = 147
-- Other = 2


-- 4. Which age group is most active on the platform?
SELECT
CASE
    WHEN age BETWEEN 17 AND 20 THEN '17-20'
    WHEN age BETWEEN 21 AND 25 THEN '21-25'
    WHEN age BETWEEN 26 AND 30 THEN '26-30'
    ELSE '30+'
END AS age_group,
COUNT(*) AS total_users
FROM users
GROUP BY age_group
ORDER BY total_users DESC;

-- ANSWER:
-- 21-25 = 155 users
-- 26-30 = 110 users
-- 17-20 = 28 users
-- 30+ = 4 users
-- Most active age group = 21-25


-- 5. Which users spend the most time watching content?
SELECT u.user_id, u.name, SUM(ue.watch_duration_minutes) AS total_watch_time
FROM users u
JOIN user_engagement ue
ON u.user_id = ue.user_id
GROUP BY u.user_id, u.name
ORDER BY total_watch_time DESC
LIMIT 10;

-- ANSWER:
-- User 126 = 739 minutes
-- User 89 = 627 minutes
-- User 91 = 518 minutes
-- These users spend the highest time watching content.


-- 6. Which users have given the highest number of ratings?
SELECT u.user_id, u.name, COUNT(ue.rating) AS total_ratings
FROM users u
JOIN user_engagement ue
ON u.user_id = ue.user_id
GROUP BY u.user_id, u.name
ORDER BY total_ratings DESC
LIMIT 10;

-- ANSWER:
-- User 91 = 6 ratings
-- User 179 = 5 ratings
-- User 126 = 5 ratings


-- 7. Which users are inactive for more than 30 days?
SELECT u.user_id, u.name, MAX(ue.watch_date) AS last_watch_date
FROM users u
JOIN user_engagement ue
ON u.user_id = ue.user_id
GROUP BY u.user_id, u.name
HAVING DATEDIFF(CURDATE(), MAX(ue.watch_date)) > 30;

-- ANSWER:
-- Multiple users are inactive for more than 30 days.
-- Exact output depends on current execution date.


-- 8. What percentage of users are active monthly?
SELECT ROUND(COUNT(DISTINCT ue.user_id) * 100 /(SELECT COUNT(*) FROM users),2) AS monthly_active_percentage
FROM user_engagement ue;

-- ANSWER:
-- Monthly active users percentage = 56.57%


-- 9. Which country has the highest average watch time?
SELECT u.country, ROUND(AVG(ue.watch_duration_minutes),2) AS avg_watch_time
FROM users u
JOIN user_engagement ue
ON u.user_id = ue.user_id
GROUP BY u.country
ORDER BY avg_watch_time DESC;

-- ANSWER:
-- India = 94.03 minutes
-- UK = 67.67 minutes
-- USA = 66.50 minutes
-- India has highest average watch time.


-- 10. Which users are most likely to churn?
SELECT u.user_id, u.name, us.status, MAX(ue.watch_date) AS last_active_date
FROM users u
JOIN user_subscriptions us
ON u.user_id = us.user_id
LEFT JOIN user_engagement ue
ON u.user_id = ue.user_id
GROUP BY u.user_id, u.name, us.status
HAVING us.status = 'Expired';

-- ANSWER:
-- Users with expired subscriptions and low engagement
-- are most likely to churn.


-- 11. Which genre has the highest total watch time?
SELECT c.genre, SUM(ue.watch_duration_minutes) AS total_watch_time
FROM content c
JOIN user_engagement ue
ON c.content_id = ue.content_id
GROUP BY c.genre
ORDER BY total_watch_time DESC;

-- ANSWER:
-- Action = 9459 minutes
-- Drama = 4551 minutes
-- Crime = 3820 minutes
-- Thriller = 3017 minutes
-- Action genre has highest total watch time.


-- 12. Which content type is more popular: MOVIE or SERIES?
SELECT c.type, COUNT(*) AS total_views
FROM content c
JOIN user_engagement ue
ON c.content_id = ue.content_id
GROUP BY c.type;

-- ANSWER:
-- Movies = 276 views
-- Series = 58 views
-- Movies are more popular.


-- 13. Which content has the highest average rating?
SELECT c.title, ROUND(AVG(ue.rating),2) AS average_rating
FROM content c
JOIN user_engagement ue
ON c.content_id = ue.content_id
GROUP BY c.title
ORDER BY average_rating DESC
LIMIT 10;

-- ANSWER:
-- Inside Edge = 5.0
-- Love Mocktail 2 = 5.0
-- Varudu Kaavalenu = 5.0
-- Valimai = 5.0
-- Kshana Kshanam = 5.0


-- 14. Which genres receive the best ratings?
SELECT c.genre, ROUND(AVG(ue.rating),2) AS avg_rating
FROM content c
JOIN user_engagement ue
ON c.content_id = ue.content_id
GROUP BY c.genre
ORDER BY avg_rating DESC;

-- ANSWER:
-- Superhero = 5.0
-- Crime Thriller = 5.0
-- Mystery = 5.0
-- Spy Thriller = 4.0
-- Historical = 3.8


-- 15. Which language has the most watched content?
SELECT c.language, COUNT(*) AS total_views
FROM content c
JOIN user_engagement ue
ON c.content_id = ue.content_id
GROUP BY c.language
ORDER BY total_views DESC;

-- ANSWER:
-- Telugu = 115 views
-- Hindi = 105 views
-- Tamil = 67 views
-- Kannada = 25 views
-- Malayalam = 22 views
-- Telugu content is watched the most.


-- 16. Which movies/shows are watched the least?
SELECT c.title, COUNT(ue.engagement_id) AS total_views
FROM content c
LEFT JOIN user_engagement ue
ON c.content_id = ue.content_id
GROUP BY c.title
ORDER BY total_views ASC
LIMIT 10;

-- ANSWER:
-- Sacred Games Season 2 = 1 view
-- Etharkkum Thunindhavan = 1 view
-- Four More Shots Please! = 1 view
-- Gaddalakonda Ganesh = 1 view
-- Ludo = 1 view


-- 17. Which release year has the most popular content?
SELECT c.release_year, COUNT(*) AS total_views
FROM content c
JOIN user_engagement ue
ON c.content_id = ue.content_id
GROUP BY c.release_year
ORDER BY total_views DESC;

-- ANSWER:
-- 2021 = 75 views
-- 2019 = 61 views
-- 2018 = 56 views
-- 2020 = 55 views
-- 2021 content is most popular.


-- 18. Which content generates the highest engagement?
SELECT c.title, SUM(ue.watch_duration_minutes) AS total_engagement
FROM content c
JOIN user_engagement ue
ON c.content_id = ue.content_id
GROUP BY c.title
ORDER BY total_engagement DESC
LIMIT 10;

-- ANSWER:
-- Nerkonda Paarvai = 815 minutes
-- Raat Akeli Hai = 806 minutes
-- KGF Chapter 2 = 779 minutes
-- Vikram = 524 minutes
-- Drishyam = 522 minutes


-- 19. Which genres are most popular among different age groups?
SELECT
CASE
    WHEN u.age BETWEEN 17 AND 20 THEN '17-20'
    WHEN u.age BETWEEN 21 AND 25 THEN '21-25'
    WHEN u.age BETWEEN 26 AND 30 THEN '26-30'
    ELSE '30+'
END AS age_group,
c.genre, COUNT(*) AS total_views
FROM users u
JOIN user_engagement ue
ON u.user_id = ue.user_id
JOIN content c
ON ue.content_id = c.content_id
GROUP BY age_group, c.genre
ORDER BY age_group, total_views DESC;

-- ANSWER:
-- Users aged 21-25 mostly watch Action and Thriller content.
-- Users aged 26-30 prefer Drama and Crime genres.


-- 20. Which content is repeatedly watched by users?
SELECT u.user_id, u.name, c.title, COUNT(*) AS repeat_views
FROM users u
JOIN user_engagement ue
ON u.user_id = ue.user_id
JOIN content c
ON ue.content_id = c.content_id
GROUP BY u.user_id, u.name, c.title
HAVING repeat_views > 1
ORDER BY repeat_views DESC;

-- ANSWER:
-- User 95 watched Love Story 2 times.
-- User 8 watched Raat Akeli Hai 2 times.
-- These contents show replay value.


-- 21. Which subscription plan has the most users?
SELECT s.plan_name, COUNT(us.user_id) AS total_users
FROM subscriptions s
JOIN user_subscriptions us
ON s.subscription_id = us.subscription_id
GROUP BY s.plan_name
ORDER BY total_users DESC;

-- ANSWER:
-- Premium = 176 users
-- Premium HD = 164 users
-- Premium 4K = 159 users
-- Premium plan has the highest number of users.


-- 22. Which subscription plan generates the highest revenue?
SELECT s.plan_name, SUM(s.price_per_month) AS total_revenue
FROM subscriptions s
JOIN user_subscriptions us
ON s.subscription_id = us.subscription_id
GROUP BY s.plan_name
ORDER BY total_revenue DESC;

-- ANSWER:
-- Premium 4K = ₹47541
-- Premium HD = ₹40836
-- Premium = ₹26224
-- Premium 4K generates the highest revenue.


-- 23. Do premium users watch more content than basic users?
SELECT s.plan_name, ROUND(AVG(ue.watch_duration_minutes),2) AS avg_watch_time
FROM subscriptions s
JOIN user_subscriptions us
ON s.subscription_id = us.subscription_id
JOIN user_engagement ue
ON us.user_id = ue.user_id
GROUP BY s.plan_name
ORDER BY avg_watch_time DESC;

-- ANSWER:
-- Premium 4K users have highest average watch duration.
-- Premium users watch less content compared to Premium HD and Premium 4K users.


-- 24. What is the average revenue generated per user?
SELECT ROUND(SUM(s.price_per_month) /COUNT(DISTINCT us.user_id),2) AS ARPU
FROM subscriptions s
JOIN user_subscriptions us
ON s.subscription_id = us.subscription_id;

-- ANSWER:
-- Average Revenue Per User (ARPU) = ₹385.19


-- 25. Which subscription plan has the highest retention rate?
SELECT s.plan_name, COUNT(*) AS active_users
FROM subscriptions s
JOIN user_subscriptions us
ON s.subscription_id = us.subscription_id
WHERE us.status = 'ACTIVE'
GROUP BY s.plan_name
ORDER BY active_users DESC;

-- ANSWER:
-- Premium = 90 active users
-- Premium HD = 82 active users
-- Premium 4K = 76 active users
-- Premium has the highest retention.


-- 26. How many subscriptions are currently active vs expired?
SELECT status, COUNT(*) AS total_subscriptions
FROM user_subscriptions
GROUP BY status;

-- ANSWER:
-- ACTIVE = 248
-- EXPIRED = 251


-- 27. Which users upgraded their subscription plans?
SELECT user_id, COUNT(DISTINCT subscription_id) AS plans_used
FROM user_subscriptions
GROUP BY user_id
HAVING plans_used > 1
ORDER BY plans_used DESC;

-- ANSWER:
-- Multiple users upgraded between Premium,
-- Premium HD, and Premium 4K plans.


-- 28. Which countries contribute the most subscription revenue?
SELECT u.country, SUM(s.price_per_month) AS total_revenue
FROM users u
JOIN user_subscriptions us
ON u.user_id = us.user_id
JOIN subscriptions s
ON us.subscription_id = s.subscription_id
GROUP BY u.country
ORDER BY total_revenue DESC;

-- ANSWER:
-- India = ₹112252
-- USA = ₹249
-- UK = ₹149
-- India contributes the highest subscription revenue.


-- 29. What is the average subscription duration per user?
SELECT ROUND(AVG(DATEDIFF(end_date,start_date)),2) AS avg_subscription_days
FROM user_subscriptions;

-- ANSWER:
-- Average subscription duration = 83.71 days


-- 30. Which plan has the highest churn rate?
SELECT s.plan_name, COUNT(*) AS expired_subscriptions
FROM subscriptions s
JOIN user_subscriptions us
ON s.subscription_id = us.subscription_id
WHERE us.status = 'EXPIRED'
GROUP BY s.plan_name
ORDER BY expired_subscriptions DESC;

-- ANSWER:
-- Premium = 86 expired subscriptions
-- Premium HD = 82 expired subscriptions
-- Premium 4K = 83 expired subscriptions
-- Premium plan shows the highest churn count.


-- 31. What is the average watch duration per session?
SELECT ROUND(AVG(watch_duration_minutes),2) AS avg_watch_duration
FROM user_engagement;

-- ANSWER:
-- Average watch duration per session = 93.63 minutes


-- 32. What day has the highest user engagement?
SELECT DAYNAME(watch_date) AS day_name, COUNT(*) AS total_engagement
FROM user_engagement
GROUP BY day_name
ORDER BY total_engagement DESC;

-- ANSWER:
-- Sunday has the highest user engagement.


-- 33. What month has the highest platform activity?
SELECT MONTHNAME(watch_date) AS month_name, COUNT(*) AS total_activity
FROM user_engagement
GROUP BY month_name
ORDER BY total_activity DESC;

-- ANSWER:
-- June has the highest platform activity.


-- 34. Is higher watch duration associated with higher ratings?
SELECT rating, ROUND(AVG(watch_duration_minutes),2) AS avg_watch_duration
FROM user_engagement
GROUP BY rating
ORDER BY rating DESC;

-- ANSWER:
-- Sessions with ratings 4 and 5 generally have higher watch durations,
-- indicating positive engagement.


-- 35. How many users watch content daily?
SELECT watch_date, COUNT(DISTINCT user_id) AS daily_active_users
FROM user_engagement
GROUP BY watch_date
ORDER BY daily_active_users DESC;

-- ANSWER:
-- Daily active users vary between 1 and 5 users per day.


-- 36. What percentage of content is fully watched?
SELECT ROUND(SUM(
CASE
WHEN ue.watch_duration_minutes >= c.duration_minutes
THEN 1
ELSE 0
END
) * 100 / COUNT(*),2) AS fully_watched_percentage
FROM user_engagement ue
JOIN content c
ON ue.content_id = c.content_id;

-- ANSWER:
-- Fully watched content percentage = 8.38%


-- 37. Which users binge-watch the most content?
SELECT u.user_id, u.name, COUNT(*) AS total_sessions, SUM(ue.watch_duration_minutes) AS total_watch_time
FROM users u
JOIN user_engagement ue
ON u.user_id = ue.user_id
GROUP BY u.user_id, u.name
ORDER BY total_sessions DESC, total_watch_time DESC
LIMIT 10;

-- ANSWER:
-- User 91, User 126, and User 179
-- are the biggest binge-watchers.


-- 38. Which genres keep users engaged longest?
SELECT c.genre, ROUND(AVG(ue.watch_duration_minutes),2) AS avg_watch_time
FROM content c
JOIN user_engagement ue
ON c.content_id = ue.content_id
GROUP BY c.genre
ORDER BY avg_watch_time DESC;

-- ANSWER:
-- Action and Thriller genres have the longest engagement durations.


-- 39. What is the average rating given by active users?
SELECT ROUND(AVG(ue.rating),2) AS avg_active_user_rating
FROM user_engagement ue
JOIN user_subscriptions us
ON ue.user_id = us.user_id
WHERE us.status = 'ACTIVE';

-- ANSWER:
-- Average rating by active users = 3.08


-- 40. Which users interact with the platform most frequently?
SELECT u.user_id, u.name, COUNT(*) AS total_interactions
FROM users u
JOIN user_engagement ue
ON u.user_id = ue.user_id
GROUP BY u.user_id, u.name
ORDER BY total_interactions DESC
LIMIT 10;

-- ANSWER:
-- User 91 = 6 interactions
-- User 126 = 5 interactions
-- User 179 = 5 interactions
-- These users interact most frequently with the platform.


-- 41. What is the total revenue generated by the platform?
SELECT SUM(s.price_per_month) AS total_revenue
FROM subscriptions s
JOIN user_subscriptions us
ON s.subscription_id = us.subscription_id;

-- ANSWER:
-- Total platform revenue = ₹114601


-- 42. What is the monthly recurring revenue (MRR)?
SELECT DATE_FORMAT(start_date,'%Y-%m') AS month, SUM(s.price_per_month) AS monthly_recurring_revenue
FROM user_subscriptions us
JOIN subscriptions s
ON us.subscription_id = s.subscription_id
GROUP BY month
ORDER BY month;

-- ANSWER:
-- Monthly recurring revenue varies month to month.
-- Peak MRR observed during 2025 subscription growth periods.


-- 43. What is the average revenue per paying user (ARPU)?
SELECT ROUND(SUM(s.price_per_month) /COUNT(DISTINCT us.user_id),2) AS ARPU
FROM subscriptions s
JOIN user_subscriptions us
ON s.subscription_id = us.subscription_id;

-- ANSWER:
-- ARPU = ₹385.19


-- 44. What is the customer retention rate?
SELECT ROUND(SUM(
CASE
WHEN status='ACTIVE'
THEN 1
ELSE 0
END
) * 100 / COUNT(*),2) AS retention_rate
FROM user_subscriptions;

-- ANSWER:
-- Customer retention rate = 49.70%


-- 45. What is the platform churn rate?
SELECT ROUND(SUM(
CASE
WHEN status='EXPIRED'
THEN 1
ELSE 0
END
) * 100 / COUNT(*),2) AS churn_rate
FROM user_subscriptions;

-- ANSWER:
-- Platform churn rate = 50.30%


-- 46. What is the average watch time per user?
SELECT ROUND(AVG(user_watch_time),2) AS avg_watch_time_per_user
FROM (SELECT user_id, SUM(watch_duration_minutes) AS user_watch_time
FROM user_engagement
GROUP BY user_id
) AS watch_summary;

-- ANSWER:
-- Average watch time per user = 185.06 minutes


-- 47. What is the ratio of active users to total users?
SELECT ROUND(COUNT(DISTINCT ue.user_id) * 100 /(SELECT COUNT(*) FROM users),2) AS active_user_ratio
FROM user_engagement ue;

-- ANSWER:
-- Active user ratio = 56.57%


-- 48. Which genre contributes most to platform engagement?
SELECT c.genre, SUM(ue.watch_duration_minutes) AS total_engagement
FROM content c
JOIN user_engagement ue
ON c.content_id = ue.content_id
GROUP BY c.genre
ORDER BY total_engagement DESC;

-- ANSWER:
-- Action = 9459 minutes
-- Drama = 4551 minutes
-- Crime = 3820 minutes
-- Action contributes most to engagement.


-- 49. Which subscription plan contributes most to profitability?
SELECT s.plan_name, SUM(s.price_per_month) AS total_profitability
FROM subscriptions s
JOIN user_subscriptions us
ON s.subscription_id = us.subscription_id
GROUP BY s.plan_name
ORDER BY total_profitability DESC;

-- ANSWER:
-- Premium 4K = ₹47541
-- Premium HD = ₹40836
-- Premium = ₹26224
-- Premium 4K contributes most to profitability.


-- 50. What are the top KPIs for measuring OTT platform success?
SELECT
(SELECT COUNT(*) FROM users) AS total_users,
(SELECT COUNT(*) FROM user_engagement) AS total_watch_events,
(SELECT ROUND(AVG(rating),2) FROM user_engagement) AS avg_platform_rating,
(SELECT SUM(price_per_month)
 FROM subscriptions s
 JOIN user_subscriptions us
 ON s.subscription_id = us.subscription_id
) AS total_revenue;

-- ANSWER:
-- Total Users = 297
-- Total Watch Events = 334
-- Average Platform Rating = 3.01
-- Total Revenue = ₹114601


-- 51. Which genre is most popular in each country?
SELECT u.country, c.genre, COUNT(*) AS total_views
FROM users u
JOIN user_engagement ue
ON u.user_id = ue.user_id
JOIN content c
ON ue.content_id = c.content_id
GROUP BY u.country, c.genre
ORDER BY u.country, total_views DESC;

-- ANSWER:
-- India → Action genre most popular
-- USA → Drama genre most popular
-- UK → Thriller genre most popular


-- 52. Which users watch the widest variety of genres?
SELECT u.user_id, u.name, COUNT(DISTINCT c.genre) AS genres_watched
FROM users u
JOIN user_engagement ue
ON u.user_id = ue.user_id
JOIN content c
ON ue.content_id = c.content_id
GROUP BY u.user_id, u.name
ORDER BY genres_watched DESC
LIMIT 10;

-- ANSWER:
-- User 91 watched 6 different genres.
-- User 126 watched 5 genres.
-- These users have the widest content diversity.


-- 53. Which users consistently rate content highly?
SELECT u.user_id, u.name, ROUND(AVG(ue.rating),2) AS avg_rating
FROM users u
JOIN user_engagement ue
ON u.user_id = ue.user_id
GROUP BY u.user_id, u.name
HAVING AVG(ue.rating) >= 4
ORDER BY avg_rating DESC;

-- ANSWER:
-- Several highly engaged users consistently give ratings above 4.


-- 54. Which content performs best among premium subscribers?
SELECT c.title, SUM(ue.watch_duration_minutes) AS total_watch_time
FROM content c
JOIN user_engagement ue
ON c.content_id = ue.content_id
JOIN user_subscriptions us
ON ue.user_id = us.user_id
JOIN subscriptions s
ON us.subscription_id = s.subscription_id
WHERE s.plan_name = 'Premium 4K'
GROUP BY c.title
ORDER BY total_watch_time DESC
LIMIT 10;

-- ANSWER:
-- KGF Chapter 2
-- Vikram
-- RRR
-- perform best among Premium 4K users.


-- 55. Which users have the longest continuous engagement streak?
SELECT user_id, COUNT(DISTINCT watch_date) AS active_days
FROM user_engagement
GROUP BY user_id
ORDER BY active_days DESC
LIMIT 10;

-- ANSWER:
-- User 91 and User 126 have longest engagement streaks.


-- 56. Which content drives the highest retention?
SELECT c.title, COUNT(DISTINCT us.user_id) AS retained_users
FROM content c
JOIN user_engagement ue
ON c.content_id = ue.content_id
JOIN user_subscriptions us
ON ue.user_id = us.user_id
WHERE us.status = 'ACTIVE'
GROUP BY c.title
ORDER BY retained_users DESC
LIMIT 10;

-- ANSWER:
-- KGF Chapter 2
-- Raat Akeli Hai
-- Vikram
-- drive highest retention.


-- 57. Which genre has growing popularity over time?
SELECT YEAR(ue.watch_date) AS year, c.genre, COUNT(*) AS total_views
FROM content c
JOIN user_engagement ue
ON c.content_id = ue.content_id
GROUP BY year, c.genre
ORDER BY year, total_views DESC;

-- ANSWER:
-- Action and Thriller genres show consistent growth over time.


-- 58. Which users contribute most to total platform engagement?
SELECT u.user_id, u.name, SUM(ue.watch_duration_minutes) AS total_engagement
FROM users u
JOIN user_engagement ue
ON u.user_id = ue.user_id
GROUP BY u.user_id, u.name
ORDER BY total_engagement DESC
LIMIT 10;

-- ANSWER:
-- User 126 = 739 minutes
-- User 89 = 627 minutes
-- User 91 = 518 minutes
-- These users contribute most engagement.


-- 59. Which content has high watch time but low ratings?
SELECT c.title, SUM(ue.watch_duration_minutes) AS total_watch_time, ROUND(AVG(ue.rating),2) AS avg_rating
FROM content c
JOIN user_engagement ue
ON c.content_id = ue.content_id
GROUP BY c.title
HAVING avg_rating < 3
ORDER BY total_watch_time DESC;

-- ANSWER:
-- Some highly watched titles still receive poor ratings,
-- indicating curiosity-based viewing but weak satisfaction.


-- 60. Which subscription plans attract highly engaged users?
SELECT s.plan_name, ROUND(AVG(ue.watch_duration_minutes),2) AS avg_engagement
FROM subscriptions s
JOIN user_subscriptions us
ON s.subscription_id = us.subscription_id
JOIN user_engagement ue
ON us.user_id = ue.user_id
GROUP BY s.plan_name
ORDER BY avg_engagement DESC;

-- ANSWER:
-- Premium 4K users show highest engagement.
-- Premium HD users are second highest.