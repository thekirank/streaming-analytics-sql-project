-- 1. TOTAL USERS
SELECT COUNT(*) AS total_users
FROM Users;

-- ANSWER:
-- Total registered users = 297


-- 2. TOTAL CONTENT AVAILABLE
SELECT COUNT(*) AS total_content
FROM Content;

-- ANSWER:
-- Total content available = 200


-- 3. TOTAL WATCH EVENTS
SELECT COUNT(*) AS total_watch_events
FROM UserEngagement;

-- ANSWER:
-- Total watch events = 334


-- 4. TOTAL WATCH TIME (MINUTES)
SELECT SUM(watch_duration_minutes) AS total_watch_time
FROM UserEngagement;

-- ANSWER:
-- Total watch time = 31,273 minutes


-- 5. AVERAGE WATCH TIME PER USER
SELECT ROUND(AVG(user_watch_time), 2) AS avg_watch_time_per_user
FROM (
    SELECT user_id,
           SUM(watch_duration_minutes) AS user_watch_time
    FROM UserEngagement
    GROUP BY user_id
) AS watch_summary;

-- ANSWER:
-- Average watch time per user = 185.06 minutes


-- 6. MONTHLY ACTIVE USERS (MAU)
SELECT YEAR(watch_date) AS year,
       MONTH(watch_date) AS month,
       COUNT(DISTINCT user_id) AS monthly_active_users
FROM UserEngagement
GROUP BY YEAR(watch_date),
         MONTH(watch_date)
ORDER BY year, month;

-- ANSWER:
-- 2024-08 = 28 users
-- 2024-09 = 31 users
-- 2024-10 = 29 users
-- 2024-11 = 34 users
-- 2024-12 = 30 users
-- 2025-01 = 26 users
-- 2025-02 = 25 users
-- 2025-03 = 27 users
-- 2025-04 = 24 users
-- 2025-05 = 35 users
-- 2025-06 = 38 users
-- 2025-07 = 32 users


-- 7. DAILY ACTIVE USERS (DAU)
SELECT watch_date,
       COUNT(DISTINCT user_id) AS daily_active_users
FROM UserEngagement
GROUP BY watch_date
ORDER BY watch_date;

-- ANSWER:
-- Daily active users range between 1 and 5 users per day.
-- Highest DAU observed during June and July 2025.


-- 8. TOTAL ACTIVE SUBSCRIPTIONS
SELECT COUNT(*) AS active_subscriptions
FROM UserSubscriptions
WHERE status = 'ACTIVE';

-- ANSWER:
-- Total active subscriptions = 248


-- 9. TOTAL EXPIRED SUBSCRIPTIONS
SELECT COUNT(*) AS expired_subscriptions
FROM UserSubscriptions
WHERE status = 'EXPIRED';

-- ANSWER:
-- Total expired subscriptions = 251


-- 10. TOTAL REVENUE GENERATED
SELECT SUM(s.price_per_month) AS total_revenue
FROM Subscriptions s
JOIN UserSubscriptions us
ON s.subscription_id = us.subscription_id
WHERE us.status = 'ACTIVE';

-- ANSWER:
-- Total active subscription revenue = ₹56,977


-- 11. REVENUE BY SUBSCRIPTION PLAN
SELECT s.plan_name,
       COUNT(us.user_id) AS total_subscribers,
       SUM(s.price_per_month) AS total_revenue
FROM Subscriptions s
JOIN UserSubscriptions us
ON s.subscription_id = us.subscription_id
GROUP BY s.plan_name
ORDER BY total_revenue DESC;

-- ANSWER:
-- Premium 4K = 159 subscribers, ₹47,541 revenue
-- Premium HD = 164 subscribers, ₹40,836 revenue
-- Premium = 176 subscribers, ₹26,224 revenue


-- 12. AVERAGE REVENUE PER USER (ARPU)
SELECT ROUND(
    SUM(s.price_per_month) /
    COUNT(DISTINCT us.user_id)
, 2) AS average_revenue_per_user
FROM Subscriptions s
JOIN UserSubscriptions us
ON s.subscription_id = us.subscription_id;

-- ANSWER:
-- Average Revenue Per User (ARPU) = ₹385.19


-- 13. MOST POPULAR GENRE
SELECT c.genre,
       SUM(ue.watch_duration_minutes) AS total_watch_time
FROM Content c
JOIN UserEngagement ue
ON c.content_id = ue.content_id
GROUP BY c.genre
ORDER BY total_watch_time DESC
LIMIT 1;

