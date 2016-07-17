/**
Updated and altered Tables for the test
 */
 CREATE TABLE Client(
	ClientID int NOT NULL,
	ClientName varchar(30) NOT NULL,
	ClientAddress varchar(30) NOT NULL,
	ClientCity varchar(15) NOT NULL,
	ClientState char(32) NOT NULL,
	ClientZip varchar(12) NOT NULL,
	Phone char(10) NOT NULL,
	Email varchar(50),
	CONSTRAINT pk_ClientID PRIMARY KEY(ClientID)
);

CREATE TABLE Employee(
	EmpID int NOT NULL,
	LastName varchar(30) NOT NULL,
	FirstName varchar(30),
	CONSTRAINT pk_EmpID PRIMARY KEY(EmpID) 
);

CREATE TABLE Task(
	TaskID int NOT NULL,
	TaskDescription varchar(50) NOT NULL,
	CONSTRAINT pk_TaskID PRIMARY KEY(TaskID)
);

CREATE TABLE Job(
	JobID int NOT NULL,
	JobName varchar(40) NOT NULL,
	DateProposed Date NOT NULL,
	DateAccepted Date,
	JobAddress varchar(30),
	JobCity varchar(15),
	JobState char(2),
	JobZip varchar(12),
	AllTaskCreated Bit NOT NULL, 
	JobCompleted Bit NOT NULL,
	PrimaryJobID int,
	ClientID int NOT NULL,
	EmpManagerID int, 
	CONSTRAINT pk_JobID PRIMARY KEY(JobID),
	CONSTRAINT fk_PrimaryJobID FOREIGN KEY (PrimaryJobID) REFERENCES Job(JobID),
	CONSTRAINT fk_ClientID FOREIGN KEY (ClientID) REFERENCES Client(ClientID),
	CONSTRAINT fk_EmpManagerID FOREIGN KEY (EmpManagerID) REFERENCES Employee(EmpID)
);

CREATE TABLE JobTask(
	TaskID int NOT NULL,
	JobID int NOT NULL,
	DateStarted Date NOT NULL,
	DateCompleted Date,
	SquareFeet int NOT NULL,
	EstHours int NOT NULL,
	EstLaborCost Money NOT NULL,
	EstMaterialCost Money NOT NULL,
	CONSTRAINT pk_JobTask PRIMARY KEY(TaskID,JobID),
	CONSTRAINT fk_TaskID FOREIGN KEY(TaskID) REFERENCES Task(TaskID),
	CONSTRAINT fk_JobID FOREIGN KEY(JobID) REFERENCES Job(JobID)
);

CREATE TABLE EmployeePay(
	EmpID int NOT NULL,
	DateStartPay Datetime NOT NULL,
	DateEnd Datetime NULL,
	HourlyPayRate Money NOT NULL,
	CONSTRAINT pk_employeePay PRIMARY KEY ([EmpID],[DateStartPay]),
	CONSTRAINT fk_EmpID FOREIGN KEY (EmpID) REFERENCES Employee(EmpID) 
);


CREATE TABLE TimeSheet(
	EmpID int NOT NULL,
	StartWork DateTime NOT NULL,
	HoursWorked Decimal (4,2) NOT NULL,
	TaskID int,
	JobID int,
	Activity varchar(15),
	CONSTRAINT pk_TImeSheet PRIMARY KEY(EmpID,StartWork),
	CONSTRAINT fk_TimeSheetEmpID FOREIGN KEY(EmpID) REFERENCES Employee(EmpID),
	CONSTRAINT fk_JobTaskID FOREIGN KEY(TaskID,JobID) REFERENCES JobTask(TaskID,JobID),
);


CREATE TABLE MATERIAL(
	MaterialID int NOT NULL,
	MaterialName varchar(50) NOt NULL,
	UOM varchar(5),
	CONSTRAINT pk_MaterialID PRIMARY KEY(MaterialID),
	CHECK ( UOM = 'Tube' OR  UOM = 'SQFT' OR UOM = 'Sheet' OR 
		UOM = 'qt' OR UOM = 'lb' OR UOM = 'gal' OR UOM = 'ea' OR  UOM = 'ft' OR
		 UOM ='ton' OR UOM  = 'pint' )
)

CREATE TABLE MaterialPurchased(
	POID int NOT NULL,
	DatePurchased DateTime NOT NULL,
	Quantity Decimal (7,2) NOT NULL,
	CostPerUOM Money NOT NULL,
	MaterialID int NOT NULL,
	CONSTRAINT pk_POID PRIMARY KEY(POID),
	CONSTRAINT fk_MaterialID FOREIGN KEY(MaterialID) REFERENCES Material(MaterialID)
)

CREATE TABLE MaterialAssigned(
	MaterialAssignedID int NOT NULL IDENTITY (1000,1),
	DateAssigned DateTime NOT NULL,
	Quantity Decimal(7,2) NOT NULL,
	TaskID int NOT NULL,
	JobID int NOT NULL,
	POID int NOT NULL,
	CONSTRAINT pk_MaterialAssigned PRIMARY KEY(MaterialAssignedID),
	CONSTRAINT fk_MaterialAssignedJobTaskID FOREIGN KEY(TaskID,JobID) REFERENCES JobTask(TaskID,JobID),
	CONSTRAINT fk_POID FOREIGN KEY(POID) REFERENCES MaterialPurchased(POID)
);

