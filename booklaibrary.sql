CREATE DATABASE Book_library;

USE Book_library;

-- table branch

create table Branch(
Branch_no INT PRIMARY KEY, 
Manager_id INT, 
Branch_address VARCHAR(50),
Contact_no BIGINT);

-- values for table branch

INSERT INTO Branch VALUES(101,100,' Delhi Public Library,Delhi',9855593388),
                         (102,101,'Swami Vivekanand Library,Bhopal',7555267961),
						 (103,102,'Gowtami_Grandhalayam,Rajahmundry',8555190364),
                         (104,103,'Saraswata Niketanam,	Vetapalem',7555609110),
                         (105,104,'Visakhapatnam Public Library,Visakhapatnam',8555190364);

CREATE TABLE Employee(
Emp_id INT PRIMARY KEY, 
Emp_name VARCHAR(50), 
Position VARCHAR(50), 
Salary INT);

INSERT INTO Employee VALUES(100,'Ajay','Manager',55000),
                            (101,'Laxmi','Librarian',28000),
                            (103,'Urmila','IT support',20000),
							(104,'Amit','Library Assistant','40000'),
							(105,'Krishna','Librarian',18000),
							(106,'Rakesh','Manager',52000),
							(107,'Kiran','IT support',45000),
							(108,'Rakesh','Manager',540000);

CREATE TABLE Emp(
Emp_id INT PRIMARY KEY, 
Emp_name VARCHAR(50), 
Position VARCHAR(50), 
Salary INT, 
br_id INT);

INSERT INTO Emp VALUES(100,'Ajay','Manager',20000,101),
                      (101,'Laxmi','Librarian',18000,102),
                      (103,'Urmila','IT support',18000,103),
		              (104,'Amit','Library Assistant','20000',101),
                      (105,'Krishna','Librarian',18000,104),
                      (106,'Rakesh','Manager',20000,101),
                      (107,'Kiran','IT support',20000,101),
                      (108,'Rakesh','Manager',20000,101);


CREATE TABLE Customer(
Customer_id INT PRIMARY KEY, 
Customer_name VARCHAR(50), 
Customer_address VARCHAR(50),
Reg_date DATE);

INSERT INTO customer VALUES(100,'Maya','Delhi','2020-09-12'),
                           (101,'Arun','Visakhapatnam','2021-01-03'),
                           (103,'Rama','Bhopal','2020-02-03'),
		                   (104,'Shiv','Rajahmundry','2022-08-14'),
                           (105,'Rahul','Rajahmundry','2020-12-12'),
                           (106,'Mahesh','Vetapalem','2021-08-03'),
                           (107,'Kamal','Bhopal','2021-05-06'),
                           (108,'Prakash','Delhi','2022-10-03');

CREATE TABLE Books(
isbn INT PRIMARY KEY, 
Book_title VARCHAR(50), 
Category VARCHAR(50), 
Rental_price FLOAT,
Status VARCHAR(5) DEFAULT 'Yes', 
Author VARCHAR(30), 
Publisher VARCHAR(30));

INSERT INTO Books VALUES(1,'The God of Small Things', ' Fiction', 25,DEFAULT,'Arundhati Roy', ' Penguin Books India'),
						(2,'Sapiens: A Brief History of Humankind','History',30,DEFAULT, ' Yuval Noah Harari',' Yuval Noah Harari'),
                        (3, 'The White Tiger', 'Fiction',20,'No','Aravind Adiga','HarperCollins India'),
                        (4,'The Immortals of Meluha',' Fiction', 25,DEFAULT,'Amish Tripathi','Westland Publications'),
                        (5,'A Suitable Boy','Fiction',20,'No','Vikram Seth','Penguin Books India'),
                        (6,'The Rozabal Line','Thriller',30,DEFAULT,'Ashwin Sanghi','Westland Publications');


CREATE TABLE Issue_Status(
Issue_id INT PRIMARY KEY, 
Issued_cust INT, 
Issued_book_name VARCHAR(30),
Issue_date DATE, 
isbn_book INT,
foreign key(Issued_cust) references Customer(Customer_id),
foreign key(isbn_book) references Books(isbn));

INSERT INTO issue_status VALUES(1,100,'The God of Small Things','2023-06-06',3),
                               (2,103,' A Brief History of Humankind','2023-06-04',4),
							   (3,104,'The White Tiger','2022-12-12',2),
                               (4,104,'The Immortals of Meluha','2022-12-12',5),
                               (5,105,'A Suitable Boy','2021-03-12',6),
                               (6,105,'The Rozabal Line','2021-03-12',3);
                               
CREATE TABLE Return_Status(
Return_id INT PRIMARY KEY, 
Return_cust INT, 
Return_book_name VARCHAR(50), 
Return_date DATE,
isbn_book2 INT, 
foreign key(isbn_book2) references Books(isbn));


INSERT INTO return_status VALUES(1,104,'The Immortals of Meluha','2023-01-10',2), 
                                (2,105,'A Brief History of Humankind','2021-04-12',6),
								(3,105,'The Rozabal Line','2021-04-12',3);
                                
-- Queries --
  
-- Retrieves the book title, category, and rental price of all available books 
select Book_title,Category,Rental_price from books where Status='Yes';

-- Lists the employee names and their respective salaries in descending order of salary 
select Emp_name, Salary from employee order by Salary desc;

-- Retrieves the book titles and the corresponding customers who have issued those books 
select issue_status.Issued_book_name, customer.Customer_name 
from issue_status join customer
on issue_status.Issued_cust = customer.Customer_id;

-- Displays the total count of books in each category
select category, count(isbn)  from books group by category;

-- Retrieves the employee names and their positions for the employees whose salaries are above Rs.50,000 
select Emp_name, Position from employee where Salary>=50000;

-- Lists the customer names who registered before 2022-01-01 and have not issued any books yet 
select Customer_name from customer where Reg_date < '2022-01-01' and
 Customer_id not in(select Issued_cust from issue_status);
 
 -- Displays the branch numbers and the total count of employees in each branch 
 select branch.Branch_no, count(employee.Emp_name) 
 from branch join employee
 on branch.Manager_id = employee.Emp_id
 group by branch.Branch_no;
 
 select branch.Branch_no, count(emp.Emp_name) 
 from branch join emp
 on branch.Branch_no = emp.br_id
 group by branch.Branch_no;
 
 -- Displays the names of customers who have issued books in the month of June 2023 
 select customer.Customer_name from 
 customer join issue_status
 on customer.Customer_id = issue_status.Issued_cust 
 where issue_status.Issue_date > '2023-06-01' and issue_status.Issue_date <= '2023-06-30';
 
 -- Retrieves book_title from book table containing history --
 select Book_title from books where  Category='history' ;
 
 -- Retrieves the branch numbers along with the count of employees for branches having more than 5 employees --
 select br_id, count(Emp_id) from emp group by br_id having count(Emp_id)>=5;
 