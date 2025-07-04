# Partitioning Performance Report

## Objective
To optimize query performance on the large `bookings` table by partitioning it based on `start_date`.

---

## Partitioning Strategy

- **Partitioning Method**: RANGE
- **Partition Key**: `start_date`
- **Created Partitions**:
  - `bookings_2022`: For bookings in 2022
  - `bookings_2023`: For bookings in 2023
  - `bookings_2024`: For bookings in 2024
  - `bookings_future`: For bookings from 2025 onward

---

## Performance Testing

### Sample Query:
```sql
SELECT * FROM bookings
WHERE start_date BETWEEN '2024-01-01' AND '2024-03-31';
