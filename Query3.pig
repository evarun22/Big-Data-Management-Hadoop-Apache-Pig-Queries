cust = LOAD '/user/Project1/data/Customers.csv' using PigStorage(',') as (custId:int,Name:chararray,age:int,gender:chararray,countryCode:int,salary:float);
groupedC = GROUP cust by countryCode;
countValC = FOREACH groupedC GENERATE group, COUNT(cust) as c;
filtered = FILTER countValC by c>5000 or c<2000;
store filtered into '/user/Project1/out/pig/Query3' using PigStorage(',');
