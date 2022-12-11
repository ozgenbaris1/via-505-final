CREATE DATABASE gotur;

USE gotur;

CREATE TABLE country (
	country_id           int  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	name                 varchar(100)
 );

CREATE TABLE city (
	city_id              int  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	name                 varchar(100)      ,
	country_id           int  NOT NULL
 );

ALTER TABLE city ADD CONSTRAINT fk_city_country FOREIGN KEY ( country_id ) REFERENCES country( country_id );

CREATE TABLE district (
	district_id          int  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	name                 varchar(100)  NOT NULL    ,
	city_id              int  NOT NULL
 );

ALTER TABLE district ADD CONSTRAINT fk_district_city FOREIGN KEY ( city_id ) REFERENCES city( city_id );

CREATE TABLE address (
	address_id           int  NOT NULL    PRIMARY KEY,
	latitude             float  NOT NULL    ,
	longitude            float  NOT NULL    ,
	detail               varchar(256)  NOT NULL    ,
	country_id           int  NOT NULL    ,
	city_id              int  NOT NULL    ,
	district_id          int  NOT NULL
 );

ALTER TABLE address ADD CONSTRAINT fk_address_country FOREIGN KEY ( country_id ) REFERENCES country( country_id );

ALTER TABLE address ADD CONSTRAINT fk_address_city FOREIGN KEY ( city_id ) REFERENCES city( city_id );

ALTER TABLE address ADD CONSTRAINT fk_address_district FOREIGN KEY ( district_id ) REFERENCES district( district_id );

CREATE TABLE customer (
	customer_id          int  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	first_name           varchar(100)  NOT NULL    ,
	last_name            varchar(100)  NOT NULL    ,
	create_date          datetime  NOT NULL DEFAULT CURRENT_TIMESTAMP
 );

CREATE TABLE customer_address (
	customer_id          int  NOT NULL    ,
	create_date          datetime  NOT NULL DEFAULT CURRENT_TIMESTAMP   ,
	address_id           int  NOT NULL    ,
	CONSTRAINT idx_customer_address PRIMARY KEY ( customer_id, address_id )
 );

ALTER TABLE customer_address ADD CONSTRAINT fk_address FOREIGN KEY ( address_id ) REFERENCES address( address_id );

ALTER TABLE customer_address ADD CONSTRAINT fk_customer FOREIGN KEY ( customer_id ) REFERENCES customer( customer_id );

CREATE TABLE category (
	category_id          int  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	name                 varchar(100)  NOT NULL
 );

CREATE TABLE product (
	product_id           int  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	name                 varchar(100)  NOT NULL    ,
	price                float  NOT NULL    ,
	category_id          int  NOT NULL
 );

ALTER TABLE product ADD CONSTRAINT fk_product_category FOREIGN KEY ( category_id ) REFERENCES category( category_id );

CREATE TABLE status (
	status_id            int  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	definition           varchar(100)  NOT NULL
 );

CREATE TABLE store (
	store_id             int  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	name                 varchar(100)  NOT NULL    ,
	create_date          datetime  NOT NULL DEFAULT current_timestamp   ,
	address_id           int  NOT NULL
 );


ALTER TABLE store ADD CONSTRAINT fk_store_address FOREIGN KEY ( address_id ) REFERENCES address( address_id );

CREATE TABLE inventory (
	store_id             int  NOT NULL    ,
	quantity             int  NOT NULL    ,
	product_id           int  NOT NULL    ,
	CONSTRAINT idx_stock PRIMARY KEY ( store_id, product_id )
 );

ALTER TABLE inventory ADD CONSTRAINT fk_inventory_store FOREIGN KEY ( store_id ) REFERENCES store( store_id );

ALTER TABLE inventory ADD CONSTRAINT fk_inventory_product FOREIGN KEY ( product_id ) REFERENCES product( product_id );

CREATE TABLE stock_entry (
	stock_entry_id       int  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	create_date          datetime  NOT NULL DEFAULT CURRENT_TIMESTAMP   ,
	store_id             int  NOT NULL
 ) ;

ALTER TABLE stock_entry ADD CONSTRAINT fk_stock_entry_store FOREIGN KEY ( store_id ) REFERENCES store( store_id );

CREATE TABLE stock_entry_detail (
	stock_entry_id       int  NOT NULL    ,
	quantity             int  NOT NULL    ,
	product_id           int  NOT NULL    ,
	CONSTRAINT idx_stock_entry_detail PRIMARY KEY ( stock_entry_id, product_id )
 );

ALTER TABLE stock_entry_detail ADD CONSTRAINT fk_stock_entry_detail FOREIGN KEY ( stock_entry_id ) REFERENCES stock_entry( stock_entry_id );

ALTER TABLE stock_entry_detail ADD CONSTRAINT fk_stock_entry_detail_product FOREIGN KEY ( product_id ) REFERENCES product( product_id );

CREATE TABLE courier (
	courier_id           int  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	first_name           varchar(100)  NOT NULL    ,
	last_name            varchar(100)  NOT NULL    ,
	latitude             float  NOT NULL    ,
	longitude            float  NOT NULL
 );

CREATE TABLE customer_order (
	customer_order_id    int  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	create_date          datetime  NOT NULL DEFAULT CURRENT_TIMESTAMP   ,
	customer_id          int  NOT NULL    ,
	status_id            int  NOT NULL    ,
	courier_id           int  NOT NULL    ,
	store_id             int  NOT NULL
 ) engine=InnoDB;

ALTER TABLE customer_order ADD CONSTRAINT fk_customer_order_customer FOREIGN KEY ( customer_id ) REFERENCES customer( customer_id ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE customer_order ADD CONSTRAINT fk_customer_order_status FOREIGN KEY ( status_id ) REFERENCES status( status_id ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE customer_order ADD CONSTRAINT fk_customer_order_courier FOREIGN KEY ( courier_id ) REFERENCES courier( courier_id ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE customer_order ADD CONSTRAINT fk_customer_order_store FOREIGN KEY ( store_id ) REFERENCES store( store_id ) ON DELETE NO ACTION ON UPDATE NO ACTION;



CREATE TABLE customer_order_detail (
	customer_order_id    int  NOT NULL    ,
	quantity             int  NOT NULL    ,
	product_id           int  NOT NULL    ,
	CONSTRAINT idx_customer_order_detail PRIMARY KEY ( customer_order_id, product_id )
 );

ALTER TABLE customer_order_detail ADD CONSTRAINT fk_order FOREIGN KEY ( customer_order_id ) REFERENCES customer_order( customer_order_id );

ALTER TABLE customer_order_detail ADD CONSTRAINT fk_product FOREIGN KEY ( product_id ) REFERENCES product( product_id );

CREATE TABLE rating (
	rating_id            int  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	point                int  NOT NULL    ,
	create_date          datetime  NOT NULL DEFAULT CURRENT_TIMESTAMP   ,
	customer_id          int  NOT NULL    ,
	customer_order_id    int  NOT NULL    ,
	courier_id           int  NOT NULL
 );

ALTER TABLE rating ADD CONSTRAINT fk_rating_customer FOREIGN KEY ( customer_id ) REFERENCES customer( customer_id );

ALTER TABLE rating ADD CONSTRAINT fk_rating_customer_order FOREIGN KEY ( customer_order_id ) REFERENCES customer_order( customer_order_id );

ALTER TABLE rating ADD CONSTRAINT fk_rating_courier FOREIGN KEY ( courier_id ) REFERENCES courier( courier_id );
