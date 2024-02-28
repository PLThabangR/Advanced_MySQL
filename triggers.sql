cREATE DATABASE Lucky_Shrub_triggers;
use Lucky_Shrub_triggers;
#CREATE TABLE RevenueReport(OrderID INT NOT NULL PRIMARY KEY, ClientID VARCHAR(10), ProductID VARCHAR(10), Quantity INT, Cost DECIMAL(6,2), Date DATE); 
INSERT INTO Orders(OrderID, ClientID, ProductID , Quantity, Cost, Date) VALUES
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
(11, "Cl4", "P5", 5, 100, "2020-09-15"), 
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
(29, "Cl3", "P3", 20, 800, "2021-09-03"),  
(30, "Cl1", "P1", 10, 500, "2022-09-01");

Delimiter //
create trigger OderQtyCheck before insert on Orders for each row 
	begin 
    if new.Quantity < 0 then set New.Quantity = 0 ; 
    end if;
    end//
    
delimiter ;
Delimiter //
#Create one time event
create event if not exists GenerateRevebueReport
on schedule at current_timestamp() + interval 12 hour
do 
begin
	insert into RevenueReport(OrderID,ClientID,ProductID,Quantity,Cost,Date) select * from Orders where date between '2022-08-01' and '2022-08-31';
    end//

delimiter ;
#Syntax on how to write triggers	
#CREATE TRIGGER trigger_name
#{BEFORE | AFTER} {INSERT | UPDATE| DELETE}
#ON table_name FOR EACH ROW
#trigger_body;
#Delete a trigger 
#DROP TRIGGER [IF EXISTS] [schema_name.]trigger_name
#
    
##########Using a new modifier
#CREATE TRIGGER OrderQtyCheck  
# BEFORE INSERT ON Orders  
#  FOR EACH ROW  
#BEGIN 
#  IF NEW.Quantity < 0 THEN  
#    SET NEW.Quantity = 0; 
#  END IF; 
#END;
    