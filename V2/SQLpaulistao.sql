CREATE DATABASE paulistao
GO
USE paulistao

GO
CREATE TABLE times(
CodigoTime					INT			NOT NULL,
NomeTime					VARCHAR(30) NOT NULL,
Cidade						VARCHAR(30)	NOT NULL,
Estadio						VARCHAR(30) NOT NULL,
MaterialEsportivo			VARCHAR(30) NOT NULL
PRIMARY KEY(CodigoTime)
)

GO
CREATE TABLE grupos(
Grupo		VARCHAR(1)	NOT NULL,
CodTime		INT			NOT NULL	UNIQUE
FOREIGN KEY(CodTime) REFERENCES times (CodigoTime)
)


	select t.NomeTime from times t INNER JOIN grupos g ON g.CodTime = t.CodigoTime
	WHERE g.Grupo = 'A'



GO
CREATE TABLE jogos(
CodTimeA	INT		NOT NULL,
CodTimeB	INT		NOT NULL,
GolsA		INT			NULL,
GolsB		INT			NULL,
DataJ		DATE		NULL
FOREIGN KEY(CodTimeA) REFERENCES times (CodigoTime),
FOREIGN KEY(CodTimeB) REFERENCES times (CodigoTime)
)




GO
INSERT INTO times VALUES
	(1, 'Água Santa', 'Diadema', 'Distrital do Inamar', 'Karilu'), 
	(2, 'Botafogo-SP', 'Riberão Preto', 'Santa Cruz', 'Volt Sport'), 
	(3, 'Corinthians', 'São Paulo', 'Neo Química Arena', 'Nike'), 
	(4, 'Ferroviária', 'Araraquara','Fonte Luminosa', 'Lupo'), 
	(5, 'Guarani', 'Campinas', 'Brinco de Ouro', 'Kappa'), 
	(6, 'Inter de Limeira', 'Limeira', 'Limerão', 'Alluri Sports'), 
	(7, 'Ituano', 'Itu', 'Novelli Júnior', 'Kanxa'), 
	(8, 'Mirassol', 'Mirassol', 'José Maria de Campos Maia', 'Super Bolla'), 
	(9, 'Novorizontino', 'Novo Horizonte', 'Jorge  Ismael de Biasi', 'Physicus'), 
	(10, 'Palmeiras', 'São Paulo', 'Allianz Parque', 'Puma'), 
	(11, 'Ponte Preta', 'Campinas', 'Moisés Lucarelli', '1900 (Marca Própria)'), 
	(12, 'Red Bull Bragantino', 'Bragança Paulista', 'Nabi Abi Chedid', 'Nike'), 
	(13, 'Santo André', 'Santo André', 'Bruno José Daniel', 'Icone Sports'), 
	(14, 'Santos', 'Santos', 'Vila Belmiro', 'Umbro'), 
	(15, 'São Bernardo', 'São Bernardo do Campo', 'Primeiro de Maio', 'Magnum Group'), 
	(16, 'São Paulo', 'São Paulo','Morumbi', 'Adidas')


SELECT * FROM times
SELECT * FROM grupos
SELECT * FROM jogos

GO
CREATE PROCEDURE timesGrandes
AS 
BEGIN 
INSERT INTO grupos 
SELECT TOP 4 SUBSTRING('ABCD', ROW_NUMBER()
		OVER (ORDER BY NEWID()), 1), times.CodigoTime
FROM times 
WHERE times.CodigoTime IN (3, 10, 14, 16)
AND times.CodigoTime NOT IN (SELECT CodigoTime FROM grupos) 
ORDER BY NEWID() 
END

GO
CREATE PROCEDURE timesPequenos
AS
BEGIN
    WITH numeros_aleatorios AS (
        SELECT ROW_NUMBER() OVER (ORDER BY NEWID()) 
        AS numero_aleatorio, CodigoTime 
        FROM times
        WHERE CodigoTime NOT IN (3, 10, 14, 16)
    ),
    numeros_grupo AS ( SELECT CodigoTime, CASE 
                WHEN numero_aleatorio IN (1, 2, 3) THEN 'A' 
                WHEN numero_aleatorio IN (4, 5, 6) THEN 'B' 
                WHEN numero_aleatorio IN (7, 8, 9) THEN 'C' 
                ELSE 'D' 
            END AS grupo
        FROM numeros_aleatorios
    )
    INSERT INTO grupos (grupo, CodTime)
    SELECT grupo, CodigoTime FROM numeros_grupo
END



