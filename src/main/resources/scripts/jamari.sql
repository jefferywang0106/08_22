-- ALTER TABLE ORDERS DROP CONSTRAINT FK_ORDERS_MEMBER_ID 
-- ALTER TABLE M_ORDER DROP CONSTRAINT M_ORDER_ORDER_ID;
-- ALTER TABLE CUSTOMER DROP CONSTRAINT FK_CUSTOMER_M_ACCOUNT;
-- ALTER TABLE PRODUCT DROP CONSTRAINT FK_PRODUCT_RESTAURANT_ID;
-- ALTER TABLE M_ORDER DROP CONSTRAINT M_ORDER_MEMBER_ACCOUNT_FK;
-- ALTER TABLE DEPOSIT DROP CONSTRAINT FK_DEPOSIT_MEMBER_ACCOUNT;
-- ALTER TABLE CUSTOMER DROP CONSTRAINT FK_CUTOMER_ITEM_ID;
-- ALTER TABLE ITEM DROP CONSTRAINT FK_ITEM_PRODUCT_ID;
-- ALTER TABLE CUSTOMER DROP CONSTRAINT FK_CUSTOMER_O_ID;
-- ALTER TABLE ITEM DROP CONSTRAINT FK_ITEM_ORDER_ID;

DROP TABLE RESTAURANT IF EXISTS;
DROP TABLE PRODUCT IF EXISTS;
DROP TABLE ORDERS IF EXISTS;
DROP TABLE M_ORDER IF EXISTS;
DROP TABLE MEMBER IF EXISTS;
DROP TABLE ITEM IF EXISTS;
DROP TABLE DEPOSIT IF EXISTS;
DROP TABLE CUSTOMER IF EXISTS;

CREATE TABLE RESTAURANT (
  ID     int GENERATED BY DEFAULT AS IDENTITY, 
  NAME   varchar(32), 
  BRIEF  varchar(255), 
  ADDR   varchar(255), 
  PHONE  varchar(20), 
  R_TYPE varchar(10), 
  IMAGE  varchar(255), 
  CONSTRAINT PK_RESTAURANT_ID 
    PRIMARY KEY (ID), 
  CONSTRAINT RESTAURANT_UK1 
    UNIQUE (PHONE));
    
    
CREATE TABLE PRODUCT (
  ID            int GENERATED BY DEFAULT AS IDENTITY, 
  NAME          varchar(60), 
  PRICE         int, 
  RESTAURANT_ID int, 
  CONSTRAINT PK_PRODUCT_ID 
    PRIMARY KEY (ID));
    
    
CREATE TABLE ORDERS (
  ID              int GENERATED BY DEFAULT AS IDENTITY, 
  RESTAURANT_ID   int, 
  BEGIN_TIME      timestamp, 
  END_TIME        timestamp, 
  END_MONEY       int, 
  MEMBER_ACCOUNT  varchar(16), 
  STATUS          varchar(10), 
  INFO            varchar(255), 
  RESTAURANT_NAME varchar(60), 
  CONSTRAINT PK_ORDERS_ID 
    PRIMARY KEY (ID)
    );
--      , 
--  CONSTRAINT ORDER_TOTAL_MIN 
--    CHECK (order_total >= 0), 
--  CONSTRAINT ORDER_MODE_LOV 
--    CHECK (order_mode in ('direct','online')), 
--    CONSTRAINT ORDER_CUSTOMER_ID_NN 
--      CHECK ("CUSTOMER_ID" IS NOT NULL), 
--    CONSTRAINT ORDER_DATE_NN 
--      CHECK ("ORDER_DATE" IS NOT NULL));
    
CREATE TABLE M_ORDER (
  MEMBER_ACCOUNT varchar(16) NOT NULL, 
  ORDER_ID       int NOT NULL, 
  JOIN_DATE      timestamp NOT NULL, 
  CONSTRAINT M_ORDER_PK 
    PRIMARY KEY (MEMBER_ACCOUNT, 
  ORDER_ID, 
  JOIN_DATE));
  
