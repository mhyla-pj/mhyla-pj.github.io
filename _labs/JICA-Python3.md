---
layout: lab
course: Python
type: stacjonarne
lab_nr: 3
subject: Obsługa stringów, słowniki, funkcje 
description: Sytuacja staje się poważna
---

# Recap – Lab 2

Na drugim laboratorium rozszerzyliśmy wiedzę o **pętle** i **kolekcje** w Pythonie.

## Pętle
Poznaliśmy dwa główne rodzaje pętli:
- **`while`** – powtarza blok kodu, dopóki warunek jest prawdziwy.  
  ```python
  i = 1
  while i <= 5:
      print(i)
      i += 1
  ```
- **`for`** – iteruje po elementach sekwencji lub po liczbach z `range()`.  
  ```python
  for i in range(1, 6):
      print(i)
  ```

Omówiliśmy także:
- **`break`** – przerywa działanie pętli,
- **`continue`** – pomija aktualną iterację,
- **`else`** w pętlach – wykonuje się, jeśli pętla zakończy się bez `break`.

## Zagnieżdżone pętle
Nauczyliśmy się, jak pętla może działać wewnątrz innej pętli, np. do generowania tabliczki mnożenia:
```python
for i in range(1, 4):
    for j in range(1, 4):
        print(i, "*", j, "=", i * j)
```

## Kolekcje
Poznaliśmy trzy nowe typy kolekcji:
- **Listy (`list`)** – przechowują wiele elementów w kolejności, np.  
  ```python
  liczby = [1, 2, 3, 4]
  ```
- **Krotki (`tuple`)** – podobne do list, ale **niezmienne**, np.  
  ```python
  tupla = (1, 2, 3)
  ```
- **Zbiory (`set`)** – przechowują **unikalne** elementy, np.  
  ```python
  zbior = {1, 2, 2, 3}  # wynik: {1, 2, 3}
  ```

Omówiliśmy najważniejsze operacje na listach (`append`, `remove`, `len`), krotkach (indeksowanie, `count`, `index`) i setach (`add`, `remove`, operacje zbiorów).

## Zadania
Na koniec rozwiązywaliśmy zadania, w których:
- tworzyliśmy proste listy i przetwarzaliśmy ich elementy,
- wykorzystywaliśmy pętle `for` i `while` do iteracji,
- używaliśmy setów do usuwania duplikatów,
- liczyliśmy średnią lub maksymalną wartość z danych.

Dzięki temu nauczyliśmy się budować **bardziej złożone programy**, wykorzystujące powtarzalność kodu i kolekcje do pracy z danymi.


## Słowniki
Ostatnie zagadnienie z tematu kolekcji. Słownik to taka specjalna struktura danych, która pozwala na przechowywanie danych w postaci *Klucz:Wartość*. Słowniki zapisujemy w nawiasach klamrowych `{}` - podobnie do setów, ale z tą różnicą, że słowniki są *ordered* - czyli kolejność wartości w nich nie zostanie nigdy zmieniona. Założenie słowników jest bardzo proste, ale równocześnie sprawia, że różnią się one bardzo od poznanych poprzednio list, tupli i setów - słowników bowiem używamy do przechowywania wielu danych dotyczących jednej rzeczy/wydarzenia, np:

```python
samochod = {
    "marka": "Toyota",
    "model": "Corolla",
    "rok_produkcji": 2020,
    "kolor": "srebrny",
    "przebieg_km": 45000,
    "silnik": {
        "pojemnosc_l": 1.8,
        "moc_km": 140,
        "rodzaj_paliwa": "benzyna"
    },
    "wyposazenie": ["klimatyzacja", "tempomat", "kamera cofania"],
    "czy_ubezpieczony": True
}

print(samochod)
```

**Kluczem** nazywamy wartość stojącą po lewej stronie znaku `:`- np. nazwę elementu lub jakiejś cechy samochodu. **Wartość** stoi po prawej stronie tego `:` - jest to *wartość klucza*. 

Aby sprawdzić, co kryje się pod danym kluczem, możemy umieścić go w `[]` :

```python
print(samochod["marka"])
```

Alternatywnie:

```python
print(samochod.get("marka"))
```

Oczywiście wartości możemy nie tylko drukować, ale również przypisywać do zmiennych

```python
x = samochod.get("marka")
```

