---
layout: lab
course: WIA2
type: [ niestacjonarne, stacjonarne ]
lab_nr: 6
subject: ONP, stos
description: Stos jest sztos
---

Generalnie, mamy trzy sposoby zapisu wyrażeń matematycznych. Standardowym dla nas jest umieszczanie znaku operacji pomiędzy operandami – to nazywamy notacją infiksową. Istnieje również notacja prefiksowa, częściej używana w logice, w której znak umieszczany jest przed operatorami. Zwana jest ona również notacją polską lub notacją Łukasiewicza.
Dzisiaj skupimy się jednak na odwrotnej notacji polskiej, inaczej ONP lub notacja postfiksowa. W tym zapisie znak zapisywany jest po operandach. Pozwala to na całkowitą rezygnację z korzystania z nawiasów przy równoczesnym zachowaniu kolejności wykonywania obliczeń. Autor, Australijczyk, zaproponował, aby nazwać ten sposób zapisu "Azciweisakul notation". Bo „Lukasiewicza” od tyłu. Dobrze, że się nie przyjęło.

## Infix -> postfix

Jeśli chodzi o wszelkie przeliczanie, to skorzystamy z dwóch bardzo przyjemnych algorytmów. Zaczniemy od tego, jak przeliczyć z notacji infiksowej na postfiksową.

Wczytujemy dane po kolei. Jeżeli wczytany element jest:
- **Zmienną (stałą)**
  - Przesyłamy go na wyjście
- **(**
  - Przesyłamy go na stos
- **)**
  - Odczytujemy ze stosu i przepisujemy na wyjście wszystkie operatory aż