CREATE TABLE MEMBER (
  ID          int GENERATED BY DEFAULT AS IDENTITY, 
  ACCOUNT     varchar(16) NOT NULL, 
  PASSWORD    varchar(16), 
  EMAIL       varchar(255), 
  CASH        int DEFAULT 0, 
  CREATE_DATE timestamp, 
  M_TYPE      varchar(32), 
  CONSTRAINT PK_MEMBER_ID 
    PRIMARY KEY (ID), 
  CONSTRAINT UK_MEMBER_ACCOUNT 
    UNIQUE (ACCOUNT));
    
CREATE TABLE ITEM (
  ID           int GENERATED BY DEFAULT AS IDENTITY, 
  PRODUCT_ID   int, 
  ORDER_ID     int, 
  PRODUCT_NAME varchar(60), 
  CONSTRAINT PK_ITEM_ID 
    PRIMARY KEY (ID));
    
CREATE TABLE DEPOSIT (
  ID             int GENERATED BY DEFAULT AS IDENTITY, 
  DEPOSIT_CASH   int, 
  DEPOSIT_TIME   timestamp, 
  MEMBER_ACCOUNT varchar(16) NOT NULL, 
  CONSTRAINT PK_DEPOSIT_ID 
    PRIMARY KEY (ID));
    
CREATE TABLE CUSTOMER (
  ID             int GENERATED BY DEFAULT AS IDENTITY, 
  ITEM_ID        int, 
  MEMBER_ACCOUNT varchar(16), 
  COUNTS         int, 
  MONEY          int, 
  C_DATE         timestamp, 
  STATUS         varchar(20), 
  ORDER_ID       int, 
  CONSTRAINT PK_CUSTOMER_ID 
    PRIMARY KEY (ID));
    
ALTER TABLE ORDERS ADD CONSTRAINT FK_ORDERS_MEMBER_ID FOREIGN KEY (MEMBER_ACCOUNT) REFERENCES MEMBER (ACCOUNT) ON UPDATE Cascade ON DELETE Restrict;
ALTER TABLE M_ORDER ADD CONSTRAINT M_ORDER_ORDER_ID FOREIGN KEY (ORDER_ID) REFERENCES ORDERS (ID) ON UPDATE Cascade ON DELETE Restrict;
ALTER TABLE CUSTOMER ADD CONSTRAINT FK_CUSTOMER_M_ACCOUNT FOREIGN KEY (MEMBER_ACCOUNT) REFERENCES MEMBER (ACCOUNT) ON UPDATE Cascade ON DELETE Restrict;
ALTER TABLE PRODUCT ADD CONSTRAINT FK_PRODUCT_RESTAURANT_ID FOREIGN KEY (RESTAURANT_ID) REFERENCES RESTAURANT (ID) ON UPDATE Cascade ON DELETE Restrict;
ALTER TABLE M_ORDER ADD CONSTRAINT M_ORDER_MEMBER_ACCOUNT_FK FOREIGN KEY (MEMBER_ACCOUNT) REFERENCES MEMBER (ACCOUNT) ON UPDATE Cascade ON DELETE Restrict;
ALTER TABLE DEPOSIT ADD CONSTRAINT FK_DEPOSIT_MEMBER_ACCOUNT FOREIGN KEY (MEMBER_ACCOUNT) REFERENCES MEMBER (ACCOUNT) ON UPDATE Cascade ON DELETE Restrict;
ALTER TABLE CUSTOMER ADD CONSTRAINT FK_CUTOMER_ITEM_ID FOREIGN KEY (ITEM_ID) REFERENCES ITEM (ID) ON UPDATE Cascade ON DELETE Restrict;
ALTER TABLE ITEM ADD CONSTRAINT FK_ITEM_PRODUCT_ID FOREIGN KEY (PRODUCT_ID) REFERENCES PRODUCT (ID) ON UPDATE Cascade ON DELETE Restrict;
ALTER TABLE CUSTOMER ADD CONSTRAINT FK_CUSTOMER_O_ID FOREIGN KEY (ORDER_ID) REFERENCES ORDERS (ID) ON UPDATE Cascade ON DELETE Restrict;
ALTER TABLE ITEM ADD CONSTRAINT FK_ITEM_ORDER_ID FOREIGN KEY (ORDER_ID) REFERENCES ORDERS (ID) ON UPDATE Cascade ON DELETE Restrict;


--------------------------------------------------------------------

