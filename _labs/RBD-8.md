---
layout: lab
course: RBD
type: stacjonarne
lab_nr: 8
subject: Agregacja, złączenia, funkcje SQL
description: Łolaboga, mnóstwo rzeczy naraz
---
Funkcje agregujące w SQL pozwalają na zwrócenie wyniku kalkulacji wartości z wielu kolumn. Są to funkcje SQL działające na grupach danych. 
```sql
SELECT COUNT(*) FROM Cars
```
Zwróci po prostu ilośc wierszy w tabeli Cars. Ale już

```sql
SELECT COUNT(*) FROM Cars GROUP BY make
```

Policzy nam, ile mamy pojazdów w zależności od marki. Aby ta informacja miała jakikolwiek sens, przydałoby się jeszcze wyświetlic te marki samochodów, które zostały zliczone

```sql
SELECT COUNT(*), make FROM Cars GROUP BY make
```

Funkcji agregujących mamy pięc:
- COUNT()
- SUM()
- MAX()
- MIN()
- AVG()

Każdej z nich możemy, a wręcz powinniśmy używac wraz z grupowaniem. I tak:

```sql
SELECT AVG(year) FROM Cars
```
zwróci nam średni rocznik samochodu w całej bazie, natomiast

```sql
SELECT AVG(year), make FROM Cars GROUP BY make
```

zwróci już średni rocznik z podziałem na marki samochodów.

### Filtrowanie

W standardowych zapytaniach SQL skorzysta możemy ze słówka kluczowego ```WHERE```, aby odfiltrowa tylko interesujące nas wyniki. W wypadku zapyta z funkcjami agregującymi takiej możliwości nie ma, skorzysta należy ze słówka kluczowego ```HAVING```, natomiast zasada korzystania będzie identyczne w obu wypadkach

```sql
SELECT AVG(year), make FROM Cars GROUP BY make HAVING make = 'Buick'
```

W identyczny sposób znajdowa możemy najmłodsze i najstarsze samochody, a jakby ktoś bardzo chciał, to można też zsumowac ich roczniki. Nie wiem po co, ale się da.

### Funkcje wbudowane
MySQL dysponuje ogromną liczbą wbudowanych funkcji znakowych, numerycznych, datowych i innych. Poniżej krótkie zestawienie najczęściej używanych, omówimy je na zajęciach. Po więcej informacji o nich oraz po inne zapraszam na [w3schools](https://www.w3schools.com/sql/sql_ref_mysql.asp)

#### Funkcje znakowe
- CONCAT()
- LEFT()
- RIGHT()
- UPPER()
- LOWER()
- STRCMP()
- TRIM()

#### Funkcje numeryczne
- CEIL()
- FLOOR()
- ROUND()
- RAND()
- Obliczeniowe:
  - SIN()
  - COS()
  - DEGREES()
  - MOD()
  - POW()

#### Funkcje datowe
- ADDDATE()
- ADDTIME()
- CURDATE()
- DAY()
- DAYNAME()
- NOW()
- TIMEDIFF()


