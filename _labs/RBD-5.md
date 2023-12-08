---
layout: lab
course: RBD
type: stacjonarne
lab_nr: 05
subject: Tworzenie i wypełnianie tabel w bazie danych
description: Oraz odpytywanie tej bazy, oczywiście
---
Na wcześniejszych zajęciach wszyscy musieli stworzyć kilka tabel, ale robiliśmy to z gotowego pliku. Teraz zajmiemy się własnoręcznym tworzeniem bazy - najpierw własnoręcznie "z palca", a pod koniec zrobimy sobie krótki przegląd narzędzi, które spowodują, że już nigdy nie będziecie tego musieli robić tradycyjnymi metodami. 

## Tworzenie nowej tabeli
Polecenie SQL ```CREATE TABLE``` pozwoli na stworzenie nowej tabeli. Po poleceniu należy umieścić nazwę tabeli (rzeczownik w liczbie mnogiej), w poniższym przykładzie *Persons*. Następnie w nawiasie, po przecinkach opisujemy kolumny tabeli - każde pole musi mieć:
- Nazwę
- Typ

Opcjonalnie, pola mogą posiadać:
- Ograniczenia
- Automatyczną inkrementację

```sql
CREATE TABLE Persons (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    firstName VARCHAR(50) NOT NULL ,
    lastName VARCHAR(50),
    dateOfBirth DATE
)
```

## Ograniczenia (constraints)
SQL-owe *constraints* używane są, aby zapewnić integralność i prawidłowość danych wprowadzanych do tabel
- NOT NULL - pole nie może być puste. Domyślnie pole bez wprowadzonej wartości przyjmie wartość NULL. NULL-em nie może być klucz główny
- UNIQUE - Zapewnia unikatowość danych w kolumnie - żadna wartość nie może się powtórzyć
- DEFAULT - Ustawia domyślną wartość dla pola, jeśli żadna nie będzie wprowadzona
- CHECK - Zapewni, że wszystkie dane w danej kolumnie spełnią podany warunek
- PRIMARY KEY - połączenie UNIQUE i NOT NULL - zapewnia klucz główny tabeli. Teoretycznie jako ograniczenie nie jest wymagany, ale każda tabela musi mieć swój klucz główny, więc lepiej z niego skorzystać
- FOREIGN KEY - Zapobiega wykonaniu działań, które mogłyby naruszyć połączenia między tabelami (usunięcie klucza głównego bez usuwania/modyfikacji rekordów z odpowiadającym kluczem obcym)

```sql
CREATE TABLE Persons (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    firstName VARCHAR(50) NOT NULL ,
    lastName VARCHAR(50),
    dateOfBirth DATE,
    cars_id int UNIQUE,
    FOREIGN KEY (cars_id) REFERENCES Cars(id)
)
```
Powyższy przykład stworzy tabelę Persons, tak jak poprzedni przykład, ale w tym wypadku dodane zostało pole cars_id określone jako klucz obcy, połączony z polem id w tabeli Cars. Będzie to relacja 1:1. Gdybyśmy usunęli ograniczenie UNIQUE w kluczu obcym, mielibyśmy w tym miejscu relację 1:n. Niezależnie od ograniczeń, przy takim układzie tabel niemożliwym będzie utworzenie osoby z *cars_id* = 5, jeśli w bazie nie będzie istniał samochód o ID = 5. 

## Modyfikacje tabel

Modyfikacje do tabel wprowadzać będziemy poleceniem ```ALTER TABLE```

```sql
ALTER TABLE Persons
ADD Address VARCHAR(255);
```

```sql
ALTER TABLE Persons
DROP COLUMN Address;
```

```sql
ALTER TABLE Persons
RENAME COLUMN dateOfBirth TO DoB;
```

```sql
ALTER TABLE Persons
ADD CONSTRAINT DoB_unique UNIQUE(DoB);
```

## Usuwanie tabel
Bardzo proste, ale również bardzo niebezpieczne, ma potencjał na rozwalenie całej bazy

```sql
DROP TABLE Persons
```

## Wprowadzanie danych
Nie jest to jakaś szczególan filozofia, zawsze będziemy używać polecenia ```INSERT INTO```, jednakże są dwa sposoby na wprowadzanie danych, jeden jest szybki, a drugi bezpieczny. Proponuję korzystać z drugiego. W pierwszym przykładzie musimy podać wartości dla wszystkich kolumn. 

```sql
INSERT INTO Persons VALUES (1, 'Pawel', 'Lelental', '1995-03-10');
```

W tym bezpieczniejszym sposobie mamy możliwość określenia, do jakich pól trafią jakie dane. nie muszą być w tej samej kolejności, co w bazie danych, nie muszą być wszystkie.

```sql
INSERT INTO Persons (firstName, lastName, DoB) VALUES ('Pawel', 'Lelental', '1995-03-10');
```

Tu na przykład możemy odpuścić wprowadzanie danych do pola ID, ponieważ jest ono określone jako automatycznie inkrementujące się, więc jego domyślną wartością przy tworzeniu nowego rekordu będzie wartość o 1 większa niż poprzedniego. Albo 1, jeśli tabela jest pusta. 