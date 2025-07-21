# Update 1

UPDATE ticketType
INNER JOIN event ON event.eventID = ticketType.eventID
SET totalTickets = totalTickets + 100
WHERE ticketType.ticketName='Adult' AND event.eventName='Exeter Food Festival 2023';


# Update 2

INSERT INTO Customer(fName, lName, email, DOB, address) values ('Ian','Cooper','iancooperbestdad@gmail.com','1973-06-06','100 Charming Ln, Albany, NY 12211, USA');
INSERT INTO SavedCard(cardNum, cardType, securityNum, expDate) values ('2747802010535534', 'Visa', '666', '2024-10-13');

SET @customerID := (
	SELECT customerid FROM customer
	WHERE email='iancooperbestdad@gmail.com');
    
SET @eventID := (
	SELECT eventID FROM event
	WHERE eventName='Exeter Food Festival 2023');
    
SET @voucherID := (
	SELECT voucherid FROM voucher
	WHERE inputCode='FOOD10');
    
INSERT INTO Payment(customerID, cardNum) values (@customerID,'2747802010535534');
INSERT INTO Booking (dateTimeBooked, sentDigitally, isRefunded, customerID, eventID, voucherID) values ('2023-07-05 07:42:21',true,false, @customerID, @eventID, @voucherID);

SET @bookingID := (
	SELECT bookingID FROM booking
	WHERE customerID=@customerID AND eventID=@eventID);
    
SET @adultTicketID := (
	SELECT ticketTypeID from ticketType
	WHERE ticketName='Adult' AND eventID=@eventID);
    
SET @childTicketID := (
	SELECT ticketTypeID from ticketType
	WHERE ticketName='Child' AND eventID=@eventID);
    
INSERT INTO Ticket (quantity, customerID, bookingID, ticketTypeID) values ('2', @customerID, @bookingID, @adultTicketID);
INSERT INTO Ticket (quantity, customerID, bookingID, ticketTypeID) values ('1', @customerID, @bookingID, @childTicketID);


# Update 3
# Doesn't remove records as per ticket_design.pdf
UPDATE booking
SET isRefunded = true
WHERE booking.bookingid='1';


# Update 4
SET @eventID := (
	SELECT eventID FROM event
	WHERE eventName='Exeter Food Festival 2023');

INSERT INTO Voucher(inputCode, discountMulti, eventID) values ('SUMMER20', '0.80', @eventID);