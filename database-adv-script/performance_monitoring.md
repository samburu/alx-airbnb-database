# Database Performance Monitoring and Refinement Report

## Overview

We analyzed performance of frequently executed queries, especially those involving joins and filtering on the `bookings` table.

## Query Monitored

```sql
SELECT
    b.booking_id,
    b.start_date,
    b.end_date,
    u.email,
    p.name AS property_name
FROM bookings b
JOIN users u ON b.user_id = u.user_id
JOIN properties p ON b.property_id = p.property_id
WHERE b.start_date BETWEEN '2024-01-01' AND '2024-12-31'
  AND b.status = 'confirmed';
```

## Bottlenecks Identified
* Sequential scans on bookings partitions
* Filters on start_date and status were slow
* Joins with users and properties tables were costly with large data sets

## Improvements Applied
* Created index on bookings(status)
* Created index on bookings(start_date)
* Created composite index on bookings(start_date, status)

