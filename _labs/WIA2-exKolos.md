---
layout: lab
course: WIA2
type: stacjonarne
lab_nr: 10
subject: Przykładowe kolokwium
description: Główne będzie podobne (albo identyczne)
---
### Zadanie 1

Napisz programik, którego zadaniem będzie szyfrowanie znaków. Program ma odczytać z konsoli znak, a następnie wydrukować go w formie zakodowanej. Odczytany znak ma zostać zmieniony o: +10(dec) pozycji dla zakresu 0x20 - 0x3F, +7(dec) pozycji dla zakresu 0x40-0x5F, -12(dec) pozycji dla zakresu 0x60-7E.

Dla przykładu: podanie znaku $ powinno skutkować wydrukowaniem kropki (.), podanie litery 'K' da nam 'R', a 'p' da nam d.

Nadprogramowymi punktami nagrodzę, jeśli program będzie w stanie przyjmować w ten sposób wiele znaków bez zamykania się. Na wszelki wypadek, jakby nie udało się zrobić jakiegoś zadania a to akurat tak.

### Zadanie 2

Napisz program, który wczyta pojedynczy znak z klawiatury. Jeśli będzie to wielka litera, wtedy niech wypisze w lewym górnym rogu tekst "wielka litera". Jeśli jest to mała litera, wtedy niech wypisze "mała litera" w jakimś określonym miejscu (ale możecie sobie wybrać gdzie).

Jeśli wprowadzone zostanie cokolwiek innego to program wydrukuje error i się zakończy

### Zadanie 3

Napisz programik, który wczyta od użytkownika stringa, a w następnej linii wydrukuje połowę tego stringa.
Np:

```
MICHAŁ HYLA JEST NAJPIEKNIEJSZY
MICHAŁ HYLA J
```