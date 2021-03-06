--    Licensed to the Apache Software Foundation (ASF) under one or more
--    contributor license agreements.  See the NOTICE file distributed with
--    this work for additional information regarding copyright ownership.
--    The ASF licenses this file to You under the Apache License, Version 2.0
--    (the "License"); you may not use this file except in compliance with
--    the License.  You may obtain a copy of the License at
--
--       http://www.apache.org/licenses/LICENSE-2.0
--
--    Unless required by applicable law or agreed to in writing, software
--    distributed under the License is distributed on an "AS IS" BASIS,
--    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
--    See the License for the specific language governing permissions and
--    limitations under the License.

use tradedb
go
DROP TABLE HOLDINGEJB
DROP TABLE ACCOUNTPROFILEEJB
DROP TABLE QUOTEEJB
DROP TABLE KEYGENEJB
DROP TABLE ACCOUNTEJB
DROP TABLE ORDEREJB

CREATE TABLE HOLDINGEJB  (
  PURCHASEPRICE DECIMAL(14, 2), 
  HOLDINGID int NOT NULL, 
  QUANTITY float NOT NULL, 
  PURCHASEDATE DATETIME,
  ACCOUNT_ACCOUNTID int,
  QUOTE_SYMBOL VARCHAR(250))

ALTER TABLE HOLDINGEJB
  ADD CONSTRAINT PK_HOLDINGEJB PRIMARY KEY (HOLDINGID)

CREATE TABLE ACCOUNTPROFILEEJB
  (ADDRESS VARCHAR(250),
   PASSWD VARCHAR(250),
   USERID VARCHAR(250) NOT NULL,
   EMAIL VARCHAR(250),
   CREDITCARD VARCHAR(250),
   FULLNAME VARCHAR(250))

ALTER TABLE ACCOUNTPROFILEEJB
  ADD CONSTRAINT PK_ACCOUNTPROFILE2 PRIMARY KEY (USERID)

CREATE TABLE QUOTEEJB
  (LOW DECIMAL(14, 2),
   OPEN1 DECIMAL(14, 2),
   VOLUME float NOT NULL,
   PRICE DECIMAL(14, 2),
   HIGH DECIMAL(14, 2),
   COMPANYNAME VARCHAR(250),
   SYMBOL VARCHAR(250) NOT NULL,
   CHANGE1 float NOT NULL)

ALTER TABLE QUOTEEJB
  ADD CONSTRAINT PK_QUOTEEJB PRIMARY KEY (SYMBOL)

CREATE TABLE KEYGENEJB
  (KEYVAL int NOT NULL,
   KEYNAME VARCHAR(250) NOT NULL)

ALTER TABLE KEYGENEJB
  ADD CONSTRAINT PK_KEYGENEJB PRIMARY KEY (KEYNAME)

CREATE TABLE ACCOUNTEJB
  (CREATIONDATE DATETIME,
   OPENBALANCE DECIMAL(14, 2),
   LOGOUTCOUNT int NOT NULL,
   BALANCE DECIMAL(14, 2),
   ACCOUNTID int NOT NULL,
   LASTLOGIN DATETIME,
   LOGINCOUNT int NOT NULL,
   PROFILE_USERID VARCHAR(250))

ALTER TABLE ACCOUNTEJB
  ADD CONSTRAINT PK_ACCOUNTEJB PRIMARY KEY (ACCOUNTID)

CREATE TABLE ORDEREJB
  (ORDERFEE DECIMAL(14, 2),
   COMPLETIONDATE DATETIME,
   ORDERTYPE VARCHAR(250),
   ORDERSTATUS VARCHAR(250),
   PRICE DECIMAL(14, 2),
   QUANTITY float NOT NULL,
   OPENDATE DATETIME,
   ORDERID int NOT NULL,
   ACCOUNT_ACCOUNTID int,
   QUOTE_SYMBOL VARCHAR(250),
   HOLDING_HOLDINGID int)
  
ALTER TABLE ORDEREJB
  ADD CONSTRAINT PK_ORDEREJB PRIMARY KEY (ORDERID);

CREATE INDEX ACCOUNT_USERID ON ACCOUNTEJB(PROFILE_USERID)
CREATE INDEX HOLDING_ACCOUNTID ON HOLDINGEJB(ACCOUNT_ACCOUNTID)
CREATE INDEX ORDER_ACCOUNTID ON ORDEREJB(ACCOUNT_ACCOUNTID)
CREATE INDEX ORDER_HOLDINGID ON ORDEREJB(HOLDING_HOLDINGID)
CREATE INDEX CLOSED_ORDERS ON ORDEREJB(ACCOUNT_ACCOUNTID,ORDERSTATUS)
go  