Insert into MEMBER (ID,ACCOUNT,PASSWORD,EMAIL,CASH,CREATE_DATE,M_TYPE) values (2,'admin','admin','admin@gmail.com',8315,to_timestamp('23-May -16 02.01.09.550000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'高級會員');
Insert into MEMBER (ID,ACCOUNT,PASSWORD,EMAIL,CASH,CREATE_DATE,M_TYPE) values (20,'fju','fju','nomad341725@gmail.com',0,to_timestamp('04-Jun -16 09.34.46.398000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'一般會員');
Insert into MEMBER (ID,ACCOUNT,PASSWORD,EMAIL,CASH,CREATE_DATE,M_TYPE) values (23,'aaa','aaa','nomad341725@gmail.com',0,to_timestamp('06-Jun -16 02.37.24.477000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'一般會員');
Insert into MEMBER (ID,ACCOUNT,PASSWORD,EMAIL,CASH,CREATE_DATE,M_TYPE) values (17,'gundam','gun','gundam',0,to_timestamp('04-Jun -16 08.48.39.558000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'一般會員');
Insert into MEMBER (ID,ACCOUNT,PASSWORD,EMAIL,CASH,CREATE_DATE,M_TYPE) values (12,'Dasein','being','Dasein',0,to_timestamp('27-May -16 02.26.32.414000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'一般會員');
Insert into MEMBER (ID,ACCOUNT,PASSWORD,EMAIL,CASH,CREATE_DATE,M_TYPE) values (15,'a183','123123','a183cute33@gmail.com',0,to_timestamp('27-May -16 05.08.28.859000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'一般會員');
Insert into MEMBER (ID,ACCOUNT,PASSWORD,EMAIL,CASH,CREATE_DATE,M_TYPE) values (16,'moon','moon','nomad341725@gmail.com',0,to_timestamp('04-Jun -16 08.45.15.983000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'一般會員');
Insert into MEMBER (ID,ACCOUNT,PASSWORD,EMAIL,CASH,CREATE_DATE,M_TYPE) values (26,'jeffery','123','1231@gmail.com',0,to_timestamp('07-Jun -16 08.19.58.578000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'一般會員');
Insert into MEMBER (ID,ACCOUNT,PASSWORD,EMAIL,CASH,CREATE_DATE,M_TYPE) values (6,'rain','RR54qy','nomad341725@gmail.com',0,to_timestamp('27-May -16 03.10.50.682000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'一般會員');
Insert into MEMBER (ID,ACCOUNT,PASSWORD,EMAIL,CASH,CREATE_DATE,M_TYPE) values (8,'rainy','rainy','rainy',0,to_timestamp('27-May -16 03.27.33.999000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'一般會員');
Insert into MEMBER (ID,ACCOUNT,PASSWORD,EMAIL,CASH,CREATE_DATE,M_TYPE) values (25,'cypher','cypher','nomad341725@gmail.com',0,to_timestamp('07-Jun -16 04.09.13.633000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'一般會員');
Insert into MEMBER (ID,ACCOUNT,PASSWORD,EMAIL,CASH,CREATE_DATE,M_TYPE) values (11,'sun','sun','sun',420,to_timestamp('27-May -16 03.30.12.094000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'一般會員');
Insert into MEMBER (ID,ACCOUNT,PASSWORD,EMAIL,CASH,CREATE_DATE,M_TYPE) values (22,'zeit','zeit','nomad341725@gmail.com',0,to_timestamp('05-Jun -16 01.13.20.779000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'一般會員');
Insert into MEMBER (ID,ACCOUNT,PASSWORD,EMAIL,CASH,CREATE_DATE,M_TYPE) values (27,'hddoddiod','123','djdddjj@gmail.com',0,to_timestamp('07-Jun -16 08.21.28.626000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'一般會員');
Insert into MEMBER (ID,ACCOUNT,PASSWORD,EMAIL,CASH,CREATE_DATE,M_TYPE) values (33,'jeffery840106','51RO5752','a183cute33@gmail.com',0,to_timestamp('07-Jun -16 08.47.07.947000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'一般會員');





Insert into ORDERS (ID,RESTAURANT_ID,BEGIN_TIME,END_TIME,END_MONEY,MEMBER_ACCOUNT,STATUS,INFO,RESTAURANT_NAME) values (121,7,to_timestamp('08-Jun -16 08.12.59.527000000 PM','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('08-Jun -16 09.12.00.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),100,'admin','已結單',null,'鬍鬚張');
Insert into ORDERS (ID,RESTAURANT_ID,BEGIN_TIME,END_TIME,END_MONEY,MEMBER_ACCOUNT,STATUS,INFO,RESTAURANT_NAME) values (122,10,to_timestamp('08-Jun -16 08.14.01.165000000 PM','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('08-Jun -16 09.13.00.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),500,'admin','已結單',null,'魏姐包心粉圓');
Insert into ORDERS (ID,RESTAURANT_ID,BEGIN_TIME,END_TIME,END_MONEY,MEMBER_ACCOUNT,STATUS,INFO,RESTAURANT_NAME) values (123,1,to_timestamp('09-Jun -16 01.30.25.807000000 AM','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('09-Jun -16 02.30.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),300,'admin','已結單',null,'麥當勞');
Insert into ORDERS (ID,RESTAURANT_ID,BEGIN_TIME,END_TIME,END_MONEY,MEMBER_ACCOUNT,STATUS,INFO,RESTAURANT_NAME) values (124,1,to_timestamp('13-Jun -16 09.57.05.925000000 PM','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('13-Jun -16 10.56.00.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),100,'admin','已結單',null,'麥當勞');
Insert into ORDERS (ID,RESTAURANT_ID,BEGIN_TIME,END_TIME,END_MONEY,MEMBER_ACCOUNT,STATUS,INFO,RESTAURANT_NAME) values (120,7,to_timestamp('08-Jun -16 08.06.32.872000000 PM','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('08-Jun -16 09.05.00.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),700,'admin','已結單',null,'鬍鬚張');
Insert into ORDERS (ID,RESTAURANT_ID,BEGIN_TIME,END_TIME,END_MONEY,MEMBER_ACCOUNT,STATUS,INFO,RESTAURANT_NAME) values (118,10,to_timestamp('08-Jun -16 12.52.51.228000000 PM','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('08-Jun -16 01.52.00.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),100,'admin','已截止',null,'魏姐包心粉圓');
Insert into ORDERS (ID,RESTAURANT_ID,BEGIN_TIME,END_TIME,END_MONEY,MEMBER_ACCOUNT,STATUS,INFO,RESTAURANT_NAME) values (119,1,to_timestamp('08-Jun -16 02.27.32.222000000 PM','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('08-Jun -16 03.27.00.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),500,'admin','已截止',null,'麥當勞');
Insert into ORDERS (ID,RESTAURANT_ID,BEGIN_TIME,END_TIME,END_MONEY,MEMBER_ACCOUNT,STATUS,INFO,RESTAURANT_NAME) values (116,2,to_timestamp('08-Jun -16 12.52.27.407000000 PM','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('08-Jun -16 01.52.00.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),100,'admin','已截止',null,'悟饕池上飯包');
Insert into ORDERS (ID,RESTAURANT_ID,BEGIN_TIME,END_TIME,END_MONEY,MEMBER_ACCOUNT,STATUS,INFO,RESTAURANT_NAME) values (117,2,to_timestamp('08-Jun -16 12.52.27.639000000 PM','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('08-Jun -16 01.52.00.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),100,'admin','已截止',null,'悟饕池上飯包');



Insert into RESTAURANT (ID,NAME,BRIEF,ADDR,PHONE,R_TYPE,IMAGE) values (1,'麥當勞',null,'242新北市新莊區中正路617號','(02)2902-2181','速食',null);
Insert into RESTAURANT (ID,NAME,BRIEF,ADDR,PHONE,R_TYPE,IMAGE) values (2,'悟饕池上飯包',null,'242新北市新莊區中港一街27號','(02)2998-1191','便當',null);
Insert into RESTAURANT (ID,NAME,BRIEF,ADDR,PHONE,R_TYPE,IMAGE) values (3,'二男小家料理',null,'235新北市中和區中山路三段36號','(02)8227-5280','日式',null);
Insert into RESTAURANT (ID,NAME,BRIEF,ADDR,PHONE,R_TYPE,IMAGE) values (4,'黃師傅港式點心',null,'220新北市板橋區中正路166號','(02)2271-0250','點心',null);
Insert into RESTAURANT (ID,NAME,BRIEF,ADDR,PHONE,R_TYPE,IMAGE) values (5,'肯德基',null,'242新北市新莊區民安路157號','(02)2202-0124','速食',null);
Insert into RESTAURANT (ID,NAME,BRIEF,ADDR,PHONE,R_TYPE,IMAGE) values (11,'金源燒臘店',null,'台北市大安區瑞安街116號','(02)2325-4872','便當',null);
Insert into RESTAURANT (ID,NAME,BRIEF,ADDR,PHONE,R_TYPE,IMAGE) values (10,'魏姐包心粉圓',null,' 108台北市萬華區桂林路1號號 1 樓','(02)2383-0116','點心',null);


Insert into PRODUCT (ID,NAME,PRICE,RESTAURANT_ID) values (17,'吮指雙雞重量級XL套餐',165,5);
Insert into PRODUCT (ID,NAME,PRICE,RESTAURANT_ID) values (18,'乳酪起司雞腿堡餐',129,5);
Insert into PRODUCT (ID,NAME,PRICE,RESTAURANT_ID) values (19,'墨西哥莎莎霸王捲套餐',119,5);
Insert into PRODUCT (ID,NAME,PRICE,RESTAURANT_ID) values (20,'義式香草紙包雞',129,5);
Insert into PRODUCT (ID,NAME,PRICE,RESTAURANT_ID) values (1,'大麥克',60,1);
Insert into PRODUCT (ID,NAME,PRICE,RESTAURANT_ID) values (2,'吉士堡',50,1);
Insert into PRODUCT (ID,NAME,PRICE,RESTAURANT_ID) values (4,'麥脆雞',50,1);
Insert into PRODUCT (ID,NAME,PRICE,RESTAURANT_ID) values (3,'勁辣雞腿堡',60,1);
Insert into PRODUCT (ID,NAME,PRICE,RESTAURANT_ID) values (5,'醬燒豚肉飯',85,2);
Insert into PRODUCT (ID,NAME,PRICE,RESTAURANT_ID) values (6,'正宗池上便當',70,2);
Insert into PRODUCT (ID,NAME,PRICE,RESTAURANT_ID) values (7,'雞腿飯',75,2);
Insert into PRODUCT (ID,NAME,PRICE,RESTAURANT_ID) values (8,'黃金排骨飯',80,2);
Insert into PRODUCT (ID,NAME,PRICE,RESTAURANT_ID) values (9,'二男海鮮丼',520,3);
Insert into PRODUCT (ID,NAME,PRICE,RESTAURANT_ID) values (10,'男子漢海鮮丼',360,3);
Insert into PRODUCT (ID,NAME,PRICE,RESTAURANT_ID) values (11,'娘子海鮮丼',320,3);
Insert into PRODUCT (ID,NAME,PRICE,RESTAURANT_ID) values (12,'荒海散壽司丼',280,3);
Insert into PRODUCT (ID,NAME,PRICE,RESTAURANT_ID) values (13,'鮮蝦燒賣',65,4);
Insert into PRODUCT (ID,NAME,PRICE,RESTAURANT_ID) values (14,'魚翅蒸餃',65,4);
Insert into PRODUCT (ID,NAME,PRICE,RESTAURANT_ID) values (15,'牛肉腸粉',65,4);
Insert into PRODUCT (ID,NAME,PRICE,RESTAURANT_ID) values (16,'鮮蝦腸粉',65,4);
Insert into PRODUCT (ID,NAME,PRICE,RESTAURANT_ID) values (109,'布丁煉乳',50,10);
Insert into PRODUCT (ID,NAME,PRICE,RESTAURANT_ID) values (107,'包心桂圓銀耳',55,10);
Insert into PRODUCT (ID,NAME,PRICE,RESTAURANT_ID) values (108,'優格雪沙',50,10);
Insert into PRODUCT (ID,NAME,PRICE,RESTAURANT_ID) values (110,'桂圓紫米粥',65,10);
Insert into PRODUCT (ID,NAME,PRICE,RESTAURANT_ID) values (111,'蜜汁雞腿飯.',100,11);
Insert into PRODUCT (ID,NAME,PRICE,RESTAURANT_ID) values (112,'脆皮鴨腿飯',100,11);
Insert into PRODUCT (ID,NAME,PRICE,RESTAURANT_ID) values (113,'港式臘味飯',90,11);






