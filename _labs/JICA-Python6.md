---
layout: lab
course: Python
type: stacjonarne
lab_nr: 6
subject: Małe projekty, ale za to podzielone na kroki
description: Wracamy do zwykłego programowania
---

Aby utrwalić wiedzę dziś wracamy do prostego programowania, nie będzie żadnych samochodzików ani wymyślnych funkcji, tylko mocna praktyka.

# Aplikacja do zarządzania zadaniami (To-Do Lista)

Projekt końcowy to prosty **menedżer zadań w konsoli** – użytkownik może dodawać zadania, usuwać je, oznaczać jako wykonane i wyświetlać listę.  
Każde kolejne zadanie rozwija program, ale też utrwala podstawy programowania.

---

## **Etap 1 – Podstawy wejścia i wyjścia**

**Opis zadania:**  
- Utwórz program, który zapyta użytkownika o **tytuł zadania** i **priorytet** (np. wysoki/średni/niski), a następnie wypisze je w konsoli w formacie:  
  `Zadanie: <tytuł>, Priorytet: <priorytet>`.

**Wymagania:**

| ID | Wymaganie |
|----|-----------|
| F1 | Program pobiera dane od użytkownika (tytuł i priorytet). |
| F2 | Program wyświetla zadanie w formacie: `Zadanie: <tytuł>, Priorytet: <priorytet>`. |
| F3 | Program działa w konsoli. |

---

## **Etap 2 – Wiele zadań (lista)**

**Opis zadania:**  
- Rozbuduj program, aby przechowywał kilka zadań w **liście** (np. `[("Nauka Pythona", "wysoki"), ("Zakupy", "niski")]`).
- Po każdym wpisaniu zadania zapytaj użytkownika, czy chce dodać kolejne.
- Na koniec wyświetl listę wszystkich zadań.

**Wymagania:**

| ID | Wymaganie |
|----|-----------|
| F1 | Program przechowuje zadania w liście. |
| F2 | Program umożliwia wprowadzenie wielu zadań. |
| F3 | Program wyświetla wszystkie zadania w konsoli. |

---

## **Etap 3 – Funkcje**

**Opis zadania:**  
- Wydziel logikę do funkcji:  
  - `dodaj_zadanie(lista)` – dodaje zadanie,  
  - `pokaz_zadania(lista)` – wyświetla wszystkie zadania.  
- Program ma działać w pętli i po każdej akcji pytać, co użytkownik chce zrobić: `dodaj`, `lista`, `exit`.

**Wymagania:**

| ID | Wymaganie |
|----|-----------|
| F1 | Program wykorzystuje funkcje do dodawania i wyświetlania zadań. |
| F2 | Program działa w pętli i obsługuje polecenia użytkownika. |
| F3 | Program kończy działanie po wpisaniu `exit`. |

---

## **Etap 4 – Oznaczanie zadań jako wykonane**

**Opis zadania:**  
- Dodaj możliwość oznaczania zadania jako `✔ wykonane`.
- Rozbuduj funkcję `pokaz_zadania(lista)` tak, aby wyświetlała status (`[ ]` lub `[✔]`).
- Dodaj nową komendę: `zrob`, która prosi o numer zadania i ustawia status na wykonane.

**Wymagania:**

| ID | Wymaganie |
|----|-----------|
| F1 | Program umożliwia oznaczanie zadań jako wykonane. |
| F2 | Program wyświetla status każdego zadania. |
| F3 | Komenda `zrob` zmienia status wybranego zadania. |

---

## **Etap 5 – Usuwanie zadań**

**Opis zadania:**  
- Dodaj funkcję `usun_zadanie(lista)`, która usuwa zadanie na podstawie numeru.
- Program powinien odświeżyć listę po usunięciu.

**Wymagania:**

| ID | Wymaganie |
|----|-----------|
| F1 | Program umożliwia usuwanie zadania po numerze. |
| F2 | Lista jest aktualizowana po usunięciu. |
| F3 | Program obsługuje błędy przy złym numerze zadania. |

---

## **Etap 6 – Historia w pliku**

