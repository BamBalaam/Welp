CREATE TABLE "User"(
	UserID			Integer,
	Email			Varchar(100),
	"Password"		Varchar(64),
	DateSignUp		Varchar(100),
	IsAdmin			Boolean,
	PRIMARY KEY (UserID)
);

CREATE TABLE Place(
	PlaceID			Integer,
	Name			Varchar(100),
	Address			Varchar(64),
	GPS				Float,
	PhoneNum		Varchar(100),
	Website			Varchar(100),
	PRIMARY KEY (PlaceID)
);

CREATE TABLE Restaurant(
	PID			Integer,
	PriceRange	Varchar(200),
	Banquet		Integer,
	TakeOut		Boolean,
	Delivery	Boolean,
	Closed		Varchar(300),
	FOREIGN KEY (PID) REFERENCES Place(PlaceID)
);

CREATE TABLE Cafe(
	PID			Integer,
	Smoking		Boolean,
	Snack		Boolean,
	FOREIGN KEY (PID) REFERENCES Place(PlaceID)
);

CREATE TABLE Hotel(
	PID			Integer,
	NumStars	Integer,
	NumRooms	Integer,
	PriceRangeDoubleRoom	Varchar(200),
	FOREIGN KEY (PID) REFERENCES Place(PlaceID)
);

CREATE TABLE "Comment"(
	PID 			Integer,
	UID				Integer,
	"Comment" 		Text,
	"Date" 			Timestamp,
	FOREIGN KEY (PID) REFERENCES Place(PlaceID),
	FOREIGN KEY (UID) REFERENCES "User"(UserID),
	PRIMARY KEY (PID, UID)
);

CREATE TABLE Tag(
	Name Varchar(100)
);