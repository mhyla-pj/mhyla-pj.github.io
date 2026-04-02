---
layout: lab
course: Python
type: stacjonarne
lab_nr: 11
subject: Praca z gitem
description: Kontrolujemy nasze projekty, współpraca wieloosobowa. 
---


Dziś mamy lekką rewolucję w materiale - nie będziemy bowiem skupiać się na wprowadzeniu nowego materiału w Pythonie. Celem dzisiejszych zajęć jest wprowadzenie was w tajniki obsługi gita, czyli systemu kontroli wersji, który jest w zasadzie wykorzystywany w 99% projektów informatycznych. Reszta tematu zajęć to niewielki projekt programistyczny do realizacji w zespołach.

## Czym jest Git?
Git jest darmowym i open-source’owym systemem kontroli wersji, pomocny przy pracy zarówno nad małymi, jak i ogromnymi projektami. System kontroli wersji, inaczej VCS (Version Control System) to narzędzie, które pozwala zachowywać historię zmian w pliku, lub zestawie plików, w taki sposób, aby można było bezproblemowo cofnąć się do wcześniejszej wersji tych plików. Posługiwać się dla przykładu będziemy dzisiaj kodem, ale VCS można używać właściwie do trzymania historii wersji każdego pliku na komputerze.

Gita traktować możemy jako swoistą bazę danych (repozytorium) migawek, które wraz z postępem prac nad projektem są zatwierdzane i dodawane (commitowane) do bazy, a nie w żaden sposób podmieniane czy zastępowane.
Ponadto, korzystając z Gita ciężko jest coś poważnie zepsuć w swoim kodzie. Pliki na komputerze mają swoją jedną wersję – tą, którą jako ostatnią zapisaliśmy. Dzięki korzystaniu z Gita, nawet jeśli nieźle w kodzie nabroiliśmy, zawsze możemy wrócić do jednaj z wcześniejszych migawek z poprawnie działającym programem. Git do swojej bazy danych pliki jedynie dodaje, żeby coś usunąć trzeba się już bardziej nagimnastykować.

## Inicjalizacja Repozytorium

Co do zasady każdy katalog na komputerze może stać się repozytorium gita. Aby przerobić "zwykły" katalog na repozytorium musimy wykonać w tym katalogu polecenie `git init`. To zdanie może nie mieć zbyt wiele sensu, jeśli nie wiemy, jak pracuje się z CLI - **Command Line Interface**. Co do zasady CLI już używaliśmy - nazywałem to terminalem. Wpisywaliśmy tam np. polecenie uruchamiające serwer `uvicorn`. CLI jest po prostu tekstowym sposobem na poruszanie się po drzewie katalogów. Aby zmienić nasz projekt w repozytorium **git** musimy najpierw wejść do katalogu, w którym się on znajduje. 

Terminal domyślnie wyświetla nam naszą lokalizację. Aby sprawdzić, jakie pliki i katalogi znajdują się w miejscu, gdzie jesteśmy należy wykonać polecenie `ls` lub `dir` i zatwierdzić klawiszem Enter. Aby przejść do dalszego katalogu (tego, który znajduje się poniżej naszej lokalizacji) musimy wykonać polecenie `cd` i podać nazwę docelowego katalogu, np:

```bash
cd ProjektPython
```

Aby przejść do katalogu nadrzędnego należy wykonać polecenie 

```bash
cd ..
```

Gdy już znajdujemy się w katalogu, w którym chcemy wystartować repozytorium, wykonujemy 

```bash
git init
```

To stworzy nam w tym katalogu repozytorium gita. Drugą, prawdopodobnie dużo prostszą metodą jest wykorzystanie klikalnego interfejsu dostarczanego przez większość środowisk programistycznych. Na przykład, w PyCharmie wystarczy kliknąć na przycisk VCS (na samym dole z lewej strony, poniżej ikony terminala), a następnie wybrać **Create Git repository**


## Repozytorium stworzone - przechodzimy do pracy

Co do zasady każda większa zmiana w kodzie powinna zakończyć się tzw. *commitem*, czyli zapisaniem bieżącej wersji kodu w repozytorium. Każdy commit to niejako punkt w rozwoju naszego projektu. Historia całego naszego projektu może być przeanalizowana właśnie poprzez kontrolę historii commitów w repozytorium. 

Wszystkie śledzone pliki najpierw należy *zatwierdzić*, czyli oznaczyć jako te, które chcemy dodać do *commita*. Następnie musimy sporządzić opis tego, co zostało od poprzedniego commita zmienione (*commit message*). Ostatnim krokiem będzie faktyczny *commit*. 

Jeśli pracujemy w terminalu:

```bash
git add main.py  # to doda pliki do commita
git commit -m "Dodano nowe rzeczy"
```

Alternatywnie

