-- ======================================
-- Step 1: Initial Complex Query (With WHERE + AND)
-- ======================================

EXPLAIN ANALYZE
SELECT
    *
FROM bookings b
JOIN users u ON b.user_id = u.user_id
JOIN properties p ON b.property_id = p.property_id
LEFT JOIN payments pay ON pay.booking_id = b.booking_id
WHERE b.status = 'confirmed'
  AND b.total_price > 100;

-- ======================================
-- Step 2: Optimized Query (Explicit fields, same WHERE/AND)
-- ======================================

EXPLAIN ANALYZE
SELECT
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status,
    u.first_name,
    u.last_name,
    u.email,
    p.name AS property_name,
    p.location_id,
    pay.amount,
    pay.payment_date
FROM bookings b
JOIN users u ON b.user_id = u.user_id
JOIN properties p ON b.property_id = p.property_id
LEFT JOIN payments pay ON pay.booking_id = b.booking_id
WHERE b.status = 'confirmed'
  AND b.total_price > 100;