GO
CREATE PROCEDURE criarJogos
AS
BEGIN
	DECLARE @count INT;
	SELECT @count = COUNT(J.CodTimeA) FROM jogos J;
	IF (@count = 0)
	BEGIN

	DECLARE @grupoRA TABLE (
	nome	VARCHAR(30),
	id		UNIQUEIDENTIFIER
	)

	INSERT INTO @grupoRA(nome, id)
	SELECT t.NomeTime, NEWID()  
	FROM times t, grupos g
	WHERE t.CodigoTime = g.CodTime
		AND g.Grupo = 'A'

	DECLARE @grupoRB TABLE (
	nome	VARCHAR(30),
	id		UNIQUEIDENTIFIER
	)

	INSERT INTO @grupoRB(nome, id)
	SELECT t.NomeTime, NEWID()  
	FROM times t, grupos g
	WHERE t.CodigoTime = g.CodTime
		AND g.Grupo = 'B'

	DECLARE @grupoRC TABLE (
	nome	VARCHAR(30),
	id		UNIQUEIDENTIFIER
	)

	INSERT INTO @grupoRC(nome, id)
	SELECT t.NomeTime, NEWID()  
	FROM times t, grupos g
	WHERE t.CodigoTime = g.CodTime
		AND g.Grupo = 'C'

	DECLARE @grupoRD TABLE (
	nome	VARCHAR(30),
	id		UNIQUEIDENTIFIER
	)

	INSERT INTO @grupoRD(nome, id)
	SELECT t.NomeTime, NEWID()  
	FROM times t, grupos g
	WHERE t.CodigoTime = g.CodTime
		AND g.Grupo = 'D'
	

	DECLARE @cont	INT,
			@cont2	INT,
			@cont3	INT
		SET @cont = 0
		WHILE(@cont < 4)
		BEGIN
			INSERT INTO jogos VALUES 

				((SELECT t.CodigoTime FROM @grupoRA a, times t  
				WHERE t.NomeTime = a.nome ORDER BY a.id
				OFFSET @cont ROW FETCH NEXT 1 ROW ONLY),

				(SELECT t.CodigoTime FROM @grupoRB b, times t  
				WHERE t.NomeTime = b.nome ORDER BY b.id
				OFFSET @cont ROW FETCH NEXT 1 ROW ONLY),
				0, 0, '29/01/2023'),


				((SELECT t.CodigoTime FROM @grupoRC c, times t  
				WHERE t.NomeTime = c.nome ORDER BY c.id
				OFFSET @cont ROW FETCH NEXT 1 ROW ONLY),

				(SELECT t.CodigoTime FROM @grupoRD d, times t  
				WHERE t.NomeTime = d.nome ORDER BY d.id
				OFFSET @cont ROW FETCH NEXT 1 ROW ONLY),
				0, 0, '29/01/2023')
			SET @cont = @cont + 1
		END


		SET @cont = 0
		WHILE(@cont < 4)
		BEGIN
			INSERT INTO jogos VALUES 

				((SELECT t.CodigoTime FROM @grupoRC c, times t  
				WHERE t.NomeTime = c.nome ORDER BY c.id
				OFFSET @cont ROW FETCH NEXT 1 ROW ONLY),

				(SELECT t.CodigoTime FROM @grupoRA a, times t  
				WHERE t.NomeTime = a.nome ORDER BY a.id
				OFFSET @cont ROW FETCH NEXT 1 ROW ONLY),
				0, 0, '01/02/2023'),


				((SELECT t.CodigoTime FROM @grupoRD d, times t  
				WHERE t.NomeTime = d.nome ORDER BY d.id
				OFFSET @cont ROW FETCH NEXT 1 ROW ONLY),

				(SELECT t.CodigoTime FROM @grupoRB b, times t  
				WHERE t.NomeTime = b.nome ORDER BY b.id
				OFFSET @cont ROW FETCH NEXT 1 ROW ONLY),
				0, 0, '01/02/2023')
			SET @cont = @cont + 1
		END


		SET @cont = 0
		WHILE(@cont < 4)
		BEGIN
			INSERT INTO jogos VALUES 

				((SELECT t.CodigoTime FROM @grupoRA a, times t  
				WHERE t.NomeTime = a.nome ORDER BY a.id
				OFFSET @cont ROW FETCH NEXT 1 ROW ONLY),

				(SELECT t.CodigoTime FROM @grupoRD d, times t  
				WHERE t.NomeTime = d.nome ORDER BY d.id
				OFFSET @cont ROW FETCH NEXT 1 ROW ONLY),
				0, 0, '05/02/2023'),


				((SELECT t.CodigoTime FROM @grupoRB b, times t  
				WHERE t.NomeTime = b.nome ORDER BY b.id
				OFFSET @cont ROW FETCH NEXT 1 ROW ONLY),

				(SELECT t.CodigoTime FROM @grupoRC c, times t  
				WHERE t.NomeTime = c.nome ORDER BY c.id
				OFFSET @cont ROW FETCH NEXT 1 ROW ONLY),
				0, 0, '05/02/2023')
			SET @cont = @cont + 1
		END


		SET @cont = 0
		SET @cont2 = 0
		WHILE(@cont < 4)
		BEGIN
			IF (@cont < 3)
				BEGIN
				INSERT INTO jogos VALUES 
						
				((SELECT t.CodigoTime FROM @grupoRA a, times t  
				WHERE t.NomeTime = a.nome ORDER BY a.id
				OFFSET @cont ROW FETCH NEXT 1 ROW ONLY),

				(SELECT t.CodigoTime FROM @grupoRB b, times t  
				WHERE t.NomeTime = b.nome ORDER BY b.id
				OFFSET @cont + 1 ROW FETCH NEXT 1 ROW ONLY),
				0, 0, '08/02/2023'),


				((SELECT t.CodigoTime FROM @grupoRC c, times t  
				WHERE t.NomeTime = c.nome ORDER BY c.id
				OFFSET @cont ROW FETCH NEXT 1 ROW ONLY),

				(SELECT t.CodigoTime FROM @grupoRD d, times t  
				WHERE t.NomeTime = d.nome ORDER BY d.id
				OFFSET @cont + 1 ROW FETCH NEXT 1 ROW ONLY),
				0, 0, '08/02/2023')
				END

			IF (@cont > 2)
				BEGIN
				INSERT INTO jogos VALUES 
						
				((SELECT t.CodigoTime FROM @grupoRA a, times t  
				WHERE t.NomeTime = a.nome ORDER BY a.id
				OFFSET @cont ROW FETCH NEXT 1 ROW ONLY),

				(SELECT t.CodigoTime FROM @grupoRB b, times t  
				WHERE t.NomeTime = b.nome ORDER BY b.id
				OFFSET @cont2 ROW FETCH NEXT 1 ROW ONLY),
				0, 0, '08/02/2023'),


				((SELECT t.CodigoTime FROM @grupoRC c, times t  
				WHERE t.NomeTime = c.nome ORDER BY c.id
				OFFSET @cont ROW FETCH NEXT 1 ROW ONLY),

				(SELECT t.CodigoTime FROM @grupoRD d, times t  
				WHERE t.NomeTime = d.nome ORDER BY d.id
				OFFSET @cont2 ROW FETCH NEXT 1 ROW ONLY),
				0, 0, '08/02/2023')
				END
			SET @cont = @cont + 1
		END


		SET @cont = 0
		SET @cont2 = 0
		WHILE(@cont < 4)
		BEGIN
			IF (@cont < 3)
				BEGIN
				INSERT INTO jogos VALUES 

				((SELECT t.CodigoTime FROM @grupoRC c, times t  
				WHERE t.NomeTime = c.nome ORDER BY c.id
				OFFSET @cont ROW FETCH NEXT 1 ROW ONLY),

				(SELECT t.CodigoTime FROM @grupoRA a, times t  
				WHERE t.NomeTime = a.nome ORDER BY a.id
				OFFSET @cont + 1 ROW FETCH NEXT 1 ROW ONLY),
				0, 0, '12/02/2023'),


				((SELECT t.CodigoTime FROM @grupoRD d, times t  
				WHERE t.NomeTime = d.nome ORDER BY d.id
				OFFSET @cont ROW FETCH NEXT 1 ROW ONLY),

				(SELECT t.CodigoTime FROM @grupoRB b, times t  
				WHERE t.NomeTime = b.nome ORDER BY b.id
				OFFSET @cont + 1 ROW FETCH NEXT 1 ROW ONLY),
				0, 0, '12/02/2023')
				END

			IF (@cont > 2)
				BEGIN
				INSERT INTO jogos VALUES 

				((SELECT t.CodigoTime FROM @grupoRC c, times t  
				WHERE t.NomeTime = c.nome ORDER BY c.id
				OFFSET @cont ROW FETCH NEXT 1 ROW ONLY),

				(SELECT t.CodigoTime FROM @grupoRA a, times t  
				WHERE t.NomeTime = a.nome ORDER BY a.id
				OFFSET @cont2 ROW FETCH NEXT 1 ROW ONLY),
				0, 0, '12/02/2023'),


				((SELECT t.CodigoTime FROM @grupoRD d, times t  
				WHERE t.NomeTime = d.nome ORDER BY d.id
				OFFSET @cont ROW FETCH NEXT 1 ROW ONLY),

				(SELECT t.CodigoTime FROM @grupoRB b, times t  
				WHERE t.NomeTime = b.nome ORDER BY b.id
				OFFSET @cont2 ROW FETCH NEXT 1 ROW ONLY),
				0, 0, '12/02/2023')
				END
			SET @cont = @cont + 1
		END


		SET @cont = 0
		SET @cont2 = 0
		WHILE(@cont < 4)
		BEGIN
			IF (@cont < 3)
				BEGIN
					INSERT INTO jogos VALUES 

				((SELECT t.CodigoTime FROM @grupoRA a, times t  
				WHERE t.NomeTime = a.nome ORDER BY a.id
				OFFSET @cont ROW FETCH NEXT 1 ROW ONLY),

				(SELECT t.CodigoTime FROM @grupoRD d, times t  
				WHERE t.NomeTime = d.nome ORDER BY d.id
				OFFSET @cont + 1 ROW FETCH NEXT 1 ROW ONLY),
				0, 0, '15/02/2023'),


				((SELECT t.CodigoTime FROM @grupoRB b, times t  
				WHERE t.NomeTime = b.nome ORDER BY b.id
				OFFSET @cont ROW FETCH NEXT 1 ROW ONLY),

				(SELECT t.CodigoTime FROM @grupoRC c, times t  
				WHERE t.NomeTime = c.nome ORDER BY c.id
				OFFSET @cont + 1 ROW FETCH NEXT 1 ROW ONLY),
				0, 0, '15/02/2023')
				END

			IF (@cont > 2)
				BEGIN
					INSERT INTO jogos VALUES 

				((SELECT t.CodigoTime FROM @grupoRA a, times t  
				WHERE t.NomeTime = a.nome ORDER BY a.id
				OFFSET @cont ROW FETCH NEXT 1 ROW ONLY),

				(SELECT t.CodigoTime FROM @grupoRD d, times t  
				WHERE t.NomeTime = d.nome ORDER BY d.id
				OFFSET @cont2 ROW FETCH NEXT 1 ROW ONLY),
				0, 0, '15/02/2023'),


				((SELECT t.CodigoTime FROM @grupoRB b, times t  
				WHERE t.NomeTime = b.nome ORDER BY b.id
				OFFSET @cont ROW FETCH NEXT 1 ROW ONLY),

				(SELECT t.CodigoTime FROM @grupoRC c, times t  
				WHERE t.NomeTime = c.nome ORDER BY c.id
				OFFSET @cont2 ROW FETCH NEXT 1 ROW ONLY),
				0, 0, '15/02/2023')
				END
			SET @cont = @cont + 1
		END


		SET @cont = 0
		SET @cont2 = 0
		SET @cont3 = 2
		WHILE(@cont < 4)
		BEGIN
			IF (@cont < 2)
				BEGIN
				INSERT INTO jogos VALUES 
						
				((SELECT t.CodigoTime FROM @grupoRA a, times t  
				WHERE t.NomeTime = a.nome ORDER BY a.id
				OFFSET @cont ROW FETCH NEXT 1 ROW ONLY),

				(SELECT t.CodigoTime FROM @grupoRB b, times t  
				WHERE t.NomeTime = b.nome ORDER BY b.id
				OFFSET @cont3 ROW FETCH NEXT 1 ROW ONLY),
				0, 0, '19/02/2023'),


				((SELECT t.CodigoTime FROM @grupoRC c, times t  
				WHERE t.NomeTime = c.nome ORDER BY c.id
				OFFSET @cont ROW FETCH NEXT 1 ROW ONLY),

				(SELECT t.CodigoTime FROM @grupoRD d, times t  
				WHERE t.NomeTime = d.nome ORDER BY d.id
				OFFSET @cont3 ROW FETCH NEXT 1 ROW ONLY),
				0, 0, '19/02/2023')
				SET @cont3 = @cont3 + 1
				END

			IF (@cont > 1)
				BEGIN
				INSERT INTO jogos VALUES 
						
				((SELECT t.CodigoTime FROM @grupoRA a, times t  
				WHERE t.NomeTime = a.nome ORDER BY a.id
				OFFSET @cont ROW FETCH NEXT 1 ROW ONLY),

				(SELECT t.CodigoTime FROM @grupoRB b, times t  
				WHERE t.NomeTime = b.nome ORDER BY b.id
				OFFSET @cont2 ROW FETCH NEXT 1 ROW ONLY),
				0, 0, '19/02/2023'),


				((SELECT t.CodigoTime FROM @grupoRC c, times t  
				WHERE t.NomeTime = c.nome ORDER BY c.id
				OFFSET @cont ROW FETCH NEXT 1 ROW ONLY),

				(SELECT t.CodigoTime FROM @grupoRD d, times t  
				WHERE t.NomeTime = d.nome ORDER BY d.id
				OFFSET @cont2 ROW FETCH NEXT 1 ROW ONLY),
				0, 0, '19/02/2023')
				SET @cont2 = @cont2 + 1
				END
			SET @cont = @cont + 1
		END


		SET @cont = 0
		SET @cont2 = 0
		SET @cont3 = 2
		WHILE(@cont < 4)
		BEGIN
			IF (@cont < 2)
				BEGIN
				INSERT INTO jogos VALUES 

				((SELECT t.CodigoTime FROM @grupoRC c, times t  
				WHERE t.NomeTime = c.nome ORDER BY c.id
				OFFSET @cont ROW FETCH NEXT 1 ROW ONLY),

				(SELECT t.CodigoTime FROM @grupoRA a, times t  
				WHERE t.NomeTime = a.nome ORDER BY a.id
				OFFSET @cont3 ROW FETCH NEXT 1 ROW ONLY),
				0, 0, '22/02/2023'),


				((SELECT t.CodigoTime FROM @grupoRD d, times t  
				WHERE t.NomeTime = d.nome ORDER BY d.id
				OFFSET @cont ROW FETCH NEXT 1 ROW ONLY),

				(SELECT t.CodigoTime FROM @grupoRB b, times t  
				WHERE t.NomeTime = b.nome ORDER BY b.id
				OFFSET @cont3 ROW FETCH NEXT 1 ROW ONLY),
				0, 0, '22/02/2023')
				SET @cont3 = @cont3 + 1
				END

			IF (@cont > 1)
				BEGIN
				INSERT INTO jogos VALUES 

				((SELECT t.CodigoTime FROM @grupoRC c, times t  
				WHERE t.NomeTime = c.nome ORDER BY c.id
				OFFSET @cont ROW FETCH NEXT 1 ROW ONLY),

				(SELECT t.CodigoTime FROM @grupoRA a, times t  
				WHERE t.NomeTime = a.nome ORDER BY a.id
				OFFSET @cont2 ROW FETCH NEXT 1 ROW ONLY),
				0, 0, '22/02/2023'),


				((SELECT t.CodigoTime FROM @grupoRD d, times t  
				WHERE t.NomeTime = d.nome ORDER BY d.id
				OFFSET @cont ROW FETCH NEXT 1 ROW ONLY),

				(SELECT t.CodigoTime FROM @grupoRB b, times t  
				WHERE t.NomeTime = b.nome ORDER BY b.id
				OFFSET @cont2 ROW FETCH NEXT 1 ROW ONLY),
				0, 0, '22/02/2023')
				SET @cont2 = @cont2 + 1
				END
			SET @cont = @cont + 1
		END


		SET @cont = 0
		SET @cont2 = 0
		SET @cont3 = 2
		WHILE(@cont < 4)
		BEGIN
			IF (@cont < 2)
				BEGIN
					INSERT INTO jogos VALUES 

				((SELECT t.CodigoTime FROM @grupoRA a, times t  
				WHERE t.NomeTime = a.nome ORDER BY a.id
				OFFSET @cont ROW FETCH NEXT 1 ROW ONLY),

				(SELECT t.CodigoTime FROM @grupoRD d, times t  
				WHERE t.NomeTime = d.nome ORDER BY d.id
				OFFSET @cont3 ROW FETCH NEXT 1 ROW ONLY),
				0, 0, '26/02/2023'),


				((SELECT t.CodigoTime FROM @grupoRB b, times t  
				WHERE t.NomeTime = b.nome ORDER BY b.id
				OFFSET @cont ROW FETCH NEXT 1 ROW ONLY),

				(SELECT t.CodigoTime FROM @grupoRC c, times t  
				WHERE t.NomeTime = c.nome ORDER BY c.id
				OFFSET @cont3 ROW FETCH NEXT 1 ROW ONLY),
				0, 0, '26/02/2023')
				SET @cont3 = @cont3 + 1
				END

			IF (@cont > 1)
				BEGIN
					INSERT INTO jogos VALUES 

				((SELECT t.CodigoTime FROM @grupoRA a, times t  
				WHERE t.NomeTime = a.nome ORDER BY a.id
				OFFSET @cont ROW FETCH NEXT 1 ROW ONLY),

				(SELECT t.CodigoTime FROM @grupoRD d, times t  
				WHERE t.NomeTime = d.nome ORDER BY d.id
				OFFSET @cont2 ROW FETCH NEXT 1 ROW ONLY),
				0, 0, '26/02/2023'),


				((SELECT t.CodigoTime FROM @grupoRB b, times t  
				WHERE t.NomeTime = b.nome ORDER BY b.id
				OFFSET @cont ROW FETCH NEXT 1 ROW ONLY),

				(SELECT t.CodigoTime FROM @grupoRC c, times t  
				WHERE t.NomeTime = c.nome ORDER BY c.id
				OFFSET @cont2 ROW FETCH NEXT 1 ROW ONLY),
				0, 0, '26/02/2023')
				SET @cont2 = @cont2 + 1
				END
			SET @cont = @cont + 1
		END


		SET @cont = 0
		SET @cont2 = 0
		SET @cont3 = 3
		WHILE(@cont < 4)
		BEGIN
			IF (@cont < 1)
				BEGIN
				INSERT INTO jogos VALUES 
						
				((SELECT t.CodigoTime FROM @grupoRA a, times t  
				WHERE t.NomeTime = a.nome ORDER BY a.id
				OFFSET @cont ROW FETCH NEXT 1 ROW ONLY),

				(SELECT t.CodigoTime FROM @grupoRB b, times t  
				WHERE t.NomeTime = b.nome ORDER BY b.id
				OFFSET @cont3 ROW FETCH NEXT 1 ROW ONLY),
				0, 0, '01/03/2023'),


				((SELECT t.CodigoTime FROM @grupoRC c, times t  
				WHERE t.NomeTime = c.nome ORDER BY c.id
				OFFSET @cont ROW FETCH NEXT 1 ROW ONLY),

				(SELECT t.CodigoTime FROM @grupoRD d, times t  
				WHERE t.NomeTime = d.nome ORDER BY d.id
				OFFSET @cont3 ROW FETCH NEXT 1 ROW ONLY),
				0, 0, '01/03/2023')
				END

			IF (@cont > 0)
				BEGIN
				INSERT INTO jogos VALUES 
						
				((SELECT t.CodigoTime FROM @grupoRA a, times t  
				WHERE t.NomeTime = a.nome ORDER BY a.id
				OFFSET @cont ROW FETCH NEXT 1 ROW ONLY),

				(SELECT t.CodigoTime FROM @grupoRB b, times t  
				WHERE t.NomeTime = b.nome ORDER BY b.id
				OFFSET @cont2 ROW FETCH NEXT 1 ROW ONLY),
				0, 0, '01/03/2023'),


				((SELECT t.CodigoTime FROM @grupoRC c, times t  
				WHERE t.NomeTime = c.nome ORDER BY c.id
				OFFSET @cont ROW FETCH NEXT 1 ROW ONLY),

				(SELECT t.CodigoTime FROM @grupoRD d, times t  
				WHERE t.NomeTime = d.nome ORDER BY d.id
				OFFSET @cont2 ROW FETCH NEXT 1 ROW ONLY),
				0, 0, '01/03/2023')
				SET @cont2 = @cont2 + 1
				END
			SET @cont = @cont + 1
		END


		SET @cont = 0
		SET @cont2 = 0
		SET @cont3 = 3
		WHILE(@cont < 4)
		BEGIN
			IF (@cont < 1)
				BEGIN
				INSERT INTO jogos VALUES 

				((SELECT t.CodigoTime FROM @grupoRC c, times t  
				WHERE t.NomeTime = c.nome ORDER BY c.id
				OFFSET @cont ROW FETCH NEXT 1 ROW ONLY),

				(SELECT t.CodigoTime FROM @grupoRA a, times t  
				WHERE t.NomeTime = a.nome ORDER BY a.id
				OFFSET @cont3 ROW FETCH NEXT 1 ROW ONLY),
				0, 0, '05/03/2023'),


				((SELECT t.CodigoTime FROM @grupoRD d, times t  
				WHERE t.NomeTime = d.nome ORDER BY d.id
				OFFSET @cont ROW FETCH NEXT 1 ROW ONLY),

				(SELECT t.CodigoTime FROM @grupoRB b, times t  
				WHERE t.NomeTime = b.nome ORDER BY b.id
				OFFSET @cont3 ROW FETCH NEXT 1 ROW ONLY),
				0, 0, '05/03/2023')
				END

			IF (@cont > 0)
				BEGIN
				INSERT INTO jogos VALUES 

				((SELECT t.CodigoTime FROM @grupoRC c, times t  
				WHERE t.NomeTime = c.nome ORDER BY c.id
				OFFSET @cont ROW FETCH NEXT 1 ROW ONLY),

				(SELECT t.CodigoTime FROM @grupoRA a, times t  
				WHERE t.NomeTime = a.nome ORDER BY a.id
				OFFSET @cont2 ROW FETCH NEXT 1 ROW ONLY),
				0, 0, '05/03/2023'),


				((SELECT t.CodigoTime FROM @grupoRD d, times t  
				WHERE t.NomeTime = d.nome ORDER BY d.id
				OFFSET @cont ROW FETCH NEXT 1 ROW ONLY),

				(SELECT t.CodigoTime FROM @grupoRB b, times t  
				WHERE t.NomeTime = b.nome ORDER BY b.id
				OFFSET @cont2 ROW FETCH NEXT 1 ROW ONLY),
				0, 0, '05/03/2023')
				SET @cont2 = @cont2 + 1
				END
			SET @cont = @cont + 1
		END


		SET @cont = 0
		SET @cont2 = 0
		SET @cont3 = 3
		WHILE(@cont < 4)
		BEGIN
			IF (@cont < 1)
				BEGIN
					INSERT INTO jogos VALUES 

				((SELECT t.CodigoTime FROM @grupoRA a, times t  
				WHERE t.NomeTime = a.nome ORDER BY a.id
				OFFSET @cont ROW FETCH NEXT 1 ROW ONLY),

				(SELECT t.CodigoTime FROM @grupoRD d, times t  
				WHERE t.NomeTime = d.nome ORDER BY d.id
				OFFSET @cont3 ROW FETCH NEXT 1 ROW ONLY),
				0, 0, '08/03/2023'),


				((SELECT t.CodigoTime FROM @grupoRB b, times t  
				WHERE t.NomeTime = b.nome ORDER BY b.id
				OFFSET @cont ROW FETCH NEXT 1 ROW ONLY),

				(SELECT t.CodigoTime FROM @grupoRC c, times t  
				WHERE t.NomeTime = c.nome ORDER BY c.id
				OFFSET @cont3 ROW FETCH NEXT 1 ROW ONLY),
				0, 0, '08/03/2023')
				END

			IF (@cont > 0)
				BEGIN
					INSERT INTO jogos VALUES 

				((SELECT t.CodigoTime FROM @grupoRA a, times t  
				WHERE t.NomeTime = a.nome ORDER BY a.id
				OFFSET @cont ROW FETCH NEXT 1 ROW ONLY),

				(SELECT t.CodigoTime FROM @grupoRD d, times t  
				WHERE t.NomeTime = d.nome ORDER BY d.id
				OFFSET @cont2 ROW FETCH NEXT 1 ROW ONLY),
				0, 0, '08/03/2023'),


				((SELECT t.CodigoTime FROM @grupoRB b, times t  
				WHERE t.NomeTime = b.nome ORDER BY b.id
				OFFSET @cont ROW FETCH NEXT 1 ROW ONLY),

				(SELECT t.CodigoTime FROM @grupoRC c, times t  
				WHERE t.NomeTime = c.nome ORDER BY c.id
				OFFSET @cont2 ROW FETCH NEXT 1 ROW ONLY),
				0, 0, '08/03/2023')
				SET @cont2 = @cont2 + 1
				END
			SET @cont = @cont + 1
		END
	END
	END



	GO
	CREATE PROCEDURE p_alterarGols 
		(@nometimeA VARCHAR(20), @nometimeB VARCHAR(20), @golstimeA INT, @golstimeB INT, @datajogo DATE) 
	AS
	BEGIN

		DECLARE @codigotimeA INT,
				@codigotimeB INT
			SET @codigotimeA = (SELECT t.CodigoTime FROM times t WHERE t.NomeTime LIKE @nometimeA)
			SET @codigotimeB = (SELECT t.CodigoTime FROM times t WHERE t.NomeTime LIKE @nometimeB)

			 UPDATE jogos
			 SET GolsA = @golstimeA,
				 GolsB = @golstimeB
			 WHERE CodTimeA = @codigotimeA
			   AND CodTimeB = @codigotimeB
	END

	EXEC p_alterarGols 'ferroviária', 'Palmeiras', 1, 2, '01/02/2023'

