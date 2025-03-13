---
layout: exercise
course: SOP
type: stacjonarne
lab_nr: 03
topic: tar, data, czas, cron
---
1. Napisz skrypt, który przeskanuje katalog Dokumenty i podkatalogi w poszukiwaniu plików .txt i wyświetli ich pełną listę
2. Poprzedni skrypt rozszerz o pakowanie tego zestawu do skompresowanego pliku o nazwie "[user]\_backup\_[data_wykonania]". Takie backupy powinny być umieszczone w katalogu ~/.backups
3. Stwórz zadanie, które cyklicznie (np. raz dziennie) wykona ten skrypt
4. Napisz skrypt + crontaba, który cyklicznie sprawdzać będzie użycie przestrzeni dyskowej przez backupy w naszym katalogu i jeśli ta zużyta przestrzeń będzie większa niż X (do samodzielego ustalenia), to powiadomi użytkownika. Przydać się mogą polecenie ```df``` do sprawdzenia zajętego miejsca, ```awk``` do wyciągnięcia odpowiedniej wartości i pakiet ```mailx```.