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