INSERT INTO Client VALUES 
(2417,'Kelly Property Development','66750 Industrial Parke Drive','Sparks','NV','89431','7758642950','Dave.Kelley@KPDLLC.inv'),
(2924,'Casem, Brokaw and Stuart, LLC','1500 Diagon Alley','Reno','NV','89519','7757261335','CCasem@gmail.inv'),
(4147,'Lloyds Casino Properties, LLC','2455 Air Park Avenue','Carson City','NV','89701','7755004010','Guillermo@gmail.inv'),
(4339,'3 Gals From Verona','1001 Apple Road','Sparks','NV','89431','7754283191','SophiaM@mail.yahoo.inv'),
(4435,'Dew Drop Inn Luxury Suites','3750 Brambley Road, Suite 2000','Reno','NV','89509','7754316404','MarySmith@dewdropproperties.inv'),
(4469,'Fran and Harrold Meyers','5740 Braeburn Hill Drive','Reno','NV','89509','7758652686','franny47@gmail.inv'),
(5012,'Less Furniture Company','1200 Apricot Blvd.','Reno','NV','89509','7757089540','bruce2@mail.yahoo.inv'),
(5423,'Aero Professional Corp.','1247 Airport Boulevard, Ste 23','Stead','NV','89441','7757157677','amelia777@gmail.inv'),
(6295,'AO Reid Construction','4275 Contractor Terrace','Sparks','NV','89431','7757225646','Harry@AOReid.inv'),
(6672,'Ms. Catherine Hampstead','23 Pine Forest Ave.','Incline Village','NV','89541','7759180022','Champstead@abner.rr.inv'),
(9948,'Adam''s Rib Restaurant','27 Main Street','Truckee','CA','96161','5309006607','Jean@adamsribsrestaurant.inv');

INSERT INTO Employee VALUES 
('2300','Riggs','Evelyn'),
('2480','Hazelton','Blake'),
('3155','Allen','Noel'),
('4702','Walker','Vance Martin'),
('5291','Kinney','Deneece'),
('5862','Bridges','Carol'),
('6460','Kane','Sylvia'),
('7651','Galloway','Odessa'),
('7656','Wiggins','Cody'),
('8110','Burgess','DaraLee'),
('8750','Fleming','Cathleen');

 
INSERT INTO Job VALUES 
(15771,	'Main Showroom, Entry Area','2015-02-02', NULL,'1200 Apricot Boulevard','Reno',	'NV' ,89509,0,0	,NULL,5012,NULL),
(16885,'Hampstead, Bathroom #2','2014-07-11','2014-07-25','23 Pine Forest Ave.','Incline Village','NV',89541,1,0,32687,6672,NULL),
(32687,'Hampstead, Bathroom 1','2014-07-25','2014-07-25','23 Pine Forest Ave.','Incline Village','NV',89541,1,1,NULL,6672,NULL),
(55841,'AO Reid - Wonder Valley PH 2-2','2013-05-20','2013-06-17','Sunrise Terrace, Unit 2','Reno','NV',89507,1,1,55873,6295,7651),
(55873,'AO Reid - Wonder Valley PH 2-3','2013-05-20','2013-06-17','Sunrise Terrace, Unit 3','Reno','NV',89507,1,1,55873,6295,7651),
(55878,'AO Reid - Wonder Valley PH 2-4','2013-05-20','2013-06-17','Sunrise Terrace, Unit 4','Reno','NV',89507,1,1,55873,6295,7651),
(62254,'Dew Drop, Meadow Wood-1','2014-09-14','2014-10-04','33 West Triple Diamond, FL 2','Reno','NV',89514,1,1,NULL,4435,4702),
(62257,'Dew Drop, Meadow Wood-2','2014-09-14','2014-10-04','33 West Triple Diamond, FL 3','Reno','NV',89514,1,1,62254,4435,4702),
(78431,'Custom Stained Glass Part.','2014-11-01','2014-11-18','1500 Diagon Alley','Reno','NV',89519,1,0,NULL,2924,6460),
(91584,'Restaurant Remodel','2014-03-18','2014-03-20','27 Main Street (Outside Bar)','Truckee','CA',96161,1,1,NULL,9948,4702);

INSERT INTO Task VALUES 
(110,'Remove Existing Floor'),
(120,'Clean mold'),
(130,'Install sub-floor'),
(140,'Design mosaic/glass'),
(150,'Prepare sub floor'),
(160,'Install tile floor'),
(170,'Grout'),
(180,'Seal and finish work'),
(190,'Install mosaic'),
(200,'Build structure'),
(210,'Remove existing tile'),
(220,'Clean site'),
(230,'Install tile counter'),
(240,'Install tile wall'),
(260,'Build mosaic/glass'),
(270,'General demolition');

INSERT INTO Material VALUES 
(1010,'Ard D 14 Type 1 Tile Adhesive','GAL'),
(1020,'Ard AF 207 Rapid Set Bonding','GAL'),
(1030,'Henry 440 Bulk','GAL'),
(1040,'Henry 440 Cove Base','TUBE'),
(1050,'Henry 356C Multi','GAL'),
(1060,'Chapco Moisture Defender','GAL'),
(1070,'Ceramic Tile','SQFT'),
(1080,'Porcelain Tile','SQFT'),
(1090,'Mosaic/Stained Glass','SQFT'),
(1100,'Granite','SQFT'),
(1110,'Hardie Backer','SHEET'),
(1120,'Underlayment Screws','SHEET'),
(1130,'Standard Install Supply Pack','EA'),
(1140,'ProTex Concrete Backer','SQFT'),
(1150,'Grout, Water based, additives','LB'),
(1160,'Grout, Epoxy','LB'),
(1170,'Tile and Stone sealant','QT'),
(2000,'Misc Material','EA');