```bash
git commit -am "Dodano nowe rzeczy"  
```

> flaga -a automatycznie dodaje do commita wszystkie **śledzone** pliki. Aby dodać pliki do repo nadal trzeba wykonać `git add [plik1] [plik2]`

Alternatywnym sposobem pacy z repozytorium jest wykorzystanie klikalnego interfejsu w IDE - prezentacja na zajęciach.

Co do zasady flow pracy z gitem jest następujący:
1. Wprowadzamy zmiany w kodzie
2. Zapisujemy plik
3. Dodajemy zmienione pliki do commita
4. Wykonujemy commit

## Gałęzie

Gałęzie używane są do rozwijania funkcjonalności odizolowanych od siebie. Domyślną gałęzią jest `master` lub `main`. Choć do szybkich, prostych i podstawowych projektów, można pracować tylko na tej jednej, głównej gałęzi, to przy większych projektach zespołowych należy każdą nowotworzoną funkcjonalność rozdzielać i rozwijać na oddzielnym branchu, a potem scalać, czyli merge’ować je z gałęzią główną.

Polecenie
```bash
git checkout -b "nazwa_gałęzi"
```

utworzy nową gałąź i automatycznie przełączy na nią kontekst. Od teraz wszystkie zmiany, które będziemy wprowadzać w kodzie będą wprowadzane na tej gałęzi. W każdym momencie możemy przełączyć się na inną, np. na maina, ale pamiętać już trzeba, że każda gałąź ma inny kontekst, więc gdy przełączymy się między gałęziami, to kod nad którym pracujemy będzie wyglądał inaczej.

Branch `main` jest tym, na którym co do zasady nie powinniśmy pracować - do niego jedynie dołączamy zmiany wprowadzone w innych gałęziach. Aby wykonać merge, czyli dociągnąć zmiany z jednej gałęzi do drugiej należy:
1. Przełączyć się na gałąź główną
2. Wykonać polecenie `git merge [nazwa gałęzi ze zmianami]`

Oczywiście można to też wykonać z klikalnego interfejsu w środowisku - pokaz na zajęciach.

Podczas scalania mogą pojawić się **konflikty**. 
#### Konflikty przy scalaniu (merge conflicts)

Podczas łączenia gałęzi może dojść do sytuacji, w której te same linie kodu zostały zmienione w obu gałęziach. Git nie wie wtedy, którą wersję zachować i oznacza to jako **konflikt**.

**Przykład:**

1. Gałąź `feature` zmienia linijkę 10 w pliku `main.py`.
2. Gałąź `main` wprowadza inną zmianę w tej samej linijce.
3. Podczas `git merge feature` powstaje konflikt.

**Rozwiązanie konfliktu:**

- Git oznaczy konflikt specjalnymi znacznikami:

```
<<<<<<< HEAD
Kod z bieżącej gałęzi
=======
Kod z gałęzi łączonej
>>>>>>> feature
```

- Wybierz odpowiednią wersję (lub połącz obie), usuń znaczniki i zapisz plik.
- Następnie:

```
git add main.py
git commit
```

 IDE, takie jak PyCharm czy VS Code, mają narzędzia do rozwiązywania konfliktów wizualnie.
## Repozytorium zdalne

Repozytorium zdalne to kopia naszego repozytorium, która znajduje się na serwerze w Internecie. Dzięki temu możemy:

- Udostępniać kod innym osobom
- Pracować w zespole
- Mieć backup kodu na wypadek utraty danych lokalnych

Najpopularniejszym serwisem do hostowania repozytoriów jest **GitHub**.

### 1. Zakładanie konta

