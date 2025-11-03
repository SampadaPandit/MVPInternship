--DimDate

CREATE TABLE DW_Project.dbo.DimDate (
DateKey int NOT NULL,
FullDate date NULL,
[Year] int NULL,
[Month] int NULL,
MonthName nvarchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
Quarter int NULL,
CONSTRAINT PK__DimDate__40DF45E37CBCFD95 PRIMARY KEY (DateKey)
);

--DimSchool

CREATE TABLE DW_Project.dbo.DimSchool (
SchoolSK int IDENTITY(1,1) NOT NULL,
SchoolCode nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
SchoolName nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
SuburbName nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
Postcode nvarchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
LevelOfSchooling nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
SelectiveSchool nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
ICSEA_Value int NULL,
StudentCount int NULL,
LBOTE_Pct decimal(5,2) NULL,
Indigenous_Pct decimal(5,2) NULL,
Latitude decimal(10,6) NULL,
Longitude decimal(10,6) NULL,
LoadDate datetime DEFAULT getdate() NULL,
IsActive bit DEFAULT 1 NULL,
CONSTRAINT PK__DimSchoo__3DA4368A4913D5AC PRIMARY KEY (SchoolSK)
);


--DimSuburb

CREATE TABLE DW_Project.dbo.DimSuburb (
SuburbSK int IDENTITY(1,1) NOT NULL,
SuburbName nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
City nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
State nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
StateCode nvarchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
Postcode nvarchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
District nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
Latitude decimal(10,6) NULL,
Longitude decimal(10,6) NULL,
LoadDate datetime DEFAULT getdate() NULL,
IsActive bit DEFAULT 1 NULL,
CONSTRAINT PK__DimSubur__BB2E4709CCB54459 PRIMARY KEY (SuburbSK)
);

--Dim_Category

CREATE TABLE DW_Project.dbo.Dim_Category (
Category_Key int IDENTITY(1,1) NOT NULL,
Category_Name varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
Min_Value decimal(18,2) NULL,
Max_Value decimal(18,2) NULL,
CONSTRAINT PK__Dim_Cate__3FF97C16AD340AAA PRIMARY KEY (Category_Key)
);


--FactPropertyMedian
CREATE TABLE DW_Project.dbo.FactPropertyMedian (
FactID int IDENTITY(1,1) NOT NULL,
DateKey int NULL,
SuburbSK int NULL,
PropertyMedianValue decimal(18,2) NULL,
State nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
City nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
District nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
LoadDate datetime DEFAULT getdate() NULL,
PropertyCategory nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
CONSTRAINT PK__FactProp__74D3209D8553CB05 PRIMARY KEY (FactID)
);


-- DW_Project.dbo.FactPropertyMedian foreign keys

ALTER TABLE DW_Project.dbo.FactPropertyMedian ADD CONSTRAINT FK__FactPrope__DateK__3587F3E0 FOREIGN KEY (DateKey) REFERENCES DW_Project.dbo.DimDate(DateKey);
ALTER TABLE DW_Project.dbo.FactPropertyMedian ADD CONSTRAINT FK__FactPrope__Subur__367C1819 FOREIGN KEY (SuburbSK) REFERENCES DW_Project.dbo.DimSuburb(SuburbSK);


--Factless_SchoolSuburb
CREATE TABLE DW_Project.dbo.Factless_SchoolSuburb (
SchoolSK int NOT NULL,
SuburbSK int NOT NULL,
LoadDate datetime DEFAULT getdate() NULL,
CONSTRAINT PK__Factless__B616D2FA2CCD4DEE PRIMARY KEY (SchoolSK,SuburbSK)
);


-- DW_Project.dbo.Factless_SchoolSuburb foreign keys

ALTER TABLE DW_Project.dbo.Factless_SchoolSuburb ADD CONSTRAINT FK__Factless___Schoo__3A4CA8FD FOREIGN KEY (SchoolSK) REFERENCES DW_Project.dbo.DimSchool(SchoolSK);
ALTER TABLE DW_Project.dbo.Factless_SchoolSuburb ADD CONSTRAINT FK__Factless___Subur__3B40CD36 FOREIGN KEY (SuburbSK) REFERENCES DW_Project.dbo.DimSuburb(SuburbSK);


--Load_AUS_Post_Suburb
CREATE TABLE DW_Project.dbo.load_AUS_Post_suburb (
postcode int NULL,
suburb nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
city nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
state nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
state_code nvarchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
lat float NULL,
lon float NULL,
district nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
);

--Load_NSW_PropertyMedianValue

CREATE TABLE DW_Project.dbo.load_NSW_PropertyMedianValue (
state nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
city_town nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
suburb nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
postcode int NULL,
district nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
location nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
property_median_value nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
updated_year int NULL,
updated_month int NULL
);


--Load_nsw_public_schools

CREATE TABLE DW_Project.dbo.load_nsw_public_schools (
school_code nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
AgeID nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
school_name nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
street nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
town_suburb nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
postcode nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
student_number int NULL,
indigenous_pct decimal(5,2) NULL,
lbote_pct decimal(5,2) NULL,
ICSEA_Value int NULL,
level_of_schooling nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
selective_school nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
opportunity_class nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
school_specialty_type nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
school_subtype nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
support_classes nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
preschool_ind nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
distance_education nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
intensive_english_centre nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
school_gender nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
phone nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
school_email nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
fax nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
late_opening_school nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
date_1st_teacher date NULL,
lga nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
electorate nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
fed_electorate nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
operational_directorate nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
principal_network nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
facs_district nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
local_health_district nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
aecg_region nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
ASGS_remoteness nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
latitude decimal(10,6) NULL,
longitude decimal(10,6) NULL,
date_extracted date NULL
);




