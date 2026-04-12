---
layout: lab
course: Python
type: stacjonarne
lab_nr: 9
subject: Własne API - Operacja CRUD
description: Dane przychodzą z zewnątrz!
---

Dotychczas nauczyliśmy się tworzyć własne, proste API oraz obsługiwać requesty z API. Jednak nasze dotychczasowe osiągnięcia ograniczały się do obsługi zapytań HTTP `GET` - zarówno nasze requesty jak i API w praktyce nie obsługiwały innych metod. Dziś się to zmieni!


Celem dzisiejszych zajęć jest nauczenie się tworzenia pełnoprawnego API, które umożliwia:

- Dodawanie nowych elementów (Create)
- Pobieranie danych (Read)
- Modyfikowanie danych (Update)
- Usuwanie danych (Delete)

Takie API nazywamy API CRUD, od nazw angielskich operacji, które można na nim wykonać. Plan na dziś zakłada, że stworzymy własne API, które **nie tylko udostępnia dane (GET)**, ale również pozwala je **tworzyć, edytować i usuwać**. 

Dziś będziemy pracowali naraz na dwóch programach - mogą się one znajdować w jednym projekcie  - jeden będzie służył do obsługi requestów, a drugi to będzie nasze API

Oczywistym jest, że gdzieś musimy przechowywać nasze dane - na potrzeby przykładu skorzystamy z prostej listy słowników:

```python
cars = [
    {"id": 1, "brand": "Toyota", "model": "Corolla", "year": 2012},
    {"id": 2, "brand": "Ford", "model": "Focus", "year": 2018},
    {"id": 3, "brand": "Tesla", "model": "Model 3", "year": 2021},
    {"id": 4, "brand": "Volkswagen", "model": "Golf", "year": 2015},
    {"id": 5, "brand": "BMW", "model": "320i", "year": 2019}
]
```

### Pierwsze kroki

Zaczniemy od napisania naszego API. I tu na razie bez niespodzianek:

```python
from fastapi import FastAPI

app = FastAPI()
```

Następny krok jest już bardziej niespodziewany - wprowadzimy sobie Pydantic - bibliotekę, która będzie służyła do walidacji danych (czyli sprawdzania, czy podawane dane są poprawne) oraz konwertowania danych do odpowiednich typów.

```python
from pydantic import BaseModel
```

To zaimportuje nam tzw. BaseModel. Jego deklaracja jest bardzo prosta -

```python
class Car(BaseModel):
    brand: str
    model: str
    year: int
```

Ten BaseModel mówi nam, że każdy samochód musi mieć `brand`, `model` i `year`. Pydantic jest jak **inteligentny filtr danych** – dba o to, żeby użytkownik nie mógł przesłać "śmieci" do Twojej aplikacji. Dzięki niemu FastAPI jest:

- **bezpieczne** (bo dane są sprawdzane),
- **czytelne** (bo wiesz, czego się spodziewać),
- **łatwe w użyciu** (bo błędy są automatyczne i opisane).

Gdy już określiliśmy, z jakich komponentów musi składać się bazowa informacja o samochodzie, dodamy sobie prostą listę:

```python
cars = [  
    {"id": 1, "brand": "Toyota", "model": "Corolla", "year": 2012},  
    {"id": 2, "brand": "Ford", "model": "Focus", "year": 2018},  
    {"id": 3, "brand": "Tesla", "model": "Model 3", "year": 2021}  
    ]
```

Zwróćcie uwagę, że każdy **słownik** na tej **liście** ma pola, które nazywają się tak, jak stworzony przez nas przed chwilą model, ale jeszcze nigdzie go nie zastosowaliśmy - modeli Pydantic będziemy używali do weryfikacji danych przychodzących z zewnątrz i dodawanych do tej "bazy danych" - dzięki temu mamy pewność, że zawsze będą poprawne

Następnym krokiem będzie wystawienie endpointu, który zwróci nam wszystkie auta. Tu po wczorajszym spotkaniu również nie powinno być niespodzianek.

```python
@app.get("/cars")  
def get_all_cars():  
    return cars
```

Natomiast małą niespodzianką może być to, w jaki sposób poprosimy o samochód o konkretnym ID. Dotychczas informacje z zewnątrz przekazywaliśmy przez *parametr*. Teraz zrobimy to odrobinę inaczej -

```python
@app.get("/cars/{car_id}")
def get_car(car_id: int):
	### kod dla endpointu
```

