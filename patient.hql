-- create hive patient table

create table patient(patient_id int, patient_name string, drug string,gender string,total_amount int) row format delimited fields terminated by ',';


--load value into patient table

load data local inpath '/home/cloudera/hive_project/hive_partitions/patient.txt' into table patient;


--using existing column
--create hive static partition table by existing column

create table p_patient1(patient_id int,patient_name string,gender string,total_amount int) partitioned by (drug string);

--insert value into the partitioned table 

insert overwrite table p_patient1 partition(drug = 'metacin') select patient_id,patient_name, gender, total_amount from patient where drug = 'metacin';


--using new column
--create hive static partition table by new column

create table p_patient(patient_id int, patient_name string,drug string,gender string,total_amount int) partitioned by (new string);


-- insert the value into p_patient table


insert overwrite table p_patient partition(new = 'metacin') select *from patient where drug = 'metacin';


--In dynamic partition partitioned column of the partitioned hive table is must present in the last column of the existing hive table


-- create table

create table patient1(patient_id int, patient_name string,gender string , total_amount int, drug string) row format delimited fields terminated by ',';


-- load data into the patient1 table

load data local inpath '/home/cloudera/hive_project/hive_partitions' into table patient1;


--before creating partitioned table in hive first we set the properties  for dynamic partiton


set hive.exec.dynamic.partition = true;

set hive.exec.dynamic.partition.mode =non-strict;


-- create dynamic partition table in hive


create table dynamic_partition_patient(patient_id int, patient_name string, gender string,total_amount int) partitioned by (drug string);



--insert data inot dynamic_partition_patient

insert into table dynamic_partition_patient PARTITION(drug) select *from patient1;



--Default partitioning in hive called bucketing

--partitioning give effective result when 

-- there are limited number of partition
-- comparatively equal size of partition

--first set the property before create bucketing table in hive


set hive.enforce.bucketing = true;

-- create bucket table in hive

create table bucket_pateint(patient_id int, patient_name string, drug string, gender string,total_amount int) clustered by(drug) into 4 buckets;


--insert the value into bucket table 


insert overwrite table bucket_pateint select *from patient1;


--do some query

select * from bucket_pateint tablesample(bucket 1 out of 4 on drug);

select * from bucket_pateint tablesample(10 percent);

select *from bucket_pateint limit 5;











