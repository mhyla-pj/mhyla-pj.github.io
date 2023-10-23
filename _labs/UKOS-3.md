---
layout: lab
course: UKOS
type: [ niestacjonarne, stacjonarne ]
lab_nr: 3
subject: Grep, regexp, pipe i inne, czyli praca na plikach
description: Tym razem zajmiemy się zawartością plików
---
| Pliki do zajęć: [komputery.txt](../assets/UKOS/komputery.txt) i [lista_zakupow.txt](../assets/UKOS/lista_zakupow.txt)

Poznaliśmy już podstawy pracy na plikach, znaki specjalne, dziś przychodzi moment, aby zająć się
tym, co pliki zawierają.

## Grep czy egrep, oto jest pytanie
Polecenie grep, w rozwinięciu global regular expression print, jak sama nazwa wskazuje, wydrukuje
nam na konsoli to, co mu podamy w wyrażeniu regularnym

```bash
grep [opcje] [wyrażenie] [plik]
```

## W czym?

W wyrażeniu regularnym, czyli wyrażeniu opisującym jakiś ciąg symboli. Bawiliśmy się trochę
upośledzoną wersją tego na poprzednich zajęciach, dziś poznamy wersję dla prawdziwych
informatyków
egrep oznacza rozszerzoną wersję grepa, extended regular expression print. Ten sam efekt uzyskamy
używając zwykłego polecenia

```bash
grep -E
```

## Wyrażenia regularne

Działają na podobnej zasadzie co poznane wcześniej wildcardy, ale elementy, z których budujemy
wyrażenia regularne są trochę bardziej złożone, i jest ich znacznie więcej.

- . – pojedynczy znak
- ? – poprzedni znak pojawia się 0 lub 1 raz
- * - poprzedni znak pojawia się 0 lub więcej razy
- + - poprzedni znak pojawia się 1 lub więcej razy
- {n} – poprzedni znak pojawia się n lub więcej razy
- {n,m} – poprzedni znak pojawia się od n do m razy
- [abc] – znak jest jednym z wymienionych w nawiasie
- [^abc] – znak nie jest jednym z wymienionych w nawiasie
- () – pozwala na grupowanie znaków
- | - operacja logiczna OR
- ^ - początek linii
- $ - koniec linii (za koniec przyjmujemy tutaj znacznik LF, windowsowe CRLF może nie zostać wykryte)

Zacznijmy od listy zakupów, dla wygody umieściłem ją na stronie, więc proszę pobrać plik
lista_zakupów.txt. Zaczniemy od czegoś prostego.

```bash
egrep ‘Lidl’ lista_zakupów.txt
```

Powyższe polecenie wydrukuje nam wszystkie zakupy, które mamy zrobić w Lidlu. Ale przecież część
mogliśmy zapisać od małej litery. Żeby wypisać nam również zakupy, które mieliśmy zrobić w **lidlu**,
użyć musimy np. nawiasów kwadratowych.

```bash
egrep ‘[lL]idl’ lista_zakupów.txt
```

Teraz wyszukamy produkty, które chcemy kupić w dwóch sztukach. Jednak gdy użyjemy polecenia 

```bash
egrep ‘2’ lista_zakupów.txt
```

Dostaniemy wszystkie pozycje, które zawierają cyfrę ‘2’, a nie o to mi chodziło. Przyjść mogłoby nam
z pomocą dodanie znaku końca linii po ‘2’

```bash
egrep ‘2$’ lista_zakupów.txt
```

ale w tym wypadku dostaniemy również jajka, które chcemy kupić w ilości sztuk 12. W tym wypadku
pomocne nam będą tzw. shorthands, które określają nam konkretne klasy znaków

- \w – określa znaki słów, czyli z zakresu [A-Za-z0-9_]
- \s – określa znaki białe, takie jak spacje, tabulatory
- \d – określa cyfry 0-9 - grep od wersji 3.4 nie wspiera tego skrótu, zamiast tego używamy
[0-9] lub [[:digit:]]

czyli w wypadku, w którym chcemy wypisać wszystkie pozycje, których zakupić chcemy 2 sztuki,
najlepiej będzie użyć polecenia

```bash
egrep ‘\s2$’ lista_zakupów.txt
```

Aby w pliku lista_zakupów.txt znaleźć wszystkie produkty, które zamierzamy kupić w Lidlu bądź
Auchanie w ilości 2 użyjemy polecenia

```bash
egrep ‘([lL]idl|Auchan)\s\w*\s2$’ lista_zakupów.txt
```

## Piping & redirection
Wrócimy na chwilę do całkowitych podstaw. Co się wydarzy, gdy zastosujemy polecenie ls? Na
konsoli wydrukuje nam się lista plików i katalogów. Polecenia zwykle zwracają informacje na standardowe wyjście - domyślnie na terminal. Jednak niekoniecznie musimy chcieć wyświetlać informacje na ekranie - niektóre rzeczy możemy chcieć zapisać do pliku. Tutaj bardzo pomocne będzie przekierowanie strumienia danych:

```bash
ls > lista.txt
cat lista.txt
```
Używając znaku ```>``` możemy przekierować wynik każdego polecenia tak, żeby zapisany został w nowym pliku.


Zasada działania jest wyjątkowo prosta. Każdy program (polecenie) ma trzy strumienie danych.
Przetwarza dane wejściowe (STDIN) na dane wyjściowe (STDOUT), które domyślnie drukuje na
terminalu, ewentualnie drukuje na nim dane o błędach (STDERR). Piping i redirection przekierowują
nam któreś z tych trzech strumieni danych w inne miejsce.

- \> - zapisuje output do pliku
- \>> - dodaje output do istniejącego pliku
- \| - przekierowuje output do innego programu
- < - wczytuje treść pliku na input
- 2> - zapisuje błędy do pliku.

Więc, dla przykładu, zapiszemy teraz do pliku zabka.txt ponumerowaną listę zakupów z żabki. Żeby to
osiągnąć musimy najpierw zastosować grepa, a następnie wynik jego działania przekazać do nl. po tej
czynności możemy już zapisać dane wyjściowe do pliku.

```bash
egrep ‘Żabka’ lista_zakupow.txt | nl > zabka.txt
```