Aby sprawdzić, jakimi kluczami dysponujemy w danym słowniku możemy użyć metody `keys()`, analogicznie wartości możemy sprawdzić metodą `values()`:

```python
print(samochod.keys()) # Klucze
print(samochod.values()) # Wartości
```

Modyfikować elementy możemy poprzez zwykłą operację przypisania:

```python
samochod["model"] = "Yaris"
print(samochod["marka"], samochod["model"])
```

Przy okazji - rozpakowywanie do zmiennych:

```python
marka, model = samochod["marka"], samochod["model"]
print(marka, model)
```

Dodawanie do słownika nowej pary *K:V* jest właściwie tym samym, co modyfikacja wartości, z tą różnicą, że podajemy w `[]` nowy klucz, który zostanie automatycznie dodany do słownika.

```python
samochod["LPG"] = False  
print(samochod)
```

Do przechodzenia pętlą po całym słowniku mamy tak naprawdę dwa podejścia. Jedno z nich zakładać będzie, że iterujemy po pojedynczej wartości: np. wszystkich kluczach, lub wszystkich wartościach:

```python
for i in samochod.values():
	print(i)

for i in samochod.keys():
	print(i)
```

Alternatywnie możemy przelecieć po wszystkich parach *key:value*, przypisując wszystkie wartości do jednej zmiennej a klucze do drugiej:

```python
for i, j in samochod.items():
	print(i, j)
```

# Metody słowników (dict) w Pythonie

| Metoda | Opis | Przykład użycia |
|--------|------|-----------------|
| `clear()` | Usuwa wszystkie elementy ze słownika. | `slownik.clear()` |
| `copy()` | Zwraca płytką kopię słownika. | `kopia = slownik.copy()` |
| `fromkeys(seq, value)` | Tworzy nowy słownik z kluczami z sekwencji `seq` i jedną wartością `value`. | `dict.fromkeys(['a', 'b'], 0)` |
| `get(key, default)` | Zwraca wartość dla klucza lub `default` jeśli klucz nie istnieje. | `slownik.get('klucz', 'brak')` |
| `items()` | Zwraca widok obiektów `(klucz, wartość)` w słowniku. | `slownik.items()` |
| `keys()` | Zwraca widok wszystkich kluczy w słowniku. | `slownik.keys()` |
| `pop(key, default)` | Usuwa element o podanym kluczu i zwraca jego wartość, lub `default`. | `slownik.pop('klucz', None)` |
| `popitem()` | Usuwa i zwraca ostatnią parę `(klucz, wartość)`. | `slownik.popitem()` |
| `setdefault(key, default)` | Zwraca wartość klucza, a jeśli klucz nie istnieje, dodaje go z wartością `default`. | `slownik.setdefault('klucz', 0)` |
| `update(other)` | Aktualizuje słownik, dodając pary `(klucz, wartość)` z innego słownika lub sekwencji. | `slownik.update({'k1': 1})` |
| `values()` | Zwraca widok wszystkich wartości w słowniku. | `slownik.values()` |

#### Zadanie na zajęcia 1
Zadanie bez mądrego celu. Napisz swój słownik zawierający co najmniej 7 kluczy, a następnie wypróbuj **wszystkie** metody z listy powyżej
## Obróbka stringów

Trochę was intencjonalnie zmusiłem do samodzielnego poszukania paru rzeczy związanych z dzieleniem stringów, teraz sobie tę wiedzę uporządkujemy.

### Tworzenie stringów
```python
tekst = "Hello World"
tekst2 = 'Python jest super'
tekst3 = """Wielolinijkowy
string"""
```

---

### Indeksowanie i slicing
- Dostęp do pojedynczych znaków za pomocą indeksów:  
  ```python
  tekst = "Python"
  print(tekst[0])   # P
  print(tekst[-1])  # n
  ```
  
- Wycinanie fragmentów (slicing):  
  ```python
  print(tekst[0:3])  # Pyt
  print(tekst[2:])   # thon
  print(tekst[:4])   # Pyth
  ```

### Najważniejsze metody stringów

