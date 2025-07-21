---
layout: lab
course: Python
type: stacjonarne
lab_nr: 1
subject: Hello World!
description: Pierwsze kroki w programowaniu
---

Na samym początku musimy określić, co rozumiemy poprzez pojęcie "programowania". Możemy je zdefiniować, jako proces tworzenia **programu komputerowego** przy użyciu **kodu źródłowego**, czyli takiego zrozumiałego dla człowieka, tłumaczonego przez komputer na **kod wynikowy** - taki, który komputer jest w stanie **wykonać**. 

```python
a = "Witaj świecie"  
b = 10  
# To jest komentarz  
  
print("Hello World", a)
```

Powyższy kod sprawi, że w oknie **terminala** pojawi się napis "Hello World Witaj świecie". W wypadku niektórych języków programowania taki kod należy najpierw **skompilować**, czyli przetłumaczyć przy użyciu specjalnego narzędzia na język, który zrozumie komputer. W wypadku niektórych języków kod nie jest kompilowany, a **interpretowany** - takim językiem jest na przykład Python, którym będziemy się podczas tego kursu posługiwać. 
## Co możemy zaprogramować?
Wszystko. Ale zacząć musimy od całkowitych podstaw - zacząć programowanie należy bowiem od ustalenia, co i w jaki sposób komputer ma za nas zrobić. Może to być obliczenie jakiegoś skomplikowanego wyrażenia matematycznego, narysowanie wykresu, wyświetlenie samochodziku przesuwającego się po ekranie, albo tak naprawdę cokolwiek innego. Aby uporządkować i mądrze zaplanować to, co chcemy zaprogramować dobrze jest sobie narysować schemat algorytmu, który będziemy programować. Ściągę do tworzenia otrzymacie w postaci drukowanej.

## Schemat Blokowy

Poniższy schemat blokowy reprezentuje program, którego jedynym zadaniem jest wyświetlenie "Witaj w świecie programowania!".

 ```mermaid
flowchart TD
    A([Start]) --> B["Wypisz Witaj w świecie programowania!"]
    B --> C([Koniec])
```

Zaczyna się od polecenia "Start", a kończy poleceniem "Koniec". W niektórych językach będziemy mieli instrukcje, które będą to reprezentowały, ale Python ich nie posiada, więc nasz cały program będzie składał się z jednej linii:

```python
print("Witaj w świecie programowania!")
```

Przewijający się przez ten dokument ```print``` jest tak naprawdę **funkcją** - jest to przygotowany kiedyś przez kogoś zestaw poleceń, który ma swoje określone działanie - w tym wypadku wydrukuje na terminalu dane podane w **argumentach** tejże funkcji - to, co znajduje się w nawiasach.


## Algorytmy do rozwiązania wspólnie

1. **Sprawdź, czy liczba jest dodatnia**  
	Wczytaj liczbę i sprawdź, czy jest większa od 0. Jeśli tak – wypisz „Dodatnia”, w przeciwnym razie „Niedodatnia”.
2. **Wypisz liczby od 1 do 5**  
	Użyj pętli, aby wypisać kolejno liczby 1, 2, 3, 4, 5.
3. **Znajdź większą z dwóch liczb**  
	Wczytaj dwie liczby i wypisz większą. Jeśli są równe, wypisz „Są równe”.
4. **Wypisz liczby parzyste od 1 do N**  
	Wczytaj N i za pomocą pętli oraz instrukcji warunkowej wypisz wszystkie liczby parzyste od 1 do N.

## Prawdziwe programowanie

### 1. Zmienne
W Pythonie (i ogólnie w programowaniu) jedną z kluczowych koncepcji jest **zmienna**. Przez pojęcie zmiennej rozumiemy przestrzeń w pamięci komputera, w której możemy umieścić *jakieś* dane. Dane te będą miały różne **typy**. 

```python
a = 10 #Integer
b = "test" #String
test = False #Bool
zmienna = 'a' #Char
Liczba = 21.37 #Double
```

To, co zrobiłem powyżej to operacje **przypisania**. W ten sposób tworzymy zmienną i przypisujemy do niej wartość. Zwróćcie uwagę, że każdą instrukcję zapisałem w oddzielnej linii - w ten sposób komputer jest w stanie rozdzielić jedną instrukcję od drugiej.

W pełni dopuszczalne jest zmienianie wartości zmiennej

```python
a = 10
a = "test"
```

Po tych dwóch operacjach **zmienna** ```a``` ma wartość ```"test"```. 

Do zmiennych możemy przypisywać wartości w bardzo prosty sposób - ```zmienna = ```  - cokolwiek podamy po prawej stronie znaku ```=``` zostanie zapisane do tej zmiennej - w tym również inna zmienna

```python
a = "test"
b = a
print(b)
```

Co zostanie wydrukowane po uruchomieniu powyższego kodu?

