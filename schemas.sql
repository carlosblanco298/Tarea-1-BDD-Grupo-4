DROP TABLE IF EXISTS Estadisticas_Jugador CASCADE;
DROP TABLE IF EXISTS Partidas CASCADE;
DROP TABLE IF EXISTS Inscripciones CASCADE;
DROP TABLE IF EXISTS Sponsor_Torneo CASCADE;
DROP TABLE IF EXISTS Jugadores CASCADE;
DROP TABLE IF EXISTS Equipos CASCADE;
DROP TABLE IF EXISTS Torneos CASCADE;
DROP TABLE IF EXISTS Sponsors CASCADE;

CREATE TABLE Sponsors (
    ID_Sponsor SERIAL PRIMARY KEY,
    Nombre VARCHAR(100) UNIQUE NOT NULL,
    Industria VARCHAR(50)
);

CREATE TABLE Torneos (
    ID_Torneo SERIAL PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Videojuego VARCHAR(100) NOT NULL,
    Fecha_Inicio DATE NOT NULL,
    Fecha_Fin DATE NOT NULL,
    Prize_Pool DECIMAL(12, 2),
    MAX_Equipos INT DEFAULT 8,
    CONSTRAINT chk_fecha CHECK (Fecha_Fin >= Fecha_Inicio)
);

CREATE TABLE Equipos (
    Nombre_Equipo VARCHAR(100) PRIMARY KEY,
    Fecha_Creacion DATE NOT NULL,
    Gamertag_Capitan VARCHAR(50)
);

CREATE TABLE Jugadores (
    Gamertag VARCHAR(50) PRIMARY KEY,
    Nombre_Real VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Fecha_Nacimiento DATE NOT NULL,
    Pais VARCHAR(50),
    Nombre_Equipo VARCHAR(100)
);

ALTER TABLE Equipos 
ADD CONSTRAINT fk_capitan
FOREIGN KEY (Gamertag_Capitan) REFERENCES Jugadores(Gamertag)
DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE Jugadores
ADD CONSTRAINT fk_equipo
FOREIGN KEY (Nombre_Equipo) REFERENCES Equipos(Nombre_Equipo)
DEFERRABLE INITIALLY DEFERRED;

CREATE TABLE Sponsor_Torneo (
    ID_Sponsor INT,
    ID_Torneo INT,
    Monto_Aporte DECIMAL(12, 2) NOT NULL,
    PRIMARY KEY (ID_Sponsor, ID_Torneo),
    FOREIGN KEY (ID_Sponsor) REFERENCES Sponsors(ID_Sponsor),
    FOREIGN KEY (ID_Torneo) REFERENCES Torneos(ID_Torneo)
);

CREATE TABLE Inscripciones (
    ID_Torneo INT,
    Nombre_Equipo VARCHAR(100),
    PRIMARY KEY (ID_Torneo, Nombre_Equipo),
    FOREIGN KEY (ID_Torneo) REFERENCES Torneos(ID_Torneo),
    FOREIGN KEY (Nombre_Equipo) REFERENCES Equipos(Nombre_Equipo)
);

CREATE TABLE Partidas (
    ID_Partida SERIAL PRIMARY KEY,
    ID_Torneo INT NOT NULL,
    Equipo_A VARCHAR(100) NOT NULL,
    Equipo_B VARCHAR(100) NOT NULL,
    Fecha_Hora TIMESTAMP NOT NULL,
    Score_A INT DEFAULT 0,
    Score_B INT DEFAULT 0,
    Fase VARCHAR(20),
    CONSTRAINT chk_fase CHECK (Fase IN ('fase de grupos', 'cuartos de final', 'semifinal', 'final')),
    CONSTRAINT chk_distintos CHECK (Equipo_A <> Equipo_B),
    FOREIGN KEY (ID_Torneo) REFERENCES Torneos(ID_Torneo),
    FOREIGN KEY (Equipo_A) REFERENCES Equipos(Nombre_Equipo),
    FOREIGN KEY (Equipo_B) REFERENCES Equipos(Nombre_Equipo)
);

CREATE TABLE Estadisticas_Jugador (
    ID_Partida INT,
    Gamertag VARCHAR(50),
    KOs INT DEFAULT 0,
    Restarts INT DEFAULT 0, 
    Assists INT DEFAULT 0,
    PRIMARY KEY (ID_Partida, Gamertag),
    FOREIGN KEY (ID_Partida) REFERENCES Partidas(ID_Partida),
    FOREIGN KEY (Gamertag) REFERENCES Jugadores(Gamertag)
);