Różnica jest niewielka - po standardowym endpoincie dodałem `/{car_id}` - dzięki temu nie będziemy musieli umieszczać parametrów po znaku `?` ani podawać ich nazw - *request* o samochód o id **1** zamiast wyglądać tak: `https://adres.com/cars?id=1` będzie wyglądał tak: `https://adres.com/cars/1` - trochę ładniej.

```python
@app.get("/cars/{car_id}")  
def get_car(car_id: int):  
    for car in cars:  ### car to nazwa wewnętrzna dla tej funkcji, cars to lista
        if car["id"] == car_id:  
            return car
```


### Obsługa POST
Clue naszych dzisiejszych zajęć - na szczęście nie jest jest to specjalnie skomplikowane. Zaczniemy od nowego dekoratora:

```python
@app.post("/cars")
```

I tu będzie zasadnicza różnica - dane do POST nie będą przekazywane w URL, a w *body* zapytania HTTP. Będą przekazywane w postaci JSON, co na szczęście bardzo wiele nam uprości. Jeszcze więcej uprości to, że jest to działanie domyślne, więc nie musimy się nic nowego uczyć.

```python
def add_car(car: Car):
```

W ten sposób powiemy programowi, że używany wewnątrz słownik `car` będzie miał Pydanticową strukturę określoną przez nas wyżej w modelu `Car`. Teraz w zasadzie jedyna rzecz która pozostaje to napisanie funkcji, która będzie do naszej listy `cars` dodawała nowy samochód, którego **wszystkie** dane przychodzą do nas z zewnątrz - poza ID. Zatem nasza funkcja musi:
- ustalić jakie jest najwyższe ID w bazie i nowe ID ustawić na o 1 większe
- dodać klucz `id` do słownika z pozostałymi danymi samochodzu
- zapisać ten słownik

```python
@app.post("/cars")  
def add_car(car: Car):  
    new_id = max([c["id"] for c in cars]) + 1 if cars else 1  
    car_data = car.dict()  
    car_data["id"] = new_id  
    cars.append(car_data)  
    return car_data
```

Wiem, że mimo moich osobistych tłumaczeń na zajęciach pierwsza linijka, odpowiadająca za znalezienie największego id w liście może nie być zrozumiała, dlatego poniżej alternatywa:

```python
if cars:
    new_id = cars[-1]["id"] + 1
else:
    new_id = 1
```

Ten przykład zakłada, że jeśli lista cars istnieje, to sprawdzamy id ostatniego elementu i dodajemy do niego 1. 

Funkcje obsługujące requesty poniżej:

```python
import requests

BASE_URL = "http://localhost:8000"

# Pobierz wszystkie samochody
def get_all_cars():
    response = requests.get(f"{BASE_URL}/cars")
    print("Lista samochodów:")
    for car in response.json():
        print(car)

# Dodaj nowy samochód
def add_car():
    car = {
        "brand": "Mazda",
        "model": "CX-5",
        "year": 2020
    }

    response = requests.post(f"{BASE_URL}/cars", json=car)
    print("Dodano samochód:")
    print(response.json())
```

Na szczególną uwagę oczywiście zasługuje funkcja `add_car()` - request `POST` przyjmuje 2 argumenty - o 1 więcej niż get. Drugi argument to json zawierający słownik z danymi samochodu.


# Laboratorium: API do zarządzania zwierzakami w schronisku

Stworzysz proste API dla schroniska dla zwierząt. Użytkownicy będą mogli:
- pobierać listę zwierząt,
- pobierać konkretne zwierzę po ID,
- dodawać nowe zwierzęta.

Twoim zadaniem jest rozszerzać funkcjonalność krok po kroku, aż stworzysz działające mini-API.

## Krok 1: Utwórz bazową aplikację FastAPI

### Wymagania funkcjonalne
- Aplikacja FastAPI działa lokalnie.
- Endpoint `/ping` zwraca komunikat `"API is working"`.

### Co należy zrobić
1. Utwórz plik `main.py`.
2. Zaimportuj FastAPI i utwórz obiekt aplikacji.
3. Dodaj endpoint `GET /ping`, który zwraca `{"message": "API is working"}`.
4. Uruchom serwer lokalnie (`uvicorn main:app --reload`) i przetestuj działanie `/ping`.

---
## Krok 2: Dodaj przykładową listę zwierząt

