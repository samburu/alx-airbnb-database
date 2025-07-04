# 🔗 Advanced SQL Joins – Airbnb Clone

This file contains SQL queries using different join types to retrieve data across multiple tables in the Airbnb database.

---

## 1 INNER JOIN – Users and Bookings

**Query Goal**: Retrieve all bookings along with the users who made them.

```sql
SELECT ...
FROM bookings b
INNER JOIN users u ON b.user_id = u.user_id;
```

Explanation:
* Only returns rows where there is a match in both bookings and users tables.
* Filters out bookings with no user (if any) and users who never made a booking.

---

## 2 LEFT JOIN – Properties and Reviews
Query Goal: Retrieve all properties and any reviews associated with them.

```sql
SELECT ...
FROM properties p
LEFT JOIN reviews r ON p.property_id = r.property_id;
```
Explanation:
* Returns all properties, including those without any review (NULLs in review fields).
* Useful for identifying unrated properties.
* ORDER BY p.property_id: Groups results by property so they’re easy to scan.
* r.created_at: Orders reviews from oldest to newest per property.
* This makes the output both compliant and readable.

---

## 3 FULL OUTER JOIN – Users and Bookings
Query Goal: Retrieve all users and all bookings, even if there's no booking-user relationship.

```sql
SELECT ...
FROM users u
FULL OUTER JOIN bookings b ON u.user_id = b.user_id;
```

Explanation:
* Returns:
** Users with no bookings (booking fields will be NULL)
** Bookings with no valid user reference (user fields will be NULL)
** All valid user-booking pairs

---

# SQL Subqueries – Airbnb Clone

This file contains SQL subqueries for analyzing property ratings and user booking activity.

---

## What is a Subquery?

A **subquery** is a query nested inside another SQL query. Subqueries can be used in `SELECT`, `FROM`, or `WHERE` clauses to help filter, compare, or derive new data.

---

## Types of Subqueries

###  Non-Correlated Subquery

A **Non-Correlated Subquery** is independent of the outer query. It runs once and returns a result that the outer query uses for filtering or comparison.

**Example:**
```sql
SELECT ...
FROM properties p
WHERE p.property_id IN (
    SELECT property_id
    FROM reviews
    GROUP BY property_id
    HAVING AVG(rating) > 4.0
);
```

**Explanation**:
- The subquery calculates average ratings per `property_id`.
- It runs only once and provides a list of properties with average ratings above 4.0.
- The outer query fetches details for only those properties.

---

###  Correlated Subquery

A **Correlated Subquery** depends on the outer query. It runs once **per row** of the outer query and uses values from the outer query to compute its result.

**Example:**
```sql
SELECT ...
FROM users u
WHERE (
    SELECT COUNT(*)
    FROM bookings b
    WHERE b.user_id = u.user_id
) > 3;
```

**Explanation**:
- The subquery is executed for each `user_id` from the outer query.
- It counts how many bookings that specific user has made.
- Only users with more than 3 bookings are returned.

---

## 1 Properties with Average Rating > 4.0

**Objective**: Retrieve all properties that have an average rating greater than 4.0 using a subquery.

```sql
SELECT ...
FROM properties p
WHERE p.property_id IN (
    SELECT property_id
    FROM reviews
    GROUP BY property_id
    HAVING AVG(rating) > 4.0
);
```

**Type**: Non-Correlated Subquery

---

## 2️ Users with More Than 3 Bookings

**Objective**: Use a correlated subquery to find users who have made more than three bookings.

```sql
SELECT ...
FROM users u
WHERE (
    SELECT COUNT(*)
    FROM bookings b
    WHERE b.user_id = u.user_id
) > 3;
```

**Type**: Correlated Subquery

---

# Aggregations & Window Functions – Airbnb Clone

This module demonstrates how to use SQL aggregation (`COUNT`, `GROUP BY`) and window functions (`RANK`) for analytics in a relational database.

---

## 1 Count Total Bookings per User

**Objective**: Find how many bookings each user has made.

```sql
SELECT
    u.user_id,
    u.first_name,
    u.last_name,
    COUNT(b.booking_id) AS total_bookings
FROM users u
LEFT JOIN bookings b ON u.user_id = b.user_id
GROUP BY u.user_id, u.first_name, u.last_name
ORDER BY total_bookings DESC;
```

**Explanation**:
- `COUNT(b.booking_id)` counts how many bookings each user has made.
- `LEFT JOIN` ensures users with 0 bookings are also included.
- Useful for generating user activity reports.

---

## 2 Rank Properties by Number of Bookings

**Objective**: Rank properties by popularity (i.e., number of bookings received).

```sql
SELECT
    p.property_id,
    p.name AS property_name,
    COUNT(b.booking_id) AS total_bookings,
    RANK() OVER (ORDER BY COUNT(b.booking_id) DESC) AS booking_rank
FROM properties p
LEFT JOIN bookings b ON p.property_id = b.property_id
GROUP BY p.property_id, p.name
ORDER BY booking_rank;
```

**Explanation**:
- Aggregates bookings per property using `COUNT`.
- Uses `RANK()` to assign rankings (1 = most booked).
- `RANK()` handles ties by assigning the same rank, skipping numbers as needed.
- Can be modified to use `ROW_NUMBER()` or `DENSE_RANK()` depending on ranking rules.

---


