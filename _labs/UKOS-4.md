---
layout: lab
course: UKOS
type: [ niestacjonarne, stacjonarne ]
lab_nr: 4
subject: Skrypty basha
description: They see me scriptin'
---

Skrypty basha pozwala nam wykonać serię akcji (poleceń) terminala, nie wymagając od nas równocześnie wchodzenia w ogóle w terminal. Podstawowa zasada jest taka: wszystko, co możemy odpalić z terminala, możemy również wykonać przy użyciu skryptu. Odwrotnie też działa: wszystko co możemy zrobić w skrypcie, zadziała również w terminalu.

## Konfiguracja

Zasadniczo, zwykle nie ma nic do konfigurowania. Pierwsza linia skryptu powinna zawierać wskazanie dla systemu, którego interpretera używać, aczkolwiek większość powłok domyślnie założy, ze używamy jej i wszystko wykona prawidłowo. Jednak na wszelki wypadek, warto to sobie zawsze skonfigurować.

```bash
which bash
```
Powie nam, jaka jest lokalizacja naszego interpretera. Na 99% odpowiedzią będzie /bin/bash.
Używanego interpretera oznaczamy w pierwszej linii skryptu w następujący sposób:

```bash
#!/bin/bash
```

## Nasz pierwszy skrypt

Stwórz pusty plik o dowolnej nazwie. Na pewno wszyscy pamiętają, że Linux działa bez rozszerzeń, ale jak poznać, że plik ```jajco``` jest plikiem tekstowym, a ```asdfasdf123``` skryptem? No nie da rady, dlatego zwykle skryptom dajemy rozszerzenie ```.sh```

```bash
nano skrypt1.sh
```

```bash
#!/bin/bash
echo ponizej pojawia sie wszystkie pliki z tego katalogu
ls
echo Mówiłem
```

taki skrypt odpalimy poleceniem

```bash
./skrypt1.sh
```

Przy czym należy zwrócić uwagę, że uruchomić (wykonać) możemy tylko pliki wykonywalne. ```skrypt1.sh``` jest na razie plikiem tekstowym - aby go uruchomić należy nadać uprawnienia do wykonywania:

```bash
chmod 755
```

## Zmienne
Wszyscy, którzy uważali na programowaniu wiedzą, czym są zmienne. W Linuksie działają prawie dokładnie tak samo. Plus jest taki, że nie musimy deklarować typu zmiennej. Składnia deklaracji też jest podobna.

```bash
zmienna=’jajco’
```

Zwrócić należy uwagę, że nie mamy tutaj żadnych spacji, ani przed, ani po znaku =. Jest tak dlatego,
że shell każdą linijkę traktuje jako polecenie. Dlatego linijka:

```bash
zmienna = jajco
```

zostanie potraktowana jako próba uruchomienia polecenia „zmienna” z parametrami „=” i „jajco”. Jakkolwiek wspaniałe nie byłyby to argumenty, tak polecenie „zmienna” raczej się nie odpali. Aby gdzieś dalej w skrypcie odwołać się do zmiennej, znów, prawie jak w C, używamy jej nazwy, ale poprzedzonej znakiem dolara

```bash
zmienna='jajco'
echo zmienna ktorej uzyłem to $zmienna
```

W skryptach basha możemy też wykonywać operacje matematyczne. Tu już nie jest podobnie, jak w C. Pracować będziemy tylko na integerach, ponieważ bash nie wspiera bezpośrednio liczb innych niż całkowite. Wynik działania arytmetycznego zapisujemy do zmiennej.

```bash
wynik=$(($zmienna1[+-*/]$zmienna2))
```

Do operacji arytmetycznych możemy użyć również polecenia let, które również zapisze nam wynik do zmiennej

```bash
let a=1+8
```

Alternatywnie, możemy użyć polecenia expr, które zamiast zapisywać wynik do zmiennej wydrukuje je na terminalu

```bash
expr 5 + 2
```

Wiemy jak zapisac do zmiennej wynik działania, ale do zmiennej możemy również zapisać wynik jakiegoś polecenia. Aby to osiągnąć, zamknąć to polecenie musimy w znakach backticks, czyli `. To ten znaczek, co dzieli klawisz z tyldą ~.

## Argumenty w skryptach

Gdy odpalimy skrypt, to niektóre zmienne są ustawiane automatycznie.
- $0 – nazwa skryptu
- $1-9 – argumenty z wiersza poleceń
- $# - ilość argumentów podanych w wierszu poleceń
I w ten sposób możemy na przykład wykonać proste dodawanie:

```bash
wynik=$(($1+$2))
echo wynik dodawanie to $wynik
```

skrypt ten uruchamiamy:

```bash
./dodawanie.sh 3 5
```

## If

Instrukcja warunkowa if w bashu też działa inaczej niż w C. Bliżej mu do pseudokodu, niż normalnego kodu.

```bash
if [ warunek ]
then
    cośtam
fi
```

Budowanie tych warunków to już w ogóle inna bajka. Inaczej będzie wyglądało porównywanie stringów, inaczej integerów

Dla liczb porównania wyglądają następująco. Dla uproszenia porównamy je do C++:
- -eq - == (equals)
- -gt - > (greater than)
- -lt - < (less than)
- -ge - >= (greater or equal)
- -le <= (less or equal)
Stringi natomiast porównujemy tak:
- = - == (równa się)
- != - != (nie równa się)
- 
Czyli warunek, który wykona się dla zmiennej1 większej od zmiennej2 wyglądać będzie następująco:

```bash
[ zmienna1 -gt zmienna2 ]
```

Tutaj nawiasów kwadratowych nie pomijamy. Operacje logiczne działają, dla odmiany, identycznie jak w C.

```bash
[ zmienna1 -eq zmienna2 ] && [ zmienna2 -lt zmienna3 ]
```

```bash
if [ warunek ]
then
    cośtam
elif [ warunek ]
then
    cośtamcośtam
else
    cośtam innego
fi
```

