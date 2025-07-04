-- STEP 1: Drop old table if exists (use with caution in prod!)
DROP TABLE IF EXISTS bookings CASCADE;

-- STEP 2: Create parent bookings table with PARTITION BY clause
CREATE TABLE bookings (
    booking_id UUID PRIMARY KEY,
    property_id UUID NOT NULL REFERENCES properties(property_id),
    user_id UUID NOT NULL REFERENCES users(user_id),
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL(10,2) NOT NULL,
    status booking_status NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) PARTITION BY RANGE (start_date);

-- STEP 3: Create partitions for different year ranges
CREATE TABLE bookings_2022 PARTITION OF bookings
    FOR VALUES FROM ('2022-01-01') TO ('2023-01-01');

CREATE TABLE bookings_2023 PARTITION OF bookings
    FOR VALUES FROM ('2023-01-01') TO ('2024-01-01');

CREATE TABLE bookings_2024 PARTITION OF bookings
    FOR VALUES FROM ('2024-01-01') TO ('2025-01-01');

CREATE TABLE bookings_future PARTITION OF bookings
    FOR VALUES FROM ('2025-01-01') TO ('2100-01-01');

-- STEP 4: Test query using EXPLAIN ANALYZE
EXPLAIN ANALYZE
SELECT * FROM bookings
WHERE start_date BETWEEN '2024-01-01' AND '2024-03-31';
