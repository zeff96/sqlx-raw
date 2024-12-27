-- All animals whose names end with mon;

SELECT name, date_of_birth, escape_attempts, neutered, weight_kg
FROM animals
WHERE name LIKE '%mon';

-- All animals born between 2016 and 2019

SELECT name
FROM animals
WHERE EXTRACT(YEAR FROM date_of_birth) BETWEEN 2016 AND 2019;

-- List animals that are neutered and have less than 3 escape attempts

SELECT name
FROM animals
WHERE neutered = true AND escape_attempts < 3;

-- Date of birth of animals named either Agumon or Pikachu

SELECT date_of_birth
FROM animals
WHERE name IN('Agumon', 'Pikachu');

-- List name and escape attempts of animals that weigh more than 10.5 kg

SELECT name, escape_attempts
FROM animals
WHERE weight_kg > 10.5;

-- All animals that are neutered

SELECT name, date_of_birth, escape_attempts, neutered, weight_kg
FROM animals
WHERE neutered = true;

-- All animals not named Gabumon

SELECT name, date_of_birth, escape_attempts, neutered, weight_kg
FROM animals
WHERE name != 'Gabumon';

-- All animals with weight between 10.4 and 17.3

SELECT name, date_of_birth, escape_attempts, neutered, weight_kg
FROM animals
WHERE weight_kg BETWEEN 10.4 AND 17.3;

-- inside transaction update species to unspecified then rollback

BEGIN TRANSACTION;
UPDATE animals
SET species = 'unspecified';

-- verify changes
SELECT name, date_of_birth, escape_attempts, neutered, weight_kg, species
FROM animals;

ROLLBACK;

--verify changes were undone

SELECT name, date_of_birth, escape_attempts, neutered, weight_kg, species
FROM animals;

-- Update species inside transaction

BEGIN TRANSACTION;
UPDATE animals
SET species = 'digimon'
WHERE name LIKE '%mon';

UPDATE animals
SET species = 'pokemon'
WHERE species IS NULL;

-- verify changes
SELECT name, date_of_birth, escape_attempts, neutered, weight_kg, species
FROM animals;

COMMIT;

-- verify changes persisted
SELECT name, date_of_birth, escape_attempts, neutered, weight_kg, species
FROM animals;

-- delete all records inside a transaction
BEGIN TRANSACTION;
DELETE FROM animals;

-- veriy changes
SELECT name, date_of_birth, escape_attempts, neutered, weight_kg, species
FROM animals;

ROLLBACK;

-- verify changes
SELECT name, date_of_birth, escape_attempts, neutered, weight_kg, species
FROM animals;

-- inside transction

BEGIN TRANSACTION;
DELETE FROM animals
WHERE EXTRACT(YEAR FROM date_of_birth) > 2022;

SAVEPOINT SP1;
UPDATE animals
SET weight_kg = weight_kg * -1;

ROLLBACK TO SP1;

UPDATE animals
SET weight_kg = weight_kg * -1
WHERE weight_kg < 0;

COMMIT;

-- verify changes
SELECT name, date_of_birth, escape_attempts, neutered, weight_kg, species
FROM animals;

-- How many animals are they

SELECT COUNT(*) AS total_animals
FROM animals;

-- How many animals have never tried to escape

SELECT COUNT(escape_attempts) AS never_escaped
FROM animals
WHERE escape_attempts = 0;

-- Average weight of animals

SELECT AVG(weight_kg) AS average_weight
FROM animals;

-- animal with most escape attempts

SELECT name, escape_attempts
FROM animals
WHERE escape_attempts = (SELECT MAX(escape_attempts) FROM animals);

-- min and max weight of each type of animal

SELECT species, MIN(weight_kg) AS min_weight, MAX(weight_kg) AS max_weight
FROM animals
GROUP BY species;

-- avg escape attempts of animals born between 1990 and 2000

SELECT AVG(escape_attempts) AS average_escape_attempts
FROM animals
WHERE EXTRACT(YEAR FROM date_of_birth) BETWEEN 1990 AND 2000;