---
layout: lab
course: RBD
type: stacjonarne
lab_nr: 09
subject: SQL w konsoli, zadania praktyczne
description: Powrót do czasów komputera łupanego
---

Nic tak nie uczy obsługi bazy, jak konieczność pilnowania składni, gdy pozbawieni jesteśmy komfortów DataGripa. W związku z tym, dzisiejsze zajęcia realizujemy w 100% przy użyciu CLI. Aby zalogować się do swojej bazy na szuflandii:

- uruchom terminal
- zaloguj się do szuflandii:
  ```bash
  ssh username@szuflandia.pjwstk.edu.pl
  ```
- po zalogowaniu na szuflandi połączyć się należy z bazą:
  ```bash
  mysql -u [username] -p
  ```
- wprowadzić hasło
- wybrać swoją schemę:
  ```sql
  USE [username];
  ```
- sprawdzić, czy na pewno na niej jesteśmy:
  ```sql
  SHOW TABLES
  ```

Polecenia wykonywane tutaj będą oczywiście dokładnie takie same, jakie pisaliśmy w konsoli DataGripa, ale pozbawieni jesteśmy takich wygód jak podpowiedzi składni, czy klikalny interfejs. Bezpośrednie połączenie człowieka z bazą, tak jak to robili nasi dziadkowie.

Kilka rzeczy, które trzeba będzie wykonać w konsoli, bo nie mamy GUI:

Wyświetlenie wszystkich tabel:
```sql
SHOW TABLES
```

Wyświetlenie CREATE TABLE konkretnej tabel - informacje o typach danych, ograniczeniach, kluczach i relacjach
```sql
SHOW CREATE TABLE Cars 
```

Pozostałe aspekty komunikacji z bazą działają dokładnie tak, jak nauczyliśmy się dotychczas. Zadania na dziś są dwa, zupełnie ze sobą niepowiązane, ale do wykonania przez terminal.