### Wymagania funkcjonalne
- W aplikacji dostępna jest lista zwierząt (`animals`) zawierająca kilka słowników.
- Każdy zwierzak ma `id`, `name`, `species`, `age`.

### Co należy zrobić
1. Stwórz listę zwierząt na górze pliku:
   ```python
   animals = [
       {"id": 1, "name": "Burek", "species": "dog", "age": 5},
       {"id": 2, "name": "Mruczek", "species": "cat", "age": 3},
   ]
   ```
2. Dodaj endpoint `GET /animals`, który zwraca pełną listę zwierząt.
3. Sprawdź w przeglądarce (`/docs`) czy zwracane dane są poprawne.
---

## Krok 3: Pobieranie zwierzęcia po ID

### Wymagania funkcjonalne
- Endpoint `GET /animals/{animal_id}` zwraca dane konkretnego zwierzaka.
- Jeśli nie znaleziono – zwraca komunikat `"Animal not found"`.

### Co należy zrobić
1. Dodaj nowy endpoint `GET /animals/{animal_id}`.
2. Wyszukaj zwierzaka po `id` w liście `animals`.
3. Jeśli istnieje – zwróć jego dane.
4. Jeśli nie – zwróć `{"error": "Animal not found"}`.
---

## Krok 4: Obsługa POST – dodawanie nowego zwierzęcia

### Wymagania funkcjonalne
- Można dodać nowe zwierzę za pomocą `POST /animals`.
- Wysłane dane powinny zawierać `name`, `species`, `age`.
- Aplikacja automatycznie nadaje nowe `id`.

### Co należy zrobić
1. Utwórz klasę `AnimalInput` dziedziczącą po `BaseModel` z polami:
   ```python
   name: str
   species: str
   age: int
   ```
2. W endpointcie `POST /animals`:
   - odbierz dane jako obiekt `animal: AnimalInput`,
   - nadaj nowe `id` (np. `animals[-1]["id"] + 1` lub `1`, jeśli lista pusta),
   - stwórz nowy słownik i dodaj go do listy `animals`.
3. Zwróć dodanego zwierzaka jako odpowiedź.
---
## Krok 5: Przetestuj API klientem

### Wymagania funkcjonalne
- Można pobrać wszystkie zwierzęta (`GET /animals`).
- Można dodać nowe zwierzę (`POST /animals`).
- Dane są widoczne po dodaniu (kolejny `GET` zwraca również nowy wpis).

### Co należy zrobić
1. W osobnym pliku `client.py`:
   - napisz funkcję `get_animals()` – wypisuje wszystkie zwierzaki,
   - napisz funkcję `add_animal()` – dodaje jednego nowego zwierzaka.
1. Uruchom `client.py`, dodaj zwierzaka, sprawdź czy się dodał.

---

# Dodatkowe kroki: PUT i DELETE w API

## Krok 6: Obsługa PUT – zmiana imienia zwierzaka

### Wymagania funkcjonalne
- Endpoint `PUT /animals/{animal_id}` umożliwia zmianę tylko pola `name`.
- Jeśli zwierzę o podanym `id` istnieje – jego imię zostaje zaktualizowane.
- Jeśli nie istnieje – zwracany jest komunikat `"Animal not found"`.

### Co należy zrobić
1. Utwórz klasę `AnimalNameUpdate` z jednym polem:
   ```python
   name: str
   ```
   Będzie to model przyjmujący JSON z 1 kluczem - `name`
2. Dodaj endpoint PUT /animals/{animal_id}.
3. Wyszukaj zwierzaka po id.
4. Jeśli istnieje – zaktualizuj jego name i zwróć zaktualizowany obiekt.
5. Jeśli nie – zwróć {"error": "Animal not found"}.

## Krok 7: Obsługa DELETE – usuwanie zwierzaka po ID
### Wymagania funkcjonalne
- Endpoint DELETE /animals/{animal_id} usuwa zwierzaka o podanym id.
- Jeśli zwierzę zostanie usunięte – zwraca komunikat "Animal deleted".
- Jeśli nie znaleziono – zwraca komunikat "Animal not found".
### Co należy zrobić
1. Dodaj endpoint DELETE /animals/{animal_id}.
2. Przeszukaj listę animals w celu znalezienia pasującego id.
3. Jeśli znaleziono – usuń zwierzaka z listy.
4. Zwróć odpowiedni komunikat zależnie od tego, czy zwierzę zostało znalezione.