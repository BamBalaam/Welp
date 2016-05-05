CREATE TABLE Users(
	UserID			Serial,
	Username        Varchar(20) UNIQUE NOT NULL,
	Email			Varchar(100) UNIQUE NOT NULL,
	PWD				Varchar(64) NOT NULL,
	DateSignUp		Varchar(100) NOT NULL,
	IsAdmin			Boolean DEFAULT False,
	PRIMARY KEY (UserID)
);

CREATE TABLE Places(
	PlaceID			Serial,
    CreatorID       Serial REFERENCES Users(UserID),
    CreationDate	Timestamp,
	Name			Varchar(100) NOT NULL,
	Street			Varchar(64) NOT NULL,
	Num				Varchar(10) NOT NULL,
	Zip				Integer NOT NULL,
	City			Varchar(100) NOT NULL,
	Longitude		Float,
	Latitude		Float,
	PhoneNum		Varchar(100),
	Website			Varchar(100),
	PRIMARY KEY (PlaceID)
);

CREATE TABLE Restaurants(
	PID			Serial REFERENCES Places(PlaceID),
	PriceRange	Varchar(200),
	Banquet		Integer,
	TakeOut		Boolean,
	Delivery	Boolean,
	Closed		Varchar(300)
);

CREATE TABLE Cafes(
    PID         Serial REFERENCES Places(PlaceID),
	Smoking		Boolean,
	Snack		Boolean
);

CREATE TABLE Hotels(
	PID			Serial REFERENCES Places(PlaceID),
	NumStars	Integer,
	NumRooms	Integer,
	PriceRangeDoubleRoom	Varchar(200)
);

CREATE TABLE Comments(
	PID 			Serial REFERENCES Places(PlaceID),
	UID				Serial REFERENCES Users(UserID),
	Stars           Integer NOT NULL,
	TextComment 	Text NOT NULL,
	CreationDate 	Timestamp NOT NULL,
	PRIMARY KEY (PID, UID,CreationDate)
);

CREATE TABLE Tags(
	PID 			Serial REFERENCES Places(PlaceID),
	UID				Serial REFERENCES Users(UserID),
	Name			Varchar(100) UNIQUE NOT NULL,
	PRIMARY KEY (PID, UID)
);