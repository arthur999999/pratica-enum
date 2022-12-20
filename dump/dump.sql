CREATE TABLE customers (
	id SERIAL PRIMARY KEY,
	"fullName" TEXT NOT NULL,
	cpf CHAR(11) NOT NULL UNIQUE,
	email TEXT NOT NULL UNIQUE,
	password TEXT NOT NULL	
);

CREATE TYPE number_type AS ENUM ('landline', 'mobile');

CREATE TABLE "customerPhones" (
	id SERIAL PRIMARY KEY,
	"customerId" INTEGER NOT NULL REFERENCES "customers"("id"),
	number INTEGER NOT NULL,
	type number_type NOT NULL
);

CREATE TABLE states (
	id SERIAL PRIMARY KEY,
	name TEXT NOT NULL
);

CREATE TABLE cities (
	id SERIAL PRIMARY KEY,
	name TEXT NOT NULL,
	"stateId" INTEGER NOT NULL REFERENCES "states"("id")
);

CREATE TABLE "customerAddresses" (
	id SERIAL PRIMARY KEY,
	"customerId" INTEGER NOT NULL UNIQUE REFERENCES "customers"("id"),
	street TEXT NOT NULL,
	number INTEGER NOT NULL,
	complement TEXT NOT NULL,
	"postalCode" TEXT NOT NULL,
	"cityId" INTEGER NOT NULL REFERENCES "cities"("id")	
);

CREATE TABLE "bankAccount" (
	id SERIAL PRIMARY KEY,
	"customerId" INTEGER NOT NULL UNIQUE REFERENCES "customers"("id"),
	"accountNumber" INTEGER NOT NULL UNIQUE,
	agency TEXT NOT NULL,
	"openDate" DATE NOT NULL,
	"closeDate" DATE
);

CREATE TYPE type_transactions AS ENUM ('deposit', 'withdraw');

CREATE TABLE transactions (
	id SERIAL PRIMARY KEY,
	"bankAccountId" INTEGER NOT NULL REFERENCES "bankAccount"("id"),
	amount INTEGER NOT NULL,
	type type_transactions NOT NULL,
	time TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT NOW(),
	description TEXT NOT NULL,
	cancelled BIT NOT NULL
);

CREATE TABLE "creditCards" (
	id SERIAL PRIMARY KEY,
	"bankAccountId" INTEGER NOT NULL REFERENCES "bankAccount"("id"),
	name TEXT NOT NULL,
	number INTEGER NOT NULL,
	"securityCode" INTEGER NOT NULL,
	"expirationMonth" INTEGER NOT NULL,
	"expirationYear" INTEGER NOT NULL,
	password INTEGER NOT NULL,
	"limit" INTEGER NOT NULL
	
);