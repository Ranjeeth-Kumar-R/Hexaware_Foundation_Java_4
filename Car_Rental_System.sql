create database car_rental_system;

use car_rental_system;

create table Vehicle(
Vehicle_ID int primary key,
Make varchar(255),
Model varchar(255),
Year int,
Daily_Rate decimal,
Available boolean,
Passenger_Capacity int,
Engine_Capacity int);

create table Customer(
Customer_ID int primary key,
First_Name varchar(255),
Last_name varchar(255),
Email varchar(255),
Phone_Number varchar(255)); 


create table Lease(
Lease_ID int primary key,
Vehicle_ID int,
Customer_ID int,
Start_Date date,
End_Date date,
Type varchar(255),
foreign key (Vehicle_ID) references Vehicle(Vehicle_ID),
foreign key(Customer_ID) references Customer(Customer_ID)); 

create table Payment(
Payment_ID int primary key,
Lease_ID int,
Payment_Date date,
Amount decimal,
foreign key(Lease_ID) references Lease(Lease_ID));

-- Insertion :

insert into Vehicle values 
(1, 'Toyota', 'Camry', 2022, 50.00, 1, 4, 1450),
(2, 'Honda', 'Civic', 2023, 45.00, 1, 7, 1500),
(3, 'Ford', 'Focus', 2022, 48.00, 0, 4, 1400),
(4, 'Nissan', 'Altima', 2023, 52.00, 1, 7, 1200),
(5, 'Chevrolet', 'Malibu', 2022, 47.00, 1, 4, 1800),
(6, 'Hyundai', 'Sonata', 2023, 49.00, 0, 7, 1400),
(7, 'BMW', '3 Series', 2023, 60.00, 1, 7, 2499),
(8, 'Mercedes', 'C-Class', 2022, 58.00, 1, 8, 2599),
(9, 'Audi', 'A4', 2022, 55.00, 0, 4, 2500),
(10, 'Lexus', 'E5', 2023, 54.00, 1, 4, 2500);

insert into Customer values 
(1, 'John', 'Doe', 'johndoe@example.com', '555-555-5555'),
(2, 'Jane', 'Smith', 'janesmith@example.com', '555-123-4567'),
(3, 'Robert', 'Johnson', 'robert@example.com', '555-789-1234'),
(4, 'Sarah', 'Brown', 'sarah@example.com', '555-456-7890'),
(5, 'David', 'Lee', 'david@example.com', '555-987-6543'),
(6, 'Laura', 'Hall', 'laura@example.com', '555-234-5678'),
(7, 'Michael', 'Davis', 'michael@example.com', '555-8765432'),
(8, 'Emma', 'Wilson', 'emma@example.com', '555-432-1098'),
(9, 'William', 'Taylor', 'william@example.com', '555-321-6547'),
(10, 'Olivia', 'Adams', 'olivia@example.com', '555-765-4321');

insert into Lease values 
(1, 1, 1, '2023-01-01', '2023-01-05', 'Daily'),
(2, 2, 2, '2023-02-15', '2023-02-28', 'Monthly'),
(3, 3, 3, '2023-03-10', '2023-03-15', 'Daily'),
(4, 4, 4, '2023-04-20', '2023-04-30', 'Monthly'),
(5, 5, 5, '2023-05-05', '2023-05-10', 'Daily'),
(6, 4, 3, '2023-06-15', '2023-06-30', 'Monthly'),
(7, 7, 7, '2023-07-01', '2023-07-10', 'Daily'),
(8, 8, 8, '2023-08-12', '2023-08-15', 'Monthly'),
(9, 3, 3, '2023-09-07', '2023-09-10', 'Daily'),
(10, 10, 10, '2023-10-10', '2023-10-31', 'Monthly');

insert into Payment values
(1, 1, '2023-01-03', 200.00),
(2, 2, '2023-02-20', 1000.00),
(3, 3, '2023-03-12', 75.00),
(4, 4, '2023-04-25', 900.00),
(5, 5, '2023-05-07', 60.00),
(6, 6, '2023-06-18', 1200.00),
(7, 7, '2023-07-03', 40.00),
(8, 8, '2023-08-14', 1100.00),
(9, 9, '2023-09-09', 80.00),
(10, 10, '2023-10-25', 1500.00);

-- Tasks:

-- Task 1:
Update Vehicle set Daily_Rate = 68 where Make = 'Mercedes';

-- Task 2:
-- Deleting a person names Olivia
Delete Payment from Payment join Lease on Payment.Lease_ID = Lease.Lease_ID 
where Lease.Customer_ID = (Select Customer_ID from Customer where First_Name='Olivia');

Delete from Lease where Lease.Customer_ID = (Select Customer_ID from Customer where First_Name='Olivia');
Delete from Customer where First_Name = 'Olivia';

-- Task 3:
Alter table Payment change column Payment_Date Transaction_Ddate date;
Alter table Payment change column Transaction_Ddate Transaction_Date date;

-- Task 4:
select * from Customer where Email = 'emma@example.com';

-- Task 5:
Select * from Lease where Customer_ID = 3 and End_Date > curdate(); 

-- Task 6:
Select Payment.* from Payment 
join Lease on Payment.Lease_ID = Lease.Lease_ID 
join Customer on Lease.Customer_ID = Customer.Customer_ID 
where Customer.Phone_Number='555-987-6543';

-- Task 7:
Select AVG(Daily_Rate) as Average_Daily_Rate_Available from Vehicle where Available = 1;

-- Task 8:
Select * from Vehicle where Daily_Rate = (Select MAX(Daily_Rate) from Vehicle);

-- Task 9:
Select * from Vehicle where Vehicle_ID in (Select Vehicle_ID from Lease where Customer_ID = 3);

-- Task 10:
Select * from Lease order by Start_Date desc limit 1;

-- Task 11:
Select * from Payment where date_format(Transaction_Date,'%Y') = '2023';

-- Task 12:
Select * from Customer where Customer_ID not in (Select Customer_ID from Lease);

-- Task 13:
select Vehicle.Vehicle_ID, Vehicle.Make, Vehicle.Model, Vehicle.Year, SUM(Payment.Amount) AS Total_Payments
from Vehicle 
join Lease on Vehicle.Vehicle_ID = Lease.Vehicle_ID
join Payment on Lease.Lease_ID = Payment.Lease_ID
group by Vehicle.Vehicle_ID, Vehicle.Make, Vehicle.Model, Vehicle.Year;

-- Task 14:
select  c.Customer_ID, c.First_Name, c.Last_Name, c.Email, c.Phone_Number, SUM(p.Amount) as Total_Payments
from Customer c
join Lease l on c.Customer_ID = l.Customer_ID
join Payment p on l.Lease_ID = p.Lease_ID
group by c.Customer_ID;

-- Task 15:
Select l.Lease_ID ,v.* from Vehicle v
join Lease l on v.Vehicle_ID = l.Vehicle_ID;

-- Task 16:
Select * from Customer c 
join Lease l on c.Customer_ID = l.Customer_ID
join Vehicle v on l.Vehicle_ID = v.Vehicle_ID
where l.End_Date > CURDATE();

-- Task 17:
select c.*, SUM(p.Amount) as Total from Customer c
join Lease l on c.Customer_ID = l.Customer_ID
join Payment p on l.Lease_ID = p.Lease_ID
group by c.Customer_ID
order by total desc
limit 1;

-- Task 18:
 select v.Vehicle_ID, l.Lease_ID, l.Start_Date, l.End_Date  from Vehicle v 
 join Lease l on v.Vehicle_ID = l.Vehicle_ID ;






