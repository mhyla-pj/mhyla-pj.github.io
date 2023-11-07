---
layout: lab
course: RBD
type: stacjonarne
lab_nr: 3
subject: Wstęp do SQL
description: Odpytywanie bazy danych
---
Na dzisiejszych zajęciach zaczniemy zaznajamiać się z językiem SQL (*Structured Query Language*). Opracowany w latach 70. przez IBM język zapewnia uproszczoną w porównaniu do języków programowania strukturę komunikacji z bazą danych, wzorowaną na potocznym języku angielskim. Użytkownik opisuje oczekiwaną strukturę danych, a serwer to polecenie interpretuje. 


## Składnia SQL
W SQL spotkamy się z czterema kategoriami podstawowymi syntaktycznymi:
1. identyfikatory - nazwy obiektów
2. literały - stałe
3. operatory - spójniki 
4. słówka kluczowe - interpretowane przez serwer w konkretny sposób

Każda instrukcja SQL zaczynać się będzie od polecenia, czyli słowa kluczowego, które w dalszej części zapytania będziemy odpowiednimi klauzulami dookreślać.  Pracować będziemy na tabeli *Cars* - do pobrania [tutaj](../assets/RBD/Cars.sql). 

Każde zapytanie zaczynać się będzie od "instrukcji" określającej klasę zapytania. Klas tych jest 7, a każda zawiera jedno lub więcej poleceń. Dziś zajmiemy się kategorią danych, czyli poleceniami ```SELECT```, ```INSERT```, ```UPDATE``` i ```DELETE```, a w szczególności tym pierwszym. Na warsztat weźmiemy dziś zapytanie ```SELECT``` - jest to równocześnie najbardziej rozbudowana, jak i najczęściej używana instrukcja. Pozwala ona odpytywać bazę o konkretne dane, filtrowanie i agregację ich.
Składnia:
```sql
SELECT id, make, model, year FROM Cars WHERE year < 1995 ORDER BY make;
```

- Na polecenia określamy jego **rodzaj**. Na ten moment wykonujemy zapytania do bazy, więc będzie to instrukcja ```SELECT```.
- Następnie określamy, **jakie kolumny** chcemy w tym zapytaniu odczytać - \* oznaczać będzie wszystkie. Kolumny oddzielamy przecinkami.
- Po słówku kluczowym ```FROM``` określić należy, z jakich tabel chcemy uzyskać dane
**Zapytanie zawierające te podstawowe elementy już można wykonać**
- Następnie, po klauzuli ```WHERE``` określamy tzw. filtry. 
- Dalej, po klauzuli ```ORDER BY``` określimy sposób sortowania wyników
- Zapytanie kończymy średnikiem

### Przykładowe zapytanie:
Chcemy uzyskać informację o wszystkich Fordach F150, ich roczniku i VIN z tabeli Cars w naszej bazie danych i posortować je od najstarszych. Zaczniemy od określenia
```sql
SELECT make, model, year, VIN FROM CARS;
```
To powinno wyświetlić nam wszystkie rekordy z tabeli Cars: 

|make|model    |year          |VIN |
|---|---------|--------------|----|
|Jaguar|XF       |2010          |3D4PH3FGXBT677014|
|Chevrolet|Silverado|2011          |5N1AN0NU6EN786815|
|Chevrolet|Avalanche 1500|2003          |WA1CFBFP0DA735583|
|BMW|X3       |2009          |KMHHT6KD8CU882900|



Dalej zająć się musimy odfiltrowaniem Fordów:
```sql
SELECT make, model, year, VIN FROM Cars WHERE make="Ford";
```

|make|model    |year          |VIN |
|----|---------|--------------|----|
|Ford|F250     |2003          |1C4RDJDG8CC591920|
|Ford|E150     |2009          |JH4DB75581S972183|
|Ford|Expedition|2006          |WA1VMBFEXED931849|
|Ford|Courier  |1986          |5NPEB4AC8BH323427|

Tutaj też warto zaznaczyć, że kolejność, w jakiej podamy kolumny do zapytania będzie równocześnie kolejnością, w jakiej zostaną umieszczone w tabeli wynikowej.

Dalej zmierzyć musimy się z problemem filtrowania po wielu kolumnach. Dotychczas wyszukaliśmy jedynie Fordy, a przydałoby się jeszcze znaleźć konkretny model. Oczekujemy, że spełnione zostaną oba warunki wyszukiwania, czyli make="Ford" oraz model="F150". Konieczny będzie tutaj łącznik ```AND```

```sql
SELECT make, model, year, VIN FROM Cars WHERE make="Ford" AND model="F150";
```

|make|model    |year          |VIN |
|----|---------|--------------|----|
|Ford|F150     |2011          |JN1AZ4EH0FM508036|
|Ford|F150     |1996          |2HNYD2H49DH617841|
|Ford|F150     |2010          |1N6AA0EC4FN982077|

Pozostaje nam dodanie sortowania. Zrealizujemy je poprzez umieszczenie klauzuli ```ORDER BY``` wraz z określeniem kolumny i rodzaju sortowania na końcu zapytania. 

```sql
SELECT make, model, year, VIN FROM Cars WHERE make="Ford" AND model="F150" ORDER BY year;
```

|make|model    |year          |VIN |
|----|---------|--------------|----|
|Ford|F150     |1996          |2HNYD2H49DH617841|
|Ford|F150     |2010          |1N6AA0EC4FN982077|
|Ford|F150     |2011          |JN1AZ4EH0FM508036|

## Operatory logiczne
- AND
- OR
- NOT

## Operatory porównawcze
- = - równy
- < - mniejszy
- \> - większy
- <= - mniejszy lub równy
- \>= - większy lub równy
- <> - nierówny 

## Operatory SQL
- IN - pozwala na określenie zbioru 
```sql 
WHERE make IN ('Ford', 'Dodge', 'Pontiac')
```
- BETWEEN ... AND - pozwala na określenie zakresu
```sql 
WHERE year BETWEEN 1995 AND 1999
```
- LIKE - pozwala na przeszukiwanie danych tekstowych zgodnie ze wzorcem. 

## Grupowanie, czyli agregacja
Tym zajmiemy się szerzej w niedalekiej przyszłości, więc teraz ogólnikowy wstęp. Grupowanie wierszy pozwala na pracę nie na pojedynczych danych, a na ich zbiorach. Skupimy się dziś na funkcji COUNT() - funkcja SQL pozwalająca na zliczanie wierszy. 
```sql
SELECT COUNT(*) AS ilosc FROM Cars;
```

Powyższe polecenie zliczy nam ilość rekordów w tabeli Cars. 

```sql
SELECT COUNT(make) AS ilosc FROM Cars;
```

Powyższe zliczy nam ilość wystąpień pola *make*. 

```sql
SELECT COUNT(DISTINCT make) AS ilosc FROM Cars
```

To natomiast zliczy unikatowe wystąpienia make, czyli powie nam, ile mamy unikatowych marek pojazdów w bazie danych.

Zagregowane wiersze można jednak grupować przy użyciu klauzuli ```GROUP BY```. 

```sql
SELECT COUNT(*) AS ilosc, make FROM Cars GROUP BY make ORDER BY ilosc DESC;
```













