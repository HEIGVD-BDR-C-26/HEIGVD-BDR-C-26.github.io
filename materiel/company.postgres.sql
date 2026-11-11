DROP SCHEMA IF EXISTS company CASCADE;
CREATE SCHEMA company;
SET SEARCH_PATH TO company;

CREATE TABLE employee (
   first_name     VARCHAR(15) NOT NULL,
   middle_initial CHAR(1),
   last_name      VARCHAR(15) NOT NULL,
   ssn            CHAR(9)     NOT NULL,
   birth_date     DATE,
   address        VARCHAR(30),
   sex            CHAR(1),
   salary         DECIMAL(10, 2),
   supervisor_ssn CHAR(9),
   department_number INTEGER  NOT NULL,
   PRIMARY KEY (ssn)
);
CREATE TABLE department (
   name               VARCHAR(15) NOT NULL,
   number             INTEGER     NOT NULL,
   manager_ssn        CHAR(9)     NOT NULL,
   manager_start_date DATE        NOT NULL,
   PRIMARY KEY (number)
);
CREATE TABLE department_location (
   department_number INTEGER NOT NULL,
   location_number   INTEGER NOT NULL,
   PRIMARY KEY (department_number, location_number)
);
CREATE TABLE project (
   name              VARCHAR(15) NOT NULL,
   number            INTEGER     NOT NULL,
   location_number   INTEGER,
   department_number INTEGER     NOT NULL,
   PRIMARY KEY (number)
);
CREATE TABLE works_on (
   employee_ssn   CHAR(9)       NOT NULL,
   project_number INTEGER       NOT NULL,
   hours          DECIMAL(3, 1) NOT NULL,
   PRIMARY KEY (employee_ssn, project_number)
);
CREATE TABLE dependent (
   employee_ssn CHAR(9)     NOT NULL,
   name         VARCHAR(15) NOT NULL,
   sex          CHAR(1),
   birth_date   DATE,
   PRIMARY KEY (employee_ssn, name)
);
CREATE TABLE location (
   number INTEGER     NOT NULL,
   name   VARCHAR(15) NOT NULL,
   PRIMARY KEY (number)
);
-- department inserts
INSERT INTO department
VALUES ('Headquarters', 1, '888665555', '1981-06-19');
INSERT INTO department
VALUES ('Administration', 4, '987654321', '1995-01-01');
INSERT INTO department
VALUES ('Research', 5, '333445555', '1988-05-22');

-- dependent inserts
INSERT INTO dependent
VALUES ('123456789', 'Alice', 'F', '1988-12-30');
INSERT INTO dependent
VALUES ('123456789', 'Elizabeth', 'F', '1967-05-05');
INSERT INTO dependent
VALUES ('123456789', 'Michael', 'M', '1988-01-04');
INSERT INTO dependent
VALUES ('333445555', 'Alice', 'F', '1986-04-04');
INSERT INTO dependent
VALUES ('333445555', 'Joy', 'F', '1958-05-03');
INSERT INTO dependent
VALUES ('333445555', 'Theodore', 'M', '1983-10-25');
INSERT INTO dependent
VALUES ('987654321', 'Abner', 'M', '1942-02-28');

-- dept_locations inserts
INSERT INTO department_location
VALUES (1, 1);
INSERT INTO department_location
VALUES (4, 2);
INSERT INTO department_location
VALUES (5, 3);
INSERT INTO department_location
VALUES (5, 1);
INSERT INTO department_location
VALUES (5, 4);

