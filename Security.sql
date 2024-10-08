select *
from accounts;

alter table accounts
add column account_manager text;

update accounts
set account_manager = case 
    WHEN acc_id = 1 THEN 'Ain Kask'
    WHEN acc_id = 2 THEN 'Liis Leht'
    WHEN acc_id = 3 THEN 'Tomas Jurgis'
    WHEN acc_id = 4 THEN 'Daina Rīdere'
    WHEN acc_id = 5 THEN 'Kristiine Pärn'
    WHEN acc_id = 6 THEN 'Martins Kalniņš'
    WHEN acc_id = 7 THEN 'Marija Baiba'
    WHEN acc_id = 8 THEN 'Andrius Šuminas'
    WHEN acc_id = 9 THEN 'Katrīna Lāce'
    WHEN acc_id = 10 THEN 'Raimonds Ozols'
    WHEN acc_id = 11 THEN 'Marta Purina'
    WHEN acc_id = 12 THEN 'Aleksandrs Dombrovskis'
    WHEN acc_id = 13 THEN 'Evelina Pakalniņa'
    WHEN acc_id = 14 THEN 'Oskars Zeltiņš'
    WHEN acc_id = 15 THEN 'Katrīna Miezīte'
    WHEN acc_id = 16 THEN 'Eerik Murd'
    WHEN acc_id = 17 THEN 'Raimonds Krūmiņš'
    WHEN acc_id = 18 THEN 'Svetlana Pētersone'
    WHEN acc_id = 19 THEN 'Justas Balčius'
    WHEN acc_id = 20 THEN 'Rūta Bērziņa'
    WHEN acc_id = 21 THEN 'Liene Skulte'
    WHEN acc_id = 22 THEN 'Vaiva Rutkė'
    WHEN acc_id = 23 THEN 'Artūrs Kalniņš'
    WHEN acc_id = 24 THEN 'Natalija Vasiljeva'
    WHEN acc_id = 25 THEN 'Toma Tomaševska'
    WHEN acc_id = 26 THEN 'Zane Dzelzīte'
    WHEN acc_id = 27 THEN 'Lukas Česnakas'
    WHEN acc_id = 28 THEN 'Agnija Koroļeva'
    WHEN acc_id = 29 THEN 'Alvis Ziemelis'
    WHEN acc_id = 30 THEN 'Ieva Pētersone'
    WHEN acc_id = 31 THEN 'Mārtiņš Šķērsts'
    WHEN acc_id = 32 THEN 'Nikita Grigorjevs'
    WHEN acc_id = 33 THEN 'Laura Ivane'
    WHEN acc_id = 34 THEN 'Sīma Štāls'
    WHEN acc_id = 35 THEN 'Kārlis Berziņš'
    WHEN acc_id = 36 THEN 'Jānis Zariņš'
    WHEN acc_id = 37 THEN 'Maksims Karpovs'
    WHEN acc_id = 38 THEN 'Rūdolfs Stankevics'
    WHEN acc_id = 39 THEN 'Elina Frolova'
    WHEN acc_id = 40 THEN 'Ivars Lejnieks'
    WHEN acc_id = 41 THEN 'Viesturs Grūbe'
    WHEN acc_id = 42 THEN 'Inese Žubēna'
    WHEN acc_id = 43 THEN 'Gita Bērziņa'
    WHEN acc_id = 44 THEN 'Oļegs Priedītis'
    WHEN acc_id = 45 THEN 'Dmitrijs Lankov'
    WHEN acc_id = 46 THEN 'Agnese Eglīte'
    WHEN acc_id = 47 THEN 'Sarma Briedis'
    WHEN acc_id = 48 THEN 'Elizabete Kažoka'
    WHEN acc_id = 49 THEN 'Krišjānis Skuja'
    WHEN acc_id = 50 THEN 'Zane Pētersone'
    ELSE account_manager -- keep existing value if no match
end
where acc_id between 1 and 50; 

select acc_id, account_manager
from accounts
where acc_id between 1 and 50;

alter table accounts
enable row level security;

create policy account_manager_policy
on accounts
for select 
using (account_manager = current_user);

create role "Ain Kask" with login password 'ain_kask';

grant select, insert, update, delete on accounts to "Ain Kask";

set role "Ain Kask";

select *
from accounts;

set role postgres;

show data_directory;