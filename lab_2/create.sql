DROP SCHEMA Lab2 CASCADE;
CREATE SCHEMA Lab2;

create table exchanges
(
    exchangeID char(6) primary key,
    exchangeName varchar(30),
    address varchar(30),
    UNIQUE(exchangeName)
);

create table stocks
(
    exchangeID char(6),
    symbol char(4),
    stockName varchar(30) NOT NULL,
    address varchar(30),
    primary key(exchangeID,symbol),
    UNIQUE(stockName)
);

create table customers
(
    customerID int primary key,
    custName varchar(30),
    address varchar(30),
    category char(1),
    isValidCustomer boolean,
    UNIQUE(custName, address)
);

create table trades
(
    exchangeID char(6),
    symbol char(4),
    tradeTS timestamp,
    buyerID integer,
    sellerID integer,
    price numeric(7,2) NOT NULL,
    volume integer NOT NULL,
    primary key(exchangeID,symbol,tradeTS)
);

create table quotes
(
    exchangeID char(6),
    symbol char(4),
    quoteTS timestamp,
    price numeric(7,2),
    primary key(exchangeID,symbol,quoteTS)
);