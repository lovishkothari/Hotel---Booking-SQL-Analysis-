use hotel_booking_analytics;
                        
                             # LEVEL 1; BASICS

# Q1. 1. Retrieve guest names and email addresses for a promotional email campaign.
# Business purpose: Marketing can use this list for direct guest communication.

SELECT first_name, last_name, email
FROM guests;

# Q2. Display all rooms with their room number, type, price per night, and amenities.
#Business purpose: Helps the hotel team review the complete room catalog.

SELECT * 
FROM rooms;

# Q3. List all unique cities from which guests have registered.
#Business purpose: Useful for understanding the geographic origin of guests.

SELECT DISTINCT(city)
FROM guests;

# Q4. Show all rooms with a price per night above n5,000.
#Business purpose: Helps identify premium rooms for high-value packages.

SELECT *
FROM rooms
WHERE price_per_night > 5000;

# Q5. Display rooms priced between n3,000 and n7,000 per night.
#Business purpose: Useful for creating a mid-range room offer.

SELECT * 
FROM rooms
WHERE price_per_night BETWEEN 3000 AND 7000;

# Q6. Retrieve bookings whose status is either 'Confirmed' or 'Checked-In'.
#Business purpose: Helps front-desk staff focus on active reservations.

SELECT *
FROM bookings
WHERE booking_status IN ('Confirmed', 'Checked-In');

# Q7. Identify guests whose names start with the letter 'A'.
#Business purpose: Useful for practicing pattern matching and alphabetical segmentation.

SELECT *
FROM guests
WHERE first_name LIKE 'A%';

# Q8. List Suite rooms costing less than n10,000 per night.
#Business purpose: Helps identify affordable premium-room options.

SELECT * 
FROM rooms
WHERE room_type = 'Suite'
and price_per_night < 10000;

# Q9. Display room types and prices sorted from highest to lowest price.
#Business purpose: Makes premium rooms easy to compare.

SELECT room_type, price_per_night
FROM rooms
ORDER BY price_per_night DESC;

# Q10. Display guest names and cities sorted by city and then by guest name.
#Business purpose: Useful for organized guest lists and reporting.

SELECT first_name, last_name, city
FROM guests
ORDER BY city ASC, first_name ASC;




                                  # LEVEL 2: FILTERING & FORMATTING

# Q11. Find bookings where guest information is missing using a NULL check.
#Business purpose: Helps identify orphaned or incomplete booking records.

SELECT *
FROM bookings
WHERE guest_id IS NULL;

# Q12. Display guest names and cities using user-friendly column aliases.
#Business purpose: Useful when preparing readable reports.

SELECT 
	first_name AS guest_first_name,
    last_name AS guest_last_name,
    city AS guest_city
FROM guests;

# Q13. Calculate the estimated room charge for each booking as price_per_night × nights.
#Business purpose: Provides a line-level room revenue calculation.

SELECT b.booking_id, r.price_per_night,
		DATEDIFF(b.check_out_date, b.check_in_date) AS nights,
		r.price_per_night * DATEDIFF(b.check_out_date, b.check_in_date) AS estimated_room_charge
FROM bookings b
JOIN rooms r
ON b.room_id = r.room_id;

# Q14. Combine guest name and city into one column called Guest_Location.
#Business purpose: Useful for compact guest summaries.

SELECT CONCAT(first_name, ' ' ,last_name, ',' ,city) AS Guest_Location
FROM guests;

# Q15. Extract only the month from each booking's check-in date.
#Business purpose: Helps prepare month-wise booking analysis.

SELECT booking_id, MONTH(check_in_date) AS Check_In_Month
FROM bookings;

# Q16. List all bookings that were cancelled.
#Business purpose: Useful for monitoring cancellations and potential lost revenue.

SELECT * 
FROM bookings
WHERE booking_status = 'Cancelled';

# Q17. Show bookings with a stay of 5 or more nights.
#Business purpose: Helps identify long-stay guests.

SELECT booking_id, check_in_date, check_out_date, DATEDIFF(check_out_date, check_in_date) AS nights
FROM bookings 
WHERE DATEDIFF(check_out_date, check_in_date) >= 5;

# Q18. List guests who registered after 1 January 2025.
#Business purpose: Useful for analyzing recently acquired guests

