---
layout: lab
course: Python
type: stacjonarne
lab_nr: 8
subject: Własne API
description: Wycsyłamy dane na zewnątrz!
---

Na poprzednim spotkaniu korzystaliśmy z zewnętrznego API, a w naszej aplikacji wyciągaliśmy dane za pomocą `requests`. Teraz postawimy się po drugiej stronie i pracować będziemy nad aplikacją serwerową - czyli teraz to nasza aplikacja będzie wysyłała dane.

**FastAPI** to nowoczesny framework webowy dla języka Python, który pozwala szybko budować interfejsy **API**. Jest lekki, szybki i bardzo intuicyjny, idealny do nauki i prototypowania.

Architektura naszej aplikacji będzie dziś relatywnie prosta, ale nadal będziemy mieli kilka różnic względem tego, jak dotychczas pracowaliśmy. Najpierw musimy zainstalować 2 *packages*: 

- `fastapi` - cały framework, który będzie odbierał zapytania HTTP i zwracał odpowiedzi
- `uvicorn` - najprostszy serwer

Nasze aplikacje serwerowe zawsze zaczynać będziemy od importu `fastapi`:

```python
from fastapi import FastAPI
```

Następnie musimy **utworzyć instancję aplikacji** - to obiekt `app` będzie zarządzał naszym API

```python
app = FastAPI()
```

```python
@app.get("/")
def root():
    return {"message": "Witaj w FastAPI!"}
```

To definicja **trasy (ang. route)** w aplikacji:
- `@app.get("/")` – **dekorator**, który mówi:
    > _"kiedy użytkownik wyśle żądanie GET na adres główny (`/`), uruchom funkcję `root`"._
- `def root():` – to funkcja, która **obsługuje to żądanie**.  
    Jej wynik zostanie wysłany jako odpowiedź HTTP.
- `return {"message": "Witaj w FastAPI!"}` – zwraca słownik (dict), który FastAPI automatycznie konwertuje na **JSON**, czyli:

### Uruchomienie
Tu mamy małą rewolucję, względem tego, co robiliśmy do tej pory - aplikację w `uvicorn` uruchomić będziemy musieli przez terminal. W terminalu (np. w PyCharmie) wpisać należy polecenie `uvicorn main:app --reload` i wcisnąć Enter. Od teraz za każdym razem jak zapiszemy plik pythona, to nasze API będzie się ładowało samoczynnie, nic nie musimy więcej robić. W odpowiedzi na terminalu pojawi się nam adres, na którym działa aplikacja.
### Jak to działa w praktyce?
Jeśli uruchomisz aplikację, a następnie otworzysz przeglądarkę i wejdziesz na `http://127.0.0.1:8000/`, zobaczysz:

```json
{"message": "Witaj w FastAPI!"}
```

A to już po wczorajszych zajęciach powinien być znajomy widok.

###  Bonus: automatyczna dokumentacja

FastAPI ma wbudowane narzędzie Swagger UI – jeśli wejdziesz na `http://127.0.0.1:8000/docs`, zobaczysz **interaktywne API**, które tworzy się automatycznie.


## Obsługa zapytań
Po wczorajszych zajęciach poznaliśmy dwa sposoby na wskazanie **API**, jakie dane nas interesują:
- `https://catfact.ninja/fact` - 'goły' adres - zwracał losowy fakt
- `https://restcountries.com/v3.1/all?fields=name,capital,population,region` - w tym wypadku po znaku `?` podawaliśmy listę *pól*, które nas interesowały - był to **parametr** - w ten sposób będziemy pracować dziś:

Na razie nasze API powinno wyglądać tak:

```python
from fastapi import FastAPI

app = FastAPI()

@app.get("/")
def root():
    return {"message": "Hello, FastAPI!"}
```

Czyli zapytanie na adres API zawsze zwraca nam wiadomość "Hello, FastAPI". Czyli mamy w aplikacji jednego, prostego *endpointa*. Dopiszemy teraz nowego, który będzie przyjmował dane w parametrze.

```python
@app.get("/hello")
def hello(name: str = "Anon"):
    return {"greeting": f"Hello {name}!"}
```

Teraz zwróćcie uwagę: nasz *dekorator* wskazuje, że do funkcji *hello* będziemy wchodzić, gdy do API przyjdzie request na adres URL `http://127.0.0.1:8000/hello`. Funkcja w argumencie przyjmuje 
```python
(name: str = "Anon")
```

