CREATE DATABASE Lucky_Shrub_transaction; 
use Lucky_Shrub_transaction;
CREATE TABLE Orders(OrderID INT NOT NULL primary key auto_increment, ClientID VARCHAR(10) DEFAULT NULL, ProductID VARCHAR(10) DEFAULT NULL, Quantity INT DEFAULT NULL, Cost DECIMAL(6,2) DEFAULT NULL, Date DATE DEFAULT NULL);
CREATE TABLE Employees(EmployeeID INT DEFAULT NULL, FullName VARCHAR(100) DEFAULT NULL, Role VARCHAR(50) DEFAULT NULL, Department VARCHAR(255) DEFAULT NULL); 
INSERT INTO Orders (OrderID, ClientID, ProductID , Quantity, Cost, Date)  
VALUES  
(1, "Cl1", "P1", 10, 500, "2020-09-01"), 
(2, "Cl2", "P2", 5, 100, "2020-09-05"),  
(3, "Cl3", "P3", 20, 800, "2020-09-03"),  
(4, "Cl4", "P4", 15, 150, "2020-09-07"),  
(5, "Cl3", "P3", 10, 450, "2020-09-08"),  
(6, "Cl2", "P2", 5, 800, "2020-09-09"),  
(7, "Cl1", "P4", 22, 1200, "2020-09-10"),  
(8, "Cl3", "P1", 15, 150, "2020-09-10"),  
(9, "Cl1", "P1", 10, 500, "2020-09-12"),  
(10, "Cl2", "P2", 5, 100, "2020-09-13"),  
(11, "Cl1", "P2", 15, 80, "2020-09-12"), 
(12, "Cl1", "P1", 10, 500, "2022-09-01"),  
(13, "Cl2", "P2", 5, 100, "2022-09-05"),  
(14, "Cl3", "P3", 20, 800, "2022-09-03"),  
(15, "Cl4", "P4", 15, 150, "2022-09-07"),  
(16, "Cl3", "P3", 10, 450, "2022-09-08"),  
(17, "Cl2", "P2", 5, 800, "2022-09-09"),  
(18, "Cl1", "P4", 22, 1200, "2022-09-10"),  
(19, "Cl3", "P1", 15, 150, "2022-09-10"),  
(20, "Cl1", "P1", 10, 500, "2022-09-12"),  
(21, "Cl2", "P2", 5, 100, "2022-09-13"),   
(22, "Cl2", "P1", 10, 500, "2021-09-01"),  
(23, "Cl2", "P2", 5, 100, "2021-09-05"),  
(24, "Cl3", "P3", 20, 800, "2021-09-03"),  
(25, "Cl4", "P4", 15, 150, "2021-09-07"),  
(26, "Cl1", "P3", 10, 450, "2021-09-08"),  
(27, "Cl2", "P1", 20, 1000, "2022-09-01"),  
(28, "Cl2", "P2", 10, 200, "2022-09-05"),  
(29, "Cl3", "P3", 20, 800, "2021-09-03"); 

INSERT INTO Employees (EmployeeID, FullName,  Role, Department)  
VALUES    
(1, "Seamus Hogan", "Manager", "Management"),    
(2, "Thomas Eriksson", "Assistant ", "Sales"),   
(3, "Simon Tolo", "Executive", "Management"),   
(4, "Francesca Soffia", "Assistant  ", "Human Resources"),   
(5, "Emily Sierra", "Accountant", "Finance"),    
(6, "Greta Galkina", "Accountant", "Finance"), 
(7, "Maria Carter", "Executive", "Human Resources"), 
(8, "Rick Griffin", "Manager", "Marketing"); 

select * from employees;
select * from Orders;

start transaction;
Update Employees set fullName= "Thabang Rakgoropo" where EmployeeID = 1;

select x.OrderID,y.FullName from Orders as x inner join Employees as y on x.OrderID = y.EmployeeID;
commit;


#############Common Table Expresion #######################################
with averageSale2020 as (Select concat(avg(Cost)," 2020") as "Avereage "from Orders where Year(Date) = 2020)
select * from averageSale2020 ;

