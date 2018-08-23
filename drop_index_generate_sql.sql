1.	select distinct 'drop index ' || index_name || ';' from information_schema.indexes where table_name = upper('PCX_FLIABDRONE_CG') and index_name not like 'PRI%';
Copy the result from the above select statement, and execute the drop statements.
Example:
drop INDEX pc0000035lN1; 
drop INDEX pc0000035lU0;
drop index PC0000035LN3; 
drop index PC0000035LU6; 
drop index PC0000035LU5; 
drop index PC0000035LU4; 
drop index PC0000035LU2; 

2.	select distinct 'drop index ' || index_name || ';' from information_schema.indexes where table_name = upper('PCX_FPROPDRONE_CG') and index_name not like 'PRI%';
Copy the result from the above select statement, and execute the drop statements.
Example:
drop index PC0000035NU0; 
drop index PC0000035NN3; 
drop index PC0000035NN1; 
drop index PC0000035NU6; 
drop index PC0000035NU5; 
drop index PC0000035NU4; 
drop index PC0000035NU2; 