INSERT INTO JobTask VALUES
(110,16885,'2014-12-10','2014-12-11',95,6,'$75.00',	'$25.00'),
(110,32687,'2014-07-31','2014-07-31',100,8,'$88.00','$0.00'),
(130,16885,'2014-12-12','2014-12-16',160,22,'$280.00','$360.00'),
(130,32687,'2014-08-04','2014-08-04',100,7,'$113.00','$95.00'),
(130,55841,'2013-07-15','2013-07-15',94,8,'$83.00','$83.00'),
(130,55873,'2013-08-14','2013-08-15',94,8,'$110.00','$83.00'),
(130,55878,'2013-09-12','2013-09-12',94,8,'$110.00','$83.00'),
(140,16885,'2014-11-24','2014-11-28',32,10,'$240.00','$10.00'),
(140,78431,'2014-11-17','2014-12-15',160,24,'$575.00','$50.00'),
(150,16885,'2014-12-16','2014-12-16',160,5,'$61.00','$250.00'),
(150,32687,'2014-08-04','2014-08-07',100,3,'$50.00','$110.00'),
(150,55841,'2013-07-16','2013-07-16',94,4,'$45.00','$110.00'),
(150,55873,'2013-08-16','2013-08-16',94,4,'$45.00','$110.00'),
(150,55878,'2013-09-16','2013-09-16',94,4,'$45.00','$110.00'),
(150,62254,'2014-10-14','2014-10-24',990,20,'$270.00','$790.00'),
(150,62257,'2014-10-30','2014-11-03',990,20,'$270.00','$790.00'),
(150,91584,'2014-03-31','2014-04-02',1240,33,'$450.00','$300.00'),
(160,16885,'2014-12-17',NULL,160,18,'$230.00','$1,530.00'),
(160,32687,'2014-08-11','2014-08-14',100,10,'$180.00','$13,550.00'),
(160,55841,'2013-07-18','2013-07-19',94,11,'$170.00','$240.00'),
(160,55873,'2013-08-19','2013-08-20',94,11,'$170.00','$240.00'),
(160,55878,'2013-09-19','2013-09-20',94,11,'$170.00','$240.00'),
(160,62254,'2014-10-16','2014-10-30',990,65,'$1,040.00','$1,897.00'),
(160,62257,'2014-11-03','2014-11-07',990,65,'$1,040.00','$1,897.00'),
(160,91584,'2014-04-07','2014-04-11',1274,72,'$1,200.00','$11,590.00'),
(170,16885,'2014-12-28',NULL,300,33,'$450.00','$40.00'),
(170,32687,'2014-08-18','2014-08-18',100,6,'$90.00','$12.00'),
(170,55841,'2013-07-22','2013-07-22',94,10,'$140.00','$9.00'),
(170,55873,'2013-08-26','2013-08-26',94,10,'$140.00','$9.00'),
(170,55878,'2013-09-24','2013-09-24',94,10,'$140.00','$9.00'),
(170,62254,'2014-10-21','2014-10-31',990,40,'$540.00','$120.00'),
(170,62257,'2014-11-07','2014-11-12',990,40,'$540.00','$120.00'),
(170,91584,'2014-04-14','2014-04-14',1274,16,'$216.00','$150.00'),
(180,16885,'2015-01-19',NULL,160,17,'$180.00','$25.00'),
(180,32687,'2014-08-22','2014-08-22',100,4,'$60.00','$10.00'),
(180,55841,'2013-07-29','2013-07-29',94,5,'$58.00','$13.00'),
(180,55873,'2013-09-02','2013-09-02',94,5,'$58.00','$13.00'),
(180,55878,'2013-09-30','2013-09-30',94,5,'$53.00','$13.00'),
(180,62254,'2014-10-30','2014-11-03',990,33,'$446.00','$125.00'),
(180,62257,'2014-11-13','2014-11-18',990,33,'$446.00','$125.00'),
(180,91584,'2014-04-18','2014-04-21',1274,8,'$108.00','$175.00'),
(190,78431,'2015-01-19',NULL,160,4,'$64.00','$0.00'),
(200,78431,'2015-01-12',NULL,160,8,'$128.00','$175.00'),
(230,91584,'2014-04-03','2014-04-04',34,16,'$265.00','$400.00'),
(240,16885,'2014-12-22',NULL,140,16,'$252.00','$1,625.00'),
(260,16885,'2015-01-05',NULL,32,16,'$384.00','$110.00'),
(260,78431,'2014-12-22',NULL,160,40,'$960.00','$1,460.00'),
(270,16885,'2014-12-08','2014-12-10',112,8,'$100.00','$0.00');

INSERT [EmployeePay]  VALUES (2300, '2012-01-09', NULL, 12.0000)
INSERT [EmployeePay]  VALUES (2480, '2011-05-02', '2012-05-01 11:59PM', 13.5000)
INSERT [EmployeePay]  VALUES (2480, '2012-05-02', NULL, 14.0000)
INSERT [EmployeePay]  VALUES (3155, '2012-03-07', '2013-03-06 11:59PM', 9.7500)
INSERT [EmployeePay]  VALUES (3155, '2013-03-07', '2014-03-06 11:59PM', 10.2500)
INSERT [EmployeePay]  VALUES (3155, '2014-03-07', NULL, 10.7500)
INSERT [EmployeePay]  VALUES (4702, '2011-03-24', NULL, 23.0000)
INSERT [EmployeePay]  VALUES (5291, '2011-03-09', '2012-03-08 11:59PM', 15.5000)
INSERT [EmployeePay]  VALUES (5291, '2012-03-09', NULL, 16.0000)
INSERT [EmployeePay]  VALUES (5862, '2012-08-15', '2014-11-04 11:59PM', 16.0000)
INSERT [EmployeePay]  VALUES (5862, '2014-11-05', NULL, 16.7200)
INSERT [EmployeePay]  VALUES (6460, '2011-11-08', '2014-02-03 11:59PM', 24.5000)
INSERT [EmployeePay]  VALUES (6460, '2014-02-04', NULL, 27.5000)
INSERT [EmployeePay]  VALUES (7651, '2012-11-01', NULL, 21.0000)
INSERT [EmployeePay]  VALUES (7656, '2011-11-11', '2014-12-18 11:59PM', 11.5000)
INSERT [EmployeePay]  VALUES (7656, '2014-12-19', NULL, 12.1500)
INSERT [EmployeePay]  VALUES (8110, '2012-10-01', '2014-01-31 11:59PM', 10.0000)
INSERT [EmployeePay]  VALUES (8110, '2014-02-01', NULL, 11.0000)
INSERT [EmployeePay]  VALUES (8750, '2013-01-02', NULL, 14.0000)

