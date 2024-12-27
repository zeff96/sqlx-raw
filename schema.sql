CREATE TABLE IF NOT EXISTS animals(
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    date_of_birth DATE NOT NULL,
    escape_attempts INT,
    neutered BOOLEAN,
    weight_kg DECIMAL
);

-- Add new column species to animals table

ALTER TABLE animals 
ADD COLUMN IF NOT EXISTS species VARCHAR(255);

-- Add owners table

CREATE TABLE IF NOT EXISTS owners(
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    full_name VARCHAR(255),
    age INT
);

-- Add species table

CREATE TABLE IF NOT EXISTS species(
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(255)
);

-- Remove species column from animals table

ALTER TABLE animals
DROP COLUMN species;

ALTER TABLE animals
ADD COLUMN IF NOT EXISTS species_id INT;

ALTER TABLE animals
ADD CONSTRAINT fk_species FOREIGN KEY(species_id) REFERENCES species(id);


ALTER TABLE animals
ADD COLUMN IF NOT EXISTS owner_id INT;

ALTER TABLE animals
ADD CONSTRAINT fk_owner FOREIGN KEY(owner_id) REFERENCES owners(id);