CREATE TABLE IF NOT EXISTS country (
	country_id           int  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	name                 varchar(100)  NOT NULL
 );

CREATE TABLE IF NOT EXISTS city (
	city_id              int  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	name                 varchar(100)      ,
	country_id           int  NOT NULL    ,
	CONSTRAINT fk_city_country FOREIGN KEY ( country_id ) REFERENCES country( country_id )
 );

CREATE TABLE IF NOT EXISTS district (
	district_id          int  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	name                 varchar(100)  NOT NULL    ,
	city_id              int  NOT NULL    ,
	CONSTRAINT fk_district_city FOREIGN KEY ( city_id ) REFERENCES city( city_id )
 );

CREATE TABLE IF NOT EXISTS address (
	address_id           int  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	latitude             float  NOT NULL    ,
	longitude            float  NOT NULL    ,
	detail               varchar(256)  NOT NULL    ,
	country_id           int  NOT NULL    ,
	city_id              int  NOT NULL    ,
	district_id          int  NOT NULL    ,
	CONSTRAINT fk_address_country FOREIGN KEY ( country_id ) REFERENCES country( country_id ),
	CONSTRAINT fk_address_city FOREIGN KEY ( city_id ) REFERENCES city( city_id ),
	CONSTRAINT fk_address_district FOREIGN KEY ( district_id ) REFERENCES district( district_id )
 );

CREATE TABLE IF NOT EXISTS customer (
	customer_id          int  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	first_name           varchar(100)  NOT NULL    ,
	last_name            varchar(100)  NOT NULL    ,
	email                varchar(100)  NOT NULL    ,
	password             varchar(256)  NOT NULL    ,
	phone                varchar(13)  NOT NULL    ,
	create_date          datetime  NOT NULL DEFAULT CURRENT_TIMESTAMP   ,
	address_id           int  NOT NULL    ,
	CONSTRAINT fk_customer_address FOREIGN KEY ( address_id ) REFERENCES address( address_id ),
	CONSTRAINT idx_customer UNIQUE ( email ) 
 );

CREATE TABLE IF NOT EXISTS category (
	category_id          int  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	name                 varchar(100)  NOT NULL
 );

CREATE TABLE IF NOT EXISTS product (
	product_id           int  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	name                 varchar(100)  NOT NULL    ,
	price                float(10,2)  NOT NULL    ,
	category_id          int  NOT NULL,
	CONSTRAINT fk_product_category FOREIGN KEY ( category_id ) REFERENCES category( category_id )
 );

CREATE TABLE IF NOT EXISTS status (
	status_id            int  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	definition           varchar(100)  NOT NULL
 );

CREATE TABLE IF NOT EXISTS store (
	store_id             int  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	name                 varchar(100)  NOT NULL    ,
	create_date          datetime  NOT NULL DEFAULT current_timestamp   ,
	address_id           int  NOT NULL,
	CONSTRAINT fk_store_address FOREIGN KEY ( address_id ) REFERENCES address( address_id )
 );

CREATE TABLE IF NOT EXISTS inventory (
	store_id             int  NOT NULL    ,
	quantity             int  NOT NULL    ,
	product_id           int  NOT NULL    ,
	CONSTRAINT idx_stock PRIMARY KEY ( store_id, product_id ),
	CONSTRAINT fk_inventory_store FOREIGN KEY ( store_id ) REFERENCES store( store_id ),
	CONSTRAINT fk_inventory_product FOREIGN KEY ( product_id ) REFERENCES product( product_id )
 );

CREATE TABLE IF NOT EXISTS stock_entry (
	stock_entry_id       int  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	create_date          datetime  NOT NULL DEFAULT CURRENT_TIMESTAMP   ,
	store_id             int  NOT NULL,
	CONSTRAINT fk_stock_entry_store FOREIGN KEY ( store_id ) REFERENCES store( store_id )
 ) ;

CREATE TABLE IF NOT EXISTS stock_entry_detail (
	stock_entry_id       int  NOT NULL    ,
	quantity             int  NOT NULL    ,
	product_id           int  NOT NULL    ,
	CONSTRAINT idx_stock_entry_detail PRIMARY KEY ( stock_entry_id, product_id ),
	CONSTRAINT fk_stock_entry_detail FOREIGN KEY ( stock_entry_id ) REFERENCES stock_entry( stock_entry_id ),
	CONSTRAINT fk_stock_entry_detail_product FOREIGN KEY ( product_id ) REFERENCES product( product_id )
 );

CREATE TABLE IF NOT EXISTS courier (
	courier_id           int  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	first_name           varchar(100)  NOT NULL    ,
	last_name            varchar(100)  NOT NULL    ,
	latitude             float  NOT NULL    ,
	longitude            float  NOT NULL
 );

CREATE TABLE IF NOT EXISTS customer_order (
	customer_order_id    int  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	create_date          datetime  NOT NULL DEFAULT CURRENT_TIMESTAMP   ,
	customer_id          int  NOT NULL    ,
	status_id            int  NOT NULL    ,
	courier_id           int  NOT NULL    ,
	store_id             int  NOT NULL,
	CONSTRAINT fk_customer_order_customer FOREIGN KEY ( customer_id ) REFERENCES customer( customer_id ),
	CONSTRAINT fk_customer_order_status FOREIGN KEY ( status_id ) REFERENCES status( status_id ),
	CONSTRAINT fk_customer_order_courier FOREIGN KEY ( courier_id ) REFERENCES courier( courier_id ),
	CONSTRAINT fk_customer_order_store FOREIGN KEY ( store_id ) REFERENCES store( store_id )
 );

CREATE TABLE IF NOT EXISTS customer_order_detail (
	customer_order_id    int  NOT NULL    ,
	quantity             int  NOT NULL    ,
	product_id           int  NOT NULL    ,
	CONSTRAINT idx_customer_order_detail PRIMARY KEY ( customer_order_id, product_id ),
	CONSTRAINT fk_order FOREIGN KEY ( customer_order_id ) REFERENCES customer_order( customer_order_id ),
	CONSTRAINT fk_product FOREIGN KEY ( product_id ) REFERENCES product( product_id )
 );

CREATE TABLE IF NOT EXISTS rating (
	rating_id            int  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	point                int  NOT NULL    ,
	create_date          datetime  NOT NULL DEFAULT CURRENT_TIMESTAMP   ,
	customer_id          int  NOT NULL    ,
	customer_order_id    int  NOT NULL    ,
	courier_id           int  NOT NULL,
	CONSTRAINT fk_rating_customer FOREIGN KEY ( customer_id ) REFERENCES customer( customer_id ),
	CONSTRAINT fk_rating_customer_order FOREIGN KEY ( customer_order_id ) REFERENCES customer_order( customer_order_id ),
	CONSTRAINT fk_rating_courier FOREIGN KEY ( courier_id ) REFERENCES courier( courier_id )
 );