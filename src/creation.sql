CREATE TYPE place_type AS ENUM ('hotel', 'cafe', 'restaurant');

CREATE TABLE Users(
	user_id          Serial,
	username         Varchar(20) UNIQUE NOT NULL,
	email            Varchar(100) UNIQUE NOT NULL,
	passwd           Varchar(64) NOT NULL,
	date_sign_up     Varchar(100) NOT NULL,
	is_admin         Boolean DEFAULT False,
	PRIMARY KEY (user_id)
);
CREATE TABLE Places(
	place_id         Serial,
	creator_id       Serial REFERENCES Users(user_id),
	creation_date    Timestamp,
	name             Varchar(100) NOT NULL,
	street           Varchar(64) NOT NULL,
	num              Varchar(10) NOT NULL,
	zip               TEXT NOT NULL,
	city             Varchar(100) NOT NULL,
	longitude        Real,
	latitude         Real,
	phone            Varchar(100),
	website          Varchar(100),
	kind             place_type,
	PRIMARY KEY (place_id)
);
CREATE TABLE Restaurants(
	place_id         Serial REFERENCES Places(place_id) ON DELETE CASCADE,
	price_range      Integer,
	banquet          Integer,
	take_out         Boolean,
	delivery         Boolean,
	closed           Bit(14)
);
CREATE TABLE Cafes(
	place_id         Serial REFERENCES Places(place_id) ON DELETE CASCADE,
	smoking          Boolean,
	snack            Boolean
);
CREATE TABLE Hotels(
	place_id         Serial REFERENCES Places(place_id) ON DELETE CASCADE,
	num_stars         Integer,
	num_rooms         Integer,
	price_range_double_room	Varchar(200)
);
CREATE TABLE Comments(
	place_id         Serial REFERENCES Places(place_id) ON DELETE CASCADE,
	user_id          Serial REFERENCES Users(user_id) ON DELETE CASCADE,
	stars             Integer NOT NULL,
	text_comment      Text NOT NULL,
	creation_date     Date NOT NULL,
	PRIMARY KEY (place_id, user_id, creation_date)
);
CREATE TABLE Tags(
	place_id          Serial REFERENCES Places(place_id) ON DELETE CASCADE,
	user_id           Serial REFERENCES Users(user_id) ON DELETE CASCADE,
	name              Varchar(100) NOT NULL,
	PRIMARY KEY (place_id, user_id, name)
);