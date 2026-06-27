---
layout: exercise
nav-exclude: true
---
Na wykonanie kolokwium macie godzinę. Zadania proszę nazywać w formacie [nr_indeksu]z[nr_zadania].c, np s14616z1.c. Rozwiązania proszę przesyłać na adres sop2026@mhyla.com w temacie "KOLOKWIUM_ZAO_26". Rozwiązać należy obowiązkowo zadanie 2 oraz jedno z zadań 1 - do wyboru wersja a lub b.

Zadanie 1a: **Napisz skrypt w Bash, który wykonuje archiwizację i kompresję plików z określonego katalogu. Skrypt powinien:**
- Przyjmować jako argument ścieżkę do katalogu, który ma być archiwizowany.
- Tworzyć archiwum (np. tar) z zawartością katalogu.
- Kompresować archiwum ustalając jego nazwę na 'indeks_data_godzina', gdzie indeks to twój numer indeksu, data i godzina to czas utworzenia backupu.
- Przenosić skompresowane archiwum do innego katalogu (np. ~/backup).
- Zawierać mechanizm do sprawdzenia, czy katalog docelowy istnieje, a jeśli nie, to tworzyć go.

Zadanie 1b: **Napisz program w języku C, który przetwarzać będzie plik tekstowy `wejscie.txt`. Program powinien:**
- Otworzyć plik wejscie.txt do odczytu,
- Utworzyć plik wyjscie.txt,
- Przepisać do pliku wyjscie.txt tylko te linie, które mają długość co najmniej 10 znaków,
- Na końcu działania wypisać na ekran: liczbę wszystkich odczytanych linii, liczbę linii zapisanych do pliku, liczbę linii pominiętych.
   
Zadanie 2: Napisz program w języku C, który implementuje równoległe sortowanie tablicy liczb całkowitych przy użyciu wielu wątków. Program powinien podzielić tablicę na podtablice, posortować każdą z nich przy użyciu oddzielnego wątku, a następnie połączyć posortowane podtablice w jedną posortowaną tablicę - liczby do testów należy sobie wygenerować samodzielnie, testować będę na zbiorze 85.000 liczb w zakresie 1-1000000.