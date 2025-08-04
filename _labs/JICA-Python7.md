---
layout: lab
course: Python
type: stacjonarne
lab_nr: 7
subject: Korzystanie z API
description: Wyciągamy dane z zewnątrz!
---

Jak wszyscy dobrze wiemy, w naszych programach możemy różne dane przetwarzać na wiele sposobów - wyświetlić je, zsumować, usunąć, cokolwiek. Cała magia programowania polega na tym, że bardzo szybko przerabiane jest bardzo dużo danych. Jednak dotychczas wszystko nad czym pracowaliśmy było generowane przez nas. To zmieni się dziś - bowiem na dziesiejszym spotkaniu będziemy pracowali z API.

  

**API** (ang. *Application Programming Interface*) to interfejs programistyczny aplikacji, który pozwala na komunikację pomiędzy różnymi programami lub usługami. Generalnie, w kontekście aplikacji internetowych najczęściej spotykamy się z **API REST**, które umożliwia przesyłanie i odbieranie danych przez protokół HTTP.

  

API działa według schematu:

1. Program wysyła zapytanie (ang. *request*) do API.
2. API przetwarza zapytanie i odsyła odpowiedź (ang. *response*).
3. Odpowiedź zawiera dane w ustalonym formacie – najczęściej w formacie **JSON**.

Na przykład, wysłanie *requestu* **GET** na adres:

https://catfact.ninja/fact

Zwraca nam odpowiedź w formacie json:

```json

{"fact":"A cat's cerebral cortex contains about twice as many neurons as that of dogs. Cats have 300 million neurons, whereas dogs have about 160 million. See, cats rule, dogs drool!","length":173}

```

Warto zwrócić uwagę na ogromne podobieństwo formatu JSON do znanych nam już doskonale **słowników**. Python posiada wygodny moduł `json` od obsługi danych w tym formacie.

```python
import json

tekst_json = '{"fact": "Cats sleep for 70% of their lives.", "length": 40}'
dane = json.loads(tekst_json)  # zamiana na słownik Pythona
print(dane["fact"])
```

Metoda `loads` z biblioteki `json` przyjmuje stringa jako argument, a zwraca słownik. Zasada działania jest bardzo prosta: 
- pobieramy zewnętrzne dane z API,
- dane przychodzić będą do nas w formacie tekstowym - `json`
- przerabiamy tego `jsona` na słownik 
- możemy już pracować na tych danych!

