use BleedrReviewedV3
go

CREATE TABLE Adresa
(
	Id INT PRIMARY KEY IDENTITY(1,1),
	Judet NVARCHAR(30) NOT NULL,
	Oras NVARCHAR(30) NOT NULL,
	Strada NVARCHAR(30) NOT NULL,
	Numarul INT NOT NULL,
	CodPostal INT NOT NULL
);


CREATE TABLE InstitutieAsociata
(
	Id INT PRIMARY KEY IDENTITY(1,1),
	Adresa INT FOREIGN KEY REFERENCES Adresa(Id),
	TipInstitutie NVARCHAR(30) NOT NULL,
	Nume NVARCHAR(30) NOT NULL,
	NumarTelefon NVARCHAR(15) NOT NULL,
	Email NVARCHAR(30) NOT NULL
);

CREATE TABLE Utilizator
(
	Id INT PRIMARY KEY IDENTITY(1,1),
	UserName NVARCHAR(30) NOT NULL,
	Password NVARCHAR(30) NOT NULL,
	TipUtilizator NVARCHAR(30) NOT NULL,
	InstitutieAsociata INT FOREIGN KEY REFERENCES InstitutieAsociata(Id)
);


CREATE TABLE Medic
(
	Id INT PRIMARY KEY IDENTITY(1,1),
	IdUtilizator INT FOREIGN KEY REFERENCES Utilizator(Id),
	Nume NVARCHAR(30) NOT NULL,
	Prenume NVARCHAR(30) NOT NULL,
	IdentificatorMedic NVARCHAR(30) NOT NULL
);

CREATE TABLE GrupaDeSange
(
	Id INT PRIMARY KEY IDENTITY(1,1),
	Nume NVARCHAR(10) NOT NULL
);

CREATE TABLE Pacient
(
	Id INT PRIMARY KEY IDENTITY(1,1),
	Nume NVARCHAR(30) NOT NULL,
	Prenume NVARCHAR(30) NOT NULL,
	DataNastere DATETIME NOT NULL,
	GrupaDeSange INT FOREIGN KEY REFERENCES GrupaDeSange(Id),
	InstitutieAsociata INT FOREIGN KEY REFERENCES InstitutieAsociata(Id)
);

CREATE TABLE Donator
(
	Id INT PRIMARY KEY IDENTITY(1,1),
	IdUtilizator INT FOREIGN KEY REFERENCES Utilizator(Id),
	Nume NVARCHAR(30) NOT NULL,
	Prenume NVARCHAR(30) NOT NULL,
	DataDonarePosibila DATETIME NOT NULL,
	GrupaDeSange INT FOREIGN KEY REFERENCES GrupaDeSange(Id)
);

CREATE TABLE Donatie
(
	Id INT PRIMARY KEY IDENTITY(1,1),
	IdDonator INT FOREIGN KEY REFERENCES Donator(id),
	EtapaDonare NVARCHAR(30) NOT NULL,
	MotivRefuz NVARCHAR(1024)
);

CREATE TABLE AnuntDonator
(
	Id INT PRIMARY KEY IDENTITY(1,1),
	IdDonator INT FOREIGN KEY REFERENCES Donator(Id),
	TipAnuntDonator NVARCHAR(20) NOT NULL,
	Mesaj NVARCHAR(1024) NOT NULL,
	DataAnunt DATETIME NOT NULL
);

CREATE TABLE Personal
(
	Id INT PRIMARY KEY IDENTITY(1,1),
	IdUtilizator INT FOREIGN KEY REFERENCES Utilizator(Id),
	Nume NVARCHAR(30) NOT NULL,
	Prenume NVARCHAR(30) NOT NULL

);

CREATE TABLE CerereMedicPacient
(
	Id INT PRIMARY KEY IDENTITY(1,1),
	IdPacient INT FOREIGN KEY REFERENCES Pacient(Id),
	IdMedic INT FOREIGN KEY REFERENCES Medic(id),
	GrupaDeSange INT FOREIGN KEY REFERENCES GrupaDeSange(Id),
	TipComponenta NVARCHAR(10) NOT NULL,
	/* Added Later */
	Stare NVARCHAR(30) NOT NULL,
	DataDepunere DATETIME NOT NULL,
	DataServire DATETIME NOT NULL,
);

CREATE TABLE Componenta
(
	Id INT PRIMARY KEY IDENTITY(1,1),
	TipComponenta NVARCHAR(10) NOT NULL,
	IdDonatie INT FOREIGN KEY REFERENCES Donatie(id) NOT NULL,
	DataDepunere DATETIME NOT NULL,
	IdPrimitor INT FOREIGN KEY REFERENCES Pacient(id),
	InstitutieAsociata INT FOREIGN KEY REFERENCES InstitutieAsociata(Id),
	GrupaDeSange INT FOREIGN KEY REFERENCES GrupaDeSange(Id),
	/* Added Later */
	DataDonare DATETIME NOT NULL,
	Stare NVARCHAR(30) NOT NULL
);
