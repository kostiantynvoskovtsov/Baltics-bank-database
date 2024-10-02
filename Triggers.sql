alter table account
rename to accounts;

select *
from accounts;

--create a table for logs
create table acc_log(
	log_id serial primary key,
	acc_id integer references accounts(acc_id),--add foreign key, type integer, as we don't want it to auto-increment
	log_timestamp timestamp);

alter table acc_log
add column log_action text not null;

select *
from acc_log;

--creating triggers for automation of critical tasks
create or replace function log_acc_delete()
returns trigger as $$
begin    
    insert into acc_log (acc_id, log_timestamp, log_action) 
    values(old.acc_id, current_timestamp, 'deleted');
    return null; -- Triggers for 'AFTER' do not need to return anything
end;
$$ language plpgsql;

-- Step 2: Create the trigger itself
create trigger after_acc_del
after delete on accounts
for each row
execute function log_acc_delete();

--for branches we only rename the table
alter table branch
rename to branches;

select *
from branches;

--now we rename customer table and create trigger for logs
alter table customer
rename to customers;

select *
from customers;

--create a table for logs
create table cust_logs(
	log_id serial primary key,
	cust_id integer references customers(cust_id),
	log_timestamp timestamp,
	log_action text not null);

select *
from cust_logs; 

--create trigger function first
create or replace function log_cust_del()
returns trigger as $$
begin
	insert into log_cust_del(cust_id, log_timestamp, log_action)
	values(old.cust_id, current_timestamp, 'deleted');
end;
$$ language plpgsql;

--create the trigger itself
create trigger after_cust_del
after delete on customers
for each row
execute function log_cust_del();

--same for loans
alter table loan
rename to loans;

--check composite key name(better thru psql)
select constraint_name
from information_schema.table_constraints
where table_name = 'loans' and constraint_name = 'primary key';

--get rid of composite key
alter table loans
drop constraint loan_pkey;

select *
from loans;

-- add loan_id column
alter table loans
add column loan_id serial primary key;


--create a table for logs
create table loan_logs(
	log_id serial primary key,
	loan_id integer references loans(loan_id),
	log_timestamp timestamp,
	log_action text
);

-- create function
create or replace function log_loan_del()
returns trigger as $$
begin
	insert into loan_logs(loan_id, log_timestamp, log_action)
	values(old.loan_id, current_timestamp, 'deleted');
end;
$$ language plpgsql;

--create trigger
create trigger after_loan_del
after delete on loans
for each row
execute function log_loan_del();

--same for transaction_details
select *
from transaction_details;


--create a table for logs
create table log_trans(
	log_id serial primary key,
	trans_id integer references transaction_details(trans_id),
	log_timestamp timestamp,
	log_action text
);

---create fucntion 
create or replace function log_trans_del()
returns trigger as $$
begin
	insert into log_trans(trans_id, log_timestamp, log_action)
	values(old.trans_id, current_timestamp, 'deleted');
end;
$$ language plpgsql;

--create trigger
create trigger after_trans_del
after delete on transaction_details
for each row
execute function log_trans_del();

--now we drop fk constraints from log tables, as they are redundant
alter table acc_log
drop constraint acc_log_acc_id_fkey;

alter table acc_log
rename to acc_logs;

alter table cust_logs
drop constraint cust_logs_cust_id_fkey;

alter table loan_logs
drop constraint loan_logs_loan_id_fkey;

alter table log_trans
drop constraint log_trans_trans_id_fkey;