SELECT * FROM jogos








DECLARE @TO INT
SELECT * FROM dbo.f_jogoinfo ('ferroviária')
PRINT (dbo.f_jogoinfo ('ferroviária'))




GO
CREATE FUNCTION f_jogoinfo (@nomeTime VARCHAR(20))
RETURNS @jogoinfo TABLE (nome VARCHAR(20), numJogo INT, vit INT, derr INT, emp INT, marcados INT, sofridos INT, saldo INT)
AS
BEGIN
	DECLARE @njogo INT,
			@vjogo INT,
			@djogo INT,
			@ejogo INT,
			@goM INT,
			@goS INT,
			@saldo INT


	SET @vjogo = dbo.f_vitorias (@nomeTime)
	SET @djogo = dbo.f_derrotas (@nomeTime)
	SET @ejogo = dbo.f_empates (@nomeTime)

	SET @njogo = @vjogo + @djogo +@ejogo

	SET @goM = dbo.f_gols_marcados (@nomeTime)
	SET @goS = dbo.f_gols_sofridos (@nomeTime)
	SET @saldo = dbo.f_gols_saldo (@nomeTime)

	INSERT INTO @jogoinfo VALUES (@nomeTime, @njogo, @vjogo, @djogo, @ejogo, @goM, @goS, @saldo)
		

