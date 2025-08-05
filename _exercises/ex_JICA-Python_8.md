---
layout: exercise
course: Python
type: stacjonarne
lab_nr: 8
topic: Własne API odpytujące inne API. YAY!
---
Celem zadania jest stworzenie własnego API (`/weather`), które po otrzymaniu nazwy miasta wysyła zapytanie do zewnętrznego API (np. Open-Meteo), pobiera dane pogodowe, przetwarza je i zwraca jako własną odpowiedź JSON.

Nie korzystamy z baz danych — dane są pobierane *na żywo* i odpowiednio filtrowane.

---

## Krok 1: Endpoint `/weather` z parametrem `city`

**Opis:**  
Utwórz endpoint `/weather`, który przyjmuje parametr `city` (string) i na razie tylko zwraca go w odpowiedzi.

**Wymagania:**

| ID  | Wymaganie |
|-----|-----------|
| W1  | Endpoint `/weather` |
| W2  | Przyjmuje parametr `city: str` |
| W3  | Zwraca `{"city": city}` |

---

## Krok 2: Znajdź współrzędne miasta

**Opis:**  
Użyj zewnętrznego API geolokalizacji (np. Open-Meteo lub api.api-ninjas.com), aby znaleźć współrzędne `lat`, `lon` dla podanej nazwy miasta.

**Wymagania:**

| ID  | Wymaganie |
|-----|-----------|
| W1  | Wysłano zapytanie do API zewnętrznego |
| W2  | Odczytano `latitude` i `longitude` z odpowiedzi |

---

## Krok 3: Pobierz dane pogodowe z Open-Meteo

**Opis:**  
Zbuduj zapytanie do API Open-Meteo z wykorzystaniem uzyskanych współrzędnych. Pobierz aktualną pogodę.

**Wymagania:**

| ID  | Wymaganie |
|-----|-----------|
| W1  | Użyto poprawnego URL do API Open-Meteo |
| W2  | Odczytano odpowiedź z temperaturą, zachmurzeniem, itp. |

---

## Krok 4: Przetwórz dane pogodowe

**Opis:**  
Wyodrębnij najważniejsze informacje z danych pogodowych: np. temperaturę, prędkość wiatru, zachmurzenie i godzinę pomiaru.

**Wymagania:**

| ID  | Wymaganie |
|-----|-----------|
| W1  | Wyciągnięto pola: `temperature`, `windspeed`, `cloudcover`, `time` |
| W2  | Przygotowano słownik z tymi wartościami |

---

## Krok 5: Zwróć odpowiedź w ładnej formie

**Opis:**  
Zbuduj odpowiedź JSON, która zawiera tylko interesujące dane, np.:

```json
{
  "temperature": 21.3,
  "windspeed": 14.2,
  "cloudcover": 85,
  "time": "2025-08-05T14:00"
}
```

**Wymagania:**

| ID  | Wymaganie |
|-----|-----------|
| W1  | Odpowiedź API zawiera tylko przetworzone dane |
| W2  | Format danych jest zgodny z JSON |

---

## Krok 6: Obsłuż błędy — brak miasta

**Opis:**  
Jeśli API nie zwróci współrzędnych lub danych pogodowych (np. zła nazwa miasta), funkcja powinna zwrócić czytelny komunikat o błędzie.

**Wymagania:**

| ID  | Wymaganie |
|-----|-----------|
| W1  | Dla błędnego miasta zwróć `{"error": "Nie znaleziono lokalizacji"}` |
| W2  | Brak błędów aplikacji (żadne `500`, `KeyError`, itp.) |

---

## Krok 7: (Opcjonalnie) Historia zapytań

**Opis:**  
Dodaj prostą historię zapytań w pamięci (np. lista w Pythonie). Dodaj nowy endpoint `/history`, który zwraca historię wcześniejszych zapytań.

**Wymagania:**

| ID  | Wymaganie |
|-----|-----------|
| W1  | Endpoint `/history` |
| W2  | Zwraca listę ostatnich zapytań, np. `{"history": [{"city": "Gdansk", "temp": 20.1}, ...]}` |

---