---
layout: exercise
course: Python
type: stacjonarne
lab_nr: 3
topic: Zadania na weekend. Proste, ale za to więcej.
---
# Zadania do laboratorium – Stringi, Słowniki, Funkcje

## Zadanie 1: Licznik liter
Napisz funkcję `licz_litery(tekst)`, która:
- przyjmie string,
- zwróci słownik z liczbą wystąpień każdej litery (ignorując wielkość liter i znaki interpunkcyjne),
- wypisze wynik w formie:
  ```
  a: 3
  b: 1
  ```

---

## Zadanie 2: Formatowanie tekstu
Napisz funkcję `formatuj(tekst)`, która:
- usunie nadmiarowe spacje z początku i końca tekstu,
- zamieni wszystkie litery na małe,
- zamieni w tekście słowo "python" na "PYTHON".

---

## Zadanie 3: Słownik studenta
Stwórz słownik opisujący studenta (`imie`, `nazwisko`, `rok`, `kierunek`, `oceny` jako lista).  
Następnie:
- dodaj nowy klucz `średnia` i oblicz średnią ocen,
- wypisz wszystkie klucze i wartości w czytelnej formie.

---

## Zadanie 4: Odwracanie słów
Napisz funkcję `odwroc_slowa(zdanie)`, która:
- rozbije zdanie na słowa (`split`),
- odwróci każde słowo osobno (np. `"Ala ma kota"` → `"alA am atok"`),
- połączy słowa w nowy string i zwróci wynik.

---

## Zadanie 5: Kalkulator prostokąta
Napisz funkcję `prostokat(a, b)`, która:
- obliczy pole prostokąta (`a*b`),
- obliczy obwód (`2*(a+b)`),
- zwróci wynik jako słownik:  
  ```python
  {"pole": ..., "obwod": ...}
  ```