/*
	UPDATE @jogoinfo
	SET nome = @nomeTime,
	numJogo = @njogo,
	vit = @vjogo,
	derr = @djogo,
	emp = @ejogo,
	marcados = @goM,
	sofridos = @goS,
	saldo = @saldo
|*/
	RETURN
END







GO
CREATE FUNCTION f_vitorias (@nomeTime VARCHAR(20))
RETURNS INT
AS
BEGIN
	DECLARE @TOTV INT
	SET @TOTV = (SELECT count(j.DataJ) As vitorias FROM times t inner join jogos j ON t.CodigoTime = j.CodTimeA	
				INNER JOIN times tb ON tb.CodigoTime = j.CodTimeB
				WHERE (t.NomeTime like @nomeTime and j.GolsA > j.GolsB)
				OR (tb.NomeTime like @nomeTime and j.GolsB > j.GolsA))
	RETURN @TOTV
END

GO
CREATE FUNCTION f_derrotas (@nomeTime VARCHAR(20))
RETURNS INT
AS
BEGIN
	DECLARE @TOTV INT
	SET @TOTV = (SELECT count(j.DataJ) As vitorias FROM times t inner join jogos j ON t.CodigoTime = j.CodTimeA	
				INNER JOIN times tb ON tb.CodigoTime = j.CodTimeB
				WHERE (t.NomeTime like @nomeTime and j.GolsA < j.GolsB)
				OR (tb.NomeTime like @nomeTime and j.GolsB < j.GolsA))
	RETURN @TOTV
