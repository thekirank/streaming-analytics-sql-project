-- 1. TOTAL USERS
SELECT COUNT(*) AS total_users
FROM Users;

-- 2. TOTAL CONTENT AVAILABLE
SELECT COUNT(*) AS total_content
FROM Content;

-- 3. TOTAL WATCH EVENTS
SELECT COUNT(*) AS total_watch_events
FROM UserEngagement;

-- 4. TOTAL WATCH TIME (MINUTES)
SELECT SUM(watch_duration_minutes) AS total_watch_time
FROM UserEngagement;

-- 5. AVERAGE WATCH TIME PER USER
SELECT ROUND(AVG(user_watch_time), 2) AS avg_watch_time_per_user
FROM (
    SELECT user_id,
           SUM(watch_duration_minutes) AS user_watch_time
    FROM UserEngagement
    GROUP BY user_id
) AS watch_summary;

-- 6. MONTHLY ACTIVE USERS (MAU)
SELECT YEAR(watch_date) AS year,
       MONTH(watch_date) AS month,
       COUNT(DISTINCT user_id) AS monthly_active_users
FROM UserEngagement
GROUP BY YEAR(watch_date),
         MONTH(watch_date)
ORDER BY year, month;

-- 7. DAILY ACTIVE USERS (DAU)
SELECT watch_date,
       COUNT(DISTINCT user_id) AS daily_active_users
FROM UserEngagement
GROUP BY watch_date
ORDER BY watch_date;

-- 8. TOTAL ACTIVE SUBSCRIPTIONS
SELECT COUNT(*) AS active_subscriptions
FROM UserSubscriptions
WHERE status = 'ACTIVE';

-- 9. TOTAL EXPIRED SUBSCRIPTIONS
SELECT COUNT(*) AS expired_subscriptions
FROM UserSubscriptions
WHERE status = 'EXPIRED';

-- 10. TOTAL REVENUE GENERATED
SELECT SUM(s.price_per_month) AS total_revenue
FROM Subscriptions s
JOIN UserSubscriptions us
ON s.subscription_id = us.subscription_id
WHERE us.status = 'ACTIVE';

-- 11. REVENUE BY SUBSCRIPTION PLAN
SELECT s.plan_name,
       COUNT(us.user_id) AS total_subscribers,
       SUM(s.price_per_month) AS total_revenue
FROM Subscriptions s
JOIN UserSubscriptions us
ON s.subscription_id = us.subscription_id
GROUP BY s.plan_name
ORDER BY total_revenue DESC;

-- 12. AVERAGE REVENUE PER USER (ARPU)
SELECT ROUND(
    SUM(s.price_per_month) /
    COUNT(DISTINCT us.user_id)
, 2) AS average_revenue_per_user
FROM Subscriptions s
JOIN UserSubscriptions us
ON s.subscription_id = us.subscription_id;

-- 13. MOST POPULAR GENRE
SELECT c.genre,
       SUM(ue.watch_duration_minutes) AS total_watch_time
FROM Content c
JOIN UserEngagement ue
ON c.content_id = ue.content_id
GROUP BY c.genre
ORDER BY total_watch_time DESC
LIMIT 1;

-- 14. MOST WATCHED CONTENT
SELECT c.title,
       COUNT(ue.engagement_id) AS total_views
FROM Content c
JOIN UserEngagement ue
ON c.content_id = ue.content_id
GROUP BY c.title
ORDER BY total_views DESC
LIMIT 10;

-- 15. TOP RATED CONTENT
SELECT c.title,
       ROUND(AVG(ue.rating), 2) AS average_rating
FROM Content c
JOIN UserEngagement ue
ON c.content_id = ue.content_id
GROUP BY c.title
ORDER BY average_rating DESC
LIMIT 10;

-- 16. AVERAGE PLATFORM RATING
SELECT ROUND(AVG(rating), 2) AS average_platform_rating
FROM UserEngagement;

-- 17. CONTENT ENGAGEMENT RATE
SELECT c.genre,
       ROUND(AVG(ue.watch_duration_minutes), 2) AS avg_engagement
FROM Content c
JOIN UserEngagement ue
ON c.content_id = ue.content_id
GROUP BY c.genre
ORDER BY avg_engagement DESC;

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

-- 20. COUNTRY-WISE USER DISTRIBUTION
SELECT country,
       COUNT(*) AS total_users
FROM Users
GROUP BY country
ORDER BY total_users DESC;

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