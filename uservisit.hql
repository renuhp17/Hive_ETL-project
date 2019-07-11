-- Log file contains entries like user A visited page 1, user B visited page -- 3, user C visited page 2, user D visited page no 4 . How will you
-- implement a Hadoop job for this to answer the following queries in real
-- time Which page was visited by user C more than 4 times in aday             -- andWhichpage was visited by only one user exactly 3 times in a day?


-- Run below two queries to load data in hive
-- create urldatabase

create database urldb;
use urldb;

-- create table urldata 

create table urldata (ip string, url string) row format delimited fields terminated by ' ';

--load data into urldata

load data local inpath '/home/cloudera/hive_project/UserVisitingLogData/usersvisitinglogfile.txt' into table urldata;

--create view v1 as

create view v1 as select ip,url, count(*) as c from urldata  group by ip,url;