INSERT INTO MaterialPurchased VALUES
(10475,'2014-10-21',125,'$0.93',1150),
(23769,'2014-08-18',13,'$0.99',1150),
(24325,'2014-08-04',1,'$10.60',1010),
(35182,'2014-04-01',1300,'$8.95',1080),
(35874,'2013-07-10',45,'$1.00',2000),
(36751,'2014-04-01',40,'$0.99',1150),
(40800,'2014-10-06',150,'$10.25',1110),
(41911,'2014-08-04',8,'$10.75',1110),
(44342,'2013-03-17',313,'$1.00',2000),
(48035,'2014-11-06',125,'$0.93',1150),
(50075,'2014-04-01',7,'$24.00',1170),
(57713,'2014-12-11',160,'$12.14',1080),
(58707,'2013-07-09',2,'$10.50',1010),
(58836,'2013-07-15',2,'$23.50',1170),
(60169,'2014-08-02',1,'$210.00',1060),
(62263,'2014-12-05',180,'$8.15',1090),
(63241,'2013-07-09',20,'$10.50',1140),
(63572,'2014-08-20',15,'$19.95',1170),
(65120,'2014-08-04',120,'$115.00',1080),
(67046,'2014-04-01',163,'$0.95',1150),
(68203,'2014-08-04',1,'$12.95',1020),
(71055,'2014-04-01',7,'$13.00',1010),
(75697,'2013-07-09',2,'$12.80',1020),
(81478,'2014-10-06',12,'$10.75',1020),
(82408,'2014-10-06',12,'$11.09',1010),
(83268,'2013-07-09',2,'$199.95',1060),
(90090,'2014-04-01',45,'$9.55',1080),
(91343,'2014-10-07',2100,'$1.75',1070),
(92573,'2013-07-15',320,'$2.09',1070),
(94515,'2014-01-01',500,'$1.00',2000),
(94696,'2014-12-29',48,'$10.78',1090),
(95998,'2014-12-12',8,'$12.25',1110),
(96900,'2014-12-22',40,'$1.15',1150),
(97277,'2014-12-11',180,'$9.88',1080);


INSERT INTO MaterialAssigned VALUES 
('2013-07-15', 0.50, 130, 55841, 75697),
('2013-07-15', 7.00, 130, 55841, 63241),
('2013-07-15', 15.00, 130, 55841, 35874),
('2013-08-13', 0.50, 130, 55873, 75697),
('2013-08-13', 7.00, 130, 55873, 63241),
('2013-08-13', 15.00, 130, 55873, 35874),
('2013-09-12', 0.50, 130, 55878, 75697),
('2013-09-12', 6.00, 130, 55878, 63241),
('2013-09-12', 12.00, 130, 55878, 35874),
('2013-07-16', 0.50, 150, 55841, 83268),
('2013-08-16', 0.50, 150, 55873, 83268),
('2013-09-16', 0.50, 150, 55878, 83268),
('2014-03-31', 313.87, 150, 91584, 44342),
('2014-04-01', 1300.00, 160, 91584, 35182),
('2014-04-03', 45.00, 230, 91584, 90090),
('2013-07-18', 0.50, 160, 55841, 58707),
('2013-07-18', 110.00, 160, 55841, 92573),
('2013-08-19', 0.50, 160, 55873, 58707),
('2013-08-19', 2.00, 160, 55873, 92573),
('2013-09-19', 0.50, 160, 55878, 58707),
('2013-09-19', 3.00, 160, 55878, 92573),
('2013-07-22', 12.00, 170, 55841, 36751),
('2013-08-26', 12.00, 170, 55873, 36751),
('2013-07-22', 12.00, 170, 55878, 36751),
('2013-07-29', 0.50, 180, 55841, 58836),
('2013-09-02', 0.50, 180, 55873, 58836),
('2014-09-30', 0.50, 180, 55878, 58836),
('2014-04-01', 7.00, 160, 91584, 71055),
('2014-04-14', 163.00, 170, 91584, 67046),
('2014-04-18', 7.00, 180, 91584, 50075),
('2014-08-04', 8.00, 130, 32687, 41911),
('2014-08-04', 1.00, 130, 32687, 68203),
('2014-08-08', 0.50, 150, 32687, 60169),
('2014-08-11', 1.00, 160, 32687, 24325),
('2014-08-11', 120.00, 160, 32687, 65120),
('2014-08-18', 13.00, 170, 32687, 23769),
('2014-08-22', 0.50, 180, 32687, 63572),
('2014-10-14', 5.00, 150, 62254, 81478),
('2014-10-14', 70.00, 150, 62254, 40800),
('2014-10-30', 5.00, 150, 62257, 81478),
('2014-10-30', 70.00, 150, 62257, 40800),
('2014-10-16', 50.00, 160, 62254, 91343),
('2014-10-16', 5.00, 160, 62254, 82408),
('2014-10-21', 125.00, 170, 62254, 10475),
('2014-10-29', 5.00, 180, 62254, 63572),
('2014-11-03', 50.00, 160, 62257, 91343),
('2014-11-03', 5.00, 160, 62257, 82408),
('2014-11-08', 125.00, 170, 62257, 48035),
('2014-11-13', 5.00, 180, 62257, 63572),
('2014-12-09', 3.00, 140, 16885, 35874),
('2014-12-09', 15.00, 140, 16885, 94515),
('2014-12-14', 0.00, 130, 16885, 40800),
('2014-12-15', 8.00, 130, 16885, 95998),
('2013-12-15', 157.00, 130, 16885, 94515),
('2014-12-14', 0.50, 130, 16885, 75697),
('2014-12-16', 0.50, 150, 16885, 60169),
('2014-12-16', 0.50, 150, 16885, 83268),
('2014-12-16', 38.00, 150, 16885, 94515),
('2014-12-17', 0.50, 160, 16885, 58707),
('2014-12-17', 1.00, 160, 16885, 82408),
('2014-12-28', 40.00, 170, 16885, 96900),
('2015-01-19', 1.00, 180, 16885, 63572),
('2014-12-17', 180.00, 160, 16885, 97277),
('2014-12-22', 160.00, 240, 16885, 57713),
('2014-12-22', 1.00, 240, 16885, 82408),
('2014-12-22', 17.50, 240, 16885, 94515),
('2014-11-27', 46.25, 140, 78431, 94515),
('2015-01-08', 122.00, 260, 78431, 94515),
('2014-04-02', 36.80, 160, 91584, 94515),
('2014-12-11', 22.83, 110, 16885, 94515),
('2014-12-22', 180.00, 260, 78431, 62263),
('2014-04-03', 4.00, 230, 91584, 36751);