SELECT *
FROM guests 
WHERE registration_date > '2025-01-01';



                                            # LEVEL 3: AGGREGATIONS

# Q19. Count the total number of bookings.
#Business purpose: Measures overall booking volume.

SELECT COUNT(*) AS Total_Bookings
FROM bookings;

# Q20. Calculate the total booking revenue from all bookings.
#Business purpose: Provides the overall booked room value.

SELECT SUM(total_amount) AS Total_Booking_Revenue
FROM bookings;

#Q21. Calculate the average booking value.
#Business purpose: Helps understand typical guest booking spend.

SELECT AVG(total_amount) AS Average_Booking_Value
FROM bookings;

#Q22. Find the total number of unique guests who have made at least one booking.
#Business purpose: Measures the active guest base.

SELECT COUNT(DISTINCT guest_id) AS Unique_Booking_Guests
FROM bookings;


#Q23. Find the number of bookings made by each guest.
#Business purpose: Helps identify repeat guests.

SELECT guest_id, COUNT(*) AS Number_Of_Bookings
FROM bookings
GROUP BY guest_id;


#Q24. Calculate total booking revenue generated by each guest.
#Business purpose: Useful for identifying high-value guests.

SELECT guest_id, SUM(total_amount) AS Total_Revenue
FROM bookings
GROUP BY guest_id;


#Q25. Find the number of bookings for each room type.
#Business purpose: Helps compare demand across room categories.

SELECT r.room_type, COUNT(*) AS Number_Of_Bookings
FROM bookings b
JOIN rooms r
ON b.room_id = r.room_id
GROUP BY r.room_type;


#Q26. Calculate the average price per night for each room type.
#Business purpose: Useful for room-pricing comparisons.

SELECT room_type, AVG(price_per_night) AS Average_Price_Per_Night
FROM rooms
GROUP BY room_type;


#Q27. Show the number of bookings made for each check-in date.
#Business purpose: Helps identify busy and quiet days.

SELECT check_in_date, COUNT(*) AS Number_Of_Bookings
FROM bookings
GROUP BY check_in_date
ORDER BY check_in_date;


#Q28. Calculate total payment amount received by each payment method.
#Business purpose: Helps finance teams understand payment preferences

SELECT payment_method, SUM(amount_paid) AS Total_Payment_Amount
FROM payments
GROUP BY payment_method;



                                          # LEVEL 4: MULTI-TABLE QUERIES (JOINS)

# Q29. Retrieve booking details along with the guest name using an INNER JOIN.
#Business purpose: Shows who made each booking.

SELECT b.booking_id, CONCAT(g.first_name, ' ' ,g.last_name) AS Guest_name,
		b.check_in_date, b.check_out_date, b.number_of_guests, b.booking_status, b.total_amount, b.booking_source
FROM bookings b 
INNER JOIN guests g
ON b.guest_id = g.guest_id;


#Q30. List all bookings with room number, room type, and nightly price.
#Business purpose: Helps front-desk and operations teams view reservation details.

SELECT b.booking_id, r.room_number, r.room_type, r.price_per_night
FROM bookings b
JOIN rooms r
ON b.room_id = r.room_id;


#Q31. Display each booking with its payment method and payment status.
#Business purpose: Useful for payment reconciliation.

SELECT b.booking_id, p.payment_method, p.payment_status
FROM bookings b
JOIN payments p
ON b.booking_id = p.booking_id;



#Q32. List all guests and their bookings using a LEFT JOIN.
#Business purpose: Shows both active bookers and guests with no bookings.

SELECT g.guest_id, CONCAT(g.first_name, ' ' ,g.last_name),
		b.check_in_date, b.check_out_date, b.number_of_guests, b.booking_status, b.total_amount, b.booking_source
FROM guests g
LEFT JOIN bookings b
on g.guest_id = b.guest_id;



#Q33. List all rooms and any bookings associated with them using a LEFT JOIN.
#Business purpose: Helps identify rooms that have never been booked.

SELECT r.room_id, r.room_number, r.room_type, b.booking_id, b.booking_status
FROM rooms r
LEFT JOIN bookings b
ON r.room_id = b.room_id;



#Q34. Combine guest, booking, room, and payment information into one transaction report.
#Business purpose: Useful for management and audit reporting.

