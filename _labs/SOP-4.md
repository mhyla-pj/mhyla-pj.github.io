---
layout: lab
course: SOP
type: stacjonarne
lab_nr: 04
subject: Kontrola procesów
description: Marzenie ministra sprawiedliwości
---

O procesach wspominałem już na wykładzie, dziś podejdziemy do nich od strony praktycznej. Procesy są podstawowymi jednostkami, które wykonują zadania w systemie operacyjnym, a każdy z nich może być jednoznacznie identyfikowany po swoim PID. 

Procesy są izolowane od siebie i działają w swojej własnej przestrzeni adresowej pamięci, co oznacza, że nie mają dostępu do pamięci innych procesów, chyba że zostanie to specjalnie udostępnione.

Procesy mogą być uruchamiane i zarządzane przez użytkowników systemu, a także przez inne procesy lub demony systemowe. Każdy proces ma swoją prywatną przestrzeń adresową, która zawiera jego kod, dane, stos i stertę, a także informacje o jego stanie (np. stan wykonywania, priorytet, ustawienia systemowe).

Aby wylistować działające obecnie procesy użyjemy polecenia
```bash
ps
```

1. ```ps``` - wyświetla listę procesów działających na systemie, wraz z ich identyfikatorami PID, stanem, priorytetem, czasem działania i innymi informacjami.
2. ```top``` - wyświetla dynamiczną listę procesów działających na systemie wraz z ich aktualnymi wartościami zasobów, takimi jak zużycie procesora, pamięci RAM, dysku i innych.
3. ```kill``` - pozwala na wysłanie sygnału do procesu, co może spowodować zakończenie jego działania. Można użyć identyfikatora PID lub nazwy procesu.
4. ```killall``` - pozwala na wysłanie sygnału do wszystkich procesów o określonej nazwie. Może to spowodować zakończenie działania wszystkich procesów o tej samej nazwie.
5. ```nice``` - pozwala na ustawienie priorytetu procesu. Domyślnie wszystkie procesy mają taki sam priorytet, ale można zmienić priorytet dla wybranych procesów.
6. ```renice``` - pozwala na zmianę priorytetu już uruchomionego procesu.
7. ```bg``` - pozwala na uruchomienie zatrzymanego procesu w tle.
8. ```fg``` - pozwala na przywrócenie procesu do działania w trybie interaktywnym.
9. ```jobs``` - wyświetla listę procesów działających w tle i zatrzymanych procesów, wraz z ich identyfikatorami i stanami.
10. ```pstree``` - wyświetla drzewo procesów, pokazując relacje między procesami i ich rodzicami.

Aby uruchomić proces "w tle" należy przy wywołującym poleceniu dopisać znak ```&```
```bash
openttd &
```

## Sygnały
Poleceniem ```kill``` wysyłać do procesu możemy sygnały. Sygnały w systemie Linux to krótkie komunikaty przesyłane do procesów, aby powiadomić je o pewnych zdarzeniach lub żądaniach. Sygnały są wykorzystywane do komunikacji między procesami oraz do kontroli i zarządzania procesami.

System Linux obsługuje wiele różnych sygnałów, z których każdy ma swój unikalny numer identyfikacyjny. Sygnały można wysyłać do procesów za pomocą programów lub polecenia kill. Niektóre z najczęściej używanych sygnałów to:

- SIGINT (sygnał przerwania) - wysyłany do procesu, gdy użytkownik wciśnie klawisze Ctrl+C. Powoduje to przerwanie bieżącej operacji procesu.
- SIGKILL (sygnał zabójstwa) - wysyłany do procesu, aby natychmiastowo zakończyć jego działanie. Ten sygnał nie daje procesowi czasu na czyszczenie swojego stanu, a zamyka go natychmiastowo.
- SIGTERM (sygnał zakończenia) - wysyłany do procesu, aby poprosić go o zakończenie swojego działania. Ten sygnał pozwala procesowi na przeprowadzenie niezbędnych czynności przed zakończeniem.
- SIGHUP (sygnał hangup) - wysyłany do procesu, gdy użytkownik zamknie terminal. Powoduje to zakończenie procesu.
- SIGUSR1 i SIGUSR2 (sygnały użytkownika) - sygnały, które mogą być zdefiniowane i wysłane przez użytkownika w celu wywołania określonej funkcji w procesie.
- SIGPIPE (sygnał potoku) - wysyłany do procesu, gdy proces próbuje pisać do potoku, który został już zamknięty. Powoduje to zakończenie procesu.

