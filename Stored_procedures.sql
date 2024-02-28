CREATE DATABASE Lucky_Shrub_procedures;
use Lucky_Shrub_procedures;

show columns from orders;

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
select * from Orders;

create function costValue(order_ID INT) 
returns decimal(5,2) DETERMINISTIC
RETURN (select Cost from Orders where OrderID= order_ID);

select costValue(5)  from Orders;

select Cost from Orders where OrderID= 5;

DELIMITER // 
create Procedure GetDiscount(OrderInput int)
Begin
	declare cost_after_discount decimal(7,2);	
	DECLARE current_cost DECIMAL(7,2); 
	DECLARE order_quantity INT; 
	SELECT QUANTITY into order_quantity from Orders where OrderID = OrderInput;
    SELECT Cost INTO current_cost FROM Orders WHERE OrderID = OrderInput; 
    if order_quantity >= 20 then
		set cost_after_discount = current_cost - (current_cost*0.2);
	elseif order_quantity >= 10 then
		set cost_after_discount = current_cost - (current_cost*0.1);
	else set cost_after_discount = current_cost;
	end	if;
select cost_after_discount;
end //
DELIMITER ;
drop procedure  GetDiscount;
call GetDiscount(5);

CREATE FUNCTION FindCost(order_id INT) 
RETURNS DECIMAL(5,2) DETERMINISTIC  RETURN 
(
    SELECT Cost FROM Orders 
    WHERE OrderID = order_id
);
select FindCost(4) from orders;