END

GO
CREATE FUNCTION f_empates (@nomeTime VARCHAR(20))
RETURNS INT
AS
BEGIN
	DECLARE @TOTV INT
	SET @TOTV = (SELECT count(j.DataJ) As vitorias FROM times t inner join jogos j ON t.CodigoTime = j.CodTimeA	
				INNER JOIN times tb ON tb.CodigoTime = j.CodTimeB
				WHERE (t.NomeTime like @nomeTime and j.GolsA = j.GolsB)
				OR (tb.NomeTime like @nomeTime and j.GolsB = j.GolsA))
	RETURN @TOTV
END



GO
CREATE FUNCTION f_gols_marcados (@nomeTime VARCHAR(20))
RETURNS INT
AS
BEGIN
	DECLARE @TOTV INT
	SET @TOTV = (SELECT SUM(j.GolsA) As vitorias FROM times t inner join jogos j ON t.CodigoTime = j.CodTimeA	
				WHERE (t.NomeTime like @nomeTime))

	SET @TOTV = @TOTV + (SELECT SUM(j.GolsB) As vitorias FROM times t inner join jogos j ON t.CodigoTime = j.CodTimeB	
				WHERE (t.NomeTime like @nomeTime))
	RETURN @TOTV
END

GO
CREATE FUNCTION f_gols_sofridos (@nomeTime VARCHAR(20))
RETURNS INT
AS
BEGIN
	DECLARE @TOTV INT
	SET @TOTV = (SELECT SUM(j.GolsB) As vitorias FROM times t inner join jogos j ON t.CodigoTime = j.CodTimeA	
				WHERE (t.NomeTime like @nomeTime))

	SET @TOTV = @TOTV + (SELECT SUM(j.GolsA) As vitorias FROM times t inner join jogos j ON t.CodigoTime = j.CodTimeB	
				WHERE (t.NomeTime like @nomeTime))
	RETURN @TOTV
