--additional constraints for account table
SELECT * 
FROM account;

alter table account
	alter column cust_id set not null;
	alter column acc_open_date set not null;
	alter column branch_id set not null;

alter column acc_type
set default 'Undeclared';

select *
from account
where acc_open_date < '2024-01-01';

alter table account
add constraint date_check check (acc_open_date >= '2024-01-01');

--additional constraints for branch table
select *
from branch;

alter table branch
alter column branch_name set not null;

--additional constraints for customer table
select *
from customer
order by cust_id;

alter table customer
alter column f_name set not null;

select *
from customer
where l_name is null;

alter table customer
	alter column l_name set not null,
	alter column city set not null,
	alter column mobile set not null,
	alter column date_of_birth set not null;

select *
from customer
where length(mobile::text) < 11;

update customer
set mobile  = '37289076541'
where mobile = '3728907654';

alter table customer
add constraint mobile_check CHECK(length(mobile::text) = 11);

--additional constraints for transaction_details table
select *
from transaction_details;

select *
from transaction_details
where date_trans < '2024-01-01';

alter table transaction_details
add constraint tr_date_check check(date_trans > '2024-01-01');

alter table transaction_details
	alter column trans_medium set not null,
	alter column trans_type set not null,
	alter column trans_amount set not null;