-- ANSWER:
-- Most popular genre = Action
-- Total watch time = 9,459 minutes


-- 14. MOST WATCHED CONTENT
SELECT c.title,
       COUNT(ue.engagement_id) AS total_views
FROM Content c
JOIN UserEngagement ue
ON c.content_id = ue.content_id
GROUP BY c.title
ORDER BY total_views DESC
LIMIT 10;

-- ANSWER:
-- KGF Chapter 2 = 8 views
-- Raat Akeli Hai = 7 views
-- Vikram = 6 views
-- RRR = 6 views
-- Drishyam = 5 views


-- 15. TOP RATED CONTENT
SELECT c.title,
       ROUND(AVG(ue.rating), 2) AS average_rating
FROM Content c
JOIN UserEngagement ue
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


-- 16. AVERAGE PLATFORM RATING
SELECT ROUND(AVG(rating), 2) AS average_platform_rating
FROM UserEngagement;

-- ANSWER:
-- Average platform rating = 3.01 / 5


-- 17. CONTENT ENGAGEMENT RATE
SELECT c.genre,
       ROUND(AVG(ue.watch_duration_minutes), 2) AS avg_engagement
FROM Content c
JOIN UserEngagement ue
ON c.content_id = ue.content_id
GROUP BY c.genre
ORDER BY avg_engagement DESC;

-- ANSWER:
-- Action = 112 minutes average engagement
-- Thriller = 104 minutes average engagement
-- Crime = 98 minutes average engagement


-- 18. BINGE WATCHING USERS
SELECT u.user_id,
       u.name,
       COUNT(ue.content_id) AS content_watched
FROM Users u
JOIN UserEngagement ue
ON u.user_id = ue.user_id
GROUP BY u.user_id, u.name
HAVING COUNT(ue.content_id) >= 5
ORDER BY content_watched DESC;

-- ANSWER:
-- User 91 watched 6 contents
-- User 126 watched 5 contents
-- User 179 watched 5 contents


-- 19. AVERAGE WATCH TIME BY SUBSCRIPTION PLAN
SELECT s.plan_name,
       ROUND(AVG(ue.watch_duration_minutes), 2) AS avg_watch_time
FROM UserEngagement ue
JOIN UserSubscriptions us
ON ue.user_id = us.user_id
JOIN Subscriptions s
ON us.subscription_id = s.subscription_id
GROUP BY s.plan_name
ORDER BY avg_watch_time DESC;

-- ANSWER:
-- Premium 4K = 108.42 minutes
-- Premium HD = 94.81 minutes
-- Premium = 82.37 minutes


-- 20. COUNTRY-WISE USER DISTRIBUTION
SELECT country,
       COUNT(*) AS total_users
FROM Users
GROUP BY country
ORDER BY total_users DESC;

-- ANSWER:
-- India = 295 users
-- USA = 1 user
-- UK = 1 user


-- 21. COUNTRY-WISE REVENUE
SELECT u.country,
       SUM(s.price_per_month) AS total_revenue
FROM Users u
JOIN UserSubscriptions us
ON u.user_id = us.user_id
JOIN Subscriptions s
ON us.subscription_id = s.subscription_id
GROUP BY u.country
ORDER BY total_revenue DESC;

-- ANSWER:
-- India = ₹112,252
-- USA = ₹249
-- UK = ₹149


-- 22. MOST ACTIVE USERS
SELECT u.user_id,
       u.name,
       SUM(ue.watch_duration_minutes) AS total_watch_time
FROM Users u
JOIN UserEngagement ue
ON u.user_id = ue.user_id
GROUP BY u.user_id, u.name
ORDER BY total_watch_time DESC
LIMIT 10;

-- ANSWER:
-- User 126 = 739 minutes
-- User 89 = 627 minutes
-- User 91 = 518 minutes


-- 23. USER ENGAGEMENT SCORE
SELECT u.user_id,
       u.name,
       COUNT(ue.engagement_id) AS total_sessions,
       SUM(ue.watch_duration_minutes) AS total_watch_time,
       ROUND(AVG(ue.rating), 2) AS avg_rating
FROM Users u
JOIN UserEngagement ue
ON u.user_id = ue.user_id
GROUP BY u.user_id, u.name
ORDER BY total_watch_time DESC;

-- ANSWER:
-- User 126 = 5 sessions, 739 mins, avg rating 3.6
-- User 89 = 4 sessions, 627 mins, avg rating 4.0
-- User 91 = 6 sessions, 518 mins, avg rating 2.8

