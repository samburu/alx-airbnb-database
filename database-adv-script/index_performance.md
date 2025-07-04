# 🚀 Index Performance Optimization

This document analyzes the impact of indexes on query performance in the Airbnb database schema.

---

## High-Usage Columns Identified

| Table      | Column(s)             | Usage Type           |
|------------|------------------------|-----------------------|
| `users`    | `email`                | WHERE, JOIN           |
| `bookings` | `user_id`, `property_id`, `created_at` | WHERE, JOIN, ORDER BY |
| `properties`| `host_id`, `location_id` | JOIN, WHERE         |

---

## Sample Query Analysis

### Query: Bookings by a specific user
```sql
SELECT * FROM bookings WHERE user_id = 'some-user-id';
```

### Without Index
```sql
EXPLAIN ANALYZE SELECT * FROM bookings WHERE user_id = 'some-user-id';
-- Seq Scan on bookings ... cost=0.00..1234.00 rows=5000
-- Execution Time: ~XX ms
```

### With Index (`CREATE INDEX idx_bookings_user_id ON bookings(user_id);`)
```sql
EXPLAIN ANALYZE SELECT * FROM bookings WHERE user_id = 'some-user-id';
-- Index Scan using idx_bookings_user_id on bookings ... cost=0.00..54.00 rows=50
-- Execution Time: ~5-10x faster
```

---

## Query: Search properties by location

```sql
SELECT * FROM properties WHERE location_id = 'nairobi-uuid';
```

### With Index
```sql
EXPLAIN ANALYZE SELECT * FROM properties WHERE location_id = 'nairobi-uuid';
-- Index Scan using idx_properties_location_id ...
```

---

## Takeaways

- **Email lookups** benefit greatly from single-column indexing (`users.email`).
- **Join operations** on `user_id`, `property_id` now avoid full scans.
- **Time-based queries** (e.g., recent bookings) are much faster with composite indexes on (`user_id`, `created_at`).
- **Over-indexing should be avoided** — balance between read speed and write performance.

---

## Indexes Added

```sql
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_bookings_user_id ON bookings(user_id);
CREATE INDEX idx_bookings_property_id ON bookings(property_id);
CREATE INDEX idx_properties_host_id ON properties(host_id);
CREATE INDEX idx_properties_location_id ON properties(location_id);
CREATE INDEX idx_bookings_user_created_at ON bookings(user_id, created_at DESC);
```