SELECT b.booking_id, CONCAT(g.first_name, ' ' ,g.last_name) AS Guest_Name,
		r.room_number, r.room_type, 
        b.check_in_date, b.check_out_date, b.booking_status, b.total_amount,
        p.payment_method, p.payment_status, p.amount_paid
FROM bookings b
INNER JOIN guests g
ON b.guest_id = g.guest_id
INNER JOIN rooms r
ON b.room_id = r.room_id
INNER JOIN payments p
ON b.booking_id = p.booking_id;


#Q35. Show booking services purchased by each guest, including service name and amount.
#Business purpose: Helps analyze guest spending beyond room charges.

SELECT CONCAT(g.first_name, ' ' ,g.last_name) AS Guest_name, 
		b.booking_id, bs.service_id, bs.service_name, bs.quantity,
        bs.service_price, bs.service_date,
        bs.quantity * bs.service_price AS Service_Amount
FROM guests g
INNER JOIN bookings b 
ON g.guest_id = b.guest_id
INNER JOIN booking_services bs
ON b.booking_id = bs.booking_id;



#Q36. Display reviews with guest name, room type, rating, and review text.
#Business purpose: Useful for customer-experience analysis.

SELECT re.review_id, CONCAT(g.first_name, ' ' ,g.last_name) AS Guest_name,
		r.room_type, re.rating, re.review_text
FROM reviews re
INNER JOIN guests g
ON re.guest_id = g.guest_id
INNER JOIN rooms r
ON re.room_id = r.room_id;


#Q37. Find guests who have both a booking and a review using multiple joins.
#Business purpose: Helps identify highly engaged guests

SELECT DISTINCT g.guest_id, CONCAT(g.first_name, ' ' ,g.last_name) AS Guest_name
FROM guests g
INNER JOIN bookings b
ON g.guest_id = b.guest_id
INNER JOIN reviews re
ON g.guest_id = re.guest_id;



                                             # LEVEL 5: SUBQUERIES

# Q38. List rooms priced above the average room price.
#Business purpose: Identifies premium-priced rooms.

SELECT * 
FROM rooms 
WHERE price_per_night > (
			SELECT AVG(price_per_night)
            FROM rooms
);



#Q39. Find guests who have made at least one booking using EXISTS.
#Business purpose: Identifies active guests.

SELECT g.guest_id, CONCAT(g.first_name, ' ' ,g.last_name) AS Guest_name
FROM guests g
WHERE EXISTS (
		SELECT 1
        FROM bookings b
        WHERE b.guest_id = g.guest_id
);


#Q40. Find guests who have never made a booking using NOT EXISTS.
#Business purpose: Useful for re-engagement campaigns.

SELECT g.guest_id, CONCAT(g.first_name, ' ' ,g.last_name) AS Guest_name
FROM guests g
WHERE NOT EXISTS (
		SELECT 1
        FROM bookings b
        WHERE b.guest_id = g.guest_id
);


#Q41. Show bookings whose total amount is greater than the average booking amount.
#Business purpose: Identifies unusually high-value reservations.

SELECT * 
FROM bookings
WHERE total_amount > (
		SELECT AVG(total_amount)
        FROM bookings
);


#Q42. Find the highest-value booking for each guest.
#Business purpose: Identifies each guest's largest transaction.

SELECT *
FROM bookings b
WHERE total_amount = (
		SELECT MAX(b2.total_amount)
        FROM bookings b2
        WHERE b2.guest_id = b.guest_id
)
ORDER BY total_amount desc;


#Q43. Show rooms that have never appeared in the bookings table.
#Business purpose: Helps identify rooms with no booking activity.

SELECT * 
FROM rooms r 
WHERE NOT EXISTS (
		SELECT 1
        FROM bookings b
        WHERE b.room_id = r.room_id
);



                                             # LEVEL 6: SET OPERATIONS


#Q44. List all guest IDs who either made a booking or wrote a review using UNION.
#Business purpose: Creates a combined list of engaged guests.

SELECT guest_id 
FROM bookings

UNION

SELECT guest_id 
FROM reviews;


#Q45. List guest IDs who made a booking as well as wrote a review. Use INTERSECT if supported; otherwise solve
# with EXISTS or INNER JOIN.
#Business purpose: Identifies guests who interacted with the hotel in both ways

SELECT DISTINCT b.guest_id
FROM bookings b
INNER JOIN reviews r
ON b.guest_id = r.guest_id;