with averageSale2021 as (Select concat(avg(Cost) , " 2021") as "Avereage" from Orders where Year(Date) = 2021),
	averageSale2022 as (Select concat(avg(Cost) ," 2022") from Orders where Year(Date) = 2022)
    
select * from averageSale2021 union
select * from averageSale2022 ;

#########################Prepare Statment#############################################
prepare GetOrderStatement from 'Select clientID,ProductID,Quantity, Cost from Orders where OrderID =?';

Set @orderID =5;

Execute GetOrderStatement using @orderID;

#####################MySQl Json############################
create table Activity(ActivityID int primary key,Properties json);
insert into Activity(ActivityID,Properties) values (1,'{"ClientID":"CL1","ProductID":"P1","Order":"True"}'),
													(2,'{"ClientID":"CL2","ProductID":"P2","Order":"False"}'),
                                                    (3,'{"ClientID":"CL3","ProductID":"P3","Order":"True"}');
                                                    
select ActivityID,Properties->> '$.ClientID' as "ClientID",Properties->> '$.ProductID' as "ProductID",Properties->> '$.Order' as "Orders" from Activity;


#####################################################End Module activity#################################
SELECT CONCAT("Cl1: ", COUNT(OrderID), "orders") AS "Total number of orders" FROM Orders WHERE YEAR(Date) = 2022 AND ClientID = "Cl1" UNION SELECT CONCAT("Cl2: ", COUNT(OrderID), "orders") FROM Orders WHERE YEAR(Date) = 2022 AND ClientID = "Cl2" UNION SELECT CONCAT("Cl3: ", COUNT(OrderID), "orders") FROM Orders WHERE YEAR(Date) = 2022 AND ClientID = "Cl3"; 


############################Task 1 Solution
SELECT CONCAT("Cl1: ", COUNT(OrderID), "orders") AS "Total number of orders" 
FROM Orders 
WHERE YEAR(Date) = 2022 AND ClientID = "Cl1" 
UNION 
SELECT CONCAT("Cl2: ", COUNT(OrderID), "orders") 
FROM Orders 
WHERE YEAR(Date) = 2022 AND ClientID = "Cl2" 
UNION 
SELECT CONCAT("Cl3: ", COUNT(OrderID), "orders") 
FROM Orders 
WHERE YEAR(Date) = 2022 AND ClientID = "Cl3"; 

###########################################################Task 2 Solution
WITH 
CL1_Orders AS (SELECT CONCAT("Cl1: ", COUNT(OrderID), "orders") AS "Total number of orders"  
FROM Orders 
WHERE YEAR(Date) = 2022 AND ClientID = "Cl1"), 
CL2_Orders AS (SELECT  CONCAT("Cl2: ", COUNT(OrderID), "orders") 
FROM Orders WHERE YEAR(Date) = 2022 AND ClientID = "Cl2"), 
CL3_Orders AS (SELECT  CONCAT("Cl3: ", COUNT(OrderID), "orders") 
FROM Orders WHERE YEAR(Date) = 2022 AND ClientID = "Cl3") 
SELECT * FROM CL1_Orders
UNION 
SELECT * FROM CL2_Orders
UNION 
SELECT * FROM CL3_Orders; 

##################################Task 3
SELECT Activity.Properties ->>'$.ProductID' 
AS ProductID, Products.ProductName, Products.BuyPrice, Products.SellPrice 
FROM Products INNER JOIN Activity 
ON Products.ProductID = Activity.Properties ->>'$.ProductID' 
WHERE Activity.Properties ->>'$.Order' = "True";

##########################################Task 1 answerB
select * from averageSale2020 ;

with nOrders201 as (Select concat("Cl1:",count(OrderID)) as "TotalOrders" from Orders where Year(Date) = 2022 and ClientID="Cl1"),
	nOrders202 as (Select concat("Cl1:",count(OrderID)) from Orders where Year(Date) = 2022 and ClientID="Cl2")
    
select * from nOrders201 union
select * from nOrders202 ;