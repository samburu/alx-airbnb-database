# Database Normalization – AirBnB Clone

## Objective

Ensure that the AirBnB database schema adheres to **Third Normal Form (3NF)** by identifying and eliminating redundancy and transitive dependencies.

---

## Normal Forms Recap

### ➤ First Normal Form (1NF)
- Eliminate repeating groups.
- Ensure atomic (indivisible) fields.

### ➤ Second Normal Form (2NF)
- Satisfy 1NF.
- Remove partial dependencies (applies when composite primary keys exist).

### ➤ Third Normal Form (3NF)
- Satisfy 2NF.
- Remove transitive dependencies (non-key attributes should not depend on other non-key attributes).

---

## Normalization Analysis by Table

### User

Already in 3NF
- Atomic fields.
- No partial or transitive dependencies.
- Each attribute fully depends on the primary key `user_id`.

---

### Property (Original)

 **Issue Identified**
The `location` field (e.g., `"Nairobi, Kenya"`) is a compound value — it contains multiple attributes (city, country).
This:
- Violates **1NF** (not atomic).
- Leads to **redundancy** across properties in the same location.
- Makes querying by country or city inefficient.

---

### Property (Normalized)

We normalize location into its own table to achieve 3NF.

#### New Schema

#### `Location` Table

| Field         | Type         | Description                    |
|---------------|--------------|--------------------------------|
| `location_id` | UUID (PK)    | Unique location identifier     |
| `city`        | VARCHAR(50)  | City name                      |
| `region`      | VARCHAR(50)  | Optional: state/province       |
| `country`     | VARCHAR(50)  | Country name                   |

#### `Property` Table (Updated)

| Field         | Type         | Description                             |
|---------------|--------------|-----------------------------------------|
| `property_id` | UUID (PK)    | Unique property identifier              |
| `host_id`     | UUID (FK)    | References `User(user_id)`              |
| `location_id` | UUID (FK)    | References `Location(location_id)`      |
| `name`        | VARCHAR(50)  | Property name                           |
| `description` | TEXT         | Description of the property             |
| `pricepernight` | DECIMAL    | Price per night                         |
| `created_at`  | TIMESTAMP    | Default: CURRENT_TIMESTAMP              |
| `updated_at`  | TIMESTAMP    | Auto-updated timestamp on modification  |

Benefits:
- Eliminates redundancy (e.g., no repeated `"Nairobi, Kenya"` strings).
- Makes filtering by city or country efficient.
- Sets the foundation for geospatial extensions if needed.

---

### Booking, Payment, Review, Message

All remain in 3NF
- Atomic fields.
- No partial or transitive dependencies.
- All foreign keys point to primary keys.

---

## Final Verdict

> All entities in the schema are now **fully normalized to 3NF**, including a refactored location model for `Property`.

This improves:
- Query efficiency
- Data integrity
- Maintainability

---