END


GO
CREATE FUNCTION f_gols_saldo (@nomeTime VARCHAR(20))
RETURNS INT
AS
BEGIN
	DECLARE @TOTV INT,
			@TOTD INT,
			@TOT  INT

	SET @TOTV = (SELECT SUM(j.GolsA) As vitorias FROM times t inner join jogos j ON t.CodigoTime = j.CodTimeA	
				WHERE (t.NomeTime like @nomeTime))

	SET @TOTV = @TOTV + (SELECT SUM(j.GolsB) As vitorias FROM times t inner join jogos j ON t.CodigoTime = j.CodTimeB	
				WHERE (t.NomeTime like @nomeTime))

	SET @TOTD = (SELECT SUM(j.GolsB) As vitorias FROM times t inner join jogos j ON t.CodigoTime = j.CodTimeA	
				WHERE (t.NomeTime like @nomeTime))

	SET @TOTD = @TOTD + (SELECT SUM(j.GolsA) As vitorias FROM times t inner join jogos j ON t.CodigoTime = j.CodTimeB	
				WHERE (t.NomeTime like @nomeTime))

	SET @TOT = @TOTV - @TOTD

	RETURN @TOT
END





------------------------------------------------------------------------------------------------------

CREATE TRIGGER t_time ON times
FOR UPDATE, INSERT, DELETE
AS
BEGIN
	ROLLBACK TRANSACTION
	RAISERROR('NÃO PODE INSERIR, ALTERAR OU DELETAR TIMES', 16, 1)
