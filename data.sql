INSERT INTO animals(name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES
    ('Agumon', TO_DATE('Feb 3, 2020', 'Mon DD, YYYY'), 0, true, 10.23),
    ('Gabumon', TO_DATE('Nov 15, 2018', 'Mon DD, YYYY'), 2, true, 8),
    ('Pikachu', TO_DATE('Jan 7, 2021', 'Mon DD, YYYY'), 1, false, 15.04),
    ('Devimon', TO_DATE('May 12, 2017', 'Mon DD, YYYY'), 5, true, 11);

-- Add new data to animals table

INSERT INTO animals(name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES
    ('Charmander', TO_DATE('Feb 8, 2020', 'Mon DD, YYYY'), 0, false, -11),
    ('Plantmon', TO_DATE('Nov 15, 2021', 'Mon DD, YYYY'), 2, true, -5.7),
    ('Squirtle', TO_DATE('Apr 2, 1993', 'Mon DD, YYYY'), 3, false, -12.13),
    ('Angemon', TO_DATE('Jun 12, 2005', 'Mon DD, YYYY'), 1, true, -45),
    ('Boarmon', TO_DATE('Jun 7, 2005', 'Mon DD, YYYY'), 7, true, 20.4),
    ('Blossom', TO_DATE('Oct 13, 1998', 'Mon DD, YYYY'), 3, true, 17),
    ('Ditto', TO_DATE('May 14, 2022', 'Mon DD, YYYY'), 4, true, 22);


-- Add data to owners table
INSERT INTO owners(full_name, age)
VALUES
    ('Sam Smith', 34),
    ('Jennifer Orwell', 19),
    ('Bob', 45),
    ('Melody Pond', 77),
    ('Dean Winchester', 14),
    ('Jodie Whittaker', 38);

-- Add data to species table
INSERT INTO species(name)
VALUES
    ('Pokemon'),
    ('Digimon');

-- Add species_id to animals table
UPDATE animals
SET species_id =
    CASE
        WHEN name LIKE '%mon' THEN (SELECT id FROM species WHERE name = 'Digimon')
        WHEN species_id IS NULL THEN (SELECT id FROM species WHERE name = 'Pokemon')
        ELSE species_id
    END;

UPDATE animals
SET owner_id = 
    CASE
        WHEN name = 'Agumon' THEN (SELECT id FROM owners WHERE full_name = 'Sam Smith')
        WHEN name IN('Gabumon', 'Pikachu') THEN (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell')
        WHEN name IN('Devimon', 'Plantmon') THEN (SELECT id FROM owners WHERE full_name = 'Bob')
        WHEN name IN('Charmander', 'Squirtle', 'Blossom') THEN (SELECT id FROM owners WHERE full_name = 'Melody Pond')
        WHEN name IN('Angemon', 'Boarmon') THEN (SELECT id FROM owners WHERE full_name = 'Dean Winchester')
        ELSE owner_id
    END;