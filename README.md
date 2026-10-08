#  Hotel Booking & Guest Analytics SQL Project

##  Project Overview

This project is a **MySQL Hotel Booking & Guest Analytics project** designed to practice SQL and relational database concepts using a hotel business scenario.

The database contains information related to guests, rooms, bookings, booking services, payments, and customer reviews.

The project includes SQL questions covering basic queries, filtering, aggregations, joins, subqueries, and set operations.

---

##  Project Objectives

- Build a relational hotel booking database
- Create tables with appropriate constraints
- Insert and manage hotel-related data
- Retrieve and filter business information using SQL
- Perform aggregations and calculations
- Analyze data using multiple-table joins
- Use subqueries and EXISTS / NOT EXISTS
- Practice UNION and other set operations
- Answer real-world hotel business questions

---

##  Database Tables

The project includes the following tables:

-  **Guests**
-  **Rooms**
-  **Bookings**
-  **Booking Services**
-  **Payments**
-  **Reviews**

---

##  Relationships

The database uses primary keys and foreign keys to connect related tables.

Major relationships include:

- Guests → Bookings
- Rooms → Bookings
- Bookings → Booking Services
- Bookings → Payments
- Bookings → Reviews
- Guests → Reviews
- Rooms → Reviews

---

##  SQL Topics Covered

### Level 1 – Basics
- SELECT
- DISTINCT
- WHERE
- LIKE
- BETWEEN
- IN
- ORDER BY

### Level 2 – Filtering & Formatting
- NULL checks
- Column aliases
- Calculated columns
- CONCAT
- Date functions
- Filtering by dates

### Level 3 – Aggregations
- COUNT
- SUM
- AVG
- GROUP BY
- Aggregated business metrics

### Level 4 – Multi-Table Queries
- INNER JOIN
- LEFT JOIN
- Multiple-table joins
- Guest, booking, room and payment analysis

### Level 5 – Subqueries
- Subqueries
- EXISTS
- NOT EXISTS
- Average-based analysis
- Highest-value transactions

### Level 6 – Set Operations
- UNION
- INTERSECT concepts
- Combining results from different tables

---

##  Business Questions Explored

The project answers practical hotel business questions such as:

- Which guests have registered?
- Which rooms are premium-priced?
- Which cities do guests come from?
- How many bookings have been made?
- What is the total booking revenue?
- What is the average booking value?
- Which room types receive more bookings?
- Which guests generate higher revenue?
- Which payment methods are used?
- Which guests have never made a booking?
- Which rooms have never been booked?
- What are the guest reviews and ratings?

---

##  Tools & Technologies

- **MySQL**
- **SQL**
- Relational Database Concepts

---

##  Project Files

| File | Description |
|---|---|
| `Hotel_Booking_SQL_Project.sql` | Database and table creation |
| `Hotel_Booking_Data_Insert.sql` | Data insertion queries |
| `SQL_PROJECT_HOTEL_RATING_ANALYSIS_QUESTIONS.sql` | SQL questions and solutions |
| `README.md` | Project documentation |

---

⭐ This project demonstrates practical SQL skills through a real-world hotel booking and guest analytics scenario.
