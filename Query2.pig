txn = LOAD '/user/Project1/data/Transactions.csv' using PigStorage(',') as (txnId:int,custId:int,transTotal:float,transNumItem:int);
cust = LOAD '/user/Project1/data/Customers.csv' using PigStorage(',') as (custId:int,Name:chararray,age:int,gender:chararray,countryCode:int,salary:float);
joinC = JOIN cust  BY custId, txn BY custId using 'replicated';
groupedC = GROUP joinC by (cust::custId,cust::Name,cust::salary);
countValC = FOREACH groupedC GENERATE group, COUNT(joinC),SUM(joinC.transTotal),MIN(joinC.transNumItem);
store countValC into '/user/Project1/out/pig/Query2' using PigStorage(',');



