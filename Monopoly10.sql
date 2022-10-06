DROP DATABASE IF EXISTS Monopoly;
CREATE DATABASE Monopoly;
USE Monopoly;

CREATE TABLE Games (
 gameID INT,
 status VARCHAR(50),
 PRIMARY KEY (GAMEID)
)ENGINE=InnoDB;

CREATE TABLE Players (
 gameID INT NOT NULL,
 playerID VARCHAR(50),
 PRIMARY KEY (gameID,playerID),
 FOREIGN KEY (gameID) REFERENCES Games(gameID) ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE=InnoDB;

CREATE TABLE PlayerStatus (
 gameID INT NOT NULL,
 playerID VARCHAR(50),
 money INT,
 properties VARCHAR(50),
 specialcard INT,
 jail INT,
 position INT,
 PRIMARY KEY (gameID,playerID),
 FOREIGN KEY (gameID) REFERENCES Games(gameID) ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE=InnoDB;

CREATE TABLE PlayerProperties (
 gameID INT NOT NULL,
 playerID VARCHAR(50),
 property INT,
 mortgaged INT,
 PRIMARY KEY (gameID,playerID,property),
 FOREIGN KEY (gameID) REFERENCES Games(gameID) ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE=InnoDB;


/*Games*/
INSERT INTO Games VALUES (1,'Playing');
INSERT INTO Games VALUES (2,'Playing');
INSERT INTO Games VALUES (3,'Playing');

/*Players and games that are playing*/
INSERT INTO Players VALUES (1,'player1');
INSERT INTO Players VALUES (2,'player1');
INSERT INTO Players VALUES (1,'player2');
INSERT INTO Players VALUES (1,'player3');
INSERT INTO Players VALUES (1,'player4');
INSERT INTO Players VALUES (2,'player4');
INSERT INTO Players VALUES (2,'player5');

/*Status of each player in each game*/
INSERT INTO PlayerStatus VALUES (1,'player1',500,'temporary',0,0,20);
INSERT INTO PlayerStatus VALUES (2,'player1',1200, 'temporary',1,1,2);
INSERT INTO PlayerStatus VALUES (1,'player2',100, 'temporary', 0,0,24);
INSERT INTO PlayerStatus VALUES (1,'player3',2000, 'temporary', 0, 1,4);
INSERT INTO PlayerStatus VALUES (1,'player4',4000, 'temporary', 1, 0,12);
INSERT INTO PlayerStatus VALUES (2,'player4',3250, 'temporary', 0, 0,18);
INSERT INTO PlayerStatus VALUES (2,'player5',35, 'temporary', 0, 1,15);

/*Game 1 properties*/
INSERT INTO PlayerProperties VALUES (1,'player1',12,0);
INSERT INTO PlayerProperties VALUES (1,'player1',8,0);
INSERT INTO PlayerProperties VALUES (1,'player1',19,0);
INSERT INTO PlayerProperties VALUES (1,'player2',14,1);
INSERT INTO PlayerProperties VALUES (1,'player3',13,1);
INSERT INTO PlayerProperties VALUES (1,'player4',4,0);

/*Game 2 properties*/
INSERT INTO PlayerProperties VALUES (2,'player1',2,0);
INSERT INTO PlayerProperties VALUES (2,'player5',12,0);
INSERT INTO PlayerProperties VALUES (2,'player4',9,1);


/* Dame los ID de los jugadores y de la partida donde estan con más de 100 euros que estan en prisión */

SELECT Games.gameID, PlayerStatus.playerID FROM Games, PlayerStatus WHERE Games.gameID = PlayerStatus.gameID AND PlayerStatus.jail = 1 AND PlayerStatus.money > 100;