END

--			TESTES DO TRIGGER DO TIMES

INSERT INTO times VALUES
(20, 'Água Santaa', 'Diademaa', 'Distrital do Inamara', 'Kariluu')

UPDATE times
SET Cidade = 'A'
WHERE CodigoTime = 1

DELETE times 
WHERE CodigoTime = 1

------------------------------------------------------------------------------------------------------

GO
CREATE TRIGGER t_grupos ON grupos
FOR UPDATE, INSERT, DELETE
AS
BEGIN
	ROLLBACK TRANSACTION
	RAISERROR('NÃO PODE INSERIR, ALTERAR OU DELETAR GRUPOS', 16, 1)
END

--			TESTES DO TRIGGER DO GRUPOS

INSERT INTO grupos VALUES
('C', 20)

UPDATE grupos
SET Grupo = 'A'
WHERE Grupo = 'B'

DELETE grupos 
WHERE Grupo = 'A'

-----------------------------------------------------------------------------------------

GO
CREATE TRIGGER t_jogos ON jogos
FOR INSERT, DELETE
AS
BEGIN
	ROLLBACK TRANSACTION
	RAISERROR('NÃO PODE INSERIR OU DELETAR JOGOS', 16, 1)
END

--			TESTES DO TRIGGER DO JOGOS

INSERT INTO jogos VALUES
(1, 2, 3, 4, '05/03/2023')

DELETE jogos
WHERE DataJ = '05/03/2023'