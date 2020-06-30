txn = LOAD '/user/Project1/data/Transactions.csv' using PigStorage(',') as (txnId:int,custId:int,transTotal:float,transNumItem:int,transDescr:chararray);
cust = LOAD '/user/Project1/data/Customers.csv' using PigStorage(',') as (custId:int,Name:chararray,age:int,gender:chararray,countryCode:int,salary:float);
groupedT = GROUP txn by custId;
T1= FOREACH groupedT GENERATE group,COUNT(txn.txnId) AS no_of_txn;
T2 = JOIN cust by custId, T1 by group;
Result1 = FOREACH T2 GENERATE Name, no_of_txn;
Result2 = ORDER Result1 by no_of_txn;
STORE Result2 into '/user/Project1/out/pig/Query1' using PigStorage(',');
