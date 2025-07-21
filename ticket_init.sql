CREATE TABLE Customer (
    customerID int auto_increment not null,
    fName varchar(50) not null,
    lName varchar(50) not null,
    email varchar(255) not null,
    DOB date not null,
    address varchar(255) not null,
    primary key (customerID)
);

INSERT INTO Customer(fName, lName, email, DOB, address) values ('Joe','Smiths','goodoldjoe@gmail.com','1985-08-14','1 White House Lane, Washington, D.C. United States'),
('Puss','In Boots','yourfavouritefearlesshero@gmail.com','2006-04-16','10 Cat Haven, San Ricardo');

CREATE TABLE Venue (
	venueID int auto_increment not null,
	venueName varchar(100) not null,
    address varchar(255) not null,
    wheelchairAccess boolean,
    foodAvailable boolean,
    venueDescription varchar(1000),
    primary key (venueID)
);

INSERT INTO Venue(venueName, address, wheelchairAccess, foodAvailable, venueDescription) values ("The Great Hall", 'Stocker Rd, Exeter EX4 4PY', false, 
true, "The largest of the Universities facilities, the Great Hall boasts a large auditorium perfect for many different events."), 
('Cathedral Lawn', '1 The Cloisters, Exeter EX1 1HS', true, false, 'The lawn surrounding the Exeter Cathedral'), 
('Exmouth Beach', 'Esplanade, Exmouth EX8 2AZ', true, true, 'A sandy beach on the Exmouth coast, surrounded by cafes and places to eat!');

CREATE TABLE Event (
    eventID int auto_increment not null,
    eventName varchar(100) not null,
    startDateTime datetime not null,
    endDateTime datetime not null,
    eventDescription varchar(1000) not null,
    venueID int not null,
    primary key (eventID),
    foreign key (venueID) references Venue(venueID)
);

INSERT INTO Event(eventName, startDateTime, endDateTime, eventDescription, venueID) values 
('Exeter Food Festival 2023', '2023-07-05 11:00:00', '2023-07-08 19:00:00','A cultural event where food from around the world is explored!', '1'),
('Exeter Flash Mob', '2023-07-14 16:00:00', '2023-07-14 16:10:00', 'A quick flash mob for the people!', '2'),
('Exmouth Music Festival 2023', '2023-07-03 20:00:00', '2023-07-04 03:00:00', 'A music festival for everyone in Exmouth!', '3');

CREATE TABLE SavedCard (
    cardNum varchar(16) not null,
    cardType varchar(32) not null,
    securityNum varchar(3) not null,
    expDate date not null,
    primary key (cardNum)
);

INSERT INTO SavedCard(cardNum, cardType, securityNum, expDate) values ('0121001711200343', 'Mastercard', '007', '2026-01-01'),('9785125317103056','Visa','573','2025-05-24');

CREATE TABLE Payment (
    customerID int not null,
    cardNum varchar(16) not null,
    primary key(customerID, cardNum),
    foreign key (customerID) references Customer(customerID),
	foreign key (cardNum) references SavedCard(cardNum)
);

INSERT INTO Payment(customerID, cardNum) values ('1', '9785125317103056'),('2', '0121001711200343');

CREATE TABLE Voucher (
	voucherID int auto_increment not null,
    inputCode varchar(255) not null,
    discountMulti decimal(3,2) not null,
    eventID int not null,
    primary key(voucherID),
    foreign key (eventID) references Event(eventID)
);

INSERT INTO Voucher(inputCode, discountMulti, eventID) values ('Gina30', '0.70', '1'),('FOOD10', '0.90', '1');

CREATE TABLE Booking (
	bookingID int auto_increment not null,
    dateTimeBooked datetime not null,
    sentDigitally boolean not null,
    isRefunded boolean default false not null,
    customerID int not null,
    eventID int not null,
    voucherID int,
    primary key(bookingID),
    foreign key (customerID) references Customer(customerID),
    foreign key (eventID) references Event(eventID),
    foreign key (voucherID) references Voucher(voucherID)
);

INSERT INTO Booking (dateTimeBooked, sentDigitally, isRefunded, customerID, eventID, voucherID) values 
('2019-12-12 8:59:42',true,false,'1','3','1'),
('2019-12-15 14:34:24',false,false,'2','3', null),
('2019-12-15 14:34:24',false,false,'2','3', null),
('2020-01-01 12:32:23',true,false,'2', '1', '1');

CREATE TABLE TicketType (
	ticketTypeID int auto_increment not null,
    price decimal(15, 2) not null,
    ticketName varchar(100) not null,
    minAge int default 0,
    maxAge int default 100,
    totalTickets int not null,
    eventID int not null,
    primary key(ticketTypeID),
    foreign key (eventID) references Event(eventID)
);

INSERT INTO TicketType (price, ticketName, minAge, maxAge, totalTickets, eventID) values ('20.00', 'Adult', '16', default, '500', '1'), 
('5.00', 'Child', '5', '15', '500', '1'), ('50.00', 'Gold', default, default, 100, 3), ('30.00', 'Silver', default, default, 200, 3), ('15.00', 'Bronze', default, default, 500, 3),
('12.50', 'All Ages', default, default, '50', '2');
CREATE TABLE Ticket (
	ticketID int auto_increment not null,
    quantity int not null,
    customerID int not null,
    bookingID int not null,
    ticketTypeID int not null,
    primary key(ticketID),
    foreign key (ticketTypeID) references TicketType(ticketTypeID)
);

INSERT INTO Ticket (quantity, customerID, bookingID, ticketTypeID) values ('2', '1', '1', '3'), ("5","1","3","5"), ("3", "1", "3", "3"), ('4', '1', '2', '1'), ('1', '2', '4','2');


