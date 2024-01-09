---
layout: lab
course: PRG
type: stacjonarne
lab_nr: 19
subject: Więcej Pythona
description: Trudniejsze programowanie dla dzieci
---
Dziś zajmiemy się obsługą danych w Pythonie. Na pierwszy ogień:

## Tuple
Tupla to jedna z wbudowanych struktur danych w języku Python. Jest to sekwencyjny, niemodyfikowalny (immutable) obiekt, co oznacza, że nie można zmieniać jego zawartości po utworzeniu.

Tupla jest tworzona za pomocą nawiasów okrągłych () i może zawierać różne typy danych, w tym liczby, stringi, inne tupli, czy nawet inne struktury danych. Przykład:

```python
tupla = (1, "Python", 3.14, (1, 2, 3))
```

Niemodyfikowalność tupli sprawia, że są one przydatne w sytuacjach, gdzie chcemy mieć pewność, że dane nie ulegną zmianie. Bezproblemowo możemy wykonywać różne operacje na tuplach

```python
# Dostęp do elementów tupli przez indeksowanie
pierwszy_element = tupla[0]

# Rozpakowywanie tupli
a, b, c, d = tupla
print(a, b, c, d)  # Wydrukuje: 1 Python 3.14 (1, 2, 3)

# Wyszukiwanie elementu w tupli
indeks_pythona = tupla.index("Python")

# Liczenie wystąpień danego elementu w tupli
ilosc_jedynek = tupla.count(1)
```

## Słowniki
Słownik (ang. dictionary) to struktura danych w Pythonie, która umożliwia przechowywanie zbioru par klucz-wartość. Każdy klucz musi być unikalny w obrębie danego słownika, a wartości mogą być dowolnymi obiektami.

Słownik jest tworzony za pomocą nawiasów klamrowych {}, a pary klucz-wartość oddzielane są dwukropkiem. Przykład:

```python
slownik = {"klucz1": "wartosc1", "klucz2": 42, "klucz3": [1, 2, 3]}
```

```python
# Dostęp do wartości poprzez klucz
wartosc = slownik["klucz1"]

# Dodanie nowej pary klucz-wartość
slownik["nowy_klucz"] = "nowa_wartosc"

# Aktualizacja wartości dla istniejącego klucza
slownik["klucz2"] = 100

# Usunięcie pary klucz-wartość
del slownik["klucz3"]

# Sprawdzenie, czy klucz istnieje w słowniku
istnieje_klucz = "klucz1" in slownik

# Pobranie wartości dla danego klucza z domyślną wartością, jeśli klucz nie istnieje
wartosc = slownik.get("klucz_nieistniejacy", "domyslna_wartosc")

# Iteracja po kluczach
for klucz in slownik:
    print(klucz, slownik[klucz])

# Iteracja po parach klucz-wartość
for klucz, wartosc in slownik.items():
    print(klucz, wartosc)
```

## Sety

Struktura danych reprezentująca kolekcję unikalnych elementów. Inaczej niż tuple albo listy nie utrzymują kolejności elementów, ale za to wszystkie elementy są różne. 

```python
zbior = {1, 2, 3, 4, 5}
```

Elementy w zbiorze muszą być unikalne, co oznacza, że jeśli próbujemy dodać do zbioru element, który już w nim istnieje, nie będzie on dodawany po raz drugi. Zbiory w Pythonie są dynamiczne i można do nich dodawać, usuwać oraz przeprowadzać różne magiczne operacje.

```python
# Dodanie elementu do zbioru
zbior.add(6)

# Usunięcie elementu ze zbioru
zbior.remove(3)

# Sprawdzenie, czy element znajduje się w zbiorze
czy_jest_w_zbiorze = 2 in zbior

# Operacje zbiorowe (suma, różnica, iloczyn)
zbior_a = {1, 2, 3, 4}
zbior_b = {3, 4, 5, 6}

suma_zbiorow = zbior_a | zbior_b
roznica_zbiorow = zbior_a - zbior_b
iloczyn_zbiorow = zbior_a & zbior_b

# Iteracja po elementach zbioru
for element in zbior:
    print(element)
```
