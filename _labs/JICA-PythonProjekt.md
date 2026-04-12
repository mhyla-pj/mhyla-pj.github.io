---
layout: lab
nav-exclude: true
subject: Własne API - Operacja CRUD
description: Dane przychodzą z zewnątrz!
---
# Zadanie dodatkowe: Aplikacja Python + API komunikacji miejskiej w Gdańsku

## Cel projektu
W parach stworzycie aplikację, która:
- pobierze dane z **API TRISTAR** dotyczące przystanku tramwajowego **Brama Wyżynna** (oba kierunki: 01 i 02),
- wyświetli tablicę odjazdów w **CLI** (opcjonalnie: mini-strona w FastAPI),
- będzie rozwijana w **repozytorium zdalnym na GitHubie** z podziałem zadań, gałęziami, Pull Requestami i code review.

---

## Źródła
- **Lista przystanków** (`stops.json` lub `stopsingdansk.json`): zawiera `stopId`, `stopName`, `subName`, `type` (TRAM, BUS, BUS_TRAM).
- **Estymowane czasy odjazdów** (`departures?stopId={stopId}`): pola m.in. `estimatedTime` (UTC), `status` (REALTIME/SCHEDULED), `routeShortName`, `headsign`, `delayInSeconds`.
- Dokumentacja API: https://ckan.multimediagdansk.pl/dataset/tristar

---

## Podział ról

### **Dev A – Backend / dane**
- wyszukiwanie `stopId` dla Brama Wyżynna 01 i 02,
- funkcje pobierające dane z API i konwertujące czas z UTC na Europe/Warsaw,
- obsługa statusów REALTIME i SCHEDULED,
- testy jednostkowe logiki.

### **Dev B – Prezentacja / integracja**
- CLI: czytelna tablica odjazdów (osobno lub łączony widok),
- auto-odświeżanie co ≥20 s (API cache),
- opcjonalnie: mini-aplikacja FastAPI z endpointem `/departures` i prostym HTML,
- README i instrukcja uruchomienia.

Wspólnie: konfiguracja repozytorium, PR-y, review.

---

## Krok po kroku

### 1. Przygotowanie repozytorium (Sprint 0)
1. Utwórz repozytorium GitHub.
2. Skonfiguruj `.venv` i `requirements.txt` (requests, fastapi*).
3. Ustalcie strukturę katalogów, np.:
    ```
    app/
      services/ztm.py
      cli.py
      web.py        # opcjonalnie
    tests/test_ztm.py
    README.md
    ```

### 2. Znalezienie `stopId`
- **Dev A**: parsuje `stops.json` i wybiera `stopId` dla `Brama Wyżynna 01` i `Brama Wyżynna 02` (`type == "TRAM"`).
- Zapisuje wynik w `config/stops.json`.

### 3. Pobranie estymowanych odjazdów
- **Dev A**: `get_departures(stop_id)` → lista słowników z: linia, kierunek, czas lokalny, opóźnienie.
- Konwersja UTC → Europe/Warsaw.

### 4. CLI – tablica odjazdów
- **Dev B**: czytelny format, odświeżanie ≥20 s, wyróżnianie dużych opóźnień.
- Widok dla obu słupków.

### 5. Integracja
- **Dev A**: agregacja danych z obu stopów.
- **Dev B**: tryb `--combined` w CLI.

### 6. (Opcjonalnie) mini-aplikacja FastAPI
- `/departures` → JSON,
- `/` → prosta tabela HTML.

### 7. Testy i dokumentacja
- **Dev A**: testy logiki czasu i parsowania.
- **Dev B**: test działania CLI.
- README z instrukcją, screenshotem/gifem.

---

## Workflow na GitHubie
1. Każdy pracuje na osobnej gałęzi (`feature/...`).
2. PR z opisem zmian i checklistą.
3. Code review drugiej osoby.
4. Po akceptacji – merge i usunięcie gałęzi.

---

## Kryteria zaliczenia
- Działa CLI dla obu słupków,
- Poprawna konwersja czasu,
- Repo z PR-ami i code review,
- README z uruchomieniem i screenem.

---

## Dobre praktyki
- Małe, częste PR-y,
- Opisowe commity,
- Aktualizacja gałęzi przed PR.

---

## Rozszerzenia dla chętnych
- Widok webowy (FastAPI),
- Eksport do CSV/JSON,
- Filtr linii tramwajowych,
- Obsługa GTFS-RT (Trip Updates, Vehicle Positions).
