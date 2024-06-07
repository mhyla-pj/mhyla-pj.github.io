---
layout: exercise
subject: Kolokwium SOP 2024
nav-exclude: true
---

Na wykonanie kolokwium macie godzinę. Zadania proszę nazywać w formacie [nr_indeksu]z[nr_zadania].c, np s14616z1.c. Rozwiązania proszę przesyłać na adres sop2024@mhyla.com w temacie "KOLOKWIUM".

1. **Napisz program w języku C, który symuluje problem producenta-konsumenta z użyciem wielowątkowości. Program powinien mieć:**
- Bufor współdzielony: Bufor cykliczny o ograniczonej wielkości, np. 10 elementów.
- Producenci: Kilka wątków producentów, które generują dane i umieszczają je w buforze.
- Konsumenci: Kilka wątków konsumentów, które pobierają dane z buforu i przetwarzają je.
Wątki producentów powinny czekać, jeśli bufor jest pełny, a wątki konsumentów powinny czekać, jeśli bufor jest pusty.
Producenci powinni generować losowe liczby całkowite i umieszczać je w buforze.
Konsumenci powinni pobierać liczby z buforu i wyświetlać je na ekranie.
Program powinien działać przez 10 sekund lub do momentu wprowadzenia przez użytkownika sygnału do zakończenia - Ctrl+C.

2. **Napisz program w języku C, który tworzy dwa procesy potomne. Procesy te będą komunikować się za pomocą sygnałów. Program powinien spełniać następujące wymagania:**
- Proces nadrzędny: Tworzy dwa procesy potomne i czeka na ich zakończenie.
- Procesy potomne: Każdy proces potomny powinien rejestrować obsługę sygnału SIGUSR1 i po otrzymaniu tego sygnału wypisywać komunikat oraz kończyć swoje działanie.
- Wysyłanie sygnałów: Proces nadrzędny powinien wysłać sygnał SIGUSR1 do każdego z procesów potomnych po otrzymaniu SIGUSR1.
Proces nadrzędny powinien czekać na zakończenie obu procesów potomnych.
Każdy proces potomny powinien wypisać komunikat "Otrzymano sygnał SIGUSR1, kończę działanie" po otrzymaniu sygnału SIGUSR1.

3. **Napisz skrypt w Bash, który wykonuje archiwizację i kompresję plików z określonego katalogu. Skrypt powinien:**
- Przyjmować jako argument ścieżkę do katalogu, który ma być archiwizowany.
- Tworzyć archiwum (np. tar) z zawartością katalogu.
- Kompresować archiwum ustalając jego nazwę na 'indeks_data_godzina', gdzie indeks to twój numer indeksu, data i godzina to czas utworzenia backupu.
- Przenosić skompresowane archiwum do innego katalogu (np. ~/backup).
- Zawierać mechanizm do sprawdzenia, czy katalog docelowy istnieje, a jeśli nie, to tworzyć go.