Co do zasady, obróbka danych wynikających ze słowników jest bardzo proste, ale oczywiście rozumiem, jeśli ktoś zapomniał - [tu ściąga](https://www.w3schools.com/python/python_dictionaries.asp) 

### Zadanie 1:
Dany jest JSON:

```json
{
  "currency": "PLN",
  "vat_rate": 0.23,
  "items": [
    { "name": "Notes A5", "qty": 2, "unit_price": 7.50 },
    { "name": "Długopis", "qty": 3, "unit_price": 2.20 },
    { "name": "Marker", "qty": 1, "unit_price": 5.90 }
  ]
}
```

Napisz program, który go wczyta (może być z pliku, może być wklejony jako string). Program ma następnie wyliczyć kwotę brutto każdego z produktów i wyświetlić sumę paragonu - dla każdej pozycji - `qty * unit_price * vat_rate`. Jeśli starczy czasu, to poza sumą możemy wyświetlić ładnie sformatowane dane, a nawet pokusić się o posortowanie.

```
Notes A5 x2  = 15.00 PLN
Długopis x3  =  6.60 PLN
Marker x1    =  5.90 PLN
-------------------------
Suma netto: 27.50 PLN
VAT 23%:     6.33 PLN
Suma brutto: 33.83 PLN
```


## Pobieranie danych w Pythonie

**REST API**, z których będziemy co do zasady korzystać obsługują zazwyczaj metody HTTP:

- **GET** – pobieranie danych (najczęściej używane),
- **POST** – wysyłanie nowych danych,
- **PUT/PATCH** – aktualizacja danych,
- **DELETE** – usuwanie danych.

My dziś będziemy jedynie pobierać dane, więc korzystać będziemy tylko z metody GET. Skorzystamy w tym celu z biblioteki `requests` - ona już nie jest wbudowana, więc musimy ją poprzez package managera doinstalować.

Przykład:

```python
import requests  
  
response = requests.get("https://catfact.ninja/fact")  
print(response)
```

ten kawałek kodu zwróci nam dość enigmatyczną odpowiedź: `<Response [200]>`. Jest to jeden z obsługiwanych **kodów statusu HTTP**. Najważniejsze kody to

- 200 - **OK** - zapytanie wykonane prawidłowo
- 404 - **NOT FOUND** - nie znaleziono - zwykle oznacza literówkę w adresie
- 500 - **INTERNAL SERVER ERROR** - nie nasza wina, serwer zwrócił błąd

Każde zapytanie wykonane z `requests` zwraca nam **Response Object** - jest to teoretycznie **jedna zmienna**, która w sobie zawiera **wiele zmiennych**. 
## Atrybuty (properties)

| Nazwa         | Typ         | Do czego służy?                                | Najprostszy przykład           |
| ------------- | ----------- | ---------------------------------------------- | ------------------------------ |
| `status_code` | `int`       | Kod HTTP odpowiedzi (200 OK, 404 itd.)         | `resp.status_code`             |
| `ok`          | `bool`      | `True` gdy kod w zakresie 200–399              | `if resp.ok:`                  |
| `url`         | `str`       | Ostateczny adres, z którego przyszła odpowiedź | `resp.url`                     |
| `text`        | `str`       | Treść odpowiedzi jako **tekst**                | `resp.text[:200]`              |
| `elapsed`     | `timedelta` | Czas odpowiedzi                                | `resp.elapsed.total_seconds()` |

> **`text` vs `content`**: `text` to zdekodowany ciąg znaków, `content` to surowe bajty.
## Metody

| Nazwa               | Zwraca        | Do czego służy?                                | Najprostszy przykład      |
|---------------------|---------------|-----------------------------------------------|---------------------------|
| `json()`            | `dict/list`   | Parsuje treść jako JSON                       | `data = resp.json()`      |
| `raise_for_status()`| `None`        | Rzuca błąd przy kodach 4xx/5xx (fail-fast)    | `resp.raise_for_status()` |

```python
resp = requests.get(url)
resp.raise_for_status()
data = resp.json()   # jeśli API zwraca JSON
```


## Zadanie 2:
Z *endpointu* `https://restcountries.com/v3.1/all?fields=name,capital,population,region` wyciągamy podstawowe dane o krajach na świecie

Celem jest: **pobrać listę krajów z API, odfiltrować Europę, posortować po populacji, wypisać TOP-10 oraz sumę populacji**.

---

## Krok 1 — Pobranie danych z API

**Opis:**  
Wyślij zapytanie `GET` do `https://restcountries.com/v3.1/all`, sprawdź status, zdekoduj JSON.

**Wymagania:**

| ID  | Wymaganie |
|-----|-----------|
| K1.1 | Program wykonuje `GET` na `https://restcountries.com/v3.1/all`. |
| K1.2 | Sprawdza powodzenie (`raise_for_status()` lub `status_code`). |
| K1.3 | Dekoduje odpowiedź do struktury Pythona (`list`/`dict`). |
| K1.4 | Używa `timeout` w żądaniu (np. 10–15 s). |

---

## Krok 2 — Ekstrakcja potrzebnych pól

**Opis:**  
Dla każdego kraju pobierz: `name.common`, `region`, `capital` (pierwszy element, jeśli istnieje), `population`.

**Wymagania:**

| ID  | Wymaganie |
|-----|-----------|
| K2.1 | Dla każdego elementu wyciągane są pola: `name.common`, `region`, `capital`, `population`. |
| K2.2 | Brakujące `capital` obsłużone bez błędu (np. `["—"]` lub `None`). |
| K2.3 | Brakujące `population` zastąp `0` (lub pomiń z komunikatem). |
| K2.4 | Dane przechowywane w ujednoliconej strukturze (np. krotka lub słownik). |

---

## Krok 3 — Filtrowanie regionu „Europe”

**Opis:**  
Zostaw tylko kraje, dla których `region == "Europe"`.

**Wymagania:**

| ID  | Wymaganie |
|-----|-----------|
| K3.1 | Powstaje kolekcja `europe` zawierająca tylko kraje z `region == "Europe"`. |
| K3.2 | Program wypisuje liczbę zakwalifikowanych krajów (krótka informacja). |

---

## Krok 4 — Sortowanie po populacji malejąco

**Opis:**  
Posortuj listę `europe` po `population` w kolejności malejącej.

**Wymagania:**

| ID  | Wymaganie |
|-----|-----------|
| K4.1 | Zastosowane sortowanie `reverse=True` po kluczu `population`. |
| K4.2 | Dane po sortowaniu są nadal kompletne (nazwa, stolica, populacja). |

---

## Krok 5 — Wypisanie TOP-10 w ustalonym formacie

**Opis:**  
Wypisz pierwsze 10 krajów w formacie:
`1. Germany — capital: Berlin — population: 83,294,633`

**Wymagania:**

| ID  | Wymaganie |
|-----|-----------|
| K5.1 | Wypisuje maks. 10 pierwszych pozycji (lub mniej, jeśli jest mniej danych). |
| K5.2 | Format zawiera indeks, nazwę kraju, stolicę i populację. |
| K5.3 | Populacja sformatowana z separatorami tysięcy (np. `f"{pop:,}"`). |

---

## Krok 6 — Suma populacji Europy

**Opis:**  
Policz sumę populacji wszystkich krajów w `europe` i wypisz wynik.

**Wymagania:**

| ID  | Wymaganie |
|-----|-----------|
| K6.1 | Obliczona suma `total = sum(population)` dla listy `europe`. (Albo inaczej - ważne, żeby się poprawnie liczyło) |
| K6.2 | Wynik wypisany w czytelnym formacie z separatorami tysięcy. |

---

## Krok 7 — Minimalna obsługa błędów i „graceful degradation”

**Opis:**  
Zadbaj o stabilność: obsłuż `requests.exceptions`, puste odpowiedzi lub brak internetu. (Opcjonalnie: fallback do lokalnego pliku JSON z próbką danych.)

**Wymagania:**

| ID   | Wymaganie                                                              |
| ---- | ---------------------------------------------------------------------- |
| K7.1 | `try/except` wokół zapytania HTTP i dekodowania JSON.                  |
| K7.2 | Informacja dla użytkownika przy błędzie (kod statusu / brak sieci).    |
| K7.3 | Program nie kończy się wyjątkiem bez komunikatu.                       |


# Mini-projekt: „Pogoda dla listy miast” – plan kroków z wymaganiami

Celem projektu jest stworzenie konsolowej aplikacji, która:
1. Przyjmuje listę miast od użytkownika,
2. Dla każdego miasta pobiera współrzędne geograficzne (API geokodowania),
3. Pobiera aktualną pogodę (API Open-Meteo),
4. Wyświetla czytelną tabelę z wynikami,
5. (Opcjonalnie) zapisuje dane do pliku.

---

## Krok 1 – Pobieranie listy miast od użytkownika

**Opis:**  
Poproś użytkownika o podanie miast, np. w jednej linii, oddzielonych przecinkami. Oczyść dane.

**Wymagania:**

| ID  | Wymaganie |
|-----|-----------|
| P1.1 | Użytkownik wpisuje miasta w formacie `Miasto1,Miasto2,...`. |
| P1.2 | Miasta dzielone są przy pomocy `.split(",")`. |
| P1.3 | Białe znaki są usuwane z nazw (`strip()`). |
| P1.4 | Pusta lub błędna lista jest odrzucana z komunikatem. |

---

## Krok 2 – Pobranie współrzędnych z API Open-Meteo

**Opis:**  
Dla każdego miasta wykonaj zapytanie do API geokodowania:  
`https://geocoding-api.open-meteo.com/v1/search?name=<miasto>` - API zwraca wiele podobnych miejscowości - korzystamy zawsze z pierwszego zwróconego wyniku!

**Wymagania:**

| ID  | Wymaganie |
|-----|-----------|
| P2.1 | Dla każdego miasta wysyłane jest zapytanie `GET`. |
| P2.2 | Wynik jest dekodowany do formatu JSON. |
| P2.3 | Z odpowiedzi wyciągane są `latitude` i `longitude` **pierwszego wyniku**. |
| P2.4 | Brak wyniku → komunikat `[WARN] Nie znaleziono miasta: <nazwa>` |
| P2.5 | Używany `timeout` i `raise_for_status()`. |

---

## Krok 3 – Pobranie danych pogodowych

**Opis:**  
Dla każdego miasta (po uzyskaniu współrzędnych) wykonaj zapytanie do:  
`https://api.open-meteo.com/v1/forecast?latitude=...&longitude=...&current_weather=true`

**Wymagania:**

| ID  | Wymaganie |
|-----|-----------|
| P3.1 | Dla każdego miasta wykonywane jest zapytanie `GET`. |
| P3.2 | Program sprawdza `status_code` i wykonuje `resp.raise_for_status()`. |
| P3.3 | Dane są pobierane z klucza `current_weather`. |
| P3.4 | Wyciągnięte są: `temperature` (°C), `windspeed` (km/h). |
| P3.5 | Brak danych pogodowych → komunikat `[WARN] Brak danych pogodowych: <miasto>`. |

---

## Krok 4 – Wyświetlenie tabeli wyników

**Opis:**  
Wyniki dla każdego miasta są wyświetlane w przejrzystej tabeli.

**Wymagania:**

| ID  | Wymaganie |
|-----|-----------|
| P4.1 | Wypisywana jest nagłówkowa linia tabeli. |
| P4.2 | Dla każdego miasta wypisane są: nazwa, temperatura (1 miejsce po przecinku), wiatr. |
| P4.3 | Kolumny są wyrównane (np. `f"{temp:6.1f}"`). |

**Przykład:**
```
City       | Temp [°C] | Wind [km/h]
Gdansk     |     19.8  |       12.3
Warsaw     |     21.4  |       10.1
```

---

## Krok 5 – Obsługa błędów

**Opis:**  
Zadbaj o to, by błędy sieci, nieistniejące miasta czy puste odpowiedzi nie przerywały programu.

**Wymagania:**

| ID  | Wymaganie |
|-----|-----------|
| P5.1 | Wszystkie zapytania objęte są `try/except`. |
| P5.2 | Błędy sieci (`ConnectionError`, `Timeout`) są łapane i komunikowane użytkownikowi. |
| P5.3 | Program kontynuuje działanie mimo błędów dla pojedynczych miast. |

---

## Krok 6 – Zapis danych do pliku (opcjonalny)

**Opis:**  
Po zakończeniu pobierania, zapisz dane do pliku `pogoda_<data>.txt` lub `pogoda.csv`.

**Wymagania:**

| ID  | Wymaganie |
|-----|-----------|
| P6.1 | Program tworzy plik wynikowy z danymi w formacie CSV lub prostym tekstowym. |
| P6.2 | Nazwa pliku zawiera datę (np. `pogoda_2025-08-04.txt`). |
| P6.3 | Wiersze pliku zawierają miasto, temperaturę, wiatr. |

**Przykład CSV:**
```
city,temperature_c,wind_kmh
Gdansk,19.8,12.3
Warsaw,21.4,10.1
```

---

## Efekt końcowy

Po przejściu wszystkich kroków program:

✅ Pozwala wpisać kilka miast  
✅ Pobiera współrzędne geograficzne i pogodę  
✅ Wyświetla dane w przejrzystej tabeli  
✅ Informuje o błędach w czytelny sposób  
✅ (Opcjonalnie) zapisuje dane do pliku