INSERT INTO TimeSheet VALUES 
(2300, 'Jul 15 2013  8:00AM', 3.50, 130, 55841, NULL),
(2300, 'Jul 15 2013  1:30PM', 4.00, 130, 55841, NULL),
(2300, 'Jul 16 2013  8:30AM', 4.00, 150, 55841, NULL),
(2300, 'Jul 22 2013  8:00AM', 4.00, 170, 55841, NULL),
(2300, 'Sep 12 2013  8:00AM', 4.00, 130, 55878, NULL),
(2300, 'Sep 13 2013  1:00PM', 4.50, 150, 55878, NULL),
(2300, 'Sep 25 2013  7:30AM', 4.00, 170, 55878, NULL),
(2300, 'Sep 29 2013 12:00PM', 5.00, 180, 55878, NULL),
(2300, 'Apr 14 2014  8:30AM', 3.75, 170, 91584, NULL),
(2300, 'Apr 14 2014  2:00PM', 2.00, 170, 91584, NULL),
(2300, 'Apr 15 2014  9:00AM', 3.00, 170, 91584, NULL),
(2300, 'Apr 15 2014  1:00PM', 2.50, 170, 91584, NULL),
(2300, 'Apr 22 2014 12:45PM', 3.75, 180, 91584, NULL),
(2300, 'Aug  8 2014  1:00PM', 4.50, 150, 32687, NULL),
(2300, 'Aug 15 2014  8:00AM', 4.00, 170, 32687, NULL),
(2300, 'Aug 15 2014  1:00PM', 2.50, 170, 32687, NULL),
(2300, 'Oct 24 2014  8:00AM', 4.00, 170, 62254, NULL),
(2300, 'Oct 24 2014  1:00PM', 4.00, 170, 62254, NULL),
(2300, 'Oct 27 2014  8:00AM', 3.00, 170, 62254, NULL),
(2300, 'Oct 27 2014  1:00PM', 2.50, 170, 62254, NULL),
(2300, 'Dec 15 2014  8:00AM', 4.00, 130, 16885, NULL),
(2300, 'Dec 15 2014  1:00PM', 4.00, 130, 16885, NULL),
(2300, 'Dec 16 2014  8:15AM', 3.75, 130, 16885, NULL),
(2300, 'Dec 16 2014 12:30PM', 4.50, 150, 16885, NULL),
(2480, 'Jul 22 2013  8:00AM', 4.00, 170, 55841, NULL),
(2480, 'Jul 22 2013  1:00PM', 2.50, 170, 55841, NULL),
(2480, 'Aug 16 2013  9:00AM', 3.00, 150, 55873, NULL),
(2480, 'Aug 16 2013 12:00PM', 1.00, NULL, NULL, 'Lunch'),
(2480, 'Aug 16 2013  1:00PM', 1.25, 150, 55873, NULL),
(2480, 'Aug 26 2013  7:30AM', 4.00, 170, 55873, NULL),
(2480, 'Aug 26 2013  2:00PM', 3.00, 170, 55873, NULL),
(2480, 'Sep  2 2013  8:15AM', 5.00, 180, 55873, NULL),
(2480, 'Sep 12 2013  8:00AM', 4.00, 130, 55878, NULL),
(2480, 'Sep 25 2013  8:00AM', 3.50, 170, 55878, NULL),
(2480, 'Sep 25 2013  1:00PM', 1.00, NULL, NULL, 'Med Appointment'),
(2480, 'Sep 25 2013  2:00PM', 2.25, 170, 55878, NULL),
(2480, 'Mar 31 2014  8:30AM', 3.50, 150, 91584, NULL),
(2480, 'Mar 31 2014  1:00PM', 4.00, 150, 91584, NULL),
(2480, 'Apr  1 2014  8:00AM', 4.00, 150, 91584, NULL),
(2480, 'Apr  1 2014  1:00PM', 4.00, 150, 91584, NULL),
(2480, 'Apr  2 2014  8:30AM', 3.00, 150, 91584, NULL),
(2480, 'Aug 21 2014  8:30AM', 4.50, 180, 32687, NULL),
(2480, 'Oct 14 2014  9:00AM', 3.50, 150, 62254, NULL),
(2480, 'Oct 14 2014 12:30PM', 0.30, NULL, NULL, 'lunch'),
(2480, 'Oct 14 2014  1:00PM', 4.00, 150, 62254, NULL),
(2480, 'Oct 15 2014  8:00AM', 4.00, 150, 62254, NULL),
(2480, 'Oct 15 2014  1:00PM', 4.00, 150, 62254, NULL),
(2480, 'Oct 16 2014  8:00AM', 4.00, 150, 62254, NULL),
(2480, 'Oct 17 2014 12:00PM', 1.00, NULL, NULL, 'Lunch'),
(2480, 'Nov 10 2014  1:00PM', 4.00, 170, 62257, NULL),
(2480, 'Nov 11 2014  8:00AM', 4.00, 170, 62257, NULL),
(2480, 'Nov 12 2014  8:00AM', 2.50, 170, 62257, NULL),
(2480, 'Nov 12 2014  1:00PM', 1.00, 170, 62257, NULL),
(3155, 'Aug 26 2013  8:00AM', 3.50, 170, 55873, NULL),
(3155, 'Mar 31 2014  8:30AM', 3.50, 150, 91584, NULL),
(3155, 'Mar 31 2014  1:00PM', 4.00, 150, 91584, NULL),
(3155, 'Apr  1 2014  8:00AM', 4.00, 150, 91584, NULL),
(3155, 'Apr  1 2014  1:00PM', 4.00, 150, 91584, NULL),
(3155, 'Oct 30 2014 12:30PM', 4.25, 180, 62254, NULL),
(3155, 'Oct 31 2014  8:00AM', 4.00, 180, 62254, NULL),
(3155, 'Oct 31 2014  1:00PM', 4.00, 180, 62254, NULL),
(3155, 'Nov  3 2014  1:00PM', 4.00, 180, 62254, NULL),
(3155, 'Nov 13 2014  1:00PM', 4.00, 180, 62257, NULL),
(3155, 'Nov 14 2014  8:00AM', 4.00, 180, 62257, NULL),
(3155, 'Nov 14 2014  1:00PM', 3.75, 180, 62257, NULL),
(3155, 'Nov 18 2014  8:30AM', 3.50, 180, 62257, NULL),
(3155, 'Dec  9 2014  1:00PM', 3.75, 270, 16885, NULL),
(4702, 'Aug 15 2013 12:30PM', 5.75, 130, 55873, NULL),
(4702, 'Oct 29 2014  1:00PM', 1.75, 180, 62254, NULL),
(4702, 'Oct 30 2014 11:45AM', 3.00, 180, 62254, NULL),
(4702, 'Nov  4 2014 10:00AM', 4.00, 180, 62254, NULL),
(4702, 'Nov 13 2014  1:50PM', 3.50, 180, 62257, NULL),
(4702, 'Nov 17 2014 10:00AM', 4.00, 180, 62257, NULL),
(5291, 'Jul 18 2013 10:00AM', 2.00, 160, 55841, NULL),
(5291, 'Jul 18 2013  1:00PM', 4.00, 160, 55841, NULL),
(5291, 'Jul 19 2013  7:30AM', 4.50, 160, 55841, NULL),
(5291, 'Aug 19 2013  8:10AM', 4.30, 160, 55873, NULL),
(5291, 'Aug 19 2013  1:30PM', 3.50, 160, 55873, NULL),
(5291, 'Aug 20 2013  8:00AM', 3.50, 160, 55873, NULL),
(5291, 'Apr  7 2014  8:00AM', 4.00, 160, 91584, NULL),
(5291, 'Apr  7 2014  1:00PM', 4.00, 160, 91584, NULL),
(5291, 'Apr  8 2014  8:30AM', 3.75, 160, 91584, NULL),
(5291, 'Apr  8 2014  1:00PM', 5.00, 160, 91584, NULL),
(5291, 'Apr  9 2014  8:00AM', 4.00, 160, 91584, NULL),
(5291, 'Apr  9 2014  1:00PM', 4.00, 160, 91584, NULL),
(5291, 'Apr 10 2014  8:00AM', 4.00, 160, 91584, NULL),
(5291, 'Apr 10 2014  1:00PM', 4.00, 160, 91584, NULL),
(5291, 'Apr 11 2014  8:00AM', 4.00, 160, 91584, NULL),
(5291, 'Apr 11 2014  1:00PM', 3.00, 160, 91584, NULL),
(5291, 'Oct 16 2014  8:00AM', 4.25, 160, 62254, NULL),
(5291, 'Oct 16 2014  1:00PM', 4.00, 160, 62254, NULL),
(5291, 'Oct 17 2014  8:00AM', 4.00, 160, 62254, NULL),
(5291, 'Oct 17 2014 12:00PM', 1.00, NULL, NULL, 'errands'),
(5291, 'Oct 17 2014  1:00PM', 4.00, 160, 62254, NULL),
(5291, 'Oct 20 2014  8:00AM', 4.00, 160, 62254, NULL),
(5291, 'Oct 20 2014  1:00PM', 4.00, 160, 62254, NULL),
(5291, 'Oct 21 2014  2:30PM', 1.50, 160, 62254, NULL),
(5291, 'Oct 22 2014  8:00AM', 4.00, 160, 62254, NULL),
(5291, 'Nov  3 2014  8:00AM', 4.50, 160, 62257, NULL),
(5291, 'Nov  3 2014  1:00PM', 4.00, 160, 62257, NULL),
(5291, 'Nov  4 2014  8:00AM', 4.00, 160, 62257, NULL),
(5291, 'Nov  4 2014  1:00PM', 4.00, 160, 62257, NULL),
(5291, 'Nov  5 2014  8:00AM', 4.00, 160, 62257, NULL),
(5291, 'Nov  5 2014  1:00PM', 4.00, 160, 62257, NULL),
(5291, 'Nov  6 2014  8:00AM', 4.00, 160, 62257, NULL),
(5291, 'Nov  6 2014  1:00PM', 3.50, 160, 62257, NULL),
(5862, 'Sep 20 2013  1:30PM', 3.75, 160, 55878, NULL),
(5862, 'Sep 21 2013  8:30AM', 7.00, 160, 55878, NULL),
(5862, 'Apr  3 2014  8:00AM', 4.00, 230, 91584, NULL),
(5862, 'Apr  3 2014  1:00PM', 4.00, 230, 91584, NULL),
(5862, 'Apr  4 2014  8:00AM', 4.00, 230, 91584, NULL),
(5862, 'Apr  4 2014  1:00PM', 4.50, 230, 91584, NULL),
(5862, 'Apr  7 2014  8:00AM', 4.00, 160, 91584, NULL),
(5862, 'Apr  7 2014  1:00PM', 4.00, 160, 91584, NULL),
(5862, 'Apr  8 2014  8:00AM', 4.00, 160, 91584, NULL),
(5862, 'Apr  8 2014  1:00PM', 4.00, NULL, NULL, 'Fam Emergency'),
(5862, 'Apr  9 2014  8:00AM', 4.00, 160, 91584, NULL),
(5862, 'Apr  9 2014  1:00PM', 4.00, 160, 91584, NULL),
(5862, 'Apr 10 2014  8:00AM', 4.00, 160, 91584, NULL),
(5862, 'Apr 10 2014  1:00PM', 4.00, 160, 91584, NULL),
(5862, 'Apr 11 2014  8:00AM', 4.00, 160, 91584, NULL),
(5862, 'Apr 11 2014  1:00PM', 2.50, 160, 91584, NULL),
(5862, 'Aug 11 2014  8:00AM', 4.00, 160, 32687, NULL),
(5862, 'Aug 11 2014  9:00AM', 2.00, 160, 32687, NULL),
(5862, 'Aug 11 2014  1:00PM', 4.00, 160, 32687, NULL),
(5862, 'Oct 16 2014  8:00AM', 3.00, 160, 62254, NULL),
(5862, 'Oct 16 2014  1:00PM', 4.00, 160, 62254, NULL),
(5862, 'Oct 17 2014  8:00AM', 4.00, 160, 62254, NULL),
(5862, 'Oct 17 2014  1:00PM', 4.50, 160, 62254, NULL),
(5862, 'Oct 20 2014  8:00AM', 4.00, 160, 62254, NULL),
(5862, 'Oct 20 2014  1:00PM', 4.00, 160, 62254, NULL),
(5862, 'Oct 21 2014  8:00AM', 4.00, 160, 62254, NULL),
(5862, 'Oct 21 2014  2:30PM', 4.00, 160, 62254, NULL),
(5862, 'Nov  3 2014  8:00AM', 4.50, 160, 62257, NULL),
(5862, 'Nov  3 2014  1:00PM', 4.00, 160, 62257, NULL),
(5862, 'Nov  4 2014  8:00AM', 4.00, 160, 62257, NULL),
(5862, 'Nov  4 2014  1:00PM', 4.00, 160, 62257, NULL),
(5862, 'Nov  5 2014  8:00AM', 4.00, 160, 62257, NULL),
(5862, 'Nov  5 2014  1:00PM', 4.00, 160, 62257, NULL),
(5862, 'Nov  6 2014  8:00AM', 4.00, 160, 62257, NULL),
(5862, 'Nov  6 2014  1:00PM', 4.00, 160, 62257, NULL),
(6460, 'Nov 19 2014 10:00AM', 2.50, 140, 78431, NULL),
(6460, 'Nov 19 2014  2:00PM', 3.00, 140, 78431, NULL),
(6460, 'Nov 20 2014  9:00AM', 3.50, 140, 78431, NULL),
(6460, 'Nov 20 2014  1:30PM', 4.15, 140, 78431, NULL),
(6460, 'Nov 24 2014 12:00PM', 1.50, 140, 78431, NULL),
(6460, 'Nov 26 2014  8:00AM', 4.00, 140, 78431, NULL),
(6460, 'Nov 26 2014  1:15PM', 3.00, 140, 78431, NULL),
(6460, 'Nov 27 2014  2:00PM', 2.00, 140, 78431, NULL),
(6460, 'Dec  1 2014 10:00AM', 1.50, 140, 16885, NULL),
(6460, 'Dec  3 2014 10:30AM', 6.00, 140, 16885, NULL),
(6460, 'Dec  5 2014  4:30PM', 1.00, 140, 16885, NULL),
(6460, 'Dec  8 2014 12:00PM', 0.50, 140, 16885, NULL),
(6460, 'Dec 18 2014 12:30PM', 4.00, 260, 78431, NULL),
(6460, 'Dec 22 2014  8:00AM', 4.00, 260, 78431, NULL),
(6460, 'Dec 22 2014  1:30PM', 4.00, 260, 78431, NULL),
(6460, 'Dec 23 2014 11:00AM', 6.00, 260, 78431, NULL),
(6460, 'Dec 29 2014  1:00PM', 4.50, 260, 78431, NULL),
(6460, 'Dec 30 2014  8:00AM', 3.50, 260, 78431, NULL),
(6460, 'Jan  2 2015  9:30AM', 2.50, 260, 78431, NULL),
(6460, 'Jan  2 2015  1:45PM', 3.00, 260, 78431, NULL),
(6460, 'Jan  8 2015  8:00AM', 4.00, 260, 78431, NULL),
(7656, 'Jul 29 2013  1:15PM', 4.00, 180, 55841, NULL),
(7656, 'Apr 15 2014  8:00AM', 4.00, 170, 91584, NULL),
(7656, 'Apr 15 2014  1:00PM', 3.50, 170, 91584, NULL),
(7656, 'Apr 22 2014 12:45PM', 3.75, 180, 91584, NULL),
(7656, 'Aug  4 2014  8:00AM', 4.00, 130, 32687, NULL),
(7656, 'Aug  4 2014  1:00PM', 4.00, 130, 32687, NULL),
(7656, 'Oct 22 2014  2:00PM', 3.00, 170, 62254, NULL),
(7656, 'Oct 23 2014  8:00AM', 4.00, 170, 62254, NULL),
(7656, 'Oct 23 2014  1:00PM', 4.00, 170, 62254, NULL),
(7656, 'Oct 24 2014  8:00AM', 4.00, 170, 62254, NULL),
(7656, 'Oct 24 2014 12:30PM', 1.30, NULL, NULL, 'doctor'),
(7656, 'Oct 24 2014  1:50PM', 4.00, 170, 62254, NULL),
(7656, 'Oct 30 2014  8:00AM', 4.00, 150, 62257, NULL),
(7656, 'Oct 30 2014  1:00PM', 4.00, 150, 62257, NULL),
(7656, 'Oct 31 2014  8:00AM', 4.00, 150, 62257, NULL),
(7656, 'Oct 31 2014  1:00PM', 4.00, 150, 62257, NULL),
(7656, 'Nov  3 2014  8:00AM', 4.25, 150, 62257, NULL),
(7656, 'Nov 11 2014  8:00AM', 4.00, 170, 62257, NULL),
(7656, 'Nov 11 2014  1:00PM', 3.00, 170, 62257, NULL),
(7656, 'Dec 15 2014  8:00AM', 4.00, 130, 16885, NULL),
(7656, 'Dec 15 2014  1:00PM', 4.00, 130, 16885, NULL),
(7656, 'Dec 16 2014  8:15AM', 3.75, 130, 16885, NULL),
(7656, 'Dec 17 2014  8:00AM', 4.00, 160, 16885, NULL),
(7656, 'Dec 17 2014  1:00PM', 4.00, 160, 16885, NULL),
(7656, 'Dec 18 2014  8:00AM', 4.00, 160, 16885, NULL),
(7656, 'Dec 18 2014  1:00PM', 4.00, 160, 16885, NULL),
(7656, 'Dec 19 2014  8:00AM', 3.25, 160, 16885, NULL),
(8110, 'Aug  1 2014  8:00AM', 4.00, 110, 32687, NULL),
(8110, 'Aug  1 2014  1:00PM', 3.50, 110, 32687, NULL),
(8110, 'Nov  3 2014  8:00AM', 4.00, 180, 62254, NULL),
(8110, 'Nov  3 2014  1:00PM', 3.00, 180, 62254, NULL),
(8110, 'Nov 17 2014  1:15PM', 4.00, 180, 62257, NULL),
(8110, 'Nov 18 2014  8:00AM', 4.00, 180, 62257, NULL),
(8110, 'Dec  9 2014  1:00PM', 3.75, 270, 16885, NULL),
(8110, 'Dec 11 2014  8:30AM', 4.00, 110, 16885, NULL),
(8110, 'Dec 11 2014  1:00PM', 3.00, 110, 16885, NULL),
(8750, 'Oct 23 2014  7:00AM', 4.00, 170, 62254, NULL),
(8750, 'Oct 23 2014  1:00PM', 4.00, 170, 62254, NULL),
(8750, 'Nov  9 2014  8:45AM', 3.00, 170, 62257, NULL),
(8750, 'Nov  9 2014  1:00PM', 4.00, 170, 62257, NULL),
(8750, 'Nov 10 2014  8:00AM', 4.00, 170, 62257, NULL),
(8750, 'Nov 11 2014  1:00PM', 4.00, 170, 62257, NULL),
(8750, 'Nov 12 2014  8:00AM', 4.00, 170, 62257, NULL),
(8750, 'Nov 12 2014  1:00PM', 1.50, 170, 62257, NULL);
/**
 * Pre-homework table modification
 *
 * Before starting this homework assignment, I want you to change the data
 * type of two fields in one table � the EmployeePay table. In the
 * EmployeePay table, I want the DateStartPay and DateEnd fields to
 * be datetime data types rather than date data types. The easiest way
 * to complete this change is to just drop the table, create it, and
 * repopulate it. Some of the DateEnd fields need to have a time in them,
 * so it seemed most expedient if I just created a SQL script file that
 * would accomplish those goals for you. The file is called
 * BuildEmployeePayHW5.sql and is located on the K: drive in the
 * IS475\CutGlassS15 folder.
 */