| Metoda | Opis | Przykład |
|--------|------|----------|
| `lower()` | Zwraca kopię stringa z małymi literami. | `"ABC".lower()` → `abc` |
| `upper()` | Zwraca kopię stringa z wielkimi literami. | `"abc".upper()` → `ABC` |
| `title()` | Zamienia pierwsze litery słów na wielkie. | `"hello world".title()` → `Hello World` |
| `capitalize()` | Zamienia pierwszą literę na wielką, resztę na małe. | `"hello".capitalize()` → `Hello` |
| `strip()` | Usuwa białe znaki z początku i końca stringa. | `"  hi  ".strip()` → `hi` |
| `lstrip()` | Usuwa białe znaki z początku. | `"  hi".lstrip()` → `hi` |
| `rstrip()` | Usuwa białe znaki z końca. | `"hi  ".rstrip()` → `hi` |
| `replace(old, new)` | Zastępuje fragment `old` na `new`. | `"ala ma kota".replace("kota", "psa")` → `ala ma psa` |
| `split(sep)` | Dzieli string na listę, używając separatora `sep`. | `"a,b,c".split(",")` → `['a', 'b', 'c']` |
| `join(iterable)` | Łączy elementy iterowalne w string, używając separatora. | `",".join(['a', 'b'])` → `a,b` |
| `startswith(prefix)` | Sprawdza, czy string zaczyna się od `prefix`. | `"python".startswith("py")` → `True` |
| `endswith(suffix)` | Sprawdza, czy string kończy się na `suffix`. | `"python".endswith("on")` → `True` |
| `find(sub)` | Zwraca indeks pierwszego wystąpienia `sub` (lub -1). | `"hello".find("l")` → `2` |
| `count(sub)` | Zlicza wystąpienia `sub` w stringu. | `"banana".count("a")` → `3` |
| `isdigit()` | Sprawdza, czy string składa się z cyfr. | `"123".isdigit()` → `True` |
| `isalpha()` | Sprawdza, czy string składa się z liter. | `"abc".isalpha()` → `True` |
| `isalnum()` | Sprawdza, czy string składa się z liter lub cyfr. | `"abc123".isalnum()` → `True` |


### F-stringi i formatowanie
- **F-stringi (Python 3.6+)**:
  ```python
  imie = "Anna"
  wiek = 25
  print(f"Cześć, {imie}! Masz {wiek} lat.")
  ```

- **`format()`**:
  ```python
  print("Cześć, {}! Masz {} lat.".format(imie, wiek))
  ```

### Iterowanie po stringu
String jest iterowalny, więc można używać pętli `for`:
```python
for litera in "Python":
    print(litera)
```

### Sprawdzanie podłańcuchów
- Operator `in`:
  ```python
  print("Py" in "Python")   # True
  print("Java" not in "Python")  # True
  ```

### Długość stringa
- Funkcja `len()`:
  ```python
  print(len("Python"))  # 6
  ```

#### Zadanie na zajęcia 2
Napisz program, który:
- wczyta od użytkownika dowolny tekst,
- usunie z niego spacje i znaki interpunkcyjne,
- policzy, ile razy występuje każda litera (bez rozróżniania wielkości liter),
- wypisze wynik w formie:
```
a: 3
b: 1
c: 5
```

---

#### Zadanie na zajęcia 3
Napisz program, który:
- wczyta zdanie od użytkownika,
- rozbije je na słowa (`split()`),
- zbuduje słownik, w którym kluczem jest słowo, a wartością liczba jego wystąpień,
- wypisze wszystkie słowa w kolejności alfabetycznej z ich licznością.

