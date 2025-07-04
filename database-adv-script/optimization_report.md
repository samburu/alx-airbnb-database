# Query Optimization Report

This report outlines the performance analysis and optimization of a complex SQL query used in the Airbnb database project.

---

## Initial Query

We began with a query that retrieves:
- All bookings (`bookings`)
- User details (`users`)
- Property details (`properties`)
- Payment info (`payments`)

---

## Performance Analysis

We used `EXPLAIN ANALYZE` to analyze the execution:

## Issues Found:
* Sequential scans on bookings, users, and payments for large datasets.

* Missing indexes caused JOIN operations to slow down.

* `SELECT *` and unnecessary fields increased data size.

---

## Optimizations Applied

* Selected only required columns.
* Replaced inner joins with LEFT JOIN only for optional data (e.g., payments).
* Ensured foreign key relationships are indexed.