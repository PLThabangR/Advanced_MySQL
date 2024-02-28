create database Lucky_Shrub_pract1;
use Lucky_Shrub_pract1;

CREATE TABLE Products (ProductID VARCHAR(10), ProductName VARCHAR(100),BuyPrice DECIMAL(6,2), SellPrice DECIMAL(6,2), NumberOfItems INT);
INSERT INTO Products (ProductID, ProductName, BuyPrice, SellPrice, NumberOfITems)

VALUES ("P1", "Artificial grass bags ", 40, 50, 100),  
("P2", "Wood panels", 15, 20, 250),  
("P3", "Patio slates",35, 40, 60),  
("P4", "Sycamore trees ", 7, 10, 50),  
("P5", "Trees and Shrubs", 35, 50, 75),  
("P6", "Water fountain", 65, 80, 15);

CREATE TABLE Notifications (NotificationID INT AUTO_INCREMENT, Notification VARCHAR(255), DateTime TIMESTAMP NOT NULL, PRIMARY KEY(NotificationID));
select * from Products;
Delimiter //
create trigger ProductSellPriceInsertCheck 
after insert on Products for each row 
Begin
	if new.SellPrice<= new.BuyPrice then
	replace into Notifications(Notification,DateTime) values(concat('A sellPrice same or less than buyPrice was inserted for ',new.productID),now());
    end if;
end//
Delimiter ;

INSERT INTO Products (ProductID, ProductName, BuyPrice, SellPrice, NumberOfITems)
VALUES ("P8", "Product 8 ", 40, 30, 100);

select * from notifications;
select * from products;

##############################END OF SOLUTION 1 ##################################################################
Delimiter //
create trigger ProductSellPriceUpdateCheck after update on Products for each row
begin 
if New.sellPrice < new.buyPrice
	replace into Notifications(Notification,DateTime) values(concat(new.productID," as updated with a SellPrice of  + SellPrice + which is the same or less than the BuyPrice"),now());
end 
Delimiter ;