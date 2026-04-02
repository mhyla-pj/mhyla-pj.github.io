---
layout: lab
subject: Logowanie do MongoDB w DataGrip
nav_exclude: true
---

Proces relatywnie prosty, ale nie chcę, żeby na kolokwium ktokolwiek był poszkodowany

1. W DataGrip należy dodać nowe źródło danych - w naszym wypadku będzie to MongoDB.
![datasource](../../../assets/RBD/Zrzut%20ekranu%202024-06-24%20o%2000.10.58.png)
1. Należy wejść w zakładkę **SSH/SSL** i wybrać opcję "Use SSH Tunnel", kliknąć na przycisk z 3 kropeczkami i podać tam swoje dane do logowania do szuflandii
![ssh login](../../../assets/RBD/Zrzut%20ekranu%202024-06-24%20o%2000.17.15.png)
1. Po sprawdzeniu połączeniu należy zamknąć okno i prześć do zakładki **General** i wprowadzić tam dane do połączenia:
   1. User - numer indeksu, np. s14616
   2. Password - numer indeksu, np. s14616
   3. URL - poniżej, proszę pamiętać o podmianie [nrIndeksu] na swoj numer indeksu
    ```mongodb://127.0.0.1:27017/?directConnection=true&serverSelectionTimeoutMS=2000&authSource=[nrIndeksu]&appName=mongosh+2.2.6```
    ![mongo pass](../../../assets/RBD/Zrzut%20ekranu%202024-06-24%20o%2000.25.18.png)
2. Po sprawdzeniu połączenia uruchomić konsolę i wykonać polecenie ```use [nrIndeksu]```

