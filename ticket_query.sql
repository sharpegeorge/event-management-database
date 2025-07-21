# Query 1

SELECT eventName, startDateTime, endDateTime, eventDescription, venueName, venue.address, wheelchairAccess, foodAvailable, venueDescription FROM event 
INNER JOIN venue ON venue.venueID = event.venueID
WHERE event.eventName='Exeter Food Festival 2023' ;

SELECT ticketType.ticketName, totalTickets FROM tickettype
INNER JOIN event on event.eventID = ticketType.eventID
WHERE event.eventName='Exeter Food Festival 2023';


# Query 2

SELECT eventName, startDateTime, endDateTime, eventDescription FROM event 
INNER JOIN venue ON venue.venueID = event.venueID
WHERE startDateTime BETWEEN '2023-07-01' AND '2023-07-10 23:59:59'
AND venue.address LIKE '%Exeter%';


# Query 3

SELECT totalTickets AS bronzeTickets, price FROM ticketType
INNER JOIN event on event.eventID = tickettype.eventID
WHERE tickettype.ticketName='Bronze' AND event.eventName='Exmouth Music Festival 2023';


# Query 4

SELECT fName, lName, quantity from booking
INNER JOIN customer ON booking.customerID = customer.customerID
INNER JOIN ticket ON booking.bookingID = ticket.bookingID
INNER JOIN event on booking.eventID = event.eventID
INNER JOIN ticketType ON ticketType.ticketTypeID = ticket.ticketTypeID
WHERE ticketType.ticketName='Gold' AND event.eventName='Exmouth Music Festival 2023';


# Query 5

SELECT event.eventName, IFNULL(SUM(ticket.quantity),0) FROM event
INNER JOIN ticketType ON ticketType.eventid = event.eventid
LEFT JOIN ticket ON ticket.ticketTypeid = tickettype.ticketTypeid
GROUP BY event.eventName
ORDER BY SUM(ticket.quantity) DESC;


# Query 6

SELECT fName, lName, dateTimeBooked, isRefunded, sentDigitally, eventName, eventDescription, venueName, startDateTime, venue.address, venueDescription, wheelchairAccess, foodAvailable, 
	(SELECT TRUNCATE(SUM(tickettype.price * quantity * IFNULL(discountMulti, 1)),2) FROM booking
	INNER JOIN ticket ON ticket.bookingID = booking.bookingID
	INNER JOIN ticketType ON ticketType.ticketTypeid = ticket.ticketTypeid
	LEFT JOIN voucher ON voucher.voucherID = booking.voucherID
	WHERE booking.bookingID='1') as totalCost
    
FROM booking
INNER JOIN customer ON customer.customerID = booking.customerID
INNER JOIN event ON event.eventID = booking.eventID
INNER JOIN venue ON venue.venueID = event.venueID
WHERE bookingID='1';

# Seperate select incase more than one ticket is bought
SELECT ticketType.ticketName, quantity FROM booking
INNER JOIN ticket ON ticket.bookingID = booking.bookingID
INNER JOIN ticketType ON ticketType.ticketTypeid = ticket.ticketTypeid
WHERE booking.bookingID='1';


# Query 7

SELECT eventName, max(totalIncome)
FROM ( 
	SELECT event.eventName, TRUNCATE(IFNULL(SUM(ticket.quantity * ticketType.price * IFNULL(discountMulti, 1)),0),2) AS totalIncome FROM event
	INNER JOIN ticketType ON ticketType.eventID = event.eventID
    INNER JOIN booking ON booking.eventID = event.eventID
	LEFT JOIN ticket ON ticket.ticketTypeID = ticketType.ticketTypeID
	LEFT JOIN voucher ON voucher.voucherID = booking.voucherID
GROUP BY event.eventName
) AS subquery
GROUP BY eventName
ORDER BY max(totalIncome) DESC
 LIMIT 1;