**Opis zadania:**  
- Rozbuduj program tak, aby zapisywał zadania do pliku `tasks.txt`.
- Przy uruchomieniu program wczytuje istniejące zadania.
- Wprowadź komendę `save` i `load` (opcjonalnie, jeśli nie chcemy automatycznego zapisu).
- [Dokumentacja obsługi plików](https://www.w3schools.com/python/python_file_handling.asp)

**Wymagania:**

| ID | Wymaganie |
|----|-----------|
| F1 | Program zapisuje zadania do pliku. |
| F2 | Program wczytuje zadania przy uruchomieniu. |
| F3 | Program obsługuje komendy `save` i `load` (opcjonalnie). |

---

# Zadania opcjonalne do projektu "To-Do Lista"

## **Zadanie opcjonalne 1 – Sortowanie zadań według priorytetu**
**Opis zadania:**  
Dodaj funkcję `sortuj_zadania(lista)`, która sortuje zadania według priorytetu (np. `wysoki`, `średni`, `niski`).  
Użytkownik może wpisać komendę `sort`, aby wyświetlić listę w posortowanej kolejności.

**Wymagania:**

| ID  | Wymaganie |
|-----|-----------|
| O1  | Program sortuje zadania według priorytetu. |
| O2  | Komenda `sort` wyświetla posortowaną listę. |
| O3  | Priorytety są ustalone w kolejności: wysoki > średni > niski. |

---

## **Zadanie opcjonalne 2 – Termin wykonania zadania**
**Opis zadania:**  
Rozszerz strukturę zadań o **termin wykonania** (np. `2025-08-15`).  
- Podczas dodawania zadania użytkownik podaje termin.  
- Komenda `deadline` wyświetla wszystkie zadania z najbliższymi terminami (posortowane rosnąco według daty).

**Wymagania:**

| ID  | Wymaganie |
|-----|-----------|
| O1  | Każde zadanie przechowuje termin wykonania (data w formacie YYYY-MM-DD). |
| O2  | Program pozwala wyświetlić zadania posortowane według terminu. |
| O3  | Komenda `deadline` wyświetla zadania z nadchodzącymi terminami. |


---


# Projekt: Generator Raportów Pogodowych

Celem projektu jest stworzenie aplikacji konsolowej, która generuje raporty pogodowe dla wybranych miast. Program będzie stopniowo rozbudowywany o kolejne funkcjonalności, takie jak losowanie danych, analiza wyników i zapis do pliku. Ten projekt nam się przyda jako baza do rozbudowania, bo już w następnym tygodniu będziemy pobierali takie dane z zewnętrznego API i je tutaj wepniemy.

## **Etap 7 - dla tych, co są za szybcy**

**Opis Zadania**
-

---

## **Etap 1 – Wyświetlanie jednej prognozy**

**Opis zadania:**  
Program pyta użytkownika o miasto oraz temperaturę (wprowadzoną ręcznie) i wyświetla komunikat:  
`Miasto: Gdańsk, Temperatura: 22°C`.

**Wymagania:**

| ID  | Wymaganie |
|-----|-----------|
| F1  | Program pyta użytkownika o nazwę miasta. |
| F2  | Program pyta o temperaturę. |
| F3  | Program wyświetla wprowadzone dane w formacie: `Miasto: <miasto>, Temperatura: <temp>°C`. |

---

## **Etap 2 – Losowa prognoza**

**Opis zadania:**  
Program losuje temperaturę z przedziału -10 do 35°C oraz warunki pogodowe (`Słonecznie`, `Deszczowo`, `Zachmurzenie`).  
Wyświetla komunikat: `Miasto: Gdańsk, Temperatura: 15°C, Warunki: Słonecznie`.

**Wymagania:**

| ID  | Wymaganie |
|-----|-----------|
| F1  | Program losuje temperaturę w zakresie -10 do 35. |
| F2  | Program losuje warunki pogodowe z listy dostępnych warunków. |
| F3  | Program wyświetla kompletną prognozę w formacie: `Miasto: <miasto>, Temperatura: <temp>°C, Warunki: <warunki>`. |

---

## **Etap 3 – Lista miast**

**Opis zadania:**  
Użytkownik może wpisać kilka miast. Dla każdego z miast generowana jest losowa prognoza.  
Program wyświetla wszystkie wyniki w formie tabeli.

**Wymagania:**

| ID  | Wymaganie |
|-----|-----------|
| F1  | Program pozwala wprowadzić listę miast. |
| F2  | Program generuje prognozę dla każdego miasta z listy. |
| F3  | Program wyświetla wyniki w formie tabelarycznej. |

---

## **Etap 4 – Funkcje**

**Opis zadania:**  
Kod zostaje podzielony na funkcje:  
- `generuj_prognoze(miasto)` – zwraca losową prognozę dla podanego miasta,  
- `pokaz_prognozy(lista_miast)` – wyświetla prognozy dla wszystkich miast.

**Wymagania:**

| ID  | Wymaganie |
|-----|-----------|
| F1  | Program korzysta z funkcji do generowania prognozy. |
| F2  | Program korzysta z funkcji do wyświetlania wszystkich prognoz. |
| F3  | Funkcje zwracają dane w odpowiednim formacie tekstowym. |

---

## **Etap 5 – Analiza danych**

**Opis zadania:**  
Program analizuje temperatury z wygenerowanych prognoz i wyświetla:  
- średnią temperaturę,  
- najwyższą temperaturę i miasto,  
- najniższą temperaturę i miasto.

**Wymagania:**

| ID  | Wymaganie |
|-----|-----------|
| F1  | Program oblicza średnią temperaturę. |
| F2  | Program znajduje miasto z najwyższą temperaturą. |
| F3  | Program znajduje miasto z najniższą temperaturą. |

---

## **Etap 6 – Zapis do pliku**

**Opis zadania:**  
Program zapisuje raport pogodowy do pliku `raport.txt`.  
W pliku znajdują się wszystkie prognozy oraz wyniki analizy (średnia, min., max.).

**Wymagania:**

| ID  | Wymaganie |
|-----|-----------|
| F1  | Program zapisuje wszystkie prognozy do pliku tekstowego. |
| F2  | Program dopisuje podsumowanie analizy (średnia, min., max.). |
| F3  | Format pliku jest czytelny (np. dane w kolejnych liniach). |

---

## **Pomysły na rozszerzenia (opcjonalne)**

- Sortowanie miast po temperaturze (od najwyższej do najniższej).  
- Zapis raportu w formacie CSV.  
- Możliwość wygenerowania kilku raportów z losowymi danymi w pętli.  
- Dodanie jednostki wiatru (np. km/h) i wilgotności.
