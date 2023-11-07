---
layout: lab
course: RBD
type: stacjonarne
lab_nr: 10
subject: SQL - zapytania
description: Wszystko to, co nie pasowało do wcześniejszych tematów
---
## Podzapytania
Podzapytanie, czyli *subquery* to mechanizm zagnieżdżania jednego zapytania wewnątrz innego. Podzapytań można użyć w klauzulach ```FROM```, ```WHERE``` i ```SELECT```.

```sql
SELECT make, model, year, VIN FROM Cars WHERE make IN (SELECT make FROM Cars WHERE year<1973);
```

## Łączenie danych poziomo
Operację ```JOIN``` już wszyscy znają. To, czego dotychczas używaliśmy, to ```INNER JOIN```, operacja zwracająca rekordów, występujących w obu podanych tabelach. 

```LEFT JOIN``` Zwróci  wszystkie rekordy z lewej tabeli oraz pasujące z prawej tabeli

```RIGHT JOIN``` Zwróci  wszystkie rekordy z prawej tabeli oraz pasujące z lewej tabeli

```FULL JOIN``` lub ```FULL OUTER JOIN``` Zwróci wszystkie rekordy z lewej i prawej tabeli

![ALL JOINS](https://miro.medium.com/v2/resize:fit:640/format:webp/0*Omae6Ca_MVxGj_aY.png)

Źródło: [medium.com](https://medium.com/swlh/the-best-visual-to-explain-sql-joins-612b95c81555)

## Łączenie danych pionowo
Klauzula ```UNION``` połączy pionowo wyniki dwóch zapytań - w tabeli wynikowej wyniki jednego zapytania zostaną umieszczone bezpośrednio nad drugim

```sql
SELECT * FROM Cars WHERE make='Ford'
UNION
SELECT * FROM Cars WHERE year<1993
```

Każde zapytanie, które w ten sposób łączymy, musi mie tyle samo kolumn o tych samych typach danych

```INTERSECT``` zwróci częśc wspólną obu zapytań

```sql
SELECT * FROM Cars WHERE make='Ford'
INTERSECT
SELECT * FROM Cars WHERE year<1993
```

## Widoki

Widok to 'wirtualna' tabela, zawierająca wyniki zdefiniowanego przy tworzeniu widoku zapytania. Dzięki temu mechanizmowi nie musimy za każdym razem wpisywa skomplikowanego zapytania, z którego często korzystamy - wystarczy zdefiniowac widok, a następnie odwoływac się jedynie do niego:

```sql
CREATE VIEW loty_b777 AS
SELECT * FROM Routes 
JOIN Flights ON Routes.flight_nr = Flights.Routes_flight_nr 
JOIN Aircrafts A on A.ID = Flights.Aircrafts_ID 
WHERE Aircrafts_ID=7;
```