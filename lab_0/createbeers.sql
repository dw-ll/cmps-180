SELECT timeofday();

CREATE TABLE Beers (
    name VARCHAR(30),
    manf VARCHAR(50)
);

CREATE TABLE Bars (
    name VARCHAR(30),
    addr VARCHAR(50),
    license VARCHAR(50)
);

CREATE TABLE Sells (
    bar VARCHAR(20),
    beer VARCHAR(30),
    price REAL
);

CREATE TABLE Drinkers (
    name VARCHAR(30),
    addr VARCHAR(50),
    phone CHAR(16)
);

CREATE TABLE Likes (
    drinker VARCHAR(30),
    beer VARCHAR(30)
);

CREATE TABLE Frequents (
    drinker VARCHAR(30),
    bar VARCHAR(30)
);

-- prints current time
SELECT timeofday();

