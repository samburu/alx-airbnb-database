# 🌱 AirBnB Sample Data Seeding

This script populates the database with **sample data** to simulate real-world usage.

## 📁 Files

- `seed.sql` – Contains `INSERT` statements for users, properties, bookings, payments, reviews, and messages.

## 🔗 Dependencies

- Ensure that the database schema (`schema.sql`) has already been created.
- UUIDs are pre-set; adjust or use `gen_random_uuid()` if dynamic generation is preferred.

## ✅ Entities Populated

- 3 Users (1 host, 2 guests)
- 2 Locations (Kenya, South Africa)
- 2 Properties
- 2 Bookings (1 confirmed, 1 pending)
- 1 Payment
- 2 Reviews
- 2 Messages

## 🚀 How to Run

```bash
psql -U your_user -d your_database -f seed.sql