Python pozwala również na przypisywaniu wielu zmiennych w jednej linii, co niekiedy przyspiesza pracę:

```python
x, y, z = "Jabłko", "Banan", "Ananas"
print(x)
```

Dopuszczalne (ale często niepotrzebne) jest też przypisanie jednej wartości do wielu zmiennych:

```python
x = y = z = "Jabłko"
print(x,y,z)
```

Wybierając nazwy zmiennych powinniśmy przestrzegać kilku zasad nazewnictwa - nazwy zmiennych powinny być:
- krótkie, 
- opisywać, do czego zmienna jest używana
- mogą zawierać litery, cyfry, underscore ```_```

Dane do zmiennych mogą być również przyjmowane w inny sposób - poprzez użycie specjalnych funkcji - jedną z nich będzie ```input()```
```python
b = input("Napisz coś!")
```

Gdy używamy funkcji ```input()``` program się zatrzyma do momentu wpisania danych i wciśnięcia klawisza "Enter". Warto zwrócić tutaj uwagę, że funkcja ```input()``` z założenia przyjmuje zmienne typu **string**, czyli ciągi znaków - jeśli chcielibyśmy wprowadzić dane w innym typie musimy dokonać **rzutowania**, czyli procesu zmiany jednego typu danych na inny.

| **Typ danych** | **Funkcja konwersji** | **Przykład użycia**           | **Opis**                                                      |
| -------------- | --------------------- | ----------------------------- | ------------------------------------------------------------- |
| `int`          | `int(x)`              | `int("42") → 42`              | Konwertuje na liczbę całkowitą (obcina część dziesiętną).     |
| `float`        | `float(x)`            | `float("3.14") → 3.14`        | Konwertuje na liczbę zmiennoprzecinkową.                      |
| `str`          | `str(x)`              | `str(42) → "42"`              | Konwertuje na napis (string).                                 |
| `bool`         | `bool(x)`             | `bool(0) → False`             | Konwertuje na wartość logiczną (`0`, `""`, `None` → `False`). |

```python
# 1. Na int
print(int("42"))       # 42 (ze stringa na int)
print(int(3.99))       # 3 (obcięcie części dziesiętnej)

# 2. Na float
print(float("3.14"))   # 3.14 (ze stringa na float)
print(float(5))        # 5.0 (z int na float)

# 3. Na string
print(str(42))         # "42" (z int na string)
print(str(3.14))       # "3.14" (z float na string)

# 4. Bez konwersji
print(42.3)            # Wydrukuje się 42.3 - bez konwersji
print(3.14)
```

### 2. Arytmetyka
Programowanie wraz z całą informatyką wywodzi się z nauk matematycznych - stąd obliczenia matematyczne są bardzo ważną składową każdego języka programowania. Python udostępnia nam szereg operatorów:

| **Kategoria**    | **Operator** | **Opis**            | **Przykład**    |
| ---------------- | ------------ | ------------------- | --------------- |
| **Arytmetyczne** | `+`          | Dodawanie           | `3 + 2 = 5`     |
|                  | `-`          | Odejmowanie         | `3 - 2 = 1`     |
|                  | `*`          | Mnożenie            | `3 * 2 = 6`     |
|                  | `/`          | Dzielenie (float)   | `3 / 2 = 1.5`   |
|                  | `//`         | Dzielenie całkowite | `3 // 2 = 1`    |
|                  | `%`          | Reszta z dzielenia  | `3 % 2 = 1`     |
|                  | `**`         | Potęgowanie         | `3 ** 2 = 9`    |

Programowanie przestrzega prawidłowej kolejności wykonywania działań - potęgowanie zostanie wykonane przed mnożeniem i dzieleniem, a te zostaną wykonane przed dodawaniem lub odejmowaniem:

```python
a = 3 - 5 * 2
print(a)
```

Powyższy program zwróci nam wartość ```-7```.

```python
a = (3 - 5) * 2  
print(a)
```

Powyższy zwróci ```-4```. Warto również zwrócić uwagę, że obydwa programy mogłyby zostać uproszczone, ponieważ obliczenie możemy wykonać bezpośrednio w funkcji:

```python
print((3 - 5) * 2)
```

### Kilka zadań
1. Napisz program, który przyjmie 2 liczby i wydrukuje ich sumę (+), różnicę (-), iloczyn (\*\) i iloraz (/). Pamiętaj o ładnym opisaniu danych, które mają być wczytane
2. Napisz program, który przyjmie dwie liczby i obliczy z nich pole i obwód prostokąta
3. Napisz program, który przyjmie liczbę minut i przeliczy to na liczbę godzin i minut - np 192 minuty to 3 godziny 12 minut.

Poniższa tabela prezentuje operatory przypisania wraz z przykładami. Co do zasady pozwalają one na przyspieszenie pracy i ich używanie zazwyczaj nie jest konieczne - ale warto je znać. 

