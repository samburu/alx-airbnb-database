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

## 2️ LEFT JOIN – Properties and Reviews
Query Goal: Retrieve all properties and any reviews associated with them.

```sql
SELECT ...
FROM properties p
LEFT JOIN reviews r ON p.property_id = r.property_id;
```
Explanation:
* Returns all properties, including those without any review (NULLs in review fields).
* Useful for identifying unrated properties.

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

