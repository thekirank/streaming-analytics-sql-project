-- Create the database
CREATE DATABASE ott;

-- Use database
USE ott;

-- Subscriptions Table
CREATE TABLE subscriptions (
    subscription_id INT PRIMARY KEY AUTO_INCREMENT,
    plan_name VARCHAR(50), -- premium, premiun HD, premium 4K
    price_per_month DECIMAL(6,2), -- 149, 249, 299
    duration_months INT -- 1 month
);

-- Users Table
CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    email VARCHAR(100) unique,
    gender VARCHAR(10),
    age INT check(age>16),
    country VARCHAR(50) default'India'
);

-- user_subscriptions Table
CREATE TABLE user_subscriptions (
    user_subscription_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    subscription_id INT,
    start_date DATE,
    end_date DATE,
    status varchar(50) DEFAULT 'Active', -- active, expired
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (subscription_id) REFERENCES subscriptions(subscription_id)
);


-- Content Table
CREATE TABLE content (
    content_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(100),
    type VARCHAR(20), -- Movie or Series
    release_year INT,
    genre varchar(50),  -- single genre
    language VARCHAR(50),
    duration_minutes INT
);


-- user_engagement
CREATE TABLE user_engagement (
    engagement_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    content_id INT,
    watch_date DATE,
    watch_duration_minutes INT,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    review TEXT,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (content_id) REFERENCES content(content_id)
);


-- check Tables in Database
SHOW TABLES;



/*

### OTT Platform Database Schema

This document provides a structured overview of the "OTT Platform Database Schema"

---

## Content Table

| Column Name       | Data Type     | Description                                  |
|-------------------|---------------|----------------------------------------------|
| content_id        | INT           | Unique identifier for each content item      |
| title             | VARCHAR(100)  | Title of the content                         |
| type              | VARCHAR(20)   | Type (e.g., Movie, Series)                   |
| release_year      | INT           | Year of release                              |
| genre             | VARCHAR(50)   | Genre (e.g., Drama, Thriller)                |
| language          | VARCHAR(50)   | Language of the content                      |
| duration_minutes  | INT           | Total duration in minutes                    |

---

## Users Table

| Column Name | Data Type     | Description                                  |
|-------------|---------------|----------------------------------------------|
| user_id     | INT           | Unique identifier for each user              |
| name        | VARCHAR(100)  | Name of the user                             |
| email       | VARCHAR(100)  | Unique email address                         |
| gender      | VARCHAR(10)   | Gender of the user                           |
| age         | INT           | Age (must be greater than 16)                |
| country     | VARCHAR(50)   | Country (default is 'India')                 |

---

## Subscriptions Table

| Column Name       | Data Type     | Description                                  |
|-------------------|---------------|----------------------------------------------|
| subscription_id   | INT           | Unique identifier for each subscription plan |
| plan_name         | VARCHAR(50)   | Name of the plan (e.g., Premium, Premium HD) |
| price_per_month   | DECIMAL(6,2)  | Monthly price of the plan                    |
| duration_months   | INT           | Duration of the plan in months               |

---

## User_Subscriptions Table

| Column Name           | Data Type     | Description                                         |
|-----------------------|---------------|-----------------------------------------------------|
| user_subscription_id  | INT           | Unique identifier for each user subscription        |
| user_id               | INT           | References `Users(user_id)`                         |
| subscription_id       | INT           | References `Subscriptions(subscription_id)`         |
| start_date            | DATE          | Subscription start date                             |
| end_date              | DATE          | Subscription end date                               |
| status                | VARCHAR(50)   | Status of the subscription (e.g., Active, Expired)  |

---

## User_Engagement Table

| Column Name            | Data Type     | Description                                         |
|------------------------|---------------|-----------------------------------------------------|
| engagement_id          | INT           | Unique identifier for each engagement record        |
| user_id                | INT           | References `Users(user_id)`                         |
| content_id             | INT           | References `Content(content_id)`                    |
| watch_date             | DATE          | Date the content was watched                        |
| watch_duration_minutes | INT           | Duration watched in minutes                         |
| rating                 | INT           | Rating (between 1 and 5)                            |
| review                 | TEXT          | User review of the content                          |

---

## Entity Relationship Summary

| Entity            | Relationship Type | Related Entity       | Description                                      |
|-------------------|-------------------|----------------------|--------------------------------------------------|
| Users             | 1-to-many         | User_Subscriptions   | One user can have multiple subscriptions         |
| Subscriptions     | 1-to-many         | User_Subscriptions   | One plan can be subscribed by many users         |
| Users             | 1-to-many         | User_Engagement      | One user can engage with multiple content items  |
| Content           | 1-to-many         | User_Engagement      | One content item can be watched by many users    |

---
*/

