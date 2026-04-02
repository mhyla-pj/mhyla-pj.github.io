---
layout: lab
course: Python
type: stacjonarne
lab_nr: 4
subject: Zadania praktyczne 
description: Rozwój małych projektów
---


Na dzisiejszych zajęciach właściwie nie poznamy żadnej nowej technologii ani żadnego nowego elementu Pythona. Szlifować będziemy dzisiaj inny niż znajomość języka zestaw umiejętności programistycznych. Gdy pracujemy nad większym projektem, niezależnie czy na swoje potrzeby czy w firmie, to musimy być świadomi, że taki projekt nie powstaje "sam z siebie". Jego realizacja jest składową wielu kroków - od planowania funkcjonalności, przez określenie kamieni milowych rozwoju projektu, implementacje kolejnych kroków, testy, aż po dokumentację. Dziś, przynajmniej w pierwszej części, będziemy pracować w parach.

## Projekt 1: Kalkulator

Zaczniemy od planowania. Chciałbym, aby kalkulator działał w konsoli. Zasada działania jest w zasadzie prosta:
- Kalkulator ma obsługiwać operacje `+`, `-`, `*`, `/`, `^`;
- Realizacja każdej operacji ma być umieszczona w oddzielnej funkcji
- Kalkulator ma przyjmować obliczenia w jednej linii, np.: `2 + 17` i po wciśnięciu klawisza `Enter` zwracać wynik
- Przyjmowanie operacji również ma być wyniesione do funkcji
- Kalkulator ma przechowywać historię wykonanych operacji i pozwalać na jej wyświetlenie
- Kalkulator powinien działać w pętli - jeśli użytkownik wpisze `exit` lub `quit`, to powinien się zakończyć
- Aplikacja ma mieć proste menu tekstowe - jeśli użytkownik wpisze opcję `history`, `exit` lub `quit`, to aplikacja ma wykonać odpowiednią akcję, w przeciwnym wypadku zakładamy, że wprowadzono operację do obliczenia


### Planowanie

W zespołach omówcie kolejność, w jakiej implementować będziecie zaproponowane powyżej funkcjonalności. Nie realizujemy całego projektu na jednej raz - cel dzisiejszych zajęć to pokazanie wam, jak ważne jest rozbijanie dużych zadań na mniejsze komponenty. Dziś pracujemy "iteracyjnie", w każdym kolejny kroku rozbudowując nasz kalkulator o kolejną funkcjonalność. Pracując wspólnie wypiszcie kolejne "kroki" implementacji, na przykład:

#### Krok 1: Rozpoznawanie znaku**
- Input/Trigger: Terminal, jeden ze znaków: `+`, `-`, `*`, `/`, `^`
- Oczekiwany efekt: Program wchodzi w funkcję odpowiadającą znakowi (`add()`, `sub()` itd.)
- Potencjalne błędy: Wprowadzono znak inny niż przewidziano

#### Krok 2: Rozbicie stringa na dwie liczby oraz znak operacji
- Input/Trigger: Terminal, wyrażenie do obliczenia, np. `2 * 7`
- Oczekiwany efekt: Program dzieli stringa i rozpoznaje, co jest pierwszą liczbą, co znakiem, a co drugą liczbą - wydruk informacji co jest czym
- Potencjalne błędy: Wprowadzono stringa, który nie jest wyrażeniem arytmetycznym

I tak dalej - faza planowania zazwyczaj jest nudna, żmudna i kroki, które wyprodukujemy będą się w trakcie realizacji projektu musiały zmienić, ale to nadal bardzo ważny etap pracy nad projektem.


### Implementacja

Krok najprostszy do opisania: po prostu implementujemy po kolei funkcjonalności opisane we wcześniejszym etapie, pamiętając o tym, aby po każdej zaimplementowanej funkcjonalności przetestować program, czy działa tak, jak byśmy tego na danym etapie jego rozwoju oczekiwali. 

**Krok 1** -> analiza kroku -> implementacja kroku -> test, czy działa -> **analiza kroku 2** -> implementacja kroku 2 -> test, czy krok 2 działa -> test, czy krok 1 + krok 2 działają -> itd....


## Plan implementacji kalkulatora konsolowego (Python)

### 1. Przygotowanie środowiska
- Utwórz nowy plik `kalkulator.py`.
- Ustal strukturę programu (funkcje, zmienne globalne np. do historii).

---

### 2. Implementacja podstawowych operacji matematycznych
Dla każdej operacji tworzona jest osobna funkcja:
- `dodaj(a, b)` – zwraca sumę `a + b`.
- `odejmij(a, b)` – zwraca różnicę `a - b`.
- `pomnoz(a, b)` – zwraca iloczyn `a * b`.
- `podziel(a, b)` – zwraca wynik `a / b` (z kontrolą dzielenia przez zero).
- `potega(a, b)` – zwraca wynik `a ** b`.

---

### 3. Funkcja obsługująca pojedyncze wyrażenie
- Napisz funkcję `wykonaj_operacje(wyrazenie: str)`, która:
  1. Dzieli wprowadzone wyrażenie po spacjach, np. `"2 + 3" → ['2', '+', '3']`.
  2. Konwertuje liczby na typ `float`.
  3. Sprawdza, jaki operator został wpisany (`+`, `-`, `*`, `/`, `^`).
  4. Wywołuje odpowiednią funkcję matematyczną.
  5. Zwraca wynik.

---

### 4. Funkcja do pobierania wejścia od użytkownika
- Utwórz funkcję `pobierz_wejscie()`, która:
  - Pobiera tekst z `input()`.
  - Sprawdza, czy nie wpisano komendy specjalnej (`exit`, `history`, `clear`).
  - Przekazuje wyrażenie do `wykonaj_operacje()`.

---

### 5. Historia działań
- Utwórz listę `history = []`.
- Po każdej operacji dodawaj wpis w formacie `"2 + 3 = 5"`.
- Dodaj obsługę komendy `history`:
  - Funkcja `pokaz_historie()` wypisuje całą historię działań.

---

### 6. Obsługa błędów
- W `wykonaj_operacje()` dodaj `try/except`:
  - Obsłuż błąd dzielenia przez zero.
  - Obsłuż błędne dane (np. `ValueError` gdy ktoś wpisze literę zamiast liczby).
  - Wypisz komunikat, ale nie przerw program.

---

### 7. Główna pętla programu
- Utwórz funkcję `main()`, która:
  - W pętli `while True` pobiera wejście od użytkownika.
  - Kończy działanie po wpisaniu `exit` lub `quit`.
  - Wywołuje `pobierz_wejscie()` i drukuje wynik.

---

### 8. Dodatkowe funkcjonalności (opcjonalnie)
- Dodaj komendę `clear`, która czyści historię.
- Dodaj zmienną `_`, w której przechowywany jest ostatni wynik.
- Wprowadź formatowanie wyniku (np. 2 miejsca po przecinku).