| **Kategoria**   | **Operator** | **Opis**                          | **Przykład**           |
| --------------- | ------------ | --------------------------------- | ---------------------- |
| **Przypisania** | `=`          | Przypisanie                       | `x = 5`                |
|                 | `+=`         | Dodaj i przypisz                  | `x += 2` (`x = x + 2`) |
|                 | `-=`         | Odejmij i przypisz                | `x -= 2`               |
|                 | `*=`         | Pomnóż i przypisz                 | `x *= 2`               |
|                 | `/=`         | Podziel i przypisz                | `x /= 2`               |
|                 | `//=`        | Dzielenie całkowite i przypisanie | `x //= 2`              |
|                 | `%=`         | Reszta i przypisanie              | `x %= 2`               |
|                 | `**=`        | Potęguj i przypisz                | `x **= 2`              |

### 3. Sterowanie zachowaniem programu
Wszystkie programy, które dotychczas stworzyliśmy wykonywały swoje instrukcje po kolei - a nie zawsze jest taka konieczność - niekiedy może się zdarzyć potrzeba, aby jakiś fragment kodu ominąć, albo wykonać go pod warunkiem spełnienia jakiegoś warunku. Do tego właśnie służą **instrukcje warunkowe**. Instrukcja warunkowa ```if``` przyjmuje w argumencie (podanym w nawiasach) wyrażenie lub wartość typu Bool - czyli prawda lub fałsz (True lub False). 

```python
if (statement1):
	print("Statement 1 to prawda")
elif (statement2):
	print("Statement 1 to Fałsz, Statement 2 to Prawda")
else: 
	print("Statement 1 i Statement 2 to Fałsz")
```

Zagadka: Co zostanie wydrukowane, jeśli oba statementy ustawione są na wartość True?

Specjalne operacje porównawcze dostępne w pythonie zwracają wartości True albo False:

| **Kategoria**  | **Operator** | **Opis**                                    | **Przykład**             |
| -------------- | ------------ | ------------------------------------------- | ------------------------ |
| **Porównania** | `==`         | Równe                                       | `3 == 3 → True`          |
|                | `!=`         | Różne                                       | `3 != 2 → True`          |
|                | `>`          | Większe niż                                 | `3 > 2 → True`           |
|                | `<`          | Mniejsze niż                                | `3 < 2 → False`          |
|                | `>=`         | Większe lub równe                           | `3 >= 2 → True`          |
|                | `<=`         | Mniejsze lub równe                          | `3 <= 3 → True`          |
| **Logiczne**   | `and`        | Logic AND (oba warunki muszą być prawdziwe) | `True and False → False` |
|                | `or`         | Logic OR (jeden warunek prawdziwy)          | `True or False → True`   |
|                | `not`        | Negacja logiczna                            | `not True → False`       |
Dobrą metodą sprawdzenia, czy nasza logika działa jest próba wydrukowania wyniku:

```python
a = 10
print(a == 7,a > 11, a == 10)
```

Połączenie operacji porównawczych z wyrażeniami warunkowymi otwiera nam drzwi do tworzenia znacznie bardziej skomplikowanych programów, ale również doweryfikacji danych podawanych przez użytkownika, bądź przychodzących z innych źródeł. Na przykład, powyżej napisaliśmy program, który przyjmował dwie liczby i liczył pole i obwód prostokąta. Czy taki program powinien wykonać się niezależnie od podanych danych? Nie ma przecież prostokątów, które mają jeden bok krótszy niż 0cm. Przy użyciu instrukcji warunkowej ```if``` możemy sprawdzić, czy podawane dane są poprawne.

#### Zadanie 1:
W ZOO w Gdańsku bilet normalny kosztuje 45 zł, a ulgowy 35 zł. 
- Dzieci poniżej 3 roku życia oraz seniorzy powyżej 70 lat wchodzą za darmo
- Dzieci i młodzież do 26 lat korzysta z biletów ulogwych
- powyżej 26 roku życia obowiązuje bilet normalny
Napisz program, który przyjmie od użytkownika liczbę - wiek osoby i w odpowiedzi wydrukuje kwotę, którą ta osoba powinna zapłacić za wstęp.

#### Zadanie 2:
W Multikinie bilety kosztują:
- bilet normalny: **30 zł**,
- bilet studencki: **20 zł**,
- bilet dla seniora (od 65 lat): **15 zł**.

Dzieci do 4 lat mają **wstęp za darmo**.
**dodatkowo:**
- W **środy** wszystkie bilety są tańsze o **5 zł**, z wyjątkiem biletów darmowych.

**Twoje zadanie:**
- Zapytaj użytkownika o **wiek**,
- zapytaj, czy jest **studentem** (`tak/nie`),
- zapytaj o **dzień tygodnia** (np. „poniedziałek”),
- wyświetl kwotę do zapłaty po uwzględnieniu ewentualnej zniżki.