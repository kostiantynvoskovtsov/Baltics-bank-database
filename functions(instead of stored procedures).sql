select *
from accounts;

--as we're in Postgres, let's create function, rather than procedure to write less queries
create or replace function get_acc_dtls(AccId int)
returns table(
	acc_id int,
	cust_id int, 
	branch_id int,
	opening_balance int,
	acc_open_date date,
	acc_type varchar(20),
	acc_status varchar(20)
) AS $$
begin
	return query
	select *
	from accounts
	where accounts.acc_id = AccId;
end;
$$ language plpgsql;
--call the function
select *
from get_acc_dtls('4');

select *
from branches; 

--initialise the function for branches table
create or replace function get_br_dtls(BrnId int)
returns table(
	branch_id int,
	branch_name varchar(50),
	branch_city varchar(50)
) AS $$
begin
return query
	select *
	from branches
	where branches.branch_id = BrnId;
end;
$$ language plpgsql;
--call the function
select *
from get_br_dtls('6');

select *
from customers;

--create fucntion for customers table
create or replace function get_cust_dtls(CustId int)

returns table (
	cust_id int,
	f_name varchar(50),
	m_name varchar(50),
	l_name varchar(50),
	city varchar(50),
	mobile numeric,
	occupation varchar(20),
	date_of_birth date
) AS $$

begin
return query
	select *
	from customers
	where customers.cust_id  = CustId;
end;
$$ language plpgsql;

--call the function
select *
from get_cust_dtls('5');

--call the function
select *
from loans;
--just in case: drop function get_loan_dtls(int);
--create a function for loans table
create or replace function get_loan_dtls(LoanId int)
returns table(
	cust_id int,
	branch_id int,
	loan_amount float,
	loan_id int
) AS $$

begin
return query
	select *
	from loans
	where loans.loan_id = LoanId;
end;
$$ language plpgsql;

--call the function
select *
from get_loan_dtls('8');

select *
from transaction_details;

--create delete query just in case(but not execute it before the function)
drop function get_trans_dtls(int);

--create the function itself
create or replace function get_trns_dtls(TransId int)
returns table(
	trans_id int,
	acc_id int, 
	date_trans date,
	trans_medium varchar(20),
	trans_type varchar(20),
	trans_amount float
)
as $$

begin
return query
	select *
	from transaction_details
	where transaction_details.trans_id = TransId;
end;
$$ language plpgsql;

--call the function
select *
from get_trns_dtls(17);