Wskazaliśmy w ten sposób, że w adresie URL *może* znaleźć się parametr *name* i będzie on *stringiem*. Gdy do aplikacji trafi zapytanie z tym parametrem, to wewnątrz funkcji będziemy mieli do niego dostęp poprzez zmienną `name`. Jeśli zapytanie na adres `/hello` będzie puste (czyli bez parametru), to aplikacja dopisze sobie do niego stringa "Anon". 

#### Zadanie na zajęcia 1:

Przygotuj prostą aplikację, która będzie obsługiwała jeden *endpoint* - `/square`. Powinien on przyjmować w parametrze liczbę typu `int` i zwracać jej drugą potęgę - czyli zapytanie na 
`http://127.0.0.1:8000/square?x=10` powinno zwrócić nam JSON-a 

```json
{ "square": 100 }
```

Możemy w ramach jednego zapytania podać dwa lub więcej parametrów - np. 

```python
@app.get("/sum")
def add(x: int, y: int):
    return {"result": x + y}
```

W takim wypadku request, który będziemy musieli wysłać do API będzie potrzebował dwóch parametrów - `x` i `y` - `http://127.0.0.1:8000/sum?x=10&y=5` - pomiędzy argumentami znajduje się znak `&`.

##  Mini-projekt: Kalkulator w FastAPI (`/calc`)

Celem tego mini-projektu jest stworzenie endpointa `/calc`, który przyjmuje trzy parametry: `x`, `y` oraz `op`, a następnie wykonuje odpowiednią operację matematyczną.

---

###  Krok 1: Przygotuj bazowy endpoint `/calc`

**Opis:**  
Utwórz w pliku aplikacji nowy endpoint `/calc`, który przyjmuje dwa parametry typu `int`: `x` oraz `y`. Na razie nie musi niczego jeszcze liczyć — niech tylko zwraca odebrane dane w formie słownika.

**Wymagania:**

| ID  | Wymaganie |
|-----|-----------|
| K1  | Endpoint działa pod adresem `/calc` |
| K2  | Funkcja przyjmuje dwa parametry `x: int` i `y: int` |
| K3  | Wynikiem działania funkcji jest słownik z tymi danymi, np. `{"x": 2, "y": 3}` |

---

###  Krok 2: Dodaj trzeci parametr `op` i podstawową obsługę

**Opis:**  
Dodaj trzeci parametr `op` typu `str`, który będzie mówił, jaką operację należy wykonać. Jeśli użytkownik wpisze `op=add`, funkcja ma zwrócić sumę `x + y`.

**Wymagania:**

| ID  | Wymaganie |
|-----|-----------|
| K1  | Endpoint nadal działa pod `/calc` |
| K2  | Funkcja przyjmuje trzy parametry: `x: int`, `y: int`, `op: str` |
| K3  | Gdy `op` to `"add"`, funkcja zwraca `{"result": x + y}` |
| K4  | Dla innych wartości `op` funkcja zwraca na razie `{"error": "Nieznana operacja"}` |

---

###  Krok 3: Rozszerz obsługę o wszystkie operacje

**Opis:**  
Rozszerz funkcję tak, aby obsługiwała dodatkowe wartości parametru `op`: `sub`, `mul`, `div`.

**Wymagania:**

| ID  | Wymaganie |
|-----|-----------|
| K1  | Gdy `op == "sub"`, zwracana jest różnica `x - y` |
| K2  | Gdy `op == "mul"`, zwracany jest iloczyn `x * y` |
| K3  | Gdy `op == "div"` i `y != 0`, zwracany jest iloraz `x / y` |
| K4  | Dla nieznanych wartości `op`, zwracany jest błąd `{"error": "Nieznana operacja"}` |

---

###  Krok 4: Zabezpiecz dzielenie przez zero

**Opis:**  
Dodaj obsługę przypadku, gdy użytkownik wybierze `op=div` i poda `y = 0`. W takim przypadku funkcja powinna nie wykonywać dzielenia, lecz zwrócić informację o błędzie.

**Wymagania:**

| ID  | Wymaganie |
|-----|-----------|
| K1  | Jeśli `op == "div"` i `y == 0`, funkcja zwraca `{"error": "Dzielenie przez zero!"}` |
| K2  | Dla poprawnych danych zwracany jest wynik dzielenia |

### Zadanie dodatkowe (opcjonalnie)

Dopisz mechanizm przechowywania historii - każdy wykonany request poinien zostać zapisany. Utwórz endpoint /history, który zwróci nam wszystkie zgłoszone zapytania. 