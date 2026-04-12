---
layout: lab
course: WIA2
type: [ niestacjonarne, stacjonarne ]
lab_nr: 04
subject: Skoki
description: Narciarskie też
---
Generalnie wszyscy już w tym momencie powinni wiedzieć, że procesor wykonuje rozkazy kolejno (sekwencyjnie) od tych na najmłodszym adresie do tych najstarszym. Tłumacząc na polski: program wykonuje się od góry do dołu. Możemy tę kolejność jednak trochę pozmieniać: do tego posłużą nam skoki – warunkowe i bezwarunkowe.
Gdy procesor napotka instrukcję skoku, to przeskoczy do zadanego adresu (może skoczyć do przodu, ale może też do tyłu) i od miejsca lądowania będzie dalej wykonywał instrukcje kroczek po kroczku. W związku z tym trzeba przypilnować, żebyśmy przypadkiem nie stworzyli programu, który nigdy się nie skończy.
Podstawowym i zarazem najprostszym skokiem jest skok bezwarunkowy. W asm będzie do jego wykonania służyła instrukcja

```nasm
jmp etykieta
```

Poniższy programik, gdyby nie skok, wydrukowałby nam literki AB i się zakończył, ale przez to, że po wywołaniu przerwania drukującego literkę A dokonaliśmy skoku do etykiety koniec, to literka B nie została wydrukowana. Proste.

```nasm
org 100h

mov AH, 02h
mov DL, 41h
int 21h

jmp koniec

mov DL, 42h
int 21h

koniec:
mov AH, 00h
int 21h
```

Proponuję podejrzeć ten programik w insighcie i zobaczyć, że dokładny adres skoku znany jest od razu po kompilacji. Uważać jednak trzeba, aby nie przesadzić i nie doprowadzić do sytuacji, w której będziemy wykonywać skok bezwarunkowy do tyłu bez możliwości innego zakończenia programu. Mechanizm skoków bezwarunkowych jest bardzo przydatny, ale istnieje duża szansa, że w sterowaniu programem raczej używać będziemy skoków warunkowych, a bezwarunkowego do wychodzenia na koniec programu z ominięciem różnych rzeczy, które moglibyśmy napotkać po drodze. 

## Skoki Warunkowe

Mechanizm jest dość prosty, tak mi się wydaje w każdym razie. Kiedy procesor napotka instrukcję skoku warunkowego, to skok do etykiety zostaje wykonany tylko w wypadku, w którym ustawione są odpowiednie flagi. Flagi to znajdujące się w specjalnym rejestrze bity, ustawiane w momencie wywołania komparatora, czyli instrukcji ```cmp```. Instrukcji skoków warunkowych mamy całkiem sporo, po wszystkie zapraszam [tutaj](https://pl.wikibooks.org/wiki/Asembler_x86/Instrukcje/Skokowe#Warunek). Poniżej te najczęściej używane:

- JE – skok,gdyArówneB
- JNE – skok, gdy A nierówne B
- JG – skok,gdyAwiększeodB
- JGE – skok, gdy A większe lub równe B
- JA – skok, gdy A większe od B dla liczb bez znaku
- JB – skok, gdy A mniejsze od B dla liczb bez znaku
- JG – skok, gdy A większe od B (ze znakiem)
- JL – skok, gdy A mniejsze od B (ze znakiem)

Wiemy już bez wątpienia, jak gdzieś skoczyć, gdy coś jest większe albo mniejsze, pozostaje w takim razie ustalić jeszcze czym to „coś” jest. Służyć nam do tego będzie instrukcja cmp.

```nasm
cmp A, B
```

Gdzie A i B mogą być sztywnymi wartościami, zawartościami rejestrów lub pamięci. To ta instrukcja ustawi odpowiednie flagi, na podstawie których wykonywane będą (lub nie będą) później skoki.

```nasm
org 100h

mov AH, 21h
mov AL, 11h
cmp AL, AH

JL mniejsze
JG koniec

mniejsze:
mov AH, 02h
mov DL, '<'
int 21h
jmp koniec

koniec:
mov AH, 00h
int 21h
```

W tym programiku mamy już skok. Porównujemy w nim AL (11h) i AH (21h). Jeśli 11h jest mniejsze od 21h, a jak ostatnio sprawdzałem to tak było, to ustawione przy operacji porównania zostaną flagi SF, FP i CF, IF jest już ustawiona wcześniej, pozostałe są 0. Skok JL wykonuje się, kiedy SF jest różne od OF. W tym wypadku tak jest, bo SF ustawiło się przy porównaniu, a OF pozostało zerem. 

Warto przy okazji zwrócić uwagę na to, że tę mini-funkcyjkę „mniejsze” zakończyliśmy bezwarunkowym skokiem do zakończenia programu. Taki zabieg pozwoli na ominięcie kodu, którego nie chcielibyśmy, aby się wykonywał, kiedy gdzieś skaczemy, np. etykiet obsługujące pozostałe wyniki porównania.

## A po ludzku?

Zaczynamy od porównania ze sobą dwóch danych: A i B. Następnie powinny pojawić się skoki do etykiet, zależnie od otrzymanego wyniku porównania. Każda taka etykieta powinna wykonywać jaką akcję i wykonywać bezwarunkowy skok za definicje wszystkich etykiet. Dla ułatwienia można to sobie rozrysować na jakimś diagramie blokowym, czy coś.
