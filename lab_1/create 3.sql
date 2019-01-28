SELECT timeofday();
DROP SCHEMA Lab1
CASCADE;
CREATE SCHEMA Lab1;

create table exchanges
(
    exchangeID char(6) primary key,
    exchangeName varchar(30),
    address varchar(30)
);

create table stocks
(
    exchangeID char(6),
    symbol char(4),
    stockName varchar(30),
    address varchar(30),
    primary key(exchangeID,symbol)
);

create table customers
(
    customerID int primary key,
    custName varchar(30),
    address varchar(30),
    category char(1),
    isValidCustomer boolean
);

create table trades
(
    exchangeID char(6),
    symbol char(4),
    tradeTS timestamp,
    buyerID integer,
    sellerID integer,
    price numeric(7,2),
    volume integer,
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