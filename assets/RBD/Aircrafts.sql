create table Aircrafts
(
    ID           int         not null
        primary key,
    manufacturer varchar(20) not null,
    model        varchar(15) not null
);

INSERT INTO mhyla.Aircrafts (ID, manufacturer, model) VALUES (1, 'Boeing', '737');
INSERT INTO mhyla.Aircrafts (ID, manufacturer, model) VALUES (2, 'Boeing', '747');
INSERT INTO mhyla.Aircrafts (ID, manufacturer, model) VALUES (3, 'Boeing', '757');
INSERT INTO mhyla.Aircrafts (ID, manufacturer, model) VALUES (4, 'Boeing', '767');
INSERT INTO mhyla.Aircrafts (ID, manufacturer, model) VALUES (5, 'Boeing', '787');
INSERT INTO mhyla.Aircrafts (ID, manufacturer, model) VALUES (6, 'Airbus', 'A320');
INSERT INTO mhyla.Aircrafts (ID, manufacturer, model) VALUES (7, 'Airbus', 'A340');
INSERT INTO mhyla.Aircrafts (ID, manufacturer, model) VALUES (8, 'Airbus', 'A350');
INSERT INTO mhyla.Aircrafts (ID, manufacturer, model) VALUES (9, 'Airbus', 'A380');
