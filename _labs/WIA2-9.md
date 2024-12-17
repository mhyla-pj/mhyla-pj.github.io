---
layout: lab
course: WIA2
type: stacjonarne
lab_nr: 9
subject: Kalkulator - wstęp
description: Prace projektowe
nav-exclude: true
---
Naszym następnym projektem będzie realizacja kalkulatora w asemblerze.

## Założenia podstawowe

- Aplikacja będzie działać w trybie tekstowym
- Aplikacja ma być w stanie realizować obliczenia w rozmiarze 16-bitowym
- Aplikacja powinna być w stanie przyjąć dwie liczby dziesiętne większe od 0 i mniejsze niż 10000 oraz jeden operator i zwrócić wynik obliczenia

## Implementacja
Na zajęciach temat będziemy realizować przyrostowo, rozwijając aplikację stopniowo. Zasadnicze trudności do przełamania:

- odczyt liczb dziesiętnych z terminala
- parsing odczytanych danych na liczbę
- obliczenie
- wydruk wyniku w formie dziesiętnej

Na pierwszych zajęciach zajmujemy się funkcjami, które będą parse'owały zestaw cyfr w formie ASCII na faktyczną liczbę, na której będziemy mogli wykonać obliczenia. Jak czas pozwoli to spróbujemy zająć się też przejściem w drugą stronę, z wartości na rejestrze na liczbę dziesiętną do wydrukowania na terminalu.

