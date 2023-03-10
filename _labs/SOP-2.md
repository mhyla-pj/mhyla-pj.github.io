---
layout: lab
course: SOP
type: stacjonarne
lab_nr: 2
subject: Bash bardziej złożony
description: Tego już nie było na UKOS. Chyba
---
## Warunki
Działanie if-ów w bashu jest oczywiście identyczne, jak w każdym języku programowania. Mimo identycznego działania, składnia basha jest dość charakterystyczna. 
```bash
if [ statement ]
then
    do_something
else
    do_something_else
fi
```
Wyrażenie postawione w nawiasie kwadratowym (pamiętajcie o spacjach!) to tak naprawdę polecenie ```test```. Nie będę tu wklejał całego manuala, więc zachęcam do przejrzenia, szczególnie, że dziś się przyda. 

Polecenie ```test -e ../Documents/print.c``` dokona sprawdzenia, czy istnieje plik o podanej ścieżce. Wykonanie go nie da nam jednak absolutnie żadnej informacji zwrotnej na terminalu. Dzieje się tak, ponieważ polecenie nie zwraca nic na *stdout*. Możemy jednak sprawdzić jego wynik używając specjalnej zmiennej, tzw "wbudowanej" - ```$?```. Zwróci ona exit status ostatniego wykonanego polecania, bardzo przydaje się przy weryfikacji, czy wszystko w skrypcie idzie tak jak powinno. Instrukcja ```exit 123``` w skrypcie zakończy go z kodem 123.

## Pętle
W bashu mamy kilka rodzajów pętli, a niektóre z nich mają też kilka możliwych zachowań, dlatego ważne, aby się z nimi zapoznać. 

### For 

```bash
for zmienna in 1 2 3 4
do
    echo $zmienna
done
```
For wykonujący się na secie danych, czyli dla pętla wykonująca się dla każdego elementu. Takim setem danych może być również wynik jakiegoś polecenia, np. jeśli chcielibyśmy wykonać jakieś działanie dla każdego pliku kończącego się na ".cpp":

```bash
for zmienna in `ls *.cpp`
do
    echo $zmienna
done
```

Niezależnie od tego, znany każdemu for również się wykona:

```bash
for ((i=0;i<10;i++))
do
    echo $i
done
```
### While

Pętla while jest bardzo prosta

```bash
while [ statement ]
do
    echo whatever
done
```

## Praca z tekstem
Grepa wszyscy bez wątpienia pamiętają z UKOS i regexami posługiwać się potrafią z zamkniętymi oczami, ale na wszelki wypadek przypomnę. Polecenie ```grep``` wyszuka nam w podanym do niego tekście wszystkie wystąpienia podanego do polecenia patternu. 
```bash
grep 'Lidl' zakupy.txt
```
Znajdzie wszystkie wystąpienia słowa "Lidl". Ale wyrażenia regularne określają pewien pattern - przecież na liście zakupów mógł pojawić się lidl zamiast Lidla. Dlatego grep pozwala na zastępowanie pewnych znaków (lub ciągów) symbolami oraz na określanie, w jakiej ilości występują.

- . – pojedynczy znak
- ? – poprzedni znak pojawia się 0 lub 1 raz
- \* - poprzedni znak pojawia się 0 lub więcej razy
- \+ - poprzedni znak pojawia się 1 lub więcej razy
- {n} – poprzedni znak pojawia się n lub więcej razy
- {n,m} – poprzedni znak pojawia się od n do m razy
- [abc] – znak jest jednym z wymienionych w nawiasie
- [^abc] – znak nie jest jednym z wymienionych w nawiasie
- () – pozwala na grupowanie znaków
- \| - operacja logiczna OR
- ^ - początek linii
- $ - koniec linii (za koniec przyjmujemy tutaj znacznik LF, windowsowe CRLF może nie zostać
wykryte)

Ale praca z tekstem w bashu to nie tylko wyszukiwanie tekstu, to również jego edycja. Do tego skorzystamy z polecenia ```sed```. Jest ono absolutnie przepotężne, ale w gruncie rzeczy najczęściej jego użycie sprowadzać się będzie do wyszukiwania tekstu i zastępowania go innym:

```bash
sed 's/UKOS/SOP/' przedmioty.txt
```
Takie polecenie zamieni wszystkie wystąpienia słowa "UKOS" na "SOP" w pliku przedmioty.txt. Doprowadzenie seda do działania, przynajmniej w moim przypadku, właściwie zawsze wymaga konsultacji z dokumentacją i wujkiem google, także również do tego zachęcam.