Tu przydadzą się metody `isalpha()`, `isdigit()` i `isspace()` - do znalezienia [Tutaj](https://www.w3schools.com/python/python_strings_methods.asp)
## Funkcje

Funkcje, nazywane rzadziej podprogramami lub *subroutines* to wydzielone kawałki kodu, które możemy wywołać z głównego programu. Zamykamy w funkcjach kod, który będzie używany więcej niż jeden raz podczas głównego działania programu. Na przykład, jeśli program musi policzyć litery 'A' w kilku stringach, to dużo lepiej byłoby napisać funkcję, która to robi i przekazać do niej stringa, niż wielokrotnie powtarzać zestaw linijek, które za to odpowiadają.

W Pythonie funkcje tworzymy przy użyciu *keyworda* `def`

```python
def myFunction():
	print("Welcome to myFunction!")
```

Warto zwrócić uwagę, że taka funkcja sama z siebie w zasadzie nic nie robi - musi zostać wywołana w programie głównym:

```python
def myFunction():
	print("Welcome to myFunction!")

myFunction()
```

Warto również zwrócić uwagę, że **definicja** funkcji musi nastąpić przed pierwszym wywołaniem -poniższy przykład nie zadziała, ponieważ - jak już doskonale wiemy - program wykonuje się linia po linii od góry do dołu, więc w poniższym przykładzie staramy się uruchomić funkcję, o której istnieniu komputer jeszcze nie wie:

```python
myFunction()

def myFunction():
	print("Welcome to myFunction!")
```

### Argumenty w funkcjach

Każda funkcja może korzystać z **argumentów**. Są to specjalne zmienne, dostępne **tylko** wewnątrz funkcji, których wartość ustalamy podczas wywołania funkcji

```python
def printWelcome(name):
	print("Witaj "+name)

printWelcome("Piotr") # Wydrukuje "Witaj Piotr"
printWelcome("Tomasz") # Wydrukuje "Witaj Tomasz"
```

Każda funkcja może mieć wiele argumentów, podajemy je po przecinkach zarówno w deklaracji jak i wywołaniu funkcji. Tu ważna uwaga - jeśli stworzyliśmy funkcję, która przyjmuje dwa argumenty, to każde jej wywołanie musi używać dwóch argumentów - w przeciwnym wypadku dostaniemy błąd.

```python
def printWelcome(f_name, l_name):
	print(f"Welcome {f_name} {l_name}, hope you're doing well!")

printWelcome("Michal", "Hyla") # To zadziała
printWelcome("Viktor") # To nie zadziała
```

W ten sposób możemy pracować wygodnie na funkcjach, które działają samodzielnie - czyli nie wpływają w żaden sposób na inne zmienne w programie - np. Funkcje drukujące wynik. Jednak jest to rzadkość, bowiem większość funkcji będziemy wykorzystywać do np. wykonywania obliczeń, które potem mogą być przekazane do dalszej obróbki. Dla przykładu, poniższy przykład już nie zadziała:

```python
def addition(a,b):  
    wynik = a+b  
  
print(wynik**2)
```

Dzieje się tak dlatego, że wszystkie obliczenia i zmienne są zamknięte w obrębie funkcji - poza nią nie mamy dostępu do zmiennej `wynik`. Na szczęście rozwiązanie tego problemu jest dość proste - musimy zmusić funkcję do wystawiania "na zewnątrz" wyniku swojego działania - tak, abyśmy mieli poza nią dostęp do efektów jej pracy. służyć będzie do tego *keyword* `return`.

```python
def addition(a,b):  
    wynik = a+b
    return wynik

nowy_wynik = addition(3,5)
print(nowy_wynik**2)
```

Zauważcie, że funkcja, która napisaliśmy zawsze **zwraca** wynik dodawania - zatem jeśli podamy do jej wywołania dwa argumenty z liczbami, to zawsze w odpowiedzi dostaniemy jedną liczbę - wynik dodawania tych dwóch liczb. Ten wynik możemy przypisać do zmiennej, albo nawet bezpośrednio wywołać tę funkcję w `print()`. Upraszczając kod:

```python
def addition(a, b):  
    return a + b  
  
  
print(addition**2)
```

---

#### Zadanie na zajęcia 4: Pole prostokąta
Napisz funkcję `pole_prostokata(a, b)`, która:
- przyjmuje wymiary prostokąta: **długość `a`** i **szerokość `b`**,  
- zwraca pole prostokąta,  
- w programie głównym wczytaj `a` i `b` od użytkownika i wyświetl wynik.

#### Zadanie na zajęcia 5: Liczba parzysta czy nieparzysta
Napisz funkcję `czy_parzysta(n)`, która:
- przyjmuje liczbę `n`,  
- zwraca `True`, jeśli liczba jest parzysta, lub `False` w przeciwnym razie,  
- w programie głównym sprawdź kilka liczb podanych przez użytkownika w pętli.

#### Zadanie na zajęcia 6: Największa z trzech liczb
Napisz funkcję `najwieksza(a, b, c)`, która:
- przyjmuje trzy liczby,  
- zwraca największą z nich,  
- w programie głównym wczytaj trzy liczby od użytkownika i wypisz wynik.
