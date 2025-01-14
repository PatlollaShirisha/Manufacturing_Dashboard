select * from Prod_Data;
/*alter table prod_data rename column 'Manufactured Qty' to Manufactured_Qty;*/
select count(*) as total_records from Prod_Data;


create table Prod_Data (
Buyer text,
Cust_Code text,
Cust_Name text,
Delivery_Period text,
Department_Name text,
Designer text,
Doc_Date datetime,
Doc_Num text,
EMP_Code text,
Emp_Name text,
EMPCode_MEMP text,
End_Time datetime,
Fiscal_Date date,
Fiscal_DateTime datetime,
Form_Type text,
In_Active text,
Is_FinalProcess text,
Item_Code text,
Item_Name text,
Machine_or_Employee text,
Machine_Code text,
Machine_Code_EMP text,
Machine_Name text,
Machine_Name_EMP text,
Operation_Code text,
Operation_Name text,
Rpm int,
SAP_So_Num int,
Sapgrno int,
Shortages text,
SNO int,
SO_Del_Date date,
SO_Delivery_Date date,
SO_Docdate date,
SO_DocDate_F date,
SO_Expected_Delivery_F date,
SO_Num int,
So_Posting_Date date,
Start_Time datetime,
U_GRCDate date,
U_GRRate decimal,
U_unitdeldt date,
User_Id int,
User_Id1 int,
User_Name text,
Variant_Name text,
WO_Date date,
WO_Number int,
WO_Status text,
Work_CentreCode text,
Work_CentreName text,
Balance_Qty int,
Docnum int,
Final_Processed_Qty int,
Fiscal_Year year,
Man_or_Rejc int,
Manufactured_Qty int,
Per_day_Machine_Cost_made decimal,
Press_Qty int,
Processed_Qty int,
Produced_Qty int,
Rejected_Qty int,
Repeat_ int,
today_Manufactured_qty int,
TotalQty int,
TotalValue int,
WO_Qty int );



set global LOCAL_INFILE=ON;
LOAD DATA LOCAL INFILE 'C:/Users/shiri/Downloads/Manufacturing-P726/Manufacturing dataset/Manufacturing/Prod_Data.csv' INTO TABLE Prod_Data
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;


# KPI Cards
# Manufactured Qty
SELECT sum(Manufactured_Qty) as Total_manufactured_Qty FROM prod_data;

# Processed Qty
SELECT sum(Processed_Qty) as Total_processed_Qty FROM prod_data;

# Rejected Qty
SELECT sum(Rejected_Qty) as Total_Rejected_Qty FROM prod_data;

# Wastage %

SELECT CONCAT(ROUND((SUM(Rejected_Qty) / SUM(processed_Qty)) * 100, 2), '%') AS Wastage_Percentage
FROM prod_data;

SELECT CONCAT((SUM(Rejected_Qty) / SUM(processed_Qty)) * 100, '%') AS Wastage_Percentage
FROM prod_data;

# Employee wise Rejected Qty
SELECT Emp_Name, SUM(Rejected_Qty) AS Total_Rejected_Qty
FROM prod_data
GROUP BY Emp_Name
ORDER BY Total_Rejected_Qty DESC
LIMIT 10;

# Machine wise Rejected Qty
SELECT Machine_Code, SUM(Rejected_Qty) AS Total_Rejected_Qty
FROM prod_data
GROUP BY Machine_Code
ORDER BY Total_Rejected_Qty DESC
LIMIT 10;

# Production comparision Trend
SELECT year(SO_Delivery_Date) AS Delivery_Date, sum(Produced_Qty)
FROM prod_data group by Delivery_Date
Order by Delivery_Date;

# Manufactured Qty Vs Rejected Qty
select sum(manufactured_qty) as Total_manufactured_Qty , sum(Rejected_qty) as Total_Rejected_Qty 
from prod_data;

# Department wise Manufatured Qty Vs Rejected Qty
select Department_Name, sum(manufactured_qty) as Total_Manufactured_Qty, sum(rejected_qty) as Total_Rejected_qty
from prod_data
group by Department_Name;

/*SELECT CONCAT(ROUND(SUM(Total_Sales) / 1000000, 2), ' Million') AS Total_Sales_in_Millions
FROM sales_data; */

