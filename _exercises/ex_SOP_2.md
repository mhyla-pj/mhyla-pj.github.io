---
layout: exercise
course: SOP
type: stacjonarne
lab_nr: 2
topic: Więcej basha
---
1. Napisz wyrażenia regularne, które sprawdzą:
   1. Czy podany tekst jest adresem e-mail
   2. Czy podany tekst jest prawidłowym imieniem (zaczyna się od wielkiej litery i zawiera tylko litery)
   3. Czy podany teks jest prawidłowym polskim kodem pocztowym (69-420)
2. Napisz skrypt, który sprawdzi, czy podano do niego dokładnie jeden argument (przypomnę o $#, $@) oraz czy jest to plik, a następnie wyszuka w tym pliku wszystkie wystąpienia ciągu "s[5cyfr]"
3. **NA DODATKOWY PUNKT** Napisz skrypt, który wspomoże biednego wykładowcę w sprawdzaniu kolokwiów. W katalogu znajdują się 32 pliki cpp, nazywające się zgodnie ze wzorem - [nrindeksu]_z1.cpp. Zadanie, które będzie sprawdzane poległo na wczytaniu od użytkownika liczby <25 i wydrukowaniu jej silni. Biedny wykładowca chciałby aby:
   - Wyświetlony na górze ekranu został nr indeksu studenta bez rozszerzenia oraz numeru zadania
   - Poniżej wyniki wywołania sprawdzanego zadania na wartościach 5, 10 i 30
   - Skrypt umożliwił mu wpisanie liczby punktów za zadanie i umieszczenie jej wraz z **SAMYM** nr indeksu w pliku tekstowym lub wyświetlenie kodu zadania w razie wątpliwości
   - Po wpisaniu oceny powinien przejść automatycznie do następnego studenta.