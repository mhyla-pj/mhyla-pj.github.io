---
layout: exercise
course: SOP
type: stacjonarne
lab_nr: 04 
topic: Procesy
---
Poza zadaniem 5 aby rozliczyć dzisiejsze zadania wystarczy mi plik z wynikiem działania polecenia ```history```

1. Uruchom program (np. openttd) w tle za pomocą polecenia nohup i zweryfikuj jego działanie za pomocą polecenia ```ps```. Zmień jego priorytet za pomocą polecenia renice, aby porównać wpływ na wydajność programu. Następnie użyj polecenia kill, aby zabić proces.
2. Uruchom program w tle za pomocą polecenia nohup i przekieruj jego wynik do pliku tekstowego. 
3. Użyj polecenia top lub htop, aby monitorować wykorzystanie zasobów przez różne procesy na twoim systemie. Zidentyfikuj procesy, które zużywają najwięcej pamięci lub mocy obliczeniowej, i zmień ich priorytet za pomocą polecenia renice.
4. Zastosuj polecenie nice do uruchomienia programu z niższym priorytetem niż standardowy. Następnie wykonaj inne zadanie na komputerze i zaobserwuj, jak program działa w tle z niższym priorytetem.
5. Uruchom dowolny proces, a następnie wstrzymaj jego wykonywanie za pomocą polecenia kill -STOP. Następnie wznów jego wykonywanie za pomocą polecenia kill -CONT.
6. Utwórz skrypt, który automatycznie uruchamia program po starcie systemu. Następnie zrestartuj system i upewnij się, że program uruchamia się automatycznie - wujek google albo prowadzący podpowiedzą, w razie czego. 