1. Wejdź na [https://github.com](https://github.com/)
2. Załóż darmowe konto.

### 2. Tworzenie repozytorium na GitHubie

1. Zaloguj się.
2. Kliknij przycisk **New repository** (zielony przycisk w prawym górnym rogu ekranu).
3. Podaj nazwę repozytorium (np. `ProjektPython`).
4. Opcjonalnie dodaj opis.
5. Wybierz, czy repozytorium ma być publiczne, czy prywatne.
6. Kliknij **Create repository**.

### 3. Połączenie repozytorium lokalnego z GitHubem

Zakładamy, że masz już lokalne repozytorium (po `git init`).
W terminalu w katalogu projektu wpisz:

```bash
git remote add origin https://github.com/TWOJ_LOGIN/TWOJE_REPO.git
git branch -M main
git push -u origin main
```

- `remote add origin` — dodaje zdalne repozytorium o nazwie `origin`.
- `branch -M main` — ustawia domyślną gałąź na `main`.
- `push -u origin main` — wysyła kod do GitHuba i ustawia śledzenie gałęzi.

### 4. Pobieranie zmian z GitHuba

Jeśli ktoś inny wprowadził zmiany w repozytorium:

```bash
git pull origin main
```

### 5. Wysyłanie nowych commitów na GitHuba

Po dodaniu commita lokalnie:

```bash
git push
```

## Praca zespołowa na GitHubie – przykład dwóch deweloperów

**Scenariusz:** Deweloper A i Deweloper B pracują nad tym samym projektem.

1. **Fork lub dostęp do repozytorium** – oboje mają dostęp do głównego repozytorium.
2. **Tworzenie gałęzi** – każdy tworzy własną gałąź:

```bash
git checkout -b feature-nowa-funkcja
```

3. **Praca nad zmianami** – kod jest commitowany lokalnie i pushowany do zdalnej gałęzi:

```bash
git push -u origin feature-nowa-funkcja
```

4. **Pull Request (PR)** – na GitHubie deweloper tworzy PR z gałęzi `feature-nowa-funkcja` do `main`.
5. **Code Review** – drugi deweloper sprawdza zmiany, może dodawać komentarze, sugerować poprawki.
6. **Aktualizacja gałęzi** – jeśli w `main` zaszły zmiany, gałąź funkcjonalna powinna zostać zaktualizowana (`git pull`lub merge z `main`).
7. **Scalanie PR** – po akceptacji PR jest scalany do `main` przez kliknięcie **Merge pull request**.
8. **Usuwanie gałęzi** – po scaleniu gałąź jest usuwana, by utrzymać porządek.

# Projekt trudniejszy - dla zainteresowanych - [Tutaj](/jica-pythonprojekt)
# Mini-projekt: Proste API „Biuro podróży” (2-osobowe zespoły)

**Cel:** w parach tworzycie **proste API** do zarządzania ofertami podróży.
- Dane trzymane w **SQLite** w jednej tabeli `trips`: `id`, `destination` (TEXT), `month` (TEXT), `price_pln` (REAL).
- API pozwala:
  - dodać nową ofertę (`POST /trips`),
  - pobrać wszystkie oferty (`GET /trips`),
  - pobrać oferty do danego miejsca (`GET /trips/{destination}`),
  - w każdym z widoków pobrać ceny w innej walucie (`?currency=EUR|USD|...`) – kurs z [API NBP](https://api.nbp.pl).
- Wszystko w **jednym pliku Pythona**.

**Stos technologiczny:** Python 3.10+, **FastAPI**, **Uvicorn**, **SQLite (sqlite3)**, **requests**.  
**Podział ról:**  
- **Dev A** – obsługa bazy danych, logika przeliczania walut, komunikacja z API NBP.  
- **Dev B** – definicja endpointów API, walidacje danych wejściowych, format odpowiedzi, dokumentacja.

---

## 0) Sprint 0 – przygotowanie środowiska

**Dev A**
- Utworzenie repozytorium GitHub.
- Przygotowanie pliku `requirements.txt` z wymaganymi bibliotekami.
- Utworzenie pliku `app.py` – jedynego pliku aplikacji.

**Dev B**
- Dodanie minimalnego serwera FastAPI w `app.py`.
- Uruchomienie serwera lokalnie (`uvicorn app:app --reload`).
- Dodanie endpointu `/health` zwracającego prosty status.

**Wymagania funkcjonalne**

| #   | Wymaganie           | Kryterium akceptacji                                      |
| --- | ------------------- | --------------------------------------------------------- |
| 0.1 | Repo i venv          | Repo na GitHub, w README instrukcja uruchomienia venv     |
| 0.2 | Serwer startuje      | `GET /health` zwraca `{"status":"ok"}`                    |
| 0.3 | Zależności           | `pip install -r requirements.txt` działa bez błędów       |

---

## 1) Utworzenie bazy danych (SQLite)

**Dev A**
- Przy starcie aplikacji sprawdza, czy istnieje plik `travel.db`; jeśli nie – tworzy go.
- Tworzy tabelę `trips` z kolumnami: `id` (PRIMARY KEY AUTOINCREMENT), `destination` (TEXT), `month` (TEXT), `price_pln` (REAL, >=0).
- Funkcja dodająca nowy wpis do tabeli.
- Funkcja zwracająca wszystkie wpisy z tabeli.
- Funkcja zwracająca wpisy filtrowane po `destination` (bez rozróżniania wielkości liter).

**Wymagania funkcjonalne**

| #   | Wymaganie       | Kryterium akceptacji                                   |
| --- | --------------- | ------------------------------------------------------ |
| 1.1 | Plik bazy       | Po uruchomieniu aplikacji powstaje `travel.db`          |
| 1.2 | Struktura tabeli| Tabela `trips` z wymaganymi kolumnami                   |
| 1.3 | Operacje        | Funkcje insert, select all, select by destination działają poprawnie |

---

## 2) Endpoint POST /trips

**Dev B**
- Model danych wejściowych (`destination`, `month`, `price_pln`) z walidacją:
  - brak pustych wartości tekstowych,
  - `price_pln` >= 0.
- Po odebraniu danych – wywołanie funkcji z Dev A dodającej rekord do bazy.
- Zwrócenie dodanego wpisu wraz z nadanym `id`.

**Wymagania funkcjonalne**

| #   | Wymaganie        | Kryterium akceptacji                                     |
| --- | ---------------- | -------------------------------------------------------- |
| 2.1 | Walidacja        | Niepoprawne dane → kod 422                               |
| 2.2 | Dodanie oferty   | Poprawne dane → kod 201 + zwrócenie dodanej oferty       |
| 2.3 | Obsługa błędów   | W przypadku błędu bazy – kod 400 z opisem                |

---

## 3) Endpointy GET – wszystkie i po kierunku

**Dev B**
- `GET /trips` – zwraca wszystkie oferty.
- `GET /trips/{destination}` – zwraca tylko oferty o podanym kierunku (niewrażliwe na wielkość liter).
- Możliwość dodania parametru `?currency=...` (patrz krok 4).

**Wymagania funkcjonalne**

| #   | Wymaganie        | Kryterium akceptacji                                     |
| --- | ---------------- | -------------------------------------------------------- |
| 3.1 | Lista wszystkich | `GET /trips` zwraca wszystkie oferty posortowane         |
| 3.2 | Filtr po miejscu | `GET /trips/{destination}` zwraca tylko pasujące oferty  |
| 3.3 | Puste wyniki     | Brak ofert → zwrócenie pustej listy (kod 200)            |

---

## 4) Integracja z API NBP – przeliczenia walut

**Dev A**
- Funkcja pobierająca kurs waluty z API NBP (tabela A, endpoint JSON).
- Funkcja przeliczająca cenę z PLN na wybraną walutę (2 miejsca po przecinku).
- Obsługa błędów: nieobsługiwany kod waluty lub błąd API → kod 400 z opisem.

**Dev B**
- Rozszerzenie `GET /trips` i `GET /trips/{destination}` o opcjonalny parametr `currency`.
- Jeśli `currency != PLN`, to ceny w odpowiedzi powinny być przeliczone na wskazaną walutę.

**Wymagania funkcjonalne**

| #   | Wymaganie       | Kryterium akceptacji                                     |
| --- | --------------- | -------------------------------------------------------- |
| 4.1 | Domyślna waluta | Bez parametru → ceny w PLN                               |
| 4.2 | Inna waluta     | Parametr `currency` → ceny przeliczone wg kursu NBP      |
| 4.3 | Błąd kursu      | Niepoprawna waluta → kod 400 z opisem                    |

---

## 5) Walidacje i obsługa błędów

**Dev B**
- Sprawdzenie, czy dane wejściowe są kompletne i poprawne.
- Zwracanie czytelnych komunikatów o błędach w formacie JSON.

**Dev A**
- Obsługa błędów zapisu/odczytu z bazy.
- Obsługa timeoutów i błędów API NBP.

**Wymagania funkcjonalne**

| #   | Wymaganie         | Kryterium akceptacji                                   |
| --- | ----------------- | ------------------------------------------------------ |
| 5.1 | Walidacja danych  | Niepoprawne dane → kod 422                             |
| 5.2 | Błędy bazy        | Problem z bazą → kod 400                               |
| 5.3 | Błędy NBP         | Problem z API NBP → kod 400                            |

---

## 6) README i przykłady

**Dev B**
- Instrukcja uruchomienia serwera i bazy.
- Przykłady wywołań API (curl) dla wszystkich endpointów.
- Opis parametrów, w tym `currency`.

**Wymagania funkcjonalne**

| #   | Wymaganie    | Kryterium akceptacji                                        |
| --- | ------------ | ----------------------------------------------------------- |
| 6.1 | Instrukcja   | README z kompletną instrukcją uruchomienia i testowania     |
| 6.2 | Przykłady    | Przykłady żądań i odpowiedzi w README                       |
| 6.3 | Ograniczenia | W README opis znanych ograniczeń projektu                   |

---

## 7) Git workflow

**Dev A**
- Gałęzie: `feature/db-nbp`.

**Dev B**
- Gałęzie: `feature/api-readme`.

**Zasady wspólne**
- Każda funkcjonalność w osobnym branchu.
- PR do `main` z review drugiej osoby.
- Usuwanie branchy po merge.

**Wymagania funkcjonalne**

| #   | Wymaganie        | Kryterium akceptacji                                     |
| --- | ---------------- | -------------------------------------------------------- |
| 7.1 | Oddzielne branche| Każdy krok w osobnym branchu                             |
| 7.2 | PR + review      | Min. 2 PR-y na osobę z review kolegi                     |
| 7.3 | Porządek         | Po merge – usunięcie brancha, działający `main`          |