do (, którego nie przepisujemy
- **+, -, *, /, ^**
  - Jeżeli priorytet operatora wczytywanego jest wyższy od priorytetu tego na
wierzchu stosu (lub stos jest pusty), dopisujemy na stos.
  - Jeżeli priorytet operatora wczytywanego jest mniejszy lub równy od tego
na wierzchu stosu, odczytujemy i przepisujemy na wyjście kolejne
operatory z wierzchu stosu, dopóki ich priorytet jest >= wczytanego, po
czym wpisujemy na stos operator.

Po wczytaniu wszystkich elementów przepisujemy ze stosu na wyjście pozostałe operatory


|Operator|Priorytet|
|--------|---------|
|(|0|
|**+ - )**|1|
|**\* /**|2|
|**^**|3|

Powyżej tabelka z priorytetami operatorów. W powyższym algorytmie pojawia się jeszcze określenie „stos”, więc pewnie przydałoby się wyjaśnić, o co z nim chodzi. Stos to taka struktura danych, w której dane są umieszczane i pobierane ze szczytu. Inaczej bufor LIFO, czyli last in – first out. Można to porównać do kupki książek. Ostatnia, którą na tej kupce położymy będzie pierwszą, którą z niego zdejmiemy. Przechodząc do zastosowania stosu w wykonaniu algorytmu, bo brzmi to na skomplikowane, ale tak naprawdę to nie jest. Dla przykładu:

`(12 + 8) − 2 * 6`

| step | input | stack | output         |
|------|-------|-------|----------------|
| 1    | (     | (     |                |
| 2    | 12    | (     | 12             |
| 3    | +     | ( +   | 12             |
| 4    | 8     | ( +   | 12 8           |
| 5    | )     |       | 12 8 +         |
| 6    | -     | -     | 12 8 +         |
| 7    | 2     | -     | 12 8 + 2       |
| 8    | *     | - *   | 12 8 + 2       |
| 9    | 6     | - *   | 12 8 + 2 6     |
| 10   |       |       | 12 8 + 2 6 * - |

Przypomnę, że notacja postfiksowa oznacza, że znak występuje po operandach. I w ostatecznym wyniku to widać doskonale.  
**12 8 + 2 6 * -**  
Zachowując kolejność wykonywania obliczeń, której nauczyliśmy się w okolicach 2 klasy podstawówki wiemy, że bierzemy sobie 12 i 8, dodajemy do siebie, wychodzi 20. Następnie bierzemy 2 i 6, mnożymy przez siebie, wychodzi 12. Na końcu bierzemy nasze wyniki, czyli 20 i 12 i odejmujemy, wychodzi 8.

## postfix -> wynik

W drugą stronę jest jeszcze prościej, ale nie będziemy przechodzić z ONP na infix, wyliczymy
od razu wynik. Algorytm przedstawia się następująco:
Dla wszystkich elementów wykonujemy:

- Jeżeli wczytany symbol jest liczbą, wkładamy go na stos
- Jeżeli jest operatorem, to:
  - Ze stosu zdejmujemy jeden element (a)
  - Ze stosu zdejmujemy drugi element (b)
  - Na stosie umieszczamy wynik b operator a
Po wykonaniu dla wszystkich symboli w ONP na stosie pozostanie nam wynik wyrażenia. Dla przykładu, na poprzednim przykładzie, czyli  
 `12 8 + 2 6 * -`:

| step | input | stack  |
| ---- | ----- | ------ |
| 1    | 12    | 12     |
| 2    | 8     | 12 8   |
| 3    | +     | 20     |
| 4    | 2     | 20 2   |
| 5    | 6     | 20 2 6 |
| 6    | \*    | 20 12  |
| 7    | \-    | 8      |

## Stos w ASM

Stos określany jest w asemblerze rejestrem SP – stack pointer. Tak naprawdę, to określany jest parą SS:SP, czyli stack segment: stack pointer. I tu się pojawia pierwsza trudność, bowiem w architekturze x86 stos nie rośnie, a maleje. A raczej rośnie w dół. To znaczy, że gdy przy domyślnym uruchomieniu na rejestrach znajduje się:
```nasm
SS = 0D25
SP = FFFE
```

To w momencie, w którym umieścimy na wierzchu stosu wartość FFFF, to adresy 0D25:FFFE i 0D25:FFFF pozostaną nienaruszone, nasza wartość zostanie umieszczona na 0D25:FFFC-D. Po umieszczeniu na stosie wartości AAAA, ta zostanie umieszczona na 0D25:FFFA-B. Powyższy opis przedstawia wykonanie instrukcji:

```nasm
push 0xFFFF
push 0xAAAA
```

Rejestr SP odpowiada zawsze za wskazywanie szczytu stosu. Albo spodu, zależy od której strony patrzymy. W każdym razie – SP wskazuje na to miejsce, gdzie dokładamy wartości. Instrukcja push wymaga podania dowolnej wartości w rozmiarze word. Może to zatem być zarówno rejestr, sztywna wartość, adres w pamięci, generalnie do wyboru do koloru. 
Aby zdjąć ze stosu wartości – a przypomnę, że zawsze ściągamy ze szczytu – skorzystamy z instrukcji pop. Ta wymaga już wskazania miejsca docelowego dla ściąganej ze stosu wartości, może to być rejestr ogólnego przeznaczenia lub segmentowy, alternatywnie adres w pamięci.

Są jeszcze instukcje, które pozwalają wrzucić oraz zdjąć ze stosu w takiej samej kolejności rejestry. Te instrukcje to:
```nasm
pusha 
popa
```
Pusha umieszcza na stosie zawartość rejestrów w kolejności AX, CX, DX, BX, SP, BP, SI, DI. Popa natomiast zdejmuje wartości ze stosu i umieszcza je po kolei w rejestrach DI, SI, BP, SP, BX, DX, CX, AX. Można w takim razie powiedzieć, że ta kombinacja zachowa nam zawartość rejestrów abyśmy mogli w nich namieszać, a potem bez konsekwencji przywróci je nam do pierwotnego stanu – pod warunkiem, że pomiędzy nimi nie dodamy niczego na stos bez uprzedniego zdejmowania. Używamy tej kombinacji zazwyczaj przy wykonywaniu funkcji, aby po wyjściu rejestry były dokładnie takie same jak przed wejściem do niej.