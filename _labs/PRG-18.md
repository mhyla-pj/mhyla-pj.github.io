---
layout: lab
course: PRG
type: stacjonarne
lab_nr: 18
subject: Wstęp do Pythona
description: Powrót do programowania dla dzieci
---
Python to język ogólnego przeznaczenia, który jest wyjątkowo czytelny i elastyczny. Podczas tego laboratorium zgłębimy podstawowe aspekty Pythona, porównamy jego elementy ze znanym nam C++ i pośmiejemy się z tego języka.

Python stał się jednym z najpopularniejszych języków programowania dzięki swojej prostocie, czytelności kodu oraz bogatej społeczności. Jest wykorzystywany w wielu dziedzinach, takich jak analiza danych, sztuczna inteligencja, rozwijanie stron internetowych i wiele innych. Jego składnia przypomina język angielski, co sprawia, że jest przyjazny dla początkujących.

Python jest językiem interpretowanym, czyli kod źródłowy nie jest kompilowany bezpośrednio na kod maszynowy przed uruchomieniem, jak to ma miejsce w przypadku języków kompilowanych, takich jak C++. W przypadku Pythona, kod źródłowy jest najpierw przetwarzany przez interpreter, który tłumaczy go na kod maszynowy lub kod bajtowy (bytecode), który jest następnie wykonywany przez maszynę wirtualną Pythona (Python Virtual Machine - PVM). To sprawia, że Python jest bardziej przenośny, ponieważ kod źródłowy Pythona może być uruchamiany na różnych platformach bez konieczności kompilacji na każdej z nich.

## Zmienne i typy danych

W Pythonie zmienne są dynamicznie typowane, co oznacza, że nie musimy deklarować typu zmiennej podczas jej tworzenia. Typ zmiennej jest przypisywany automatycznie w trakcie przypisywania wartości do zmiennej. Co nie znaczy, że zmienna nie ma typu, jak w bashu - jest on po prostu automatycznie wykrywany w momencie tworzenia:

```python
x = 5
tekst = "Jajco"
test = True
```

W Pythonie wszystko możemy zrobić na milion sposobów, które się od siebie nie różnią, ale za to każdy sposób ma swoich zwolenników i przeciwników, którzy nie zapomną wytknąć nam tego przy zupełnie niezwiązanym pytaniu na stackoverflow. Wydruk zmiennej:

```python
# Przykłady wydrukowania zmiennej
imie = "Anna"
liczba_calkowita = 10
liczba_zmiennoprzecinkowa = 3.14

# Wydrukowanie zmiennej
print(imie)  # Wyświetli: Anna

# Możemy również łączyć zmienne w jednym wywołaniu print()
print("Imię:", imie, "Liczba całkowita:", liczba_calkowita)

# Formatowanie stringów - metoda f-string (dostępna od Pythona 3.6)
print(f"Imię: {imie}, Liczba całkowita: {liczba_calkowita}, Liczba zmiennoprzecinkowa: {liczba_zmiennoprzecinkowa}")

# Metoda format()
print("Imię: {}, Liczba całkowita: {}, Liczba zmiennoprzecinkowa: {}".format(imie, liczba_calkowita, liczba_zmiennoprzecinkowa))
```

## Listy (nie do M.)

Listy w Pythonie są strukturami przechowującymi wiele zmiennych jednego typu, czyli w zasadzie dokładnie tym samym co tablice w C, z tą różnicą, że listy są zawsze dynamiczne.

```python
# Tworzenie listy:
lista = [1, 2, 3, 4, 5]

# Odczyt elementu
element = lista[0]

# Nadpisanie elementu
lista[0] = 9

# Dopisanie elementu na koniec listy:
lista.append(10)

# Usunięcie elementu z końca listy
lista.remove(4)

# Długość listy
len(lista)
```

## Pętle

Petle każdy zna i lubi. Koncept pętli pozostaje niezmienony, natomiast składnia jak najbardziej

```python
# Petla for-each wykonuje się dla każdego elementu w liście
for element in lista:
    print(element)

# Pętla while
licznik = 0
while licznik < 5:
    print(licznik)
    licznik += 1

# Pętla for z funkcją range()
for i in range(5):
    print(i)
```

Zauważyć należy, że w pythonie nie zamykamy funkcji w klamerkach, a oddzielamy je od reszty kodu wcięciami. Zgodnie z PEP8 będzie to 1 `Tab` lub 4 spacje.

## Warunki
if, else, elif - odpowiednik C++ else if. Nie ma tu żadnych tajemnic

```python
x = 5
if x > 5:
    print("x jest większe niż 5")
elif x == 5:
    print("x jest równe 5")
else:
    print("x jest mniejsze niż 5")
```

Warto wspomnieć też o łącznikach logicznych:

```python
x = 10
y = 20

if x > 5 and y > 10:
    print("Oba warunki są spełnione")

if x > 15 or y > 15:
    print("Przynajmniej jeden z warunków jest spełniony")

if not x == 0:
    print("x nie jest równe 0")
```

