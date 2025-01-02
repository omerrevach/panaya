CREATE DATABASE IF NOT EXISTS panaya;

USE panaya;

CREATE TABLE employees (
    id INT AUTO_INCREMENT,
    name varchar(30),
    role varchar(30),
    PRIMARY KEY (id)
);

INSERT INTO employees (name, role)
VALUES ('Omer Revach', 'SRE'),
       ('Cristiano Ronaldo', 'Developer'),
       ('Barak Obama', 'CEO');

-- this grants omer user with only SELECT privileges for the employee table
GRANT SELECT ON panaya.employees TO 'omer'@'%';
-- flush privileges makes so users permissions takes effect now
FLUSH PRIVILEGES;