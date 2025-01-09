CREATE TABLE Hotel_Booking (
    Booking_ID VARCHAR(10) PRIMARY KEY,
    no_of_adults INT,
    no_of_children INT,
    no_of_weekend_nights INT,
    no_of_week_nights INT,
    type_of_meal_plan VARCHAR(20),
    room_type_reserved VARCHAR(20),
    lead_time INT,
    arrival_date DATE,
    market_segment_type VARCHAR(20),
    avg_price_per_room FLOAT,
    booking_status VARCHAR(20)
);

select * from hotel_booking;


-----------------------------------------------Questions---------------------------------------------
1. What is the total number of reservations in the dataset?  

select count(booking_id) as Total_number_of_reservation
from hotel_booking;
---asnwer is 700----------------------------------------

2. Which meal plan is the most popular among guests?  

SELECT type_of_meal_plan, COUNT(type_of_meal_plan) AS meal_plan_count
FROM hotel_booking
GROUP BY type_of_meal_plan
ORDER BY type_of_meal_plan DESC;

------answer is meal plan 1 -----------------------


3. What is the average price per room for reservations involving children? 
select * from hotel_booking;
select Avg(avg_price_per_room) as Average_price_per_room
from hotel_booking
where no_of_children > 0;

--------------answer is 144.5683--------------------------------------


4. How many reservations were made for the year 20XX (replace XX with the desired year)?
select * from hotel_booking;

SELECT COUNT(booking_id) AS reservation_count
FROM hotel_booking
WHERE extract (year from arrival_date) = '2018';

-----------answer is 577------------------------------------

---------similarly for 2017--------

SELECT COUNT(booking_id) AS reservation_count
FROM hotel_booking
WHERE extract (year from arrival_date) = '2017';

------answer is123-----------------

5. What is the most commonly booked room type?  
select * from hotel_booking;

select room_type_reserved,count(room_type_reserved) as Total 
from hotel_booking
group by room_type_reserved
order by room_type_reserved Desc;


6. How many reservations fall on a weekend (no_of_weekend_nights > 0)?  
select * from hotel_booking;

SELECT booking_id AS Reservation, no_of_week_nights
FROM hotel_booking
WHERE no_of_week_nights > 0
GROUP BY booking_id, no_of_week_nights;

--------second method --------
SELECT count(booking_id)AS Reservation
FROM hotel_booking
WHERE no_of_week_nights > 0;

7. What is the highest and lowest lead time for reservations?  
select * from hotel_booking;

select max(lead_time) as highest_lead_time,
min(lead_time) as lowest_lead_time
from hotel_booking;



8. What is the most common market segment type for reservations? 
select * from hotel_booking;

select market_segment_type,
count(market_segment_type) as total 
from hotel_booking 
group by market_segment_type
order by market_segment_type ASC;

9. How many reservations have a booking status of "Confirmed"?  
select * from hotel_booking;


select booking_status,
count (booking_status) as total 
from hotel_booking 
group by booking_status;

10. What is the total number of adults and children across all reservations? 
select * from hotel_booking;

select sum(no_of_adults)as total_number_of_adults,
sum(no_of_children) as total_number_of_children
from hotel_booking;


11. What is the average number of weekend nights for reservations involving children? 

SELECT AVG(no_of_weekend_nights) AS avr_number_of_weekend_nights_with_children
FROM hotel_booking
WHERE no_of_children > 0;


12. How many reservations were made in each month of the year? 
select * from hotel_booking;

SELECT COUNT(booking_id) AS no_of_reservation,
EXTRACT(MONTH FROM arrival_date) AS month
FROM hotel_booking
GROUP BY EXTRACT(MONTH FROM arrival_date)
ORDER BY month;


SELECT COUNT(booking_id) AS no_of_reservation,
EXTRACT(MONTH FROM arrival_date) AS month
FROM hotel_booking
WHERE EXTRACT(YEAR FROM arrival_date) != 2017
GROUP BY EXTRACT(MONTH FROM arrival_date)
ORDER BY month ASC;




13. What is the average number of nights (both weekend and weekday) spent by guests for each room 
type?  
select * from hotel_booking;

select count(booking_id) as Reservation,
Avg(no_of_weekend_nights) as avg1,
Avg(no_of_week_nights) as avg2,
room_type_reserved 
from hotel_booking 
group by 
room_type_reserved 
order by count(booking_id) Desc; 


14. For reservations involving children, what is the most common room type, and what is the average 
price for that room type?  

SELECT room_type_reserved,
       COUNT(booking_id) AS reservation_count,
       AVG(avg_price_per_room) AS avg_price_per_room
FROM hotel_booking
WHERE no_of_children > 0
GROUP BY room_type_reserved
ORDER BY reservation_count DESC
LIMIT 1;



15. Find the market segment type that generates the highest average price per room.  

select market_segment_type,
sum(avg_price_per_room) as Total_Avg
from hotel_booking
group by 
market_segment_type
order by 
sum(avg_price_per_room)Desc;


or 


SELECT market_segment_type,
ROUND(SUM(avg_price_per_room)::numeric, 2) AS Total_Avg
FROM hotel_booking
GROUP BY market_segment_type
ORDER BY Total_Avg DESC;