-- employee inserts
INSERT INTO employee
VALUES ('John', 'B', 'Smith', '123456789', '1965-01-09', '731 Fondren, Houston, TX', 'M', 30000.00, '333445555', 5);
INSERT INTO employee
VALUES ('Franklin', 'T', 'Wong', '333445555', '1965-12-08', '638 Voss, Houston, TX', 'M', 40000.00, '888665555', 5);
INSERT INTO employee
VALUES ('Joyce', 'A', 'English', '453453453', '1972-07-31', '5631 Rice, Houston, TX', 'F', 25000.00, '333445555', 5);
INSERT INTO employee
VALUES ('Ramesh', 'K', 'Narayan', '666884444', '1962-09-15', '975 Fire Oak, Humble, TX', 'M', 38000.00, '333445555', 5);
INSERT INTO employee
VALUES ('James', 'E', 'Borg', '888665555', '1937-11-10', '450 Stone, Houston TX', 'M', 55000.00, NULL, 1);
INSERT INTO employee
VALUES ('Jennifer', 'S', 'Wallace', '987654321', '1941-06-20', '291 Berry, Bellaire, TX', 'F', 43000.00, '888665555',
        4);
INSERT INTO employee
VALUES ('Ahmad', 'V', 'Jabbar', '987987987', '1969-03-29', '980 Dallas, Houston TX', 'M', 25000.00, '987654321', 4);
INSERT INTO employee
VALUES ('Alicia', 'J', 'Zelaya', '999887777', '1968-01-19', '3321 Castle, Spring, TX', 'F', 25000.00, '987654321', 4);

-- project inserts
INSERT INTO project
VALUES ('ProductX', 1, 3, 5);
INSERT INTO project
VALUES ('ProductY', 2, 4, 5);
INSERT INTO project
VALUES ('ProductZ', 3, 1, 5);
INSERT INTO project
VALUES ('Computerization', 10, 2, 4);
INSERT INTO project
VALUES ('Reorganization', 20, 1, 1);
INSERT INTO project
VALUES ('Newbenefits', 30, 2, 4);

-- works_on inserts
INSERT INTO works_on
VALUES ('123456789', 1, 32.5);
INSERT INTO works_on
VALUES ('123456789', 2, 7.5);
INSERT INTO works_on
VALUES ('333445555', 2, 10.0);
INSERT INTO works_on
VALUES ('333445555', 3, 10.0);
INSERT INTO works_on
VALUES ('333445555', 10, 10.0);
INSERT INTO works_on
VALUES ('333445555', 20, 10.0);
INSERT INTO works_on
VALUES ('453453453', 1, 20.0);
INSERT INTO works_on
VALUES ('453453453', 2, 20.0);
INSERT INTO works_on
VALUES ('666884444', 3, 40.0);
INSERT INTO works_on
VALUES ('888665555', 20, 0.0);
INSERT INTO works_on
VALUES ('987654321', 20, 15.0);
INSERT INTO works_on
VALUES ('987654321', 30, 20.0);
INSERT INTO works_on
VALUES ('987987987', 10, 35.0);
INSERT INTO works_on
VALUES ('987987987', 30, 5.0);
INSERT INTO works_on
VALUES ('999887777', 10, 10.0);
INSERT INTO works_on
VALUES ('999887777', 30, 30.0);

-- location inserts
INSERT INTO location
VALUES (1, 'Houston');
INSERT INTO location
VALUES (2, 'Stafford');
INSERT INTO location
VALUES (3, 'Bellaire');
INSERT INTO location
VALUES (4, 'Sugarland');


ALTER TABLE department ADD FOREIGN KEY (manager_ssn) REFERENCES employee (ssn);
ALTER TABLE dependent ADD FOREIGN KEY (employee_ssn) REFERENCES employee (ssn);
ALTER TABLE department_location ADD FOREIGN KEY (department_number) REFERENCES department (number);
ALTER TABLE department_location ADD FOREIGN KEY (location_number) REFERENCES location (number);
ALTER TABLE employee ADD FOREIGN KEY (department_number) REFERENCES department (number);
ALTER TABLE employee ADD FOREIGN KEY (supervisor_ssn) REFERENCES employee (ssn);
ALTER TABLE project ADD FOREIGN KEY (department_number) REFERENCES department (number);
ALTER TABLE project ADD FOREIGN KEY (location_number) REFERENCES location (number);
ALTER TABLE works_on ADD FOREIGN KEY (employee_ssn) REFERENCES employee (ssn);
ALTER TABLE works_on ADD FOREIGN KEY (project_number) REFERENCES project (number);
