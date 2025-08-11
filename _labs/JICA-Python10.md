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
conn.row_factory = sqlite3.Row
```

To połączenie utworzy plik bazy danych, jeśli jeszcze nie istnieje oraz wskaże, że chcemy dostawać odpowiedzi od bazy w formie `Row` - jest to typ, który sprawi, że po stronie programu będziemy mogli korzystać z nazw kolumn. Następnym krokiem jest stworzenie *kursora* - mechanizmu, który pozwoli na wykonywanie zapytań do bazy:

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

Alternatywnie:

```python
for row in cur.fetchall():
    print(dict(row))  # np. {'id': 1, 'name': 'Ala'}
``` 
Pierwszy przykład zwraca nam tuplę, a drugi słownik - wybieramy zależnie od potrzeb. 

Natomiast jeśli interesuje nas tylko i wyłącznie imię, to 

Zamknięcie połączenia

```python
conn.close()
```

```python
import sqlite3

# Połączenie z bazą (utworzy plik, jeśli go nie ma)
conn = sqlite3.connect("animals.db")

# Kursor - służy do wykonywania zapytań
cur = conn.cursor()

# Tworzenie tabeli
cur.execute("""
CREATE TABLE IF NOT EXISTS animals (
    id INTEGER PRIMARY KEY,
    name TEXT,
    species TEXT,
    age INTEGER
)
""")

# Dodanie rekordu
cur.execute("INSERT INTO animals (name, species, age) VALUES (?, ?, ?)",
            ("Burek", "dog", 5))

cur.execute("INSERT INTO animals (name, species, age) VALUES (?, ?, ?)", ("jajco", "kot", 5))

# Zapis zmian
conn.commit()

# Odczyt danych
cur.execute("SELECT * FROM animals WHERE id = ?", "3")
print(cur.fetchall())

# Zamknięcie połączenia
conn.close()
```

# Zadanie: Animals API z bazą SQLite

Do istniejącego API obsługującego listę zwierząt (z Labu 9) dodajemy trwałość danych w bazie SQLite.  
Zamiast listy w pamięci (`animals = []`) wprowadzamy plik `animals.db` z tabelą `animals`, w której przechowujemy:  
`id` *(liczba całkowita, klucz główny)*,  
`name` *(tekst)*,  
`species` *(tekst)*,  
`age` *(liczba całkowita)*.

---

```python
@app.get("/animals")
def get_all_animals():
    cur.execute("SELECT * FROM animals")
    list = []
    for r in cur.fetchall():
        list.append(r)
    return list
```

## Krok 1 — Utworzenie bazy i tabeli

**Opis:**  
Przy starcie aplikacji baza danych ma być inicjalizowana, jeśli nie istnieje. Struktura tabeli:
```sql
CREATE TABLE IF NOT EXISTS animals (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    species TEXT NOT NULL,
    age INTEGER NOT NULL,
    UNIQUE(name, species)
);
```

**Wymagania:**

| ID   | Wymaganie |
|------|-----------|
| K1.1 | Plik `animals.db` tworzony automatycznie, jeśli nie istnieje. |
| K1.2 | Tabela `animals` zgodna z podanym schematem. |
| K1.3 | Inicjalizacja wykonywana tylko raz (nie nadpisuje istniejących danych). |
| K1.4 | Kod inicjalizacji bazy znajduje się w `main.py` i jest wykonywany przy starcie aplikacji. |

---

## Krok 2 — Implementacja `GET /animals`

**Opis:**  
Zacznij od endpointu, który zwróci wszystkie rekordy z tabeli.  
- Otwórz połączenie (`sqlite3.connect()`),  
- ustaw `row_factory` tak, żeby można było zwracać dane jako słowniki,  
- wykonaj zapytanie `SELECT * FROM animals`,  
- zamień wynik na listę słowników i zwróć w odpowiedzi.

**Wymagania:**

| ID   | Wymaganie |
|------|-----------|
| K2.1 | Połączenie do `animals.db` otwierane w endpointzie. |
| K2.2 | Zapytanie SQL: `SELECT * FROM animals`. |
| K2.3 | Wynik zwracany jako lista słowników. |
| K2.4 | Połączenie zamykane po wykonaniu zapytania. |

---

## Krok 3 — Implementacja `GET /animals/{id}`

**Opis:**  
Dodaj endpoint, który zwróci jeden rekord po `id`.  
- Wykonaj zapytanie `SELECT * FROM animals WHERE id = ?`,  
- jeśli rekord istnieje — zwróć go,  
- jeśli nie — zwróć 404 z komunikatem.

**Wymagania:**

| ID   | Wymaganie |
|------|-----------|
| K3.1 | Parametr `id` przekazywany do zapytania w formie parametryzowanej (`?`). |
| K3.2 | Brak rekordu → odpowiedź 404 w JSON. |
| K3.3 | Poprawne zamykanie połączenia po zapytaniu. |

---

## Krok 4 — Implementacja `POST /animals`

**Opis:**  
Dodaj możliwość dodawania nowego rekordu.  
- Wykorzystaj model Pydantic z Labu 9 do walidacji (`name`, `species`, `age`),  
- wykonaj zapytanie `INSERT INTO animals (name, species, age) VALUES (?, ?, ?)`,  
- w przypadku duplikatu `(name, species)` zwróć 409 z komunikatem,  
- po dodaniu zwróć pełny rekord (łącznie z `id`).

**Wymagania:**

| ID   | Wymaganie |
|------|-----------|
| K4.1 | Dodawanie rekordu przy pomocy zapytania parametryzowanego. |
| K4.2 | Obsługa błędu unikalności → odpowiedź 409. |
| K4.3 | Zwracanie nowo dodanego rekordu z `id`. |

---

## Krok 5 — Implementacja `PUT /animals/{id}`

**Opis:**  
Dodaj możliwość zmiany imienia (`name`) istniejącego zwierzęcia.  
- Model Pydantic jak w Labu 9 (`name` ≥ 2 znaki),  
- zapytanie `UPDATE animals SET name = ? WHERE id = ?`,  
- jeśli rekord istnieje — zwróć zaktualizowany wpis,  
- jeśli nie istnieje — 404.

**Wymagania:**

| ID   | Wymaganie |
|------|-----------|
| K5.1 | Aktualizacja tylko pola `name`. |
| K5.2 | Brak rekordu → 404. |
| K5.3 | Zwrócenie zaktualizowanego rekordu. |

---

## Krok 6 — Implementacja `DELETE /animals/{id}`

**Opis:**  
Dodaj możliwość usuwania rekordu po `id`.  
- Zapytanie `DELETE FROM animals WHERE id = ?`,  
- jeśli rekord istniał — zwróć potwierdzenie,  
- jeśli nie — 404.

**Wymagania:**

| ID   | Wymaganie |
|------|-----------|
| K6.1 | Usuwanie przy pomocy zapytania parametryzowanego. |
| K6.2 | Brak rekordu → 404. |
| K6.3 | Poprawne zamknięcie połączenia po operacji. |

---

## Krok 7 — Testy ręczne

**Opis:**  
Sprawdź działanie aplikacji przez `/docs` lub `curl`:

**Wymagania:**

| ID   | Wymaganie |
|------|-----------|
| K7.1 | Dodanie zwierzęcia → widoczne w `GET /animals`. |
| K7.2 | Restart serwera nie usuwa danych (trwałość w SQLite). |
| K7.3 | Błędy (404, 409) działają zgodnie z opisem. |
