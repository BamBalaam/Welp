CREATE TABLE "User"(
	UserID			Serial,
	Username        Varchar(20) UNIQUE NOT NULL,
	Email			Varchar(100) UNIQUE NOT NULL,
	"Password"		Varchar(64) NOT NULL,
	DateSignUp		Varchar(100) NOT NULL,
	IsAdmin			Boolean DEFAULT False,
	PRIMARY KEY (UserID)
);

CREATE TABLE Place(
	PlaceID			Serial,
    CreatorID       Serial REFERENCES "User"(UserID),
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

CREATE TABLE Restaurant(
	PID			Serial REFERENCES Place(PlaceID),
	PriceRange	Varchar(200),
	Banquet		Integer,
	TakeOut		Boolean,
	Delivery	Boolean,
	Closed		Varchar(300)
);

CREATE TABLE Cafe(
    PID         Serial REFERENCES Place(PlaceID),
	Smoking		Boolean,
	Snack		Boolean
);

CREATE TABLE Hotel(
	PID			Serial REFERENCES Place(PlaceID),
	NumStars	Integer,
	NumRooms	Integer,
	PriceRangeDoubleRoom	Varchar(200)
);

CREATE TABLE "Comment"(
	PID 			Serial REFERENCES Place(PlaceID),
	UID				Serial REFERENCES "User"(UserID),
	Stars           Integer NOT NULL,
	"Text" 			Text NOT NULL,
	"Date" 			Timestamp NOT NULL,
	PRIMARY KEY (PID, UID,"Date")
);

CREATE TABLE Tag(
	PID 			Serial REFERENCES Place(PlaceID),
	UID				Serial REFERENCES "User"(UserID),
	Name			Varchar(100) UNIQUE NOT NULL,
	PRIMARY KEY (PID, UID)
);