-- Just used the given file.

/**
 * Exercise 01
 *
 * Modify the Job table:
 */
-- Part a
-- Add a column to the table for DateDue. It should be a date data type.
ALTER TABLE
	[Job]
ADD
	[DateDue] [date] --NOT NULL?
;

-- Part b
-- UPDATE the new column with the DateDue data given below. I list the
-- JobID and the new DateDue for each job. If using the UPDATE command,
-- you will have to write 10 UPDATE statements.
UPDATE
	[Job]
SET
	[DateDue] = '2015-01-15'
WHERE
	[JobID] = 16885
;
UPDATE
	[Job]
SET
	[DateDue] = '2014-08-01'
WHERE
	[JobID] = 32687
;
UPDATE
	[Job]
SET
	[DateDue] = '2013-08-01'
WHERE
	[JobID] = 55841
;
UPDATE
	[Job]
SET
	[DateDue] = '2013-10-01'
WHERE
	[JobID] = 55873
;
UPDATE
	[Job]
SET
	[DateDue] = '2013-09-15'
WHERE
	[JobID] = 55878
;
UPDATE
	[Job]
SET
	[DateDue] = '2014-11-20'
WHERE
	[JobID] = 62254
;
UPDATE
	[Job]
SET
	[DateDue] = '2014-11-18'
WHERE
	[JobID] = 62257
;
UPDATE
	[Job]
SET
	[DateDue] = '2015-02-06'
WHERE
	[JobID] = 78431
;
UPDATE
	[Job]
SET
	[DateDue] = '2014-04-01'
WHERE
	[JobID] = 91584
;