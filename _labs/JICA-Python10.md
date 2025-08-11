---
layout: lab
course: Python
type: stacjonarne
lab_nr: 10
subject: Bazy danych, integracja z API
description: Dane przestają znikać co chwila!
---
Generalnie, jak prawdopodobnie mogliście zauważyć, za każdym razem jak przeładowywaliśmy aplikacje z poprzednich dwóch labów, to gubiliśmy dane, które zostały wprowadzone. Działo się tak ze względu, że przechowywaliśmy dane w liście - a ta tak naprawdę jest zmienną, która znika wraz z wyłączeniem czy zresetowaniem programu. 

Dziś wprowadzamy koncept **bazy danych**. Dzięki umieszczaniu danych w bazie będziemy mogli je nie tylko uporządkować, ale również uzyskiwać do nich dostęp w sposób znacznie szybszy i prostszy niż dotychczas. Będzie tak przede wszystkim dzięki temu, że oddamy zadania polegające na przeszukiwaniu zbioru danych innej aplikacji, specjalnie do tego stworzonej.

Baza danych jest strukturą nieulotną, w przeciwieństwie do używanej przez nas wcześniej listy. Skorzystanie z bazy danych ponadto pozwoli na przechowywanie danych w sposób uporządkowany, doda nam kolejną warstwę walidacji danych i pomoże przypilnować, żebyśmy przypadkiem nieumyślnie nie nadpisali już znajdujących się w niej danych. 

### Typy Baz

Najpopularniejsze dwa typy:
1. **Relacyjne bazy danych** – dane przechowywane w **tabelach** (wiersze i kolumny), używają języka **SQL** (Structured Query Language).  
    Przykłady: MySQL, PostgreSQL, SQLite, Microsoft SQL Server.
2. **NoSQL** – dane w formatach innych niż tabele (np. dokumenty JSON, grafy, klucze-wartości).  
    Przykłady: MongoDB, Redis.

My skupimy się na **relacyjnej** bazie danych.

### Ważne!

Dane w relacyjnych bazach danych przechowujemy w formacie *tabel*. W SQL **tabela** to podstawowa struktura, w której przechowywane są dane w bazie — można ją porównać do arkusza kalkulacyjnego, gdzie dane ułożone są w wierszach i kolumnach.  
**Kolumna** (ang. _column_) to jeden „rodzaj” informacji w tabeli — np. imię, gatunek, wiek. Każda kolumna ma swoją nazwę i określony typ danych (np. liczba całkowita, tekst, data).  
**Rekord** (ang. _row_ lub _record_) to pojedynczy wiersz w tabeli, czyli jeden pełny wpis zawierający wartości dla wszystkich kolumn. Na przykład w tabeli `animals` rekord może wyglądać tak: `1 | Burek | dog | 5`, gdzie `1` to identyfikator, `Burek`to imię, `dog` to gatunek, a `5` to wiek. 

### 3. Jak wygląda baza relacyjna?

- **Tabela** – jak arkusz Excela: wiersze = rekordy, kolumny = pola (atrybuty).
- **Rekord** – pojedynczy wpis (np. jeden klient, jedno zwierzę w schronisku).
- **Kolumna** – jedno z pól, np. imię, wiek, gatunek.
- **Klucz główny (PRIMARY KEY)** – unikalny identyfikator rekordu, zwykle liczba (`id`).

**Przykład – tabela `animals`:**

|id|name|species|age|
|---|---|---|---|
|1|Burek|dog|5|
|2|Filemon|cat|2|
|3|Nemo|fish|1|


### 4. Podstawowe operacje (CRUD)

```sql
-- CREATE
INSERT INTO animals (name, species, age) VALUES ('Burek', 'dog', 5);

-- READ
SELECT * FROM animals WHERE species = 'dog';

-- UPDATE
UPDATE animals SET age = 6 WHERE id = 1;

-- DELETE
DELETE FROM animals WHERE id = 1;
```


### 5. Czym jest SQLite?

SQLite to:

- lekka baza danych **zapisywana w jednym pliku** (`.db`),
- wbudowana w Pythona — nie trzeba instalować serwera,
- świetna do nauki, prototypów i małych aplikacji,
- używa standardowego języka SQL.

Plik bazy można skopiować na pendrive i działa wszędzie.  
W Pythonie korzystamy z modułu **`sqlite3`** (jest NA SZCZĘŚCIE wbudowany w standardową bibliotekę).

### 6. Implementacja

Właściwie nie jest aż tak skomplikowana. Zacząć musimy od zaimportowania biblioteki oraz ustanowienia połączenia:

```python
import sqlite3

# Połączenie z bazą (utworzy plik, jeśli go nie ma)
conn = sqlite3.connect("animals.db")
```

To połączenie utworzy plik bazy danych, jeśli jeszcze nie istnieje. Następnym krokiem jest stworzenie *kursora* - mechanizmu, który pozwoli na wykonywanie zapytań do bazy:

```python
cur = conn.cursor()
```


Następnym krokiem będzie utworzenie tabeli:

```python
# Tworzenie tabeli
cur.execute("""
CREATE TABLE IF NOT EXISTS animals (
    id INTEGER PRIMARY KEY,
    name TEXT,
    species TEXT,
    age INTEGER
)
""")
```

Tu ważna uwaga - jeśli chcemy wprowadzić jakieś zmiany w strukturze tabeli (np. dodać kolumnę), to powyższe polecenie nie zadziała, jeśli tabela już istnieje. Jest kilka sposobów na wykonanie operacji dodawania kolumny i inne modyfikacje tabeli, natomiast na nasze potrzeby prawdopodobnie wystarczające będzie usunięcie pliku.

Instrukcje, które dodają rekord do bazy:

```python
cur.execute("INSERT INTO animals (name, species, age) VALUES (?, ?, ?)",
            ("Burek", "dog", 5))
```

Po zakończeniu pracy z bazą należy **zapisać zmiany**:

```python
conn.commit()
```

Aby odczytać dane z bazy należy wykonać:

```python
cur.execute("SELECT * FROM animals")
print(cur.fetchall())
```

Powyższe polecenie wydrukuje nam wszystkie rekordy z tabeli *animals*. Gdybyśmy chcieli odczytać tylko jeden wiersz, to zrealizowalibyśmy:

```python
cur.execute("SELECT * FROM animals WHERE id = ?", "3")  
print(cur.fetchall())
```

Natomiast jeśli interesuje nas tylko i wyłącznie imię, to 

Zamknięcie połączenia

```